-- chunkname: @modules/logic/versionactivity1_4/enter/view/VersionActivity1_4EnterView.lua

module("modules.logic.versionactivity1_4.enter.view.VersionActivity1_4EnterView", package.seeall)

local VersionActivity1_4EnterView = class("VersionActivity1_4EnterView", VersionActivityEnterBaseView)

function VersionActivity1_4EnterView:onInitView()
	VersionActivity1_4EnterView.super.onInitView(self)

	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "img/#simage_bg/img/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "img/#simage_bg/img/#simage_bg2")
	self._simagebg3 = gohelper.findChildSingleImage(self.viewGO, "img/#simage_bg/img/#simage_bg3")
	self._simagebg4 = gohelper.findChildSingleImage(self.viewGO, "img/#simage_bg/img/#simage_bg4")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "img/#simage_mask")
	self._txtremainday = gohelper.findChildText(self.viewGO, "logo/Time/#txt_remaintime")
	self._txttime = gohelper.findChildText(self.viewGO, "logo/Time/#txt_time")
	self.goTabNode = gohelper.findChild(self.viewGO, "logo/#go_change")
	self._btnmainentrance = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_mainentrance")
	self._btnroom = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_room")
	self._btnachievement = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_achievement")
	self._btnseasonstore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_seasonstore")
	self._txtseasonstorenum = gohelper.findChildText(self.viewGO, "entrance/#btn_seasonstore/normal/storeBG/#txt_num")
	self._txtseasonstoretime = gohelper.findChildText(self.viewGO, "entrance/#btn_seasonstore/normal/#go_bg1/#txt_time")

	self:initTab()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_4EnterView:addEvents()
	VersionActivity1_4EnterView.super.addEvents(self)
	self._btnmainentrance:AddClickListener(self._onClickMainentranceBtn, self)
	self._btnroom:AddClickListener(self._onClickRoomBtn, self)
	self._btnachievement:AddClickListener(self._onClickAchievementBtn, self)
	self._btnseasonstore:AddClickListener(self._btnseasonstoreOnClick, self)
end

function VersionActivity1_4EnterView:removeEvents()
	VersionActivity1_4EnterView.super.removeEvents(self)
	self._btnmainentrance:RemoveClickListener()
	self._btnroom:RemoveClickListener()
	self._btnachievement:RemoveClickListener()
	self._btnseasonstore:RemoveClickListener()
end

function VersionActivity1_4EnterView:_btnseasonstoreOnClick()
	local actId = Activity104Model.instance:getCurSeasonId()
	local storeActId = Activity104Enum.SeasonStore[actId]
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(storeActId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToast(toastId, toastParam)
		end

		return
	end

	Activity104Controller.instance:openSeasonStoreView()
end

function VersionActivity1_4EnterView:_onClickMainentranceBtn()
	GameFacade.jump(51)
end

function VersionActivity1_4EnterView:_onClickRoomBtn()
	GameFacade.jump(440001)
end

function VersionActivity1_4EnterView:_onClickAchievementBtn()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			selectType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function VersionActivity1_4EnterView:_editableInitView()
	VersionActivity1_4EnterView.super._editableInitView(self)
	self._simagebg1:LoadImage("singlebg/v1a4_enterview_singlebg/v1a4_enterview_fullbg_01.png")
	self._simagebg2:LoadImage("singlebg/v1a4_enterview_singlebg/v1a4_enterview_fullbg_02.png")
	self._simagebg3:LoadImage("singlebg/v1a4_enterview_singlebg/v1a4_enterview_fullbg_03.png")
	self._simagebg4:LoadImage("singlebg/v1a4_enterview_singlebg/v1a4_enterview_fullbg_04.png")
	self._simagemask:LoadImage("singlebg/v1a4_enterview_singlebg/v1a4_enterview_fullbgmask.png")
end

function VersionActivity1_4EnterView:onClickActivity1(actId)
	Activity133Controller.instance:openActivity133MainView(actId)
end

function VersionActivity1_4EnterView:onClickActivity2()
	Activity130Controller.instance:enterActivity130()
end

function VersionActivity1_4EnterView:onClickActivity3()
	BossRushController.instance:openMainView()
end

function VersionActivity1_4EnterView:onClickActivity4(actId)
	ViewMgr.instance:openView(ViewName.VersionActivity1_4TaskView, {
		activityId = actId
	})
end

function VersionActivity1_4EnterView:onClickActivity5(actId)
	ViewMgr.instance:openView(ViewName.Activity129View, {
		actId = actId
	})
end

function VersionActivity1_4EnterView:onClickActivity6(actId)
	ViewMgr.instance:openView(ViewName.VersionActivity1_4DungeonView, {
		actId = actId
	})
end

function VersionActivity1_4EnterView:onClickActivity7(actId)
	BossRushController.instance:openMainView()
end

function VersionActivity1_4EnterView:onClickActivity8(actId)
	Activity104Controller.instance:openSeasonMainView()
end

function VersionActivity1_4EnterView:onClickActivity9(actId)
	Activity134Controller.instance:openActivity134MainView(actId)
end

function VersionActivity1_4EnterView:onClickActivity10()
	Activity131Controller.instance:enterActivity131()
end

function VersionActivity1_4EnterView:onClickActivity11(actId)
	ViewMgr.instance:openView(ViewName.Activity129View, {
		actId = actId
	})
end

function VersionActivity1_4EnterView:onClickActivity12(actId)
	ViewMgr.instance:openView(ViewName.VersionActivity1_4DungeonView, {
		actId = actId
	})
end

function VersionActivity1_4EnterView:onOpen()
	self.onOpening = true

	self:initViewParam()
	self:initActivityNode()
	self:initActivityItemList()

	for i = 2, 1, -1 do
		if self:checkTabIsOpen(i, true) then
			self:onChangeTab(i)

			break
		end
	end

	self:playOpenAnimation()
end

function VersionActivity1_4EnterView:playOpenAnimation()
	local openAnim = self.tabIndex == VersionActivity1_4Enum.TabEnum.First and "open_a" or "open_b"

	if self.skipOpenAnim then
		self.animator:Play(openAnim, 0, 1)
		TaskDispatcher.runDelay(self.onOpenAnimationDone, self, 0.5)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_open)
		self.animator:Play(openAnim)
		TaskDispatcher.runDelay(self.onOpenAnimationDone, self, 2)
	end
end

function VersionActivity1_4EnterView:refreshUI()
	gohelper.setActive(self._btnroom, self.tabIndex == VersionActivity1_4Enum.TabEnum.First)
	self:refreshRemainTime()
	self:refreshCenterActUI()
	self:refreshActivityUI()
	self:refreshSeasonStore()
	self:refreshTabRed()
end

function VersionActivity1_4EnterView:refreshActivityItem(activityItem)
	local index = activityItem.index

	if not self.actIndex2TabIndex then
		self.actIndex2TabIndex = {}

		for tabIdx, actList in pairs(VersionActivity1_4Enum.TabActivityList) do
			for i, actIdx in ipairs(actList) do
				self.actIndex2TabIndex[actIdx] = tabIdx
			end
		end
	end

	local isVisible = self.actIndex2TabIndex[index] == self.tabIndex

	gohelper.setActive(activityItem.rootGo, isVisible)

	if not isVisible then
		return
	end

	VersionActivity1_4EnterView.super.refreshActivityItem(self, activityItem)
end

function VersionActivity1_4EnterView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
	local hourSecond = offsetSecond % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)

	self._txtremainday.text = string.format(luaLang("remain"), string.format("%s%s%s%s", day, luaLang("time_day"), hour, luaLang("time_hour2")))
end

function VersionActivity1_4EnterView:refreshEnterViewTime()
	self:refreshRemainTime()
	self:refreshSeasonStore()
end

function VersionActivity1_4EnterView:onRefreshActivity5(activityItem)
	local status = ActivityHelper.getActivityStatus(activityItem.actId)
	local goTime = gohelper.findChild(activityItem.goNormal, "#go_bg1")
	local goNum = gohelper.findChild(activityItem.goNormal, "storeBG")

	gohelper.setActive(goTime, status == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(goNum, status == ActivityEnum.ActivityStatus.Normal)

	if status == ActivityEnum.ActivityStatus.Normal then
		local actInfoMo = ActivityModel.instance:getActMO(activityItem.actId)
		local txtTime = gohelper.findChildTextMesh(activityItem.goNormal, "#go_bg1/#txt_time")

		txtTime.text = actInfoMo:getRemainTimeStr(true)

		local txtNum = gohelper.findChildTextMesh(activityItem.goNormal, "storeBG/#txt_num")
		local currencyId = Activity129Config.instance:getConstValue1(activityItem.actId, Activity129Enum.ConstEnum.CostId)
		local quantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, currencyId)

		txtNum.text = tostring(quantity)
	end
end

function VersionActivity1_4EnterView:onRefreshActivity8(activityItem)
	local status = ActivityHelper.getActivityStatus(activityItem.actId)
	local isNormal = status == ActivityEnum.ActivityStatus.Normal
	local goWeek = gohelper.findChild(activityItem.goNormal, "week")
	local goScore = gohelper.findChild(activityItem.goNormal, "score")

	gohelper.setActive(goWeek, isNormal and Activity104Model.instance:isEnterSpecial())
	gohelper.setActive(goScore, isNormal)

	if isNormal and Activity104Model.instance:tryGetActivityInfo(activityItem.actId, self.checkNeedRefreshUI, self) then
		local stage = Activity104Model.instance:getAct104CurStage()
		local stage7 = gohelper.findChildImage(activityItem.rootGo, "normal/score/stage7")

		gohelper.setActive(stage7, stage == 7)

		for i = 1, 7 do
			local image = gohelper.findChildImage(activityItem.rootGo, "normal/score/stage" .. i)

			UISpriteSetMgr.instance:setV1a4EnterViewSprite(image, i <= stage and "v1a4_enterview_scorefg" or "v1a4_enterview_scorebg", true)
		end
	end
end

function VersionActivity1_4EnterView:onRefreshActivity11(activityItem)
	local status = ActivityHelper.getActivityStatus(activityItem.actId)
	local goTime = gohelper.findChild(activityItem.goNormal, "#go_bg1")
	local goNum = gohelper.findChild(activityItem.goNormal, "storeBG")

	gohelper.setActive(goTime, status == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(goNum, status == ActivityEnum.ActivityStatus.Normal)

	if status == ActivityEnum.ActivityStatus.Normal then
		local actInfoMo = ActivityModel.instance:getActMO(activityItem.actId)
		local txtTime = gohelper.findChildTextMesh(activityItem.goNormal, "#go_bg1/#txt_time")

		txtTime.text = actInfoMo:getRemainTimeStr(true)

		local txtNum = gohelper.findChildTextMesh(activityItem.goNormal, "storeBG/#txt_num")
		local currencyId = Activity129Config.instance:getConstValue1(activityItem.actId, Activity129Enum.ConstEnum.CostId)
		local quantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, currencyId)

		txtNum.text = tostring(quantity)
	end
end

function VersionActivity1_4EnterView:refreshSeasonStore()
	if self.tabIndex == VersionActivity1_4Enum.TabEnum.First then
		gohelper.setActive(self._btnseasonstore, false)

		return
	end

	local actId = Activity104Model.instance:getCurSeasonId()
	local activityStatus = ActivityHelper.getActivityStatus(actId)

	if activityStatus == ActivityEnum.ActivityStatus.Normal then
		gohelper.setActive(self._btnseasonstore, false)

		return
	end

	local storeActId = Activity104Enum.SeasonStore[actId]
	local storeActivityStatus = ActivityHelper.getActivityStatus(storeActId)

	gohelper.setActive(self._btnseasonstore, storeActivityStatus == ActivityEnum.ActivityStatus.Normal)

	if storeActivityStatus ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	local currencyMO = CurrencyModel.instance:getCurrency(Activity104Enum.StoreUTTU[actId])

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtseasonstorenum.text = GameUtil.numberDisplay(quantity)

			local actInfoMo = ActivityModel.instance:getActMO(storeActId)

			self._txtseasonstoretime.text = actInfoMo and actInfoMo:getRemainTimeStr2ByEndTime(true) or ""
		end
	end
end

function VersionActivity1_4EnterView:getSeasonStoreActivity()
	local actId = Activity104Model.instance:getCurSeasonId()
	local activityStatus = ActivityHelper.getActivityStatus(actId)

	if activityStatus == ActivityEnum.ActivityStatus.Normal then
		return false
	end

	local storeActId = Activity104Enum.SeasonStore[actId]
	local storeActivityStatus = ActivityHelper.getActivityStatus(storeActId)

	return storeActivityStatus == ActivityEnum.ActivityStatus.Normal
end

function VersionActivity1_4EnterView:everyMinuteCall()
	VersionActivity1_4EnterView.super.everyMinuteCall(self)
	self:refreshEnterViewTime()
end

function VersionActivity1_4EnterView:playBgm()
	return
end

function VersionActivity1_4EnterView:stopBgm()
	return
end

function VersionActivity1_4EnterView:initTab()
	self.tabList = {}

	for i = 1, 2 do
		self.tabList[i] = self:createTab(i)
	end
end

function VersionActivity1_4EnterView:createTab(index)
	local item = self:getUserDataTb_()

	item.go = gohelper.findChild(self.goTabNode, string.format("Item%s", index))
	item.goSelect = gohelper.findChild(item.go, "#btn_select")
	item.btn = gohelper.findButtonWithAudio(item.go, AudioEnum.UI.play_ui_leimi_theft_open)

	item.btn:AddClickListener(self.onChangeTab, self, index)

	item.goRed = gohelper.findChild(item.go, "#go_reddot")

	return item
end

function VersionActivity1_4EnterView:refreshTabRed()
	for i, v in ipairs(self.tabList) do
		if not v.redDot then
			local redDotId = i == VersionActivity1_4Enum.TabEnum.First and 1075 or 1088

			v.redDot = RedDotController.instance:addRedDot(v.goRed, redDotId)
		else
			v.redDot:refreshDot()
		end
	end
end

function VersionActivity1_4EnterView:destoryTab(item)
	if item then
		item.btn:RemoveClickListener()
	end
end

function VersionActivity1_4EnterView:onChangeTab(index)
	if self.tabIndex == index then
		return
	end

	if not self:checkTabIsOpen(index) then
		return
	end

	local isSwitch = self.tabIndex ~= nil

	self.tabIndex = index

	gohelper.setActive(self._btnachievement, true)

	for i, v in ipairs(self.tabList) do
		gohelper.setActive(v.goSelect, self.tabIndex == i)
	end

	TaskDispatcher.cancelTask(self.onSwitchAnimEnd, self)

	if isSwitch then
		local switchAnim = self.tabIndex == VersionActivity1_4Enum.TabEnum.First and "switch_b" or "switch_a"

		self.animator:Play(switchAnim)

		for _, activityItem in ipairs(self.activityItemList) do
			gohelper.setActive(activityItem.rootGo, true)
		end

		gohelper.setActive(self._btnroom, true)

		if self:getSeasonStoreActivity() then
			gohelper.setActive(self._btnseasonstore, true)
		end

		local time = 0.5

		TaskDispatcher.runDelay(self.onSwitchAnimEnd, self, time)
	else
		self:onSwitchAnimEnd()
	end
end

function VersionActivity1_4EnterView:onSwitchAnimEnd()
	self:refreshUI()
end

function VersionActivity1_4EnterView:checkTabIsOpen(index, noToast)
	local actId = VersionActivity1_4Enum.ActivityId.EnterView

	if index == VersionActivity1_4Enum.TabEnum.Second then
		actId = VersionActivity1_4Enum.ActivityId.SecondEnter
	end

	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if not noToast then
			if status == ActivityEnum.ActivityStatus.NotOpen then
				local actInfo = ActivityModel.instance:getActMO(actId)
				local leftTime = actInfo:getRealStartTimeStamp() - ServerTime.now()
				local actName = actInfo.config.name
				local timeStr = TimeUtil.getFormatTime2(leftTime)

				GameFacade.showToast(ToastEnum.V1a4_ActPreTips, actName, timeStr)
			elseif toastId then
				GameFacade.showToast(toastId, toastParam)
			end
		end

		return false
	end

	return true
end

function VersionActivity1_4EnterView:onDestroyView()
	TaskDispatcher.cancelTask(self.onSwitchAnimEnd, self)
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
	self._simagebg3:UnLoadImage()
	self._simagebg4:UnLoadImage()
	self._simagemask:UnLoadImage()

	if self.tabList then
		for k, v in pairs(self.tabList) do
			self:destoryTab(v)
		end

		self.tabList = nil
	end

	VersionActivity1_4EnterView.super.onDestroyView(self)
end

return VersionActivity1_4EnterView
