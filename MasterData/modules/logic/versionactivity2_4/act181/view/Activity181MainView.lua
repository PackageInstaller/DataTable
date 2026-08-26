-- chunkname: @modules/logic/versionactivity2_4/act181/view/Activity181MainView.lua

module("modules.logic.versionactivity2_4.act181.view.Activity181MainView", package.seeall)

local Activity181MainView = class("Activity181MainView", BaseView)

Activity181MainView.OPEN_ANIM = "open"
Activity181MainView.OPEN_ANIM_FIRST_DAY = "openfrist"
Activity181MainView.POP_UP_DELAY = 0.8

function Activity181MainView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageBoxShadow = gohelper.findChildSingleImage(self.viewGO, "Box/#simage_BoxShadow")
	self._simageBoxShadow2 = gohelper.findChildSingleImage(self.viewGO, "Box/#simage_BoxShadow2")
	self._simageBox = gohelper.findChildSingleImage(self.viewGO, "Box/#simage_Box")
	self._txtOpenTimes = gohelper.findChildText(self.viewGO, "Box/OpenTimes/#txt_OpenTimes")
	self._goClaimed = gohelper.findChild(self.viewGO, "Box/OpenTimes/#go_Claimed")
	self._goItem = gohelper.findChild(self.viewGO, "Box/Grid/#go_Item")
	self._simageItem = gohelper.findChildSingleImage(self.viewGO, "Box/Grid/#go_Item/OptionalItem/#simage_Item")
	self._txtNum = gohelper.findChildText(self.viewGO, "Box/Grid/#go_Item/OptionalItem/image_NumBG/#txt_Num")
	self._txtItemName = gohelper.findChildText(self.viewGO, "Box/Grid/#go_Item/OptionalItem/#txt_ItemName")
	self._goCover = gohelper.findChild(self.viewGO, "Box/Grid/#go_Item/#go_Cover")
	self._goType1 = gohelper.findChild(self.viewGO, "Box/Grid/#go_Item/#go_Cover/#go_Type1")
	self._goType2 = gohelper.findChild(self.viewGO, "Box/Grid/#go_Item/#go_Cover/#go_Type2")
	self._goType3 = gohelper.findChild(self.viewGO, "Box/Grid/#go_Item/#go_Cover/#go_Type3")
	self._goType4 = gohelper.findChild(self.viewGO, "Box/Grid/#go_Item/#go_Cover/#go_Type4")
	self._goTips1 = gohelper.findChild(self.viewGO, "Box/Tips/#go_Tips1")
	self._goTips2 = gohelper.findChild(self.viewGO, "Box/Tips/#go_Tips2")
	self._btnInfo = gohelper.findChildButtonWithAudio(self.viewGO, "Reward/#btn_Info")
	self._btnSpInfo = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Reward/#btn_SpInfo")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/#txt_Descr")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	self._btnspBonus = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Reward/image_Reward/#btn_spBonus")
	self._goCanGet = gohelper.findChild(self.viewGO, "Right/Reward/#go_CanGet")
	self._goSpClaimed = gohelper.findChild(self.viewGO, "Right/Reward/#go_SpClaimed")
	self._simageRewardName = gohelper.findChildSingleImage(self.viewGO, "Right/Reward/#simage_RewardName")
	self._txtRewardDescr = gohelper.findChildText(self.viewGO, "Right/Reward/#txt_RewardDescr")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity181MainView:addEvents()
	self._btnInfo:AddClickListener(self._btnInfoOnClick, self)
	self._btnspBonus:AddClickListener(self._btnspBonusOnClick, self)
	self._btnSpInfo:AddClickListener(self._btnSpInfoOnClick, self)
	Activity181Controller.instance:registerCallback(Activity181Event.OnGetBonus, self.onGetBonus, self)
	Activity181Controller.instance:registerCallback(Activity181Event.OnGetInfo, self.refreshUI, self)
	Activity181Controller.instance:registerCallback(Activity181Event.OnGetSPBonus, self.onGetSPBonus, self)
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneSecond)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.updateInfo, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDay, self.refreshSpBonusZeroTime, self)
end

function Activity181MainView:removeEvents()
	self._btnInfo:RemoveClickListener()
	self._btnspBonus:RemoveClickListener()
	self._btnSpInfo:RemoveClickListener()
	Activity181Controller.instance:unregisterCallback(Activity181Event.OnGetBonus, self.onGetBonus, self)
	Activity181Controller.instance:unregisterCallback(Activity181Event.OnGetInfo, self.refreshUI, self)
	Activity181Controller.instance:unregisterCallback(Activity181Event.OnGetSPBonus, self.onGetSPBonus, self)
	TaskDispatcher.cancelTask(self.refreshTime, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.updateInfo, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDay, self.refreshSpBonusZeroTime, self)
end

function Activity181MainView:_btnspBonusOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)

	if not Activity181Model.instance:isActivityInTime(self._actId) then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	local mo = Activity181Model.instance:getActivityInfo(self._actId)

	if not mo then
		return
	end

	if mo.spBonusState == Activity181Enum.SPBonusState.Locked then
		GameFacade.showToast(ToastEnum.NorSign)

		return
	elseif mo.spBonusState == Activity181Enum.SPBonusState.HaveGet then
		local param = string.splitToNumber(mo.config.bonus, "#")

		MaterialTipController.instance:showMaterialInfo(param[1], param[2], false)

		return
	end

	if Activity181Model.instance:getPopUpPauseState() then
		return
	end

	Activity181Controller.instance:getSPBonus(self._actId)
end

function Activity181MainView:_btnSpInfoOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)

	local mo = Activity181Model.instance:getActivityInfo(self._actId)

	if not mo then
		return
	end

	local param = string.splitToNumber(mo.config.bonus, "#")

	MaterialTipController.instance:showMaterialInfo(param[1], param[2], false)
end

function Activity181MainView:_btnInfoOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)

	if Activity181Model.instance:getPopUpPauseState() then
		return
	end

	local param = {
		actId = self._actId
	}

	ViewMgr.instance:openView(ViewName.Activity181RewardView, param)
end

function Activity181MainView:_editableInitView()
	self._bonusItemList = {}

	gohelper.setActive(self._goItem, false)

	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
end

function Activity181MainView:onUpdateParam()
	return
end

function Activity181MainView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._actId = self.viewParam.actId

	self:updateInfo()
	self:playOpenAnim()
end

function Activity181MainView:updateInfo()
	Activity181Controller.instance:getActivityInfo(self._actId)
end

function Activity181MainView:playOpenAnim()
	local isFirstLogin = Activity181Model.instance:getHaveFirstDayLogin(self._actId)

	if isFirstLogin then
		Activity181Model.instance:setHaveFirstDayLogin(self._actId)
	end

	if isFirstLogin then
		if not self.OPEN_ANIM_FIRST_DAY then
			local animName = self.OPEN_ANIM

			self._animator:Play(animName)
			AudioMgr.instance:trigger(AudioEnum.Act181.play_ui_diqiu_xueye_open)
		end
	end
end

function Activity181MainView:refreshUI()
	self:refreshTime()
	self:refreshBonus()
end

function Activity181MainView:onGetBonus(activityId, boxId, pos)
	if activityId ~= self._actId then
		return
	end

	local itemList = self._bonusItemList
	local item = itemList[pos]

	item:onUpdateMO(pos, activityId, true)

	local mo = Activity181Model.instance:getActivityInfo(self._actId)

	if not mo then
		return
	end

	if mo:getBonusTimes() <= 0 then
		for index, otherItem in ipairs(itemList) do
			if index ~= pos then
				local haveGet = mo:getBonusState(index) == Activity181Enum.BonusState.HaveGet

				otherItem:setBonusFxState(haveGet, false)
			end
		end
	end

	self:refreshBonusDesc(mo)
	self:refreshSPBonus(mo)
	Activity181Model.instance:setPopUpPauseState(true)
	TaskDispatcher.runDelay(self.onBonusAnimationEnd, self, self.POP_UP_DELAY)
end

function Activity181MainView:onBonusAnimationEnd()
	Activity181Model.instance:setPopUpPauseState(false)
	TaskDispatcher.cancelTask(self.onBonusAnimationEnd, self)
end

function Activity181MainView:onGetSPBonus(activityId)
	if activityId ~= self._actId then
		return
	end

	local mo = Activity181Model.instance:getActivityInfo(self._actId)

	if not mo then
		return
	end

	self:refreshSPBonus(mo)
end

function Activity181MainView:refreshSpBonusZeroTime()
	logNormal("Activity181MainView : refreshSpBonusZeroTime")

	local actInfo = ActivityModel.instance:getActMO(self._actId)
	local endTime = actInfo:getRealEndTimeStamp()
	local nowTime = ServerTime.now()

	if endTime <= nowTime then
		return
	end

	local mo = Activity181Model.instance:getActivityInfo(self._actId)

	if not mo then
		return
	end

	local config = mo.config

	if nowTime <= TimeUtil.stringToTimestamp(config.obtainStart) - TimeUtil.OneDaySecond or nowTime >= TimeUtil.stringToTimestamp(config.obtainEnd) + TimeUtil.OneDaySecond then
		return
	end

	logNormal("Activity181MainView : refreshSpBonusInfo")
	mo:refreshSpBonusInfo()
end

function Activity181MainView:refreshTime()
	local actInfo = ActivityModel.instance:getActMO(self._actId)
	local endTime = actInfo:getRealEndTimeStamp()
	local nowTime = ServerTime.now()

	if endTime <= nowTime then
		self._txtLimitTime.text = luaLang("ended")

		return
	end

	self._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(endTime - nowTime)
end

function Activity181MainView:refreshBonus()
	local mo = Activity181Model.instance:getActivityInfo(self._actId)

	if not mo then
		return
	end

	local bonusList = Activity181Config.instance:getBoxListByActivityId(self._actId)
	local bonusCount = #bonusList
	local bonusItemList = self._bonusItemList
	local itemCount = #bonusItemList

	for index, _ in ipairs(bonusList) do
		local bonusItem

		if itemCount < index then
			local itemObj = gohelper.clone(self._goItem, self._goItem.transform.parent.gameObject, tostring(index))

			bonusItem = Activity181BonusItem.New()

			bonusItem:init(itemObj)
			table.insert(bonusItemList, bonusItem)
		else
			bonusItem = bonusItemList[index]
		end

		bonusItem:setEnable(true)
		bonusItem:onUpdateMO(index, self._actId)
	end

	if bonusCount < itemCount then
		for i = bonusCount + 1, itemCount do
			local item = self._bonusItemList[i]

			item:setEnable(false)
		end
	end

	self:refreshBonusDesc(mo)
	self:refreshSPBonus(mo)
end

function Activity181MainView:refreshBonusDesc(mo)
	local canGetBonus = mo:canGetBonus()

	gohelper.setActive(self._goClaimed, not canGetBonus)
	gohelper.setActive(self._txtOpenTimes, canGetBonus)

	if canGetBonus then
		local desc = luaLang("blind_box_bouns_count")

		self._txtOpenTimes.text = GameUtil.getSubPlaceholderLuaLangOneParam(desc, tostring(mo.canGetTimes))
	end

	gohelper.setActive(self._goTips2, mo.canGetTimes > 0)
	gohelper.setActive(self._goTips1, mo.canGetTimes <= 0 and canGetBonus)
end

function Activity181MainView:refreshSPBonus(mo)
	if not mo then
		return
	end

	local state = mo.spBonusState

	gohelper.setActive(self._goSpClaimed, state == Activity181Enum.SPBonusState.HaveGet)
	gohelper.setActive(self._goCanGet, state == Activity181Enum.SPBonusState.Unlock)
	gohelper.setActive(self._btnSpInfo, state == Activity181Enum.SPBonusState.Locked)
end

function Activity181MainView:onClose()
	if Activity181Model.instance:getPopUpPauseState() then
		self:onBonusAnimationEnd()
	end
end

function Activity181MainView:onDestroyView()
	for _, item in ipairs(self._bonusItemList) do
		item:onDestroy()
	end

	self._bonusItemList = nil
end

return Activity181MainView
