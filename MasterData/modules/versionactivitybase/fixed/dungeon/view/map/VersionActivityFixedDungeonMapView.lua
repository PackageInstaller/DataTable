-- chunkname: @modules/versionactivitybase/fixed/dungeon/view/map/VersionActivityFixedDungeonMapView.lua

module("modules.versionactivitybase.fixed.dungeon.view.map.VersionActivityFixedDungeonMapView", package.seeall)

local VersionActivityFixedDungeonMapView = class("VersionActivityFixedDungeonMapView", BaseView)
local RECT_MASK_PADDING = Vector4(0, 0, 0, 0)
local RECT_MASK_PADDING_OPEN_MAP_LEVEL = Vector4(0, 0, 600, 0)
local ANIMA_TIME = 0.5

function VersionActivityFixedDungeonMapView:onInitView()
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._simagenormalmask = gohelper.findChildSingleImage(self.viewGO, "#simage_normalmask")
	self._simagehardmask = gohelper.findChildSingleImage(self.viewGO, "#simage_hardmask")
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "#scroll_content")
	self._rectmask2D = self._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))
	self._goswitchmodecontainer = gohelper.findChild(self.viewGO, "#go_switchmodecontainer")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")
	self._txtstorename = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitystore/normal/txt_shop")
	self._txtstorenum = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitystore/normal/#txt_num")
	self._imagestoreicon = gohelper.findChildImage(self.viewGO, "#go_topright/#btn_activitystore/normal/#simage_icon")
	self._txtStoreRemainTime = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitystore/#go_time/#txt_time")
	self._goTaskReddot = gohelper.findChild(self.viewGO, "#go_topright/#btn_activitytask/#go_reddot")
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")
	self._btnactivitystore = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_activitystore")
	self._btnactivitytask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_activitytask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityFixedDungeonMapView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnClickElement, self.onClickElement, self)
	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, self.showBtnUI, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self._OnUpdateMapElementState, self)
	self.addEventCb(self, GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, self.checkLoadingAndRefresh, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckInteractive, self._onRecheckInteractive, self)
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
	self._btnactivitystore:AddClickListener(self._btnactivitystoreOnClick, self)
	self._btnactivitytask:AddClickListener(self._btnactivitytaskOnClick, self)
end

function VersionActivityFixedDungeonMapView:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self.removeEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self.removeEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnClickElement, self.onClickElement, self)
	self.removeEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, self.showBtnUI, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self._OnUpdateMapElementState, self)
	self.removeEventCb(self, GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, self.checkLoadingAndRefresh, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckInteractive, self._onRecheckInteractive, self)
	self._btncloseview:RemoveClickListener()
	self._btnactivitystore:RemoveClickListener()
	self._btnactivitytask:RemoveClickListener()
end

function VersionActivityFixedDungeonMapView:_btncloseviewOnClick()
	ViewMgr.instance:closeView(VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(self._bigVersion, self._smallVersion))
end

function VersionActivityFixedDungeonMapView:_btnactivitystoreOnClick()
	local co = ActivityConfig.instance:getActivityCo(self._dungeonActId)

	if co.isRetroAcitivity == 0 then
		VersionActivityFixedHelper.getVersionActivityDungeonController(self._bigVersion, self._smallVersion).instance:openStoreView()
	elseif co.isRetroAcitivity == 1 then
		ReactivityController.instance:openReactivityStoreView(self._dungeonActId)
	end
end

function VersionActivityFixedDungeonMapView:_btnactivitytaskOnClick()
	if self._isRetroAcitivity then
		ReactivityController.instance:openReactivityTaskView(self._dungeonActId)
	else
		VersionActivityFixedHelper.getVersionActivityDungeonController(self._bigVersion, self._smallVersion).instance:openTaskView()
	end
end

function VersionActivityFixedDungeonMapView:_onEscBtnClick()
	local isShowInteractView = VersionActivityFixedDungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		self.viewContainer.interactView:hide()
	else
		self:closeThis()
	end
end

function VersionActivityFixedDungeonMapView:beginShowRewardView()
	self._showRewardView = true
end

function VersionActivityFixedDungeonMapView:endShowRewardView()
	self._showRewardView = false
end

function VersionActivityFixedDungeonMapView:onRemoveElement(elementId)
	return
end

function VersionActivityFixedDungeonMapView:_editableInitView()
	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	local enum = VersionActivityFixedHelper.getVersionActivityEnum(self._bigVersion, self._smallVersion)

	self._dungeonActId = enum.ActivityId.Dungeon

	local co = ActivityConfig.instance:getActivityCo(self._dungeonActId)

	self._isPermanent = co.isRetroAcitivity == 2

	if co.isRetroAcitivity == 0 then
		self._dungeonStore = enum.ActivityId.DungeonStore
	elseif co.isRetroAcitivity == 1 then
		local _enum = VersionActivityFixedHelper.getVersionActivityEnum()

		self._dungeonStore = _enum.ActivityId.ReactivityStore
	end

	gohelper.setActive(self._btnactivitystore.gameObject, not self._isPermanent)
	gohelper.setActive(self._btnactivitytask.gameObject, not self._isPermanent)

	if self._isPermanent then
		return
	end

	local storeActInfoMo = ActivityModel.instance:getActivityInfo()[self._dungeonStore]

	if storeActInfoMo then
		self._txtstorename.text = storeActInfoMo.config.name or ""
	end

	NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)
	TaskDispatcher.runRepeat(self._everyMinuteCall, self, TimeUtil.OneMinuteSecond)

	local reddot = VersionActivityFixedHelper.getVersionActivityDungeonTaskReddotId(self._bigVersion, self._smallVersion)

	RedDotController.instance:addRedDot(self._goTaskReddot, reddot)
end

function VersionActivityFixedDungeonMapView:_everyMinuteCall()
	self:refreshUI()
end

function VersionActivityFixedDungeonMapView:onUpdateParam()
	self:onOpen()
end

function VersionActivityFixedDungeonMapView:onOpen()
	VersionActivityFixedHelper.getVersionActivityDungeonController(self._bigVersion, self._smallVersion).instance:onVersionActivityDungeonMapViewOpen()
	self:refreshUI()
end

function VersionActivityFixedDungeonMapView:checkLoadingAndRefresh()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function VersionActivityFixedDungeonMapView:refreshUI()
	self:refreshActivityCurrency()
	self:refreshMask()
	self:refreshStoreRemainTime()
end

function VersionActivityFixedDungeonMapView:refreshActivityCurrency()
	if self._isPermanent then
		return
	end

	local currencyType = VersionActivityFixedHelper.getVersionActivityCurrencyType(self._bigVersion, self._smallVersion)
	local currencyMO = CurrencyModel.instance:getCurrency(currencyType)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtstorenum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivityFixedDungeonMapView:onRefreshActivityState(updateActId)
	return
end

function VersionActivityFixedDungeonMapView:setMask2DVisible(visible)
	self._rectmask2D.padding = visible and RECT_MASK_PADDING_OPEN_MAP_LEVEL or RECT_MASK_PADDING
end

function VersionActivityFixedDungeonMapView:_onOpenView(viewName)
	if viewName ~= VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(self._bigVersion, self._smallVersion) then
		return
	end

	self:setMask2DVisible(true)
	gohelper.setActive(self._btncloseview, true)
	self:hideBtnUI()
end

function VersionActivityFixedDungeonMapView:hideBtnUI()
	self.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).BlockKey.MapViewPlayCloseAnim)
	TaskDispatcher.runDelay(self.playCloseAnimaDone, self, ANIMA_TIME)
end

function VersionActivityFixedDungeonMapView:playCloseAnimaDone()
	gohelper.setActive(self._gotopright, false)
	gohelper.setActive(self._goswitchmodecontainer, false)
	UIBlockMgr.instance:endBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).BlockKey.MapViewPlayCloseAnim)
end

function VersionActivityFixedDungeonMapView:_onCloseView(viewName)
	if viewName ~= VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(self._bigVersion, self._smallVersion) then
		return
	end

	self:setMask2DVisible(false)
	gohelper.setActive(self._btncloseview, false)
	self:showBtnUI()
end

function VersionActivityFixedDungeonMapView:showBtnUI()
	self:setNavBtnIsShow(true)
	gohelper.setActive(self._gotopright, true)
	gohelper.setActive(self._goswitchmodecontainer, true)
	self.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).BlockKey.MapViewPlayOpenAnim)
	TaskDispatcher.runDelay(self.playOpenAnimaDone, self, ANIMA_TIME)
end

function VersionActivityFixedDungeonMapView:playOpenAnimaDone()
	UIBlockMgr.instance:endBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).BlockKey.MapViewPlayOpenAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivityFixedDungeonMapView:setNavBtnIsShow(isShow)
	gohelper.setActive(self._gotopleft, isShow)
end

function VersionActivityFixedDungeonMapView:onClickElement()
	self:hideBtnUI()
	self:setNavBtnIsShow(false)
end

function VersionActivityFixedDungeonMapView:_onRecheckInteractive(isShow)
	if isShow then
		self:setMask2DVisible(false)
		gohelper.setActive(self._btncloseview, false)
		self:showBtnUI()
	else
		self:hideBtnUI()
		self:setNavBtnIsShow(false)
	end
end

function VersionActivityFixedDungeonMapView:onModeChange()
	self:refreshMask()
end

function VersionActivityFixedDungeonMapView:refreshMask()
	local isHardMode = self.activityDungeonMo:isHardMode()

	gohelper.setActive(self._simagenormalmask.gameObject, not isHardMode)
	gohelper.setActive(self._simagehardmask.gameObject, isHardMode)
end

function VersionActivityFixedDungeonMapView:refreshStoreRemainTime()
	if self._isPermanent then
		return
	end

	local storeActId = self._dungeonStore
	local actInfoMo = ActivityModel.instance:getActMO(storeActId)

	if not actInfoMo or not self._txtStoreRemainTime then
		return
	end

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

function VersionActivityFixedDungeonMapView:_OnUpdateMapElementState(mapId)
	return
end

function VersionActivityFixedDungeonMapView:onClose()
	self._showRewardView = false

	TaskDispatcher.cancelTask(self._everyMinuteCall, self)
	UIBlockMgr.instance:endBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).BlockKey.MapViewPlayOpenAnim)
	UIBlockMgr.instance:endBlock(VersionActivityFixedHelper.getVersionActivityDungeonEnum(self._bigVersion, self._smallVersion).BlockKey.MapViewPlayCloseAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivityFixedDungeonMapView:onDestroyView()
	return
end

return VersionActivityFixedDungeonMapView
