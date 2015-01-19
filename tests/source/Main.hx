/*
 *
 * @author kgar
 * copyright (c) 2015 Gameduell GmBH
 */
package;

import unittest.TestRunner;
import unittest.implementations.TestHTTPLogger;
import unittest.implementations.TestJUnitLogger;
import unittest.implementations.TestSimpleLogger;

import duell.DuellKit;


class Main
{
    private var r : TestRunner;

    public function new()
    {
        DuellKit.initialize(startAfterDuellIsInitialized);
    }

    private function startAfterDuellIsInitialized(): Void
    {
        r = new TestRunner(testComplete);
        r.add(new CapabilitiesTest());
        #if test

            #if jenkins
            r.addLogger(new TestHTTPLogger(new TestJUnitLogger()));
            #else
            r.addLogger(new TestHTTPLogger(new TestSimpleLogger()));
            #end
            
        #else
            r.addLogger(new TestSimpleLogger());
        #end

        r.run();
    }

    private function testComplete()
    {
        trace(r.result);
    }


    /// MAIN
    static var _main : Main;
    static function main() : Void
    {
        _main = new Main();
    }
}