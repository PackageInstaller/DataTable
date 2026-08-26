-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/observerbox/view/ObserverBoxView.lua

module("modules.logic.versionactivity3_4.laplaceforum.observerbox.view.ObserverBoxView", package.seeall)

local ObserverBoxView = class("ObserverBoxView", BaseView)

function ObserverBoxView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "root/#simage_FullBG")
	self._txtleftnum = gohelper.findChildText(self.viewGO, "root/left/#txt_leftnum")
	self._gotips = gohelper.findChild(self.viewGO, "root/left/#go_tips")
	self._gotiptxt1 = gohelper.findChild(self.viewGO, "root/left/#go_tips/#go_txt1")
	self._txttiptxt1 = gohelper.findChildText(self.viewGO, "root/left/#go_tips/#go_txt1")
	self._gotiptxt2 = gohelper.findChild(self.viewGO, "root/left/#go_tips/#go_txt2")
	self._gocarditem = gohelper.findChild(self.viewGO, "root/left/grid/#go_carditem")
	self._simageItem = gohelper.findChildSingleImage(self.viewGO, "root/left/grid/#go_carditem/OptionalItem/#simage_Item")
	self._txtNum = gohelper.findChildText(self.viewGO, "root/left/grid/#go_carditem/OptionalItem/image_NumBG/#txt_Num")
	self._txtTips = gohelper.findChildText(self.viewGO, "root/left/Tips/#txt_Tips")
	self._goFinish = gohelper.findChild(self.viewGO, "root/left/Tips/#go_Finish")
	self._btnleftarrow = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/#btn_leftarrow")
	self._btnrightarrow = gohelper.findChildButtonWithAudio(self.viewGO, "root/left/#btn_rightarrow")
	self._txttime = gohelper.findChildText(self.viewGO, "root/right/Time/#txt_time")
	self._txtlimitnum = gohelper.findChildText(self.viewGO, "root/right/Times/txt_times/#txt_limitnum")
	self._gotimeseff = gohelper.findChild(self.viewGO, "root/right/Times/Image_TimesBG/Image_Timeslight")
	self._gotaskitem = gohelper.findChild(self.viewGO, "root/right/task/#go_taskitem")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ObserverBoxView:addEvents()
	self._btnleftarrow:AddClickListener(self._btnleftarrowOnClick, self)
	self._btnrightarrow:AddClickListener(self._btnrightarrowOnClick, self)
end

function ObserverBoxView:removeEvents()
	self._btnleftarrow:RemoveClickListener()
	self._btnrightarrow:RemoveClickListener()
end

function ObserverBoxView:_btnleftarrowOnClick()
	ObserverBoxModel.instance:setCurPage(1)
	self:_refreshInfo()
	self:_refreshCards()
end

function ObserverBoxView:_btnrightarrowOnClick()
	ObserverBoxModel.instance:setCurPage(2)
	self:_refreshInfo()
	self:_refreshCards()
end

function ObserverBoxView:_editableInitView()
	self._actId = VersionActivity3_4Enum.ActivityId.LaplaceObserverBox
	self._cardItems = self:getUserDataTb_()
	self._taskItems = self:getUserDataTb_()

	gohelper.setActive(self._gocarditem, false)
	gohelper.setActive(self._gotaskitem, false)
	self:_addSelfEvents()
end

function ObserverBoxView:_addSelfEvents()
	self.addEventCb(self, ObserverBoxController.instance, ObserverBoxEvent.RewardInfoChanged, self._refresh, self)
	self.addEventCb(self, ObserverBoxController.instance, ObserverBoxEvent.RewardBonusGetFinished, self._onBonusGetDone, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onTaskFinishDone, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._onTaskFinishDone, self)
end

function ObserverBoxView:_removeSelfEvents()
	self.removeEventCb(self, ObserverBoxController.instance, ObserverBoxEvent.RewardInfoChanged, self._refresh, self)
	self.removeEventCb(self, ObserverBoxController.instance, ObserverBoxEvent.RewardBonusGetFinished, self._onBonusGetDone, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onTaskFinishDone, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._onTaskFinishDone, self)
end

function ObserverBoxView:onOpen()
	TaskDispatcher.runRepeat(self._refreshTime, self, 1)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)

	self._couldGetCount = ObserverBoxModel.instance:couldGetCardCount()

	self:_refreshTime()
	self:_refresh()
end

function ObserverBoxView:_refreshTime()
	self._txttime.text = ActivityModel.getRemainTimeStr(self._actId)
end

function ObserverBoxView:_refresh()
	self:_refreshInfo()
	self:_refreshCards()
	self:_refreshTasks()
end

function ObserverBoxView:_onBonusGetDone()
	local curPage = ObserverBoxModel.instance:getCurPage()
	local hasAllGet = ObserverBoxModel.instance:isPageAllCardGet(curPage)

	if hasAllGet then
		local maxPage = ObserverBoxModel.instance:getMaxPage()

		if curPage < maxPage then
			ObserverBoxModel.instance:setCurPage(curPage + 1)
		end
	end

	self:_refreshInfo()
	self:_refreshCards()
end

function ObserverBoxView:_onTaskFinishDone()
	local couldGetCount = ObserverBoxModel.instance:couldGetCardCount()

	if couldGetCount > 0 then
		if self._couldGetCount <= 0 then
			self:_refreshCards()
		end
	elseif self._couldGetCount > 0 then
		self:_refreshCards()
	end

	self:_refreshInfo()
	self:_refreshTasks()
end

function ObserverBoxView:_refreshInfo()
	local curPage = ObserverBoxModel.instance:getCurPage()
	local totalPage = ObserverBoxConfig.instance:getBoxCO(self._actId).totalBox

	self._txtleftnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("laplace_observerbox_pagetip"), {
		curPage,
		totalPage
	})

	local couldGetCount = ObserverBoxModel.instance:couldGetCardCount()

	if couldGetCount > self._couldGetCount then
		gohelper.setActive(self._gotimeseff, false)
		gohelper.setActive(self._gotimeseff, true)

		self._couldGetCount = couldGetCount
	end

	self._txtlimitnum.text = couldGetCount

	local isPageAllGet = ObserverBoxModel.instance:isPageAllCardGet(curPage)

	gohelper.setActive(self._gotiptxt1, not isPageAllGet)
	gohelper.setActive(self._gotiptxt2, isPageAllGet)

	if not isPageAllGet then
		local lockCount = ObserverBoxModel.instance:getLockCardCount(curPage)

		self._txttiptxt1.text = GameUtil.getSubPlaceholderLuaLang(luaLang("laplace_observerbox_unlocktimes"), {
			lockCount
		})
	end

	gohelper.setActive(self._btnleftarrow.gameObject, curPage > 1)

	local pageAllGet = ObserverBoxModel.instance:isPageAllCardGet(curPage)

	gohelper.setActive(self._btnrightarrow.gameObject, curPage < totalPage and pageAllGet)

	local maxPage = ObserverBoxModel.instance:getMaxPage()

	gohelper.setActive(self._txtTips.gameObject, curPage < maxPage)
	gohelper.setActive(self._goFinish, curPage == maxPage)
end

function ObserverBoxView:_refreshCards()
	local curPage = ObserverBoxModel.instance:getCurPage()

	if not self._curPage or self._curPage ~= curPage then
		if self._cardItems then
			for _, cardItem in pairs(self._cardItems) do
				cardItem:hide()
			end
		end

		self._curPage = curPage
	end

	local cardCos = ObserverBoxConfig.instance:getBoxListPageCos(curPage, self._actId)

	for _, cardCo in pairs(cardCos) do
		if not self._cardItems[cardCo.id] then
			self._cardItems[cardCo.id] = ObserverBoxCardItem.New()

			local go = gohelper.cloneInPlace(self._gocarditem)

			self._cardItems[cardCo.id]:init(go)
		end

		self._cardItems[cardCo.id]:refresh(cardCo.id, curPage)
	end
end

function ObserverBoxView:_refreshTasks()
	if self._taskItems then
		for _, taskItem in pairs(self._taskItems) do
			taskItem:hide()
		end
	end

	local taskMos = ObserverBoxModel.instance:getTaskList()

	for _, taskMo in pairs(taskMos) do
		if not self._taskItems[taskMo.id] then
			self._taskItems[taskMo.id] = ObserverBoxTaskItem.New()

			local go = gohelper.cloneInPlace(self._gotaskitem)

			self._taskItems[taskMo.id]:init(go)
		end

		self._taskItems[taskMo.id]:refresh(taskMo)
	end
end

function ObserverBoxView:onClose()
	ObserverBoxModel.instance:setCurPage(nil)
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

function ObserverBoxView:onDestroyView()
	self:_removeSelfEvents()

	if self._cardItems then
		for _, cardItem in pairs(self._cardItems) do
			cardItem:destroy()
		end

		self._cardItems = nil
	end

	if self._taskItems then
		for _, taskItem in pairs(self._taskItems) do
			taskItem:destroy()
		end

		self._taskItems = nil
	end
end

return ObserverBoxView
