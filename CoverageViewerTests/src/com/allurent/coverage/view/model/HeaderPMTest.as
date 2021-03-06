/* 
 * Copyright (c) 2008 Allurent, Inc.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished
 * to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
 * OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
package com.allurent.coverage.view.model
{
	import com.adobe.ac.util.service.FileBrowserStub;
	import com.allurent.coverage.ControllerMock;
	import com.allurent.coverage.event.HeavyOperationEvent;
	
	import flexunit.framework.EventfulTestCase;

	public class HeaderPMTest extends EventfulTestCase
	{
		private var model:HeaderPM;
		private var controllerMock:ControllerMock;
		
		override public function setUp():void
		{
			controllerMock = new ControllerMock();
			model = new HeaderPM(controllerMock, new FileBrowserStub());
		}
		
        public function testClearCoverageData():void
        {
        	controllerMock.mock.method("clearCoverageData").once;
            model.clearCoverageData();
            controllerMock.mock.verify();
        }
		
		public function testCanClearCoverageData():void
		{
			assertFalse("0", model.canClearCoverageData(false, false));
			assertFalse("1", model.canClearCoverageData(false, true));
            assertTrue("2", model.canClearCoverageData(true, false));
            assertFalse("3", model.canClearCoverageData(true, true));			
		}
		
		public function testOpenFile():void
		{
			listenForEvent(model, HeavyOperationEvent.EVENT_NAME);
			
			model.openInput();
			
			assertEvents();
		}
		
        public function testSaveReport():void
        {
        	controllerMock.mock.method("writeReport").withAnyArgs.once;
            model.saveOutput();
            controllerMock.mock.verify();
        }		
	}
}