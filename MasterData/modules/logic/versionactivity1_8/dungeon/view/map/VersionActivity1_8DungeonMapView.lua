-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/map/VersionActivity1_8DungeonMapView.lua

module("modules.logic.versionactivity1_8.dungeon.view.map.VersionActivity1_8DungeonMapView", package.seeall)

local VersionActivity1_8DungeonMapView = class("VersionActivity1_8DungeonMapView", BaseView)
local RECT_MASK_PADDING = Vector4(0, 0, 0, 0)
local RECT_MASK_PADDING_OPEN_MAP_LEVEL = Vector4(0, 0, 600, 0)
local ANIMA_TIME = 0.5

function VersionActivity1_8DungeonMapView:onInitView()
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._simagenormalmask = gohelper.findChildSingleImage(self.viewGO, "#simage_normalmask")
	self._simagehardmask = gohelper.findChildSingleImage(self.viewGO, "#simage_hardmask")
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "#scroll_content")
	self._rectmask2D = self._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	self._goswitchmodecontainer = gohelper.findChild(self.viewGO, "#go_switchmodecontainer")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")
	self._txtstorenum = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitystore/normal/#txt_num")
	self._imagestoreicon = gohelper.findChildImage(self.viewGO, "#go_topright/#btn_activitystore/normal/#simage_icon")
	self._txtStoreRemainTime = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitystore/#go_time/#txt_time")
	self._goTaskReddot = gohelper.findChild(self.viewGO, "#go_topright/#btn_activitytask/#go_reddot")
	self._goFactoryReddot = gohelper.findChild(self.viewGO, "#go_topright/#btn_wish/#go_reddot")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")
	self._btnactivitystore = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_activitystore")
	self._btnactivitytask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_activitytask")
	self._btnReturnToWork = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_wish")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_8DungeonMapView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self.addEventCb(self, Activity157Controller.instance, Activity157Event.Act157RefreshEntrance, self.refreshBtnVisible, self)
	self.addEventCb(self, Activity157Controller.instance, Activity157Event.Act157PlayMissionUnlockAnim, self.refreshReddot, self)
	self.addEventCb(self, Activity157Controller.instance, Activity157Event.Act157UpdateInfo, self.refreshReddot, self)
	self.addEventCb(self, Activity157Controller.instance, Activity157Event.Act157RepairComponent, self.refreshReddot, self)
	self.addEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, self.onClickElement, self)
	self.addEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnHideInteractUI, self.showBtnUI, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckInteractive, self._onRecheckInteractive, self)
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
	self._btnactivitystore:AddClickListener(self._btnactivitystoreOnClick, self)
	self._btnactivitytask:AddClickListener(self._btnactivitytaskOnClick, self)
	self._btnReturnToWork:AddClickListener(self._btnReturnToWorkOnClick, self)
end

function VersionActivity1_8DungeonMapView:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self.removeEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self.removeEventCb(self, Activity157Controller.instance, Activity157Event.Act157RefreshEntrance, self.refreshBtnVisible, self)
	self.removeEventCb(self, Activity157Controller.instance, Activity157Event.Act157PlayMissionUnlockAnim, self.refreshReddot, self)
	self.removeEventCb(self, Activity157Controller.instance, Activity157Event.Act157UpdateInfo, self.refreshReddot, self)
	self.removeEventCb(self, Activity157Controller.instance, Activity157Event.Act157RepairComponent, self.refreshReddot, self)
	self.removeEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, self.onClickElement, self)
	self.removeEventCb(self, VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnHideInteractUI, self.showBtnUI, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckInteractive, self._onRecheckInteractive, self)
	self._btncloseview:RemoveClickListener()
	self._btnactivitystore:RemoveClickListener()
	self._btnactivitytask:RemoveClickListener()
	self._btnReturnToWork:RemoveClickListener()
end

function VersionActivity1_8DungeonMapView:_onOpenView(viewName)
	if viewName ~= ViewName.VersionActivity1_8DungeonMapLevelView then
		return
	end

	self._rectmask2D.padding = RECT_MASK_PADDING_OPEN_MAP_LEVEL

	gohelper.setActive(self._btncloseview, true)
	self:hideBtnUI()
end

function VersionActivity1_8DungeonMapView:hideBtnUI()
	self.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	TaskDispatcher.runDelay(self.playCloseAnimaDone, self, ANIMA_TIME)
end

function VersionActivity1_8DungeonMapView:playCloseAnimaDone()
	self:setNavBtnIsShow(false)
	gohelper.setActive(self._gotopright, false)
	gohelper.setActive(self._goswitchmodecontainer, false)
	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayCloseAnim)
end

function VersionActivity1_8DungeonMapView:_onCloseView(viewName)
	if viewName ~= ViewName.VersionActivity1_8DungeonMapLevelView then
		return
	end

	self._rectmask2D.padding = RECT_MASK_PADDING

	gohelper.setActive(self._btncloseview, false)
	self:showBtnUI()
end

function VersionActivity1_8DungeonMapView:showBtnUI()
	self:setNavBtnIsShow(true)
	gohelper.setActive(self._gotopright, false)
	gohelper.setActive(self._goswitchmodecontainer, true)
	self.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	TaskDispatcher.runDelay(self.playOpenAnimaDone, self, ANIMA_TIME)
end

function VersionActivity1_8DungeonMapView:playOpenAnimaDone()
	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivity1_8DungeonMapView:onRemoveElement(elementId)
	local actId = Activity157Model.instance:getActId()
	local isOnline = ActivityModel.instance:isActOnLine(actId)

	if not isOnline then
		return
	end

	local strUnlockEntranceElement = Activity157Config.instance:getAct157Const(actId, Activity157Enum.ConstId.UnlockEntranceElement)
	local isUnlockEntranceElement = elementId and elementId == tonumber(strUnlockEntranceElement)

	if isUnlockEntranceElement then
		Activity157Controller.instance:getAct157ActInfo()
	end
end

function VersionActivity1_8DungeonMapView:beginShowRewardView()
	self._showRewardView = true
end

function VersionActivity1_8DungeonMapView:onModeChange()
	self:refreshMask()
end

function VersionActivity1_8DungeonMapView:onRefreshActivityState(updateActId)
	local actId = Activity157Model.instance:getActId()

	if updateActId and updateActId ~= actId then
		return
	end

	local isOnline = ActivityModel.instance:isActOnLine(actId)

	if isOnline then
		Activity157Controller.instance:getAct157ActInfo(false, true, self.refreshBtnVisible, self)
	else
		gohelper.setActive(self._btnReturnToWork.gameObject, false)
	end
end

function VersionActivity1_8DungeonMapView:refreshReddot()
	self:refreshFactoryReddot(self._factoryReddot)
end

function VersionActivity1_8DungeonMapView:onClickElement()
	self:hideBtnUI()
	self:setNavBtnIsShow(false)
end

function VersionActivity1_8DungeonMapView:_onRecheckInteractive(isShow)
	if isShow then
		self._rectmask2D.padding = RECT_MASK_PADDING

		gohelper.setActive(self._btncloseview, false)
		self:showBtnUI()
	else
		self:hideBtnUI()
		self:setNavBtnIsShow(false)
	end
end

function VersionActivity1_8DungeonMapView:_btncloseviewOnClick()
	ViewMgr.instance:closeView(ViewName.VersionActivity1_8DungeonMapLevelView)
end

function VersionActivity1_8DungeonMapView:_btnactivitystoreOnClick()
	ReactivityController.instance:openReactivityStoreView(VersionActivity2_4Enum.ActivityId.Reactivity)
end

function VersionActivity1_8DungeonMapView:_btnactivitytaskOnClick()
	ReactivityController.instance:openReactivityTaskView(VersionActivity2_4Enum.ActivityId.Reactivity)
end

function VersionActivity1_8DungeonMapView:_btnReturnToWorkOnClick()
	Activity157Controller.instance:openFactoryMapView()
end

function VersionActivity1_8DungeonMapView:_onEscBtnClick()
	local isShowInteractView = VersionActivity1_8DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		self.viewContainer.interactView:hide()
	else
		self:closeThis()
	end
end

function VersionActivity1_8DungeonMapView:_editableInitView()
	local currencyCfg = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a8Dungeon)

	if currencyCfg then
		local currencyName = string.format("%s_1", currencyCfg and currencyCfg.icon)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagestoreicon, currencyName)
	end

	NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)
	TaskDispatcher.runRepeat(self._everyMinuteCall, self, TimeUtil.OneMinuteSecond)
	RedDotController.instance:addRedDot(self._goTaskReddot, RedDotEnum.DotNode.V1a8DungeonTask)

	self._factoryReddot = RedDotController.instance:addRedDot(self._goFactoryReddot, RedDotEnum.DotNode.V1a8DungeonFactory, nil, self.refreshFactoryReddot, self)
end

function VersionActivity1_8DungeonMapView:refreshFactoryReddot(redDotIcon)
	if not redDotIcon then
		return
	end

	redDotIcon:defaultRefreshDot()

	if redDotIcon.show then
		return
	end

	local actId = Activity157Model.instance:getActId()
	local isOnline = ActivityModel.instance:isActOnLine(actId)

	if not isOnline then
		return
	end

	local allActiveNodeGroupList = Activity157Model.instance:getAllActiveNodeGroupList()
	local isUnlockedSideMission = Activity157Model.instance:getIsSideMissionUnlocked()

	for _, missionGroupId in ipairs(allActiveNodeGroupList) do
		local isSideMissionGroup = Activity157Config.instance:isSideMissionGroup(actId, missionGroupId)

		for _, missionId in ipairs((not isUnlockedSideMission or isSideMissionGroup and isUnlockedSideMission or nil) and Activity157Config.instance:getAct157MissionList(actId, missionGroupId)) do
			local missionStatus = Activity157Model.instance:getMissionStatus(missionGroupId, missionId)
			local isNeedPlayUnlockAnim = Activity157Model.instance:getIsNeedPlayMissionUnlockAnim(missionId)

			if missionStatus == Activity157Enum.MissionStatus.Normal and isNeedPlayUnlockAnim then
				redDotIcon.show = not ((isSideMissionGroup or nil) and Activity157Model.instance:isInProgressOtherMissionGroup(missionGroupId))

				if redDotIcon.show then
					break
				end
			end
		end

		if redDotIcon.show then
			break
		end
	end

	redDotIcon:showRedDot(RedDotEnum.Style.Normal)
end

function VersionActivity1_8DungeonMapView:_everyMinuteCall()
	self:refreshUI()
end

function VersionActivity1_8DungeonMapView:onUpdateParam()
	self:onOpen()
end

function VersionActivity1_8DungeonMapView:onOpen()
	VersionActivity1_8DungeonController.instance:onVersionActivityDungeonMapViewOpen()
	self:refreshUI()
	gohelper.setActive(self._gotopright, false)
end

function VersionActivity1_8DungeonMapView:refreshUI()
	self:refreshBtnVisible()
	self:refreshActivityCurrency()
	self:refreshMask()
	self:refreshStoreRemainTime()
end

function VersionActivity1_8DungeonMapView:refreshBtnVisible()
	local isAct157UnlockEntrance = Activity157Model.instance:getIsUnlockEntrance()

	gohelper.setActive(self._btnReturnToWork.gameObject, isAct157UnlockEntrance)

	if not isAct157UnlockEntrance then
		return
	end

	Activity157Controller.instance:dispatchEvent(Activity157Event.GuideHasUnlockFactoryEntrance)

	if self._showRewardView then
		return
	end

	local actId = Activity157Model.instance:getActId()
	local isFinishFactoryUnlockGuide = GuideModel.instance:isGuideFinish(GuideEnum.GuideId.Act157FactoryUnlock)

	if not isFinishFactoryUnlockGuide then
		local strUnlockEntranceElement = Activity157Config.instance:getAct157Const(actId, Activity157Enum.ConstId.UnlockEntranceElement)

		DungeonController.instance:dispatchEvent(DungeonEvent.onGuideCloseFragmentInfoView, tonumber(strUnlockEntranceElement))
	else
		local isFirstComponentRepair = Activity157Model.instance:getIsFirstComponentRepair()

		if isFirstComponentRepair then
			return
		end

		local firstComponentId = Activity157Config.instance:getAct157Const(actId, Activity157Enum.ConstId.FirstFactoryComponent)
		local isCanRepair = Activity157Model.instance:isCanRepairComponent(firstComponentId)

		if isCanRepair then
			DungeonController.instance:dispatchEvent(DungeonEvent.onGuideCloseFragmentInfoView, Activity157Enum.UnlockBlueprintElement)
		end
	end
end

function VersionActivity1_8DungeonMapView:endShowRewardView()
	self._showRewardView = false
end

function VersionActivity1_8DungeonMapView:refreshActivityCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a8Dungeon)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtstorenum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivity1_8DungeonMapView:refreshMask()
	local isHardMode = self.activityDungeonMo:isHardMode()

	gohelper.setActive(self._simagenormalmask.gameObject, not isHardMode)
	gohelper.setActive(self._simagehardmask.gameObject, isHardMode)
end

function VersionActivity1_8DungeonMapView:refreshStoreRemainTime()
	local storeActId = VersionActivity2_4Enum.ActivityId.ReactivityStore
	local actInfoMo = ActivityModel.instance:getActMO(storeActId)
	local endTime = actInfoMo:getRealEndTimeStamp()
	local offsetSecond = endTime - ServerTime.now()

	if offsetSecond > TimeUtil.OneDaySecond then
		local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)

		self._txtStoreRemainTime.text = day .. "d"

		return
	end

	if offsetSecond > TimeUtil.OneHourSecond then
		local hour = Mathf.Floor(offsetSecond / TimeUtil.OneHourSecond)

		self._txtStoreRemainTime.text = hour .. "h"

		return
	end

	self._txtStoreRemainTime.text = "1h"
end

function VersionActivity1_8DungeonMapView:setNavBtnIsShow(isShow)
	gohelper.setActive(self._gotopleft, isShow and true or false)
end

function VersionActivity1_8DungeonMapView:onClose()
	self._showRewardView = false

	TaskDispatcher.cancelTask(self._everyMinuteCall, self)
	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivity1_8DungeonMapView:onDestroyView()
	return
end

return VersionActivity1_8DungeonMapView
