-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3EntryView.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3EntryView", package.seeall)

local Season123_2_3EntryView = class("Season123_2_3EntryView", BaseView)

function Season123_2_3EntryView:onInitView()
	self._goentranceitem = gohelper.findChild(self.viewGO, "#go_entrance/#go_entrance_item")
	self._btnprev = gohelper.findChildButtonWithAudio(self.viewGO, "#go_entrance/#btn_prev")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "#go_entrance/#btn_next")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "leftbtns/#go_store/#btn_store")
	self._txtstoreCoinNum = gohelper.findChildText(self.viewGO, "leftbtns/#go_store/#txt_num")
	self._btnstory = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtns/#go_story/#btn_story")
	self._gostoryRedDot = gohelper.findChild(self.viewGO, "rightbtns/#go_story/#btn_story/#go_storyRedDot")
	self._btnequipBook = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtns/#go_celebrity/#btn_celebrity")
	self._btnoverview = gohelper.findChildButtonWithAudio(self.viewGO, "leftbtns/#btn_overview")
	self._btnachievement = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtns/#go_achievement/#btn_achievement")
	self._goachievementRedDot = gohelper.findChild(self.viewGO, "rightbtns/#go_achievement/#btn_achievement/#go_achievementRedDot")
	self._gocards = gohelper.findChild(self.viewGO, "rightbtns/#go_cards")
	self._btncards = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtns/#go_cards/#btn_cards")
	self._gohasget = gohelper.findChild(self.viewGO, "rightbtns/#go_cards/#go_hasget")
	self._txtcardPackageNum = gohelper.findChildText(self.viewGO, "rightbtns/#go_cards/#go_hasget/#txt_num")
	self._txtpropnum = gohelper.findChildText(self.viewGO, "rightbtns/#go_retail/#go_currency/#txt_propnum")
	self._goretail = gohelper.findChild(self.viewGO, "rightbtns/#go_retail")
	self._btnretail = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtns/#go_retail/#btn_retail")
	self._golight = gohelper.findChild(self.viewGO, "#go_entrance/light")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")
	self._txttime = gohelper.findChildText(self.viewGO, "#go_title/#txt_time")
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._animExcessive = self._goexcessive:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_3EntryView:addEvents()
	self._btnprev:AddClickListener(self._btnprevOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnstore:AddClickListener(self._btnStoreOnClick, self)
	self._btnstory:AddClickListener(self._btnStoryOnClick, self)
	self._btnequipBook:AddClickListener(self._btnEquipBookOnClick, self)
	self._btnoverview:AddClickListener(self._btnOverviewOnClick, self)
	self._btnachievement:AddClickListener(self._btnAchievementOnClick, self)
	self._btncards:AddClickListener(self._btnCardPackageOnClick, self)
	self._btnretail:AddClickListener(self._btnRetailOnClick, self)
end

function Season123_2_3EntryView:removeEvents()
	self._btnprev:RemoveClickListener()
	self._btnnext:RemoveClickListener()
	self._btnstore:RemoveClickListener()
	self._btnstory:RemoveClickListener()
	self._btnequipBook:RemoveClickListener()
	self._btnoverview:RemoveClickListener()
	self._btnachievement:RemoveClickListener()
	self._btncards:RemoveClickListener()
	self._btnretail:RemoveClickListener()
end

function Season123_2_3EntryView:_editableInitView()
	self._entryList = {}
	self._centerItem = nil
end

function Season123_2_3EntryView:onDestroyView()
	if self._centerItem then
		self._centerItem:dispose()

		self._centerItem = nil
	end

	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	Season123EntryController.instance:onCloseView()
end

function Season123_2_3EntryView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.season123_entryview_open)

	local actId = self.viewParam.actId

	self.addEventCb(self, Season123Controller.instance, Season123Event.GetActInfo, self.handleGetActInfo, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.StageInfoChanged, self.refreshCenter, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.TaskUpdated, self.refreshCenter, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.StageFinishWithoutStory, self.handleStageFinishWithoutStory, self)
	self.addEventCb(self, Season123EntryController.instance, Season123Event.EntrySceneLoaded, self.handleSceneLoaded, self)
	self.addEventCb(self, Season123EntryController.instance, Season123Event.EntryStageChanged, self.refreshUI, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.refreshCardPackageUI, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.handleItemChanged, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.handleItemChanged, self)
	self.addEventCb(self, Season123Controller.instance, Season123Event.OtherViewAutoOpened, self.handleOtherViewAutoOpened, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseView, self)
	Season123EntryController.instance:onOpenView(actId)

	local actMO = ActivityModel.instance:getActMO(actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		return
	end

	self:checkFirstOpenOverview()
	self:checkSceneLoaded()
	self:refreshUI()
	self:initRedDot()
	Season123Controller.instance:dispatchEvent(Season123Event.GuideEntryOtherViewPop)

	if self.viewParam.jumpId then
		Season123EntryController.instance:processJumpParam(self.viewParam)
	else
		Season123Controller.instance:dispatchEvent(Season123Event.GuideEntryOtherViewClose)
	end

	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 1)
end

function Season123_2_3EntryView:onClose()
	TaskDispatcher.cancelTask(self._switchStage, self)
	TaskDispatcher.cancelTask(self._enterRetailView, self)
	TaskDispatcher.cancelTask(self._endBlock, self)
	TaskDispatcher.cancelTask(self._autoClickNext, self)
end

function Season123_2_3EntryView:checkFirstOpenOverview()
	local isFirstOpen = Season123EntryModel.instance:isFirstOpen()

	if isFirstOpen then
		Season123Controller.instance:openSeasonOverview({
			actId = self.viewParam.actId
		})
		Season123EntryModel.instance:setAlreadyVisited(self.viewParam.actId)
	end
end

function Season123_2_3EntryView:checkSceneIsLoaded()
	return
end

function Season123_2_3EntryView:refreshUI()
	local actMO = ActivityModel.instance:getActMO(self.viewParam.actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		return
	end

	self:refreshCenter()
	self:refreshPageBtn()
	self:refreshCardPackageUI()
	self:refreshUTTURetailTicket()
	self:refreshStoreCoin()
	self:checkHasReadUnlockStory()
	self:refreshRemainTime()
end

function Season123_2_3EntryView:refreshCenter()
	if self._centerItem then
		self._centerItem:refreshUI()
	end

	local rs, reason, value = Season123ProgressUtils.isStageUnlock(self.viewParam.actId, Season123EntryModel.instance:getCurrentStage())

	gohelper.setActive(self._golight, rs)
	self:checkHasReadUnlockStory()
end

function Season123_2_3EntryView:refreshPageBtn()
	local stageList = Season123Config.instance:getStageCos(Season123EntryModel.instance.activityId)

	if not stageList or #stageList <= 1 then
		gohelper.setActive(self._btnprev, false)
		gohelper.setActive(self._btnnext, false)

		return
	end

	local index = Season123EntryModel.instance:getCurrentStageIndex()

	gohelper.setActive(self._btnprev, index > 1)
	gohelper.setActive(self._btnnext, index < #stageList)
end

function Season123_2_3EntryView:refreshCardPackageUI()
	local cardPackageCount = Season123CardPackageModel.instance:initPackageCount()

	self._btncards.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = cardPackageCount == 0 and 0.5 or 1
	self._txtcardPackageNum.text = cardPackageCount

	gohelper.setActive(self._gohasget, cardPackageCount > 0)
end

function Season123_2_3EntryView:refreshUTTURetailTicket()
	local isFunctionOpen = Season123EntryModel.instance:isRetailOpen()

	gohelper.setActive(self._goretail, isFunctionOpen)

	if isFunctionOpen then
		local curNum, maxNum = Season123EntryModel.instance:getUTTUTicketNum()

		self._hasEnoughTicket = curNum >= 1

		if curNum == 0 then
			if not ("<color=#CF4543>" .. curNum .. "</color>/" .. maxNum) then
				self._txtpropnum.text = curNum .. "/" .. maxNum
			end
		end
	end
end

function Season123_2_3EntryView:refreshStoreCoin()
	local storeCoinId = Season123Config.instance:getSeasonConstNum(self.viewParam.actId, Activity123Enum.Const.StoreCoinId)
	local currencyMO = CurrencyModel.instance:getCurrency(storeCoinId)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtstoreCoinNum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function Season123_2_3EntryView:refreshRemainTime()
	local actMO = ActivityModel.instance:getActMO(self.viewParam.actId)

	if not actMO then
		return
	end

	local offsetSecond = actMO:getRealEndTimeStamp() - ServerTime.now()

	self._txttime.text = offsetSecond > 0 and TimeUtil.SecondToActivityTimeFormat(offsetSecond) or luaLang("ended")
end

function Season123_2_3EntryView:handleGetActInfo(actId)
	if self.viewParam.actId == actId then
		self:refreshUI()
	end
end

function Season123_2_3EntryView:handleOtherViewAutoOpened()
	self._anim:Play(Season123_2_3EntryView.Anim.Close)
end

function Season123_2_3EntryView:handleItemChanged()
	self:refreshUTTURetailTicket()
	self:refreshStoreCoin()
end

function Season123_2_3EntryView:handleSceneLoaded()
	self:checkSceneLoaded()
end

function Season123_2_3EntryView:handleStageFinishWithoutStory()
	if self._anim then
		self._anim:Play(Season123_2_3EntryView.Anim.Switch, 0, 0)
	end
end

function Season123_2_3EntryView:checkSceneLoaded()
	if self._isCenterInited then
		return
	end

	local sceneRoot = CameraMgr.instance:getSceneRoot()
	local sceneGO = gohelper.findChild(sceneRoot, "Season123_2_3EntryScene/scene")

	if sceneGO then
		gohelper.setActive(self._goentranceitem, true)

		self._centerItem = Season123_2_3EntryItem.New()

		self._centerItem:init(self._goentranceitem, self._anim)
		self._centerItem:initData(self.viewParam.actId)

		self._isCenterInited = true
	end
end

function Season123_2_3EntryView:_btnprevOnClick()
	UIBlockMgrExtend.instance:setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("switchStage")
	self._animExcessive:Play(Season123_2_3EntryView.Anim.Hard)
	AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_switch)

	self.isNext = false

	TaskDispatcher.runDelay(self._switchStage, self, 0.5)
	TaskDispatcher.runDelay(self._endBlock, self, 1)
end

function Season123_2_3EntryView:_btnnextOnClick()
	UIBlockMgrExtend.instance:setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("switchStage")
	self._animExcessive:Play(Season123_2_3EntryView.Anim.Story)
	AudioMgr.instance:trigger(AudioEnum.UI.season123_stage_switch)

	self.isNext = true

	TaskDispatcher.runDelay(self._switchStage, self, 0.5)
	TaskDispatcher.runDelay(self._endBlock, self, 1)
end

function Season123_2_3EntryView:_btnStoreOnClick()
	Season123Controller.instance:openSeasonStoreView(self.viewParam.actId)
end

function Season123_2_3EntryView:_btnStoryOnClick()
	Season123Controller.instance:openSeasonStoryView({
		actId = self.viewParam.actId
	})
end

function Season123_2_3EntryView:_btnEquipBookOnClick()
	Season123Controller.instance:openSeasonEquipBookView(self.viewParam.actId)
end

function Season123_2_3EntryView:_btnOverviewOnClick()
	Season123Controller.instance:openSeasonOverview({
		actId = self.viewParam.actId
	})
end

function Season123_2_3EntryView:_btnAchievementOnClick()
	Season123Controller.instance:openSeasonTaskView({
		actId = self.viewParam.actId
	})
end

function Season123_2_3EntryView:_btnCardPackageOnClick()
	Season123Controller.instance:openSeasonCardPackageView({
		actId = self.viewParam.actId
	})
end

function Season123_2_3EntryView:_btnRetailOnClick()
	if not self._isCenterInited then
		return
	end

	self._anim:Play(Season123_2_3EntryView.Anim.Close)
	TaskDispatcher.runDelay(self._enterRetailView, self, 0.17)
end

function Season123_2_3EntryView:_enterRetailView()
	Season123Controller.instance:openSeasonRetail({
		actId = self.viewParam.actId
	})
end

function Season123_2_3EntryView:_btnTrialOnClick()
	Season123EntryController.instance:enterTrailFightScene()
end

function Season123_2_3EntryView:onCloseView(viewName)
	if viewName == ViewName.Season123_2_3EpisodeListView then
		self._anim:Play(Season123_2_3EntryView.Anim.Switch1, 0, 0)
	end

	if viewName == ViewName.Season123_2_3RetailView then
		self._anim:Play(Season123_2_3EntryView.Anim.Switch, 0, 0)
	end

	if viewName == ViewName.Season123_2_3StoryPagePopView then
		self._anim:Play(Season123_2_3EntryView.Anim.Switch, 0, 0)
		TaskDispatcher.runDelay(self._autoClickNext, self, 0.5)
	end
end

function Season123_2_3EntryView:_switchStage()
	Season123EntryController.instance:switchStage(self.isNext)

	self.isNext = nil
end

function Season123_2_3EntryView:_endBlock()
	UIBlockMgr.instance:endBlock("switchStage")
	UIBlockMgrExtend.instance:setNeedCircleMv(true)
end

function Season123_2_3EntryView:initRedDot()
	local mutiRedDotData = {}

	for i = 1, 6 do
		table.insert(mutiRedDotData, {
			id = RedDotEnum.DotNode.Season123StageReward,
			uid = i
		})
	end

	table.insert(mutiRedDotData, {
		id = RedDotEnum.DotNode.Season123Task
	})
	RedDotController.instance:addMultiRedDot(self._goachievementRedDot, mutiRedDotData)
	RedDotController.instance:addRedDot(self._gostoryRedDot, RedDotEnum.DotNode.Season123Story)
end

function Season123_2_3EntryView:checkHasReadUnlockStory()
	Season123Controller.instance:checkHasReadUnlockStory(self.viewParam.actId)
end

function Season123_2_3EntryView:_autoClickNext()
	local seasonMO = Season123Model.instance:getActInfo(self.viewParam.actId)

	if seasonMO then
		local stageMO = seasonMO:getCurrentStage()

		if stageMO and not Season123Config.instance:isLastStage(self.viewParam.actId, stageMO.stage) then
			self:_btnnextOnClick()
		end
	end
end

Season123_2_3EntryView.Anim = {
	Story = "story",
	Close = "close",
	Switch1 = "switch1",
	Switch = "swicth",
	Hard = "hard"
}

return Season123_2_3EntryView
