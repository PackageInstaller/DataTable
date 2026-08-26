-- chunkname: @modules/logic/versionactivity2_4/dungeon/view/map/VersionActivity2_4DungeonMapView.lua

module("modules.logic.versionactivity2_4.dungeon.view.map.VersionActivity2_4DungeonMapView", package.seeall)

local VersionActivity2_4DungeonMapView = class("VersionActivity2_4DungeonMapView", BaseView)
local RECT_MASK_PADDING = Vector4(0, 0, 0, 0)
local RECT_MASK_PADDING_OPEN_MAP_LEVEL = Vector4(0, 0, 600, 0)
local ANIMA_TIME = 0.5

function VersionActivity2_4DungeonMapView:onInitView()
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
	self._btnwuerlixi = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_wuerlixi")
	self._gowuerlixireddot = gohelper.findChild(self.viewGO, "#btn_wuerlixi/image_Icon/#go_reddot")
	self._btnwuerlixiAnimator = self._btnwuerlixi.gameObject:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4DungeonMapView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self.addEventCb(self, VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnClickElement, self.onClickElement, self)
	self.addEventCb(self, VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnHideInteractUI, self.showBtnUI, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self._OnUpdateMapElementState, self)
	self.addEventCb(self, GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, self.checkLoadingAndRefresh, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckInteractive, self._onRecheckInteractive, self)
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
	self._btnactivitystore:AddClickListener(self._btnactivitystoreOnClick, self)
	self._btnactivitytask:AddClickListener(self._btnactivitytaskOnClick, self)
	self._btnwuerlixi:AddClickListener(self._btnwuerlixiOnClick, self)
end

function VersionActivity2_4DungeonMapView:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self.removeEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self.removeEventCb(self, VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnClickElement, self.onClickElement, self)
	self.removeEventCb(self, VersionActivity2_4DungeonController.instance, VersionActivity2_4DungeonEvent.OnHideInteractUI, self.showBtnUI, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self._OnUpdateMapElementState, self)
	self.removeEventCb(self, GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, self.checkLoadingAndRefresh, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckInteractive, self._onRecheckInteractive, self)
	self._btncloseview:RemoveClickListener()
	self._btnactivitystore:RemoveClickListener()
	self._btnactivitytask:RemoveClickListener()
	self._btnwuerlixi:RemoveClickListener()
end

function VersionActivity2_4DungeonMapView:_btncloseviewOnClick()
	ViewMgr.instance:closeView(ViewName.VersionActivity2_4DungeonMapLevelView)
end

function VersionActivity2_4DungeonMapView:_btnactivitystoreOnClick()
	ReactivityController.instance:openReactivityStoreView(VersionActivity3_1Enum.ActivityId.Reactivity)
end

function VersionActivity2_4DungeonMapView:_btnactivitytaskOnClick()
	ReactivityController.instance:openReactivityTaskView(VersionActivity3_1Enum.ActivityId.Reactivity)
end

function VersionActivity2_4DungeonMapView:_btnwuerlixiOnClick()
	WuErLiXiController.instance:enterLevelView()
end

function VersionActivity2_4DungeonMapView:_onEscBtnClick()
	local isShowInteractView = VersionActivity2_4DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		self.viewContainer.interactView:hide()
	else
		self:closeThis()
	end
end

function VersionActivity2_4DungeonMapView:beginShowRewardView()
	self._showRewardView = true
end

function VersionActivity2_4DungeonMapView:endShowRewardView()
	self._showRewardView = false
end

function VersionActivity2_4DungeonMapView:onRemoveElement(elementId)
	return
end

function VersionActivity2_4DungeonMapView:_editableInitView()
	local currencyCfg = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V2a4Dungeon)

	if currencyCfg then
		local currencyName = string.format("%s_1", currencyCfg and currencyCfg.icon)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagestoreicon, currencyName)
	end

	local storeActInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity3_1Enum.ActivityId.ReactivityStore]

	self._txtstorename.text = storeActInfoMo.config.name

	NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)
	TaskDispatcher.runRepeat(self._everyMinuteCall, self, TimeUtil.OneMinuteSecond)
	RedDotController.instance:addRedDot(self._goTaskReddot, RedDotEnum.DotNode.V2a4DungeonTask)
	RedDotController.instance:addRedDot(self._gowuerlixireddot, RedDotEnum.DotNode.V2a4WuErLiXiTask)
end

function VersionActivity2_4DungeonMapView:_everyMinuteCall()
	self:refreshUI()
end

function VersionActivity2_4DungeonMapView:onUpdateParam()
	self:onOpen()
end

function VersionActivity2_4DungeonMapView:onOpen()
	VersionActivity2_4DungeonController.instance:onVersionActivityDungeonMapViewOpen()
	self:refreshUI()
end

function VersionActivity2_4DungeonMapView:checkLoadingAndRefresh()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function VersionActivity2_4DungeonMapView:refreshUI()
	self:refreshActivityCurrency()
	self:refreshMask()
	self:refreshStoreRemainTime()
	self:refreshBtnState()
end

function VersionActivity2_4DungeonMapView:refreshBtnState()
	local status = ActivityHelper.getActivityStatus(VersionActivity2_4Enum.ActivityId.WuErLiXi, true)

	gohelper.setActive(self._btnwuerlixi.gameObject, status == ActivityEnum.ActivityStatus.Normal)

	self._wuerlixiunlock = status == ActivityEnum.ActivityStatus.Normal
end

function VersionActivity2_4DungeonMapView:refreshActivityCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a4Dungeon)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtstorenum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivity2_4DungeonMapView:onRefreshActivityState(updateActId)
	if updateActId == VersionActivity2_4Enum.ActivityId.Dungeon then
		local status = ActivityHelper.getActivityStatusAndToast(updateActId)
		local isNormal = status == ActivityEnum.ActivityStatus.Normal

		if not isNormal then
			self:closeThis()
			GameFacade.showToast(ToastEnum.ActivityEnd)

			return
		end
	end

	if updateActId == VersionActivity2_4Enum.ActivityId.WuErLiXi then
		self:refreshBtnState()

		local status = ActivityHelper.getActivityStatusAndToast(updateActId)
		local isNormal = status == ActivityEnum.ActivityStatus.Normal

		if isNormal and not self._wuerlixiunlock then
			self._btnwuerlixiAnimator:Play("show", 0, 0)

			self._wuerlixiunlock = true

			return
		end
	end
end

function VersionActivity2_4DungeonMapView:_onOpenView(viewName)
	if viewName ~= ViewName.VersionActivity2_4DungeonMapLevelView then
		return
	end

	self._rectmask2D.padding = RECT_MASK_PADDING_OPEN_MAP_LEVEL

	gohelper.setActive(self._btncloseview, true)
	self:hideBtnUI()
end

function VersionActivity2_4DungeonMapView:hideBtnUI()
	self.animator:Play(UIAnimationName.Close, 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_4DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	TaskDispatcher.runDelay(self.playCloseAnimaDone, self, ANIMA_TIME)
	self._btnwuerlixiAnimator:Play(UIAnimationName.Close, 0, 0)
end

function VersionActivity2_4DungeonMapView:playCloseAnimaDone()
	gohelper.setActive(self._gotopright, false)
	gohelper.setActive(self._goswitchmodecontainer, false)
	UIBlockMgr.instance:endBlock(VersionActivity2_4DungeonEnum.BlockKey.MapViewPlayCloseAnim)
end

function VersionActivity2_4DungeonMapView:_onCloseView(viewName)
	if viewName ~= ViewName.VersionActivity2_4DungeonMapLevelView then
		return
	end

	self._rectmask2D.padding = RECT_MASK_PADDING

	gohelper.setActive(self._btncloseview, false)
	self:showBtnUI()
end

function VersionActivity2_4DungeonMapView:showBtnUI()
	self:setNavBtnIsShow(true)
	gohelper.setActive(self._gotopright, true)
	gohelper.setActive(self._goswitchmodecontainer, true)
	self.animator:Play(UIAnimationName.Open, 0, 0)
	self._btnwuerlixiAnimator:Play(UIAnimationName.Open, 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_4DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	TaskDispatcher.runDelay(self.playOpenAnimaDone, self, ANIMA_TIME)
end

function VersionActivity2_4DungeonMapView:playOpenAnimaDone()
	UIBlockMgr.instance:endBlock(VersionActivity2_4DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivity2_4DungeonMapView:setNavBtnIsShow(isShow)
	gohelper.setActive(self._gotopleft, isShow)
end

function VersionActivity2_4DungeonMapView:onClickElement()
	self:hideBtnUI()
	self:setNavBtnIsShow(false)
end

function VersionActivity2_4DungeonMapView:_onRecheckInteractive(isShow)
	if isShow then
		self._rectmask2D.padding = RECT_MASK_PADDING

		gohelper.setActive(self._btncloseview, false)
		self:showBtnUI()
	else
		self:hideBtnUI()
		self:setNavBtnIsShow(false)
	end
end

function VersionActivity2_4DungeonMapView:onModeChange()
	self:refreshMask()
end

function VersionActivity2_4DungeonMapView:refreshMask()
	local isHardMode = self.activityDungeonMo:isHardMode()

	gohelper.setActive(self._simagenormalmask.gameObject, not isHardMode)
	gohelper.setActive(self._simagehardmask.gameObject, isHardMode)
end

function VersionActivity2_4DungeonMapView:refreshStoreRemainTime()
	local storeActId = VersionActivity3_1Enum.ActivityId.ReactivityStore
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

function VersionActivity2_4DungeonMapView:_OnUpdateMapElementState(mapId)
	return
end

function VersionActivity2_4DungeonMapView:onClose()
	self._showRewardView = false

	TaskDispatcher.cancelTask(self._everyMinuteCall, self)
	UIBlockMgr.instance:endBlock(VersionActivity2_4DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgr.instance:endBlock(VersionActivity2_4DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivity2_4DungeonMapView:onDestroyView()
	return
end

return VersionActivity2_4DungeonMapView
