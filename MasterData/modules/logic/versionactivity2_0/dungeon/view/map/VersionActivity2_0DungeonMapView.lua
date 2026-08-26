-- chunkname: @modules/logic/versionactivity2_0/dungeon/view/map/VersionActivity2_0DungeonMapView.lua

module("modules.logic.versionactivity2_0.dungeon.view.map.VersionActivity2_0DungeonMapView", package.seeall)

local VersionActivity2_0DungeonMapView = class("VersionActivity2_0DungeonMapView", BaseView)
local RECT_MASK_PADDING = Vector4(0, 0, 0, 0)
local RECT_MASK_PADDING_OPEN_MAP_LEVEL = Vector4(0, 0, 600, 0)
local ANIMA_TIME = 0.5

function VersionActivity2_0DungeonMapView:onInitView()
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._simagenormalmask = gohelper.findChildSingleImage(self.viewGO, "#simage_normalmask")
	self._simagehardmask = gohelper.findChildSingleImage(self.viewGO, "#simage_hardmask")
	self._simagerestaurant = gohelper.findChildSingleImage(self.viewGO, "#simage_restaurantmask")
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "#scroll_content")
	self._rectmask2D = self._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	self._goswitchmodecontainer = gohelper.findChild(self.viewGO, "#go_switchmodecontainer")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")
	self._goactivitystore = gohelper.findChild(self.viewGO, "#go_topright/#btn_activitystore")
	self._txtstorenum = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitystore/normal/#txt_num")
	self._txtStoreRemainTime = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitystore/#go_time/#txt_time")
	self._goTaskReddot = gohelper.findChild(self.viewGO, "#go_topright/#btn_activitytask/#go_reddot")
	self._goGraffitiReddot = gohelper.findChild(self.viewGO, "#go_topright/#btn_graffiti/#go_reddot")
	self._goRestaurantReddot = gohelper.findChild(self.viewGO, "#go_topright/#btn_restaurant/#go_reddot")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")
	self._btnactivitystore = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_activitystore")
	self._btnactivitytask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_activitytask")
	self._btnrestaurant = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_restaurant")
	self._btngraffiti = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_graffiti")
	self._goExcessiveEffect = gohelper.findChild(self.viewGO, "excessive")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_0DungeonMapView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self.checkHasUnDoElement, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self.addEventCb(self, VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnClickElement, self.onClickElement, self)
	self.addEventCb(self, VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnHideInteractUI, self.showBtnUI, self)
	self.addEventCb(self, Activity161Controller.instance, Activity161Event.CloseGraffitiEnterView, self.closeGraffitiEnterView, self)
	self.addEventCb(self, Activity161Controller.instance, Activity161Event.PlayExcessiveEffect, self.showExcessiveEffect, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckInteractive, self._onRecheckInteractive, self)
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
	self._btnactivitystore:AddClickListener(self._btnactivitystoreOnClick, self)
	self._btnactivitytask:AddClickListener(self._btnactivitytaskOnClick, self)
	self._btngraffiti:AddClickListener(self._btngraffitiOnClick, self)
	self._btnrestaurant:AddClickListener(self._btnrestaurantOnClick, self)
end

function VersionActivity2_0DungeonMapView:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self.checkHasUnDoElement, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self.removeEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self.removeEventCb(self, VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnClickElement, self.onClickElement, self)
	self.removeEventCb(self, VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnHideInteractUI, self.showBtnUI, self)
	self.removeEventCb(self, Activity161Controller.instance, Activity161Event.CloseGraffitiEnterView, self.closeGraffitiEnterView, self)
	self.removeEventCb(self, Activity161Controller.instance, Activity161Event.PlayExcessiveEffect, self.showExcessiveEffect, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckInteractive, self._onRecheckInteractive, self)
	self._btncloseview:RemoveClickListener()
	self._btnactivitystore:RemoveClickListener()
	self._btnactivitytask:RemoveClickListener()
	self._btngraffiti:RemoveClickListener()
	self._btnrestaurant:RemoveClickListener()
end

function VersionActivity2_0DungeonMapView:_btncloseviewOnClick()
	ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonMapLevelView)
end

function VersionActivity2_0DungeonMapView:_btnactivitystoreOnClick()
	ReactivityController.instance:openReactivityStoreView(VersionActivity2_7Enum.ActivityId.Reactivity)
end

function VersionActivity2_0DungeonMapView:_btnactivitytaskOnClick()
	ReactivityController.instance:openReactivityTaskView(VersionActivity2_7Enum.ActivityId.Reactivity)
end

function VersionActivity2_0DungeonMapView:_btngraffitiOnClick()
	local param = {}

	param.actId = Activity161Model.instance:getActId()

	Activity161Controller.instance:openGraffitiView(param)
end

function VersionActivity2_0DungeonMapView:_btnrestaurantOnClick()
	self.activityDungeonMo:changeEpisode(VersionActivity2_0DungeonEnum.restaurantChapterMap)
	VersionActivity2_0DungeonController.instance:dispatchEvent(VersionActivity2_0DungeonEvent.FocusElement, VersionActivity2_0DungeonEnum.restaurantElement)
	TaskDispatcher.runDelay(self.showExcessiveEffect, self, 0.2)
	TaskDispatcher.runDelay(self.enterRestaurant, self, 0.7)
	VersionActivity2_0DungeonModel.instance:setOpeningGraffitiEntrance(true)
	self.viewContainer.mapSceneElements:setMouseElementDown(nil)
end

function VersionActivity2_0DungeonMapView:enterRestaurant()
	self.isEnterRestaurant = true

	VersionActivity2_0DungeonModel.instance:setOpenGraffitiEntrance(true)
	gohelper.setActive(self._goswitchmodecontainer, false)
	gohelper.setActive(self._btnrestaurant.gameObject, false)
	self.viewContainer.mapEpisodeView:hideUI()

	local mapConfig = lua_chapter_map.configDict[Activity161Enum.graffitiMapId]

	Activity161Controller.instance:openGraffitiEnterView()

	self.viewContainer.mapScene.tempInitPosX = nil

	self.viewContainer.mapScene:refreshMap(false, mapConfig)
	gohelper.setActive(self._simagenormalmask.gameObject, false)
	gohelper.setActive(self._simagehardmask.gameObject, false)
	gohelper.setActive(self._simagerestaurant, true)
	self.viewContainer:forceHideRecheck(true)
end

function VersionActivity2_0DungeonMapView:showExcessiveEffect()
	gohelper.setActive(self._goExcessiveEffect, false)
	gohelper.setActive(self._goExcessiveEffect, true)
end

function VersionActivity2_0DungeonMapView:_onEscBtnClick()
	local isOpenGraffitiEntrance = VersionActivity2_0DungeonModel.instance:getOpenGraffitiEntranceState()

	if isOpenGraffitiEntrance then
		ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonMapGraffitiEnterView)

		return
	end

	local isShowInteractView = VersionActivity2_0DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		self.viewContainer.interactView:hide()
	else
		self:closeThis()
	end
end

function VersionActivity2_0DungeonMapView:beginShowRewardView()
	self._showRewardView = true
end

function VersionActivity2_0DungeonMapView:endShowRewardView()
	self._showRewardView = false
end

function VersionActivity2_0DungeonMapView:onRemoveElement(elementId)
	local graffitiActId = Activity161Model.instance:getActId()
	local isGraffitiMainElement, graffitiCo = Activity161Config.instance:checkIsGraffitiMainElement(graffitiActId, elementId)

	if isGraffitiMainElement then
		GameFacade.showToast(ToastEnum.GraffitiElementFinish, graffitiCo.finishTitle)
	end
end

function VersionActivity2_0DungeonMapView:checkHasUnDoElement()
	Activity161Controller.instance:checkHasUnDoElement()
end

function VersionActivity2_0DungeonMapView:_editableInitView()
	Activity161Controller.instance:checkHasUnDoElement()
	NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)
	TaskDispatcher.runRepeat(self._everyMinuteCall, self, TimeUtil.OneMinuteSecond)
	RedDotController.instance:addRedDot(self._goTaskReddot, RedDotEnum.DotNode.V2a0DungeonTask)

	local graffitiActId = Activity161Model.instance:getActId()

	RedDotController.instance:addMultiRedDot(self._goGraffitiReddot, {
		{
			id = RedDotEnum.DotNode.V2a0GraffitiReward,
			uid = graffitiActId
		},
		{
			id = RedDotEnum.DotNode.V2a0GraffitiUnlock,
			uid = graffitiActId
		}
	})
	RedDotController.instance:addRedDot(self._goRestaurantReddot, RedDotEnum.DotNode.V2a0DungeonRestaurant)

	self.isEnterRestaurant = false

	gohelper.setActive(self._goactivitystore, false)
	gohelper.setActive(self._btnactivitytask.gameObject, false)
end

function VersionActivity2_0DungeonMapView:_everyMinuteCall()
	self:refreshUI()
end

function VersionActivity2_0DungeonMapView:onUpdateParam()
	self:onOpen()
end

function VersionActivity2_0DungeonMapView:onOpen()
	VersionActivity2_0DungeonController.instance:onVersionActivityDungeonMapViewOpen()
	self:refreshUI()
end

function VersionActivity2_0DungeonMapView:refreshUI()
	self:refreshBtnVisible()
	self:refreshActivityCurrency()
	self:refreshMask()
	self:refreshStoreRemainTime()
end

function VersionActivity2_0DungeonMapView:refreshBtnVisible()
	self.isEntranceUnlock = VersionActivity2_0DungeonModel.instance:getGraffitiEntranceUnlockState()

	gohelper.setActive(self._btngraffiti.gameObject, false)
	gohelper.setActive(self._btnrestaurant.gameObject, self.isEntranceUnlock and not self.isEnterRestaurant)

	if self._showRewardView then
		return
	end
end

function VersionActivity2_0DungeonMapView:refreshActivityCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a0Dungeon)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtstorenum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivity2_0DungeonMapView:onRefreshActivityState(updateActId)
	local graffitiActId = Activity161Model.instance:getActId()

	if updateActId and updateActId ~= graffitiActId then
		return
	end

	local isOnline = ActivityModel.instance:isActOnLine(graffitiActId)

	if isOnline then
		Activity161Controller.instance:initAct161Info(false, true, self.refreshBtnVisible, self)
	else
		gohelper.setActive(self._btngraffiti.gameObject, false)
		gohelper.setActive(self._btnrestaurant.gameObject, false)
	end
end

function VersionActivity2_0DungeonMapView:_onOpenView(viewName)
	if viewName ~= ViewName.VersionActivity2_0DungeonMapLevelView then
		return
	end

	self._rectmask2D.padding = RECT_MASK_PADDING_OPEN_MAP_LEVEL

	gohelper.setActive(self._btncloseview, true)
	self:hideBtnUI()
end

function VersionActivity2_0DungeonMapView:hideBtnUI()
	self.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	TaskDispatcher.runDelay(self.playCloseAnimaDone, self, ANIMA_TIME)
end

function VersionActivity2_0DungeonMapView:playCloseAnimaDone()
	local isOpenGraffitiEntrance = VersionActivity2_0DungeonModel.instance:getOpenGraffitiEntranceState()

	if not isOpenGraffitiEntrance then
		self:setNavBtnIsShow(false)
	end

	gohelper.setActive(self._gotopright, false)
	gohelper.setActive(self._goswitchmodecontainer, false)
	UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayCloseAnim)
end

function VersionActivity2_0DungeonMapView:_onCloseView(viewName)
	if viewName ~= ViewName.VersionActivity2_0DungeonMapLevelView then
		return
	end

	self._rectmask2D.padding = RECT_MASK_PADDING

	gohelper.setActive(self._btncloseview, false)
	self:showBtnUI()
end

function VersionActivity2_0DungeonMapView:showBtnUI()
	self:setNavBtnIsShow(true)
	gohelper.setActive(self._gotopright, true)
	gohelper.setActive(self._btnrestaurant.gameObject, self.isEntranceUnlock and not self.isEnterRestaurant)
	gohelper.setActive(self._goswitchmodecontainer, true)
	self.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	TaskDispatcher.runDelay(self.playOpenAnimaDone, self, ANIMA_TIME)
end

function VersionActivity2_0DungeonMapView:showRestaurantPartBtnUI()
	self:setNavBtnIsShow(true)
	gohelper.setActive(self._gotopright, true)
	self.animator:Play("open", 0, 0)
end

function VersionActivity2_0DungeonMapView:playOpenAnimaDone()
	UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivity2_0DungeonMapView:setNavBtnIsShow(isShow)
	gohelper.setActive(self._gotopleft, isShow)
end

function VersionActivity2_0DungeonMapView:onClickElement()
	self:hideBtnUI()
	self:setNavBtnIsShow(false)
end

function VersionActivity2_0DungeonMapView:_onRecheckInteractive(isShow)
	if isShow then
		self._rectmask2D.padding = RECT_MASK_PADDING

		gohelper.setActive(self._btncloseview, false)
		self:showBtnUI()
	else
		self:hideBtnUI()
		self:setNavBtnIsShow(false)
	end
end

function VersionActivity2_0DungeonMapView:onModeChange()
	self:refreshMask()
end

function VersionActivity2_0DungeonMapView:refreshMask()
	local isHardMode = self.activityDungeonMo:isHardMode()

	gohelper.setActive(self._simagenormalmask.gameObject, not isHardMode and not self.isEnterRestaurant)
	gohelper.setActive(self._simagehardmask.gameObject, isHardMode and not self.isEnterRestaurant)
	gohelper.setActive(self._simagerestaurant, self.isEnterRestaurant)
	self.viewContainer:forceHideRecheck(self.isEnterRestaurant)
end

function VersionActivity2_0DungeonMapView:refreshStoreRemainTime()
	local storeActId = VersionActivity2_7Enum.ActivityId.ReactivityStore
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

function VersionActivity2_0DungeonMapView:closeGraffitiEnterView()
	self.isEnterRestaurant = false

	self:showBtnUI()
	self:refreshMask()
end

function VersionActivity2_0DungeonMapView:onClose()
	self._showRewardView = false

	TaskDispatcher.cancelTask(self._everyMinuteCall, self)
	TaskDispatcher.cancelTask(self.enterRestaurant, self)
	TaskDispatcher.cancelTask(self.showExcessiveEffect, self)
	UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.OpenGraffitiEnterView)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivity2_0DungeonMapView:onDestroyView()
	return
end

return VersionActivity2_0DungeonMapView
