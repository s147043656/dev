/* 
    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.  
 */

package org.apache.wiki.providers;

import java.io.*;
import java.util.Collection;
import java.util.List;
import java.util.Properties;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

import org.apache.wiki.PageManager;
import org.apache.wiki.TestEngine;
import org.apache.wiki.WikiContext;
import org.apache.wiki.WikiPage;
import org.apache.wiki.util.FileUtil;

// FIXME: Should this thingy go directly to the VersioningFileProvider,
//        or should it rely on the WikiEngine API?

public class VersioningFileProviderTest extends TestCase
{
    public static final String NAME1 = "Test1";

    Properties props = new Properties();

    TestEngine engine;

    public VersioningFileProviderTest( String s )
    {
        super( s );
    }

    public void setUp()
        throws Exception
    {
        props.load( TestEngine.findTestProperties("/jspwiki_vers.properties") );

        engine = new TestEngine(props);
    }

    public void tearDown()
    {
        String files = props.getProperty( FileSystemProvider.PROP_PAGEDIR );

        // Remove file
        File f = new File( files, NAME1+FileSystemProvider.FILE_EXT );
        f.delete();

        f = new File( files, "OLD" );

        TestEngine.deleteAll(f);
    }

    /**
     *  Checks if migration from FileSystemProvider to VersioningFileProvider
     *  works by creating a dummy file without corresponding content in OLD/
     */
    public void testMigration()
        throws IOException
    {
        String files = props.getProperty( FileSystemProvider.PROP_PAGEDIR );
        
        File f = new File( files, NAME1+FileSystemProvider.FILE_EXT );

        Writer out = new FileWriter( f );
        FileUtil.copyContents( new StringReader("foobar"), out );
        out.close();

        String res = engine.getText( NAME1 );

        assertEquals( "latest did not work", "foobar", res );

        res = engine.getText( NAME1, 1 ); // Should be the first version.

        assertEquals( "fetch by direct version did not work", "foobar", res );
    }

    public void testMillionChanges()
        throws Exception
    {
        String text = "";
        String name = NAME1;
        int    maxver = 100; // Save 100 versions.

        for( int i = 0; i < maxver; i++ )
        {
            text = text + ".";
            engine.saveText( name, text );
        }

        WikiPage pageinfo = engine.getPage( NAME1 );

        assertEquals( "wrong version", maxver, pageinfo.getVersion() );
        
        // +2 comes from \r\n.
        assertEquals( "wrong text", maxver+2, engine.getText(NAME1).length() );
    }

    public void testCheckin()
        throws Exception
    {
        String text = "diddo\r\n";

        engine.saveText( NAME1, text );

        String res = engine.getText(NAME1);
       
        assertEquals( text, res );
    }

    public void testGetByVersion()
        throws Exception
    {
        String text = "diddo\r\n";

        engine.saveText( NAME1, text );

        WikiPage page = engine.getPage( NAME1, 1 );
       
        assertEquals( "name", NAME1, page.getName() );
        assertEquals( "version", 1, page.getVersion() );
    }

    public void testPageInfo()
        throws Exception
    {
        String text = "diddo\r\n";

        engine.saveText( NAME1, text );

        WikiPage res = engine.getPage(NAME1);
       
        assertEquals( 1, res.getVersion() );
    }

    public void testGetOldVersion()
        throws Exception
    {
        String text = "diddo\r\n";
        String text2 = "barbar\r\n";
        String text3 = "Barney\r\n";

        engine.saveText( NAME1, text );
        engine.saveText( NAME1, text2 );
        engine.saveText( NAME1, text3 );

        WikiPage res = engine.getPage(NAME1);

        assertEquals("wrong version", 3, res.getVersion() );

        assertEquals("ver1", text, engine.getText( NAME1, 1 ) );
        assertEquals("ver2", text2, engine.getText( NAME1, 2 ) );
        assertEquals("ver3", text3, engine.getText( NAME1, 3 ) );
    }

    public void testGetOldVersion2()
        throws Exception
    {
        String text = "diddo\r\n";
        String text2 = "barbar\r\n";
        String text3 = "Barney\r\n";

        engine.saveText( NAME1, text );
        engine.saveText( NAME1, text2 );
        engine.saveText( NAME1, text3 );

        WikiPage res = engine.getPage(NAME1);

        assertEquals("wrong version", 3, res.getVersion() );

        assertEquals("ver1", 1, engine.getPage( NAME1, 1 ).getVersion() );
        assertEquals("ver2", 2, engine.getPage( NAME1, 2 ).getVersion() );
        assertEquals("ver3", 3, engine.getPage( NAME1, 3 ).getVersion() );
}

    /**
     *  2.0.7 and before got this wrong.
     */
    public void testGetOldVersionUTF8()
        throws Exception
    {
        String text = "\u00e5\u00e4\u00f6\r\n";
        String text2 = "barbar\u00f6\u00f6\r\n";
        String text3 = "Barney\u00e4\u00e4\r\n";

        engine.saveText( NAME1, text );
        engine.saveText( NAME1, text2 );
        engine.saveText( NAME1, text3 );

        WikiPage res = engine.getPage(NAME1);

        assertEquals("wrong version", 3, res.getVersion() );

        assertEquals("ver1", text, engine.getText( NAME1, 1 ) );
        assertEquals("ver2", text2, engine.getText( NAME1, 2 ) );
        assertEquals("ver3", text3, engine.getText( NAME1, 3 ) );
    }

    public void testNonexistantPage()
    {
        assertNull( engine.getPage("fjewifjeiw") );
    }

    public void testVersionHistory()
        throws Exception
    {
        String text = "diddo\r\n";
        String text2 = "barbar\r\n";
        String text3 = "Barney\r\n";

        engine.saveText( NAME1, text );
        engine.saveText( NAME1, text2 );
        engine.saveText( NAME1, text3 );

        Collection history = engine.getVersionHistory(NAME1);

        assertEquals( "size", 3, history.size() );
    }

    public void testDelete()
        throws Exception
    {
        engine.saveText( NAME1, "v1" );
        engine.saveText( NAME1, "v2" );
        engine.saveText( NAME1, "v3" );

        PageManager mgr = engine.getPageManager();
        WikiPageProvider provider = mgr.getProvider();

        provider.deletePage( NAME1 );

        String files = props.getProperty( FileSystemProvider.PROP_PAGEDIR );

        File f = new File( files, NAME1+FileSystemProvider.FILE_EXT );

        assertFalse( "file exists", f.exists() );

        f = new File( files, NAME1+".properties" );

        assertFalse( "RCS file exists", f.exists() );
    }

    public void testDeleteVersion()
        throws Exception
    {
        engine.saveText( NAME1, "v1\r\n" );
        engine.saveText( NAME1, "v2\r\n" );
        engine.saveText( NAME1, "v3\r\n" );

        PageManager mgr = engine.getPageManager();
        WikiPageProvider provider = mgr.getProvider();

        List l = provider.getVersionHistory( NAME1 );
        assertEquals( "wrong # of versions", 3, l.size() );

        provider.deleteVersion( NAME1, 2 );

        l = provider.getVersionHistory( NAME1 );

        assertEquals( "wrong # of versions", 2, l.size() );

        assertEquals( "v1", "v1\r\n", provider.getPageText( NAME1, 1 ) );
        assertEquals( "v3", "v3\r\n", provider.getPageText( NAME1, 3 ) );

        try
        {
            provider.getPageText( NAME1, 2 );
            fail( "v2" );
        }
        catch( NoSuchVersionException e )
        {
            // This is expected
        }
    }


    public void testChangeNote()
        throws Exception
    {
        WikiPage p = new WikiPage( engine, NAME1 );
        p.setAttribute(WikiPage.CHANGENOTE, "Test change" );
        WikiContext context = new WikiContext(engine,p);
        
        engine.saveText( context, "test" );
        
        WikiPage p2 = engine.getPage( NAME1 );
        
        assertEquals( "Test change", p2.getAttribute(WikiPage.CHANGENOTE) );
    }

    public void testChangeNoteOldVersion()
        throws Exception
    {
        WikiPage p = new WikiPage( engine, NAME1 );
        
        
        WikiContext context = new WikiContext(engine,p);

        context.getPage().setAttribute(WikiPage.CHANGENOTE, "Test change" );
        engine.saveText( context, "test" );
        
        context.getPage().setAttribute(WikiPage.CHANGENOTE, "Change 2" );
        engine.saveText( context, "test2" );
        
        WikiPage p2 = engine.getPage( NAME1, 1 );
        
        assertEquals( "Test change", p2.getAttribute(WikiPage.CHANGENOTE) );

        WikiPage p3 = engine.getPage( NAME1, 2 );
        
        assertEquals( "Change 2", p3.getAttribute(WikiPage.CHANGENOTE) );
    }

    public void testChangeNoteOldVersion2() throws Exception
    {
        WikiPage p = new WikiPage( engine, NAME1 );
    
        WikiContext context = new WikiContext(engine,p);

        context.getPage().setAttribute( WikiPage.CHANGENOTE, "Test change" );
        
        engine.saveText( context, "test" );

        for( int i = 0; i < 5; i++ )
        {
            WikiPage p2 = (WikiPage)engine.getPage( NAME1 ).clone();
            p2.removeAttribute(WikiPage.CHANGENOTE);

            context.setPage( p2 );

            engine.saveText( context, "test"+i );
        }

        WikiPage p3 = engine.getPage( NAME1, -1 );
    
        assertEquals( null, p3.getAttribute(WikiPage.CHANGENOTE) );
    }

    public static Test suite()
    {
        return new TestSuite( VersioningFileProviderTest.class );
    }
}
