-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\DragTwoPages.lua

local strClassName = "DragTwoPages"
local DragTwoPages = Class(strClassName)

function DragTwoPages:ctor(parent, pagePath1, pagePath2, pathPreBtn, pathNextBtn, autoNextTime, tabBtnPath, isLoop)
	self.parent = parent
	self.page1Controller = parent:getController():GetCom(UIConst.ControlTypeDragPage, pagePath1)

	self.page1Controller:SetNextPageFunction(Functor(self.onNextPage, self, self.page1Controller))

	self.page2Controller = parent:getController():GetCom(UIConst.ControlTypeDragPage, pagePath2)

	self.page2Controller:SetNextPageFunction(Functor(self.onNextPage, self, self.page2Controller))

	if autoNextTime and autoNextTime > 0 then
		self.autoNextTime = autoNextTime

		self.page1Controller:SetOnDragFunction(Slot(self.onDragOpera, self))
		self.page2Controller:SetOnDragFunction(Slot(self.onDragOpera, self))
	end

	if pathPreBtn and pathNextBtn then
		self.preBtn = UIControls.Button(parent, pathPreBtn)

		self.preBtn:addEventClick(Slot(self.onClickPrePage, self))

		self.nextBtn = UIControls.Button(parent, pathNextBtn)

		self.nextBtn:addEventClick(Slot(self.onClickNextPage, self))
	end

	local pagePanel = UIControls.Panel(parent, pagePath1)
	local pagePanel2 = UIControls.Panel(parent, pagePath2)

	self.pages = {
		pagePanel,
		pagePanel2
	}
	self.pageSize = pagePanel:getRectSize()
	self.dragEvent = nil
	self.tabBtns = {}
	self.tabBtnPath = tabBtnPath
	self.isLoop = isLoop
end

function DragTwoPages:initPage(maxPageIndex, startPage, maxBtnIndex)
	self.maxPageIndex = maxPageIndex
	self.currentPageIndex = startPage
	self.controllerIndex = self.controllerIndex or 1

	self:onDragEvent(true)
	self.page1Controller:StopTweenAnim()
	self.page2Controller:StopTweenAnim()

	for index, page in pairs(self.pages) do
		if self.controllerIndex == index then
			page:setPosition(0, 0)
			page:setVisible(true)
		else
			page:setVisible(false)
		end
	end

	if self.tabBtnPath then
		local function tabClickFunc(realParent, mParent, controlSelf, ...)
			realParent.onTabClick(realParent, controlSelf, ...)
		end

		for index = #self.tabBtns + 1, maxBtnIndex do
			local newBtn = UIControls.Button(self.parent, self.tabBtnPath .. index)

			newBtn.index = index

			newBtn:addEventClick(Slot(tabClickFunc, self))

			self.tabBtns[index] = newBtn
		end

		for index, btn in ipairs(self.tabBtns) do
			if index <= maxPageIndex and maxPageIndex ~= 1 then
				btn:setVisible(true)
			else
				btn:setVisible(false)
			end
		end
	end

	self:refreshBtn()

	if maxPageIndex > 1 and self.autoNextTime then
		if not self.autoNextTimer then
			self.autoNextTimer = Timer.New(Slot(self.timerAutoNext, self), self.autoNextTime, -1)
		end

		self.autoNextTimer:Restart()
	end
end

function DragTwoPages:onDragEvent(isInit)
	if self.dragEvent then
		self.dragEvent(self, self.currentPageIndex, self.controllerIndex, isInit)
	end
end

function DragTwoPages:destroy()
	self.page1Controller:ClearNextPageFunc()
	self.page2Controller:ClearNextPageFunc()

	if self.autoNextTimer then
		self.autoNextTimer:Stop()
		self.page1Controller:ClearOnDragFunc()
		self.page2Controller:ClearOnDragFunc()
	end
end

function DragTwoPages:onPause()
	if self.autoNextTimer then
		self.autoNextTimer:Stop()
	end
end

function DragTwoPages:timerAutoNext()
	local nextIndex = self.currentPageIndex + 1

	if nextIndex > self.maxPageIndex then
		nextIndex = 1
	end

	self:_onToSomePage(nextIndex)
end

function DragTwoPages:onDragOpera(beginDrag)
	if self.autoNextTimer then
		if beginDrag == 1 then
			self.autoNextTimer:Stop()
		else
			self.autoNextTimer:Restart()
		end
	end
end

function DragTwoPages:onTabClick(sender)
	if sender.index then
		local targetIdx = sender.index
		local isBack = targetIdx < self.currentPageIndex

		self:_onToSomePage(targetIdx, isBack)
	end
end

function DragTwoPages:onNextPage(pageController, isNext)
	if isNext > 0 then
		if self.currentPageIndex >= self.maxPageIndex and not self.isLoop then
			pageController:BackToOri()

			return
		end

		self:onClickNextPage()
	else
		if self.currentPageIndex <= 1 and not self.isLoop then
			pageController:BackToOri()

			return
		end

		self:onClickPrePage()
	end
end

function DragTwoPages:onClickNextPage()
	if self.currentPageIndex >= self.maxPageIndex then
		if self.btnRangeMode == 1 then
			if self.maxRangeNotice then
				MsgManager.notice(self.maxRangeNotice)
			end
		else
			self:_onToSomePage(1)
		end
	else
		self:_onToSomePage(self.currentPageIndex + 1)
	end
end

function DragTwoPages:_onToSomePage(nextPage, isBack)
	if isBack then
		self["page" .. self.controllerIndex .. "Controller"]:GoToNext(1)

		self.currentPageIndex = nextPage
		self.controllerIndex = self.controllerIndex == 1 and 2 or 1

		self:onDragEvent()
		self.pages[self.controllerIndex]:setVisible(true)
		self.pages[self.controllerIndex]:setPosition(-self.pageSize.width, 0)
		self["page" .. self.controllerIndex .. "Controller"]:BackToOri()
		self:refreshBtn()
	else
		self["page" .. self.controllerIndex .. "Controller"]:GoToNext(0)

		self.currentPageIndex = nextPage
		self.controllerIndex = self.controllerIndex == 1 and 2 or 1

		self:onDragEvent()
		self.pages[self.controllerIndex]:setVisible(true)
		self.pages[self.controllerIndex]:setPosition(self.pageSize.width, 0)
		self["page" .. self.controllerIndex .. "Controller"]:BackToOri()
		self:refreshBtn()
	end
end

function DragTwoPages:onClickPrePage()
	if self.currentPageIndex <= 1 then
		if self.btnRangeMode == 1 then
			if self.firstRangeNotice then
				MsgManager.notice(self.firstRangeNotice)
			end
		else
			self:_onToSomePage(self.maxPageIndex, true)
		end
	else
		self:_onToSomePage(self.currentPageIndex - 1, true)
	end
end

function DragTwoPages:setOutRangeNotice(firstRangeNotice, maxRangeNotice)
	self.btnRangeMode = 1
	self.firstRangeNotice = firstRangeNotice
	self.maxRangeNotice = maxRangeNotice or firstRangeNotice
end

function DragTwoPages:refreshBtn()
	if self.preBtn and not self.isLoop and not self.btnRangeMode then
		if self.currentPageIndex <= 1 then
			self.preBtn:setVisible(false)
		else
			self.preBtn:setVisible(true)
		end

		if self.currentPageIndex >= self.maxPageIndex then
			self.nextBtn:setVisible(false)
		else
			self.nextBtn:setVisible(true)
		end
	end

	if self.currentTabBtn then
		self.currentTabBtn:setEnable(true)
	end

	if self.tabBtns[self.currentPageIndex] then
		self.tabBtns[self.currentPageIndex]:setEnable(false)

		self.currentTabBtn = self.tabBtns[self.currentPageIndex]
	end
end

return DragTwoPages
