-- chunkname: @modules/logic/versionactivity2_3/dungeon/view/map/VersionActivity2_3DungeonMapView.lua

module("modules.logic.versionactivity2_3.dungeon.view.map.VersionActivity2_3DungeonMapView", package.seeall)

local VersionActivity2_3DungeonMapView = class("VersionActivity2_3DungeonMapView", BaseView)
local RECT_MASK_PADDING = Vector4(0, 0, 0, 0)
local RECT_MASK_PADDING_OPEN_MAP_LEVEL = Vector4(0, 0, 600, 0)
local ANIMA_TIME = 0.5

function VersionActivity2_3DungeonMapView:onInitView()
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
	self._btnrestaurant = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_restaurant")
	self._goact165Reddot = gohelper.findChild(self.viewGO, "#go_topright/#btn_restaurant/#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_3DungeonMapView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.Act165GetInfoReply, self.refreshRestaurantBtn, self)
	self.addEventCb(self, VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnClickElement, self.onClickElement, self)
	self.addEventCb(self, VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnHideInteractUI, self.showBtnUI, self)
	self.addEventCb(self, Activity165Controller.instance, Activity165Event.refreshStoryReddot, self._act165RedDot, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self._OnUpdateMapElementState, self)
	self.addEventCb(self, GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, self.checkLoadingAndRefresh, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckInteractive, self._onRecheckInteractive, self)
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
	self._btnactivitystore:AddClickListener(self._btnactivitystoreOnClick, self)
	self._btnactivitytask:AddClickListener(self._btnactivitytaskOnClick, self)
	self._btnrestaurant:AddClickListener(self._btnrestaurantOnClick, self)
end

function VersionActivity2_3DungeonMapView:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self.onRemoveElement, self, LuaEventSystem.Low)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.BeginShowRewardView, self.beginShowRewardView, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.EndShowRewardView, self.endShowRewardView, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self.removeEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivityState, self)
	self.removeEventCb(self, Activity165Controller.instance, Activity165Event.Act165GetInfoReply, self.refreshRestaurantBtn, self)
	self.removeEventCb(self, VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnClickElement, self.onClickElement, self)
	self.removeEventCb(self, VersionActivity2_3DungeonController.instance, VersionActivity2_3DungeonEvent.OnHideInteractUI, self.showBtnUI, self)
	self.removeEventCb(self, Activity165Controller.instance, Activity165Event.refreshStoryReddot, self._act165RedDot, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self._OnUpdateMapElementState, self)
	self.removeEventCb(self, GameSceneMgr.instance, SceneEventName.LoadingAnimEnd, self.checkLoadingAndRefresh, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckInteractive, self._onRecheckInteractive, self)
	self._btncloseview:RemoveClickListener()
	self._btnactivitystore:RemoveClickListener()
	self._btnactivitytask:RemoveClickListener()
	self._btnrestaurant:RemoveClickListener()
end

function VersionActivity2_3DungeonMapView:_btncloseviewOnClick()
	ViewMgr.instance:closeView(ViewName.VersionActivity2_3DungeonMapLevelView)
end

function VersionActivity2_3DungeonMapView:_btnactivitystoreOnClick()
	VersionActivity2_3DungeonController.instance:openStoreView()
end

function VersionActivity2_3DungeonMapView:_btnactivitytaskOnClick()
	VersionActivity2_3DungeonController.instance:openTaskView()
end

function VersionActivity2_3DungeonMapView:_btnrestaurantOnClick()
	Activity165Controller.instance:openActivity165EnterView()
end

function VersionActivity2_3DungeonMapView:_onEscBtnClick()
	local isShowInteractView = VersionActivity2_3DungeonModel.instance:checkIsShowInteractView()

	if isShowInteractView then
		self.viewContainer.interactView:hide()
	else
		self:closeThis()
	end
end

function VersionActivity2_3DungeonMapView:beginShowRewardView()
	self._showRewardView = true
end

function VersionActivity2_3DungeonMapView:endShowRewardView()
	self._showRewardView = false
end

function VersionActivity2_3DungeonMapView:onRemoveElement(elementId)
	local storyCo = VersionActivity2_3DungeonModel.instance:checkStoryCanUnlock(elementId)
	local actId = Activity165Model.instance:getActivityId()

	if storyCo then
		GameFacade.showToast(ToastEnum.Act165StoryUnlock, storyCo.name)
		Activity165Model.instance:onInitInfo()
	end
end

function VersionActivity2_3DungeonMapView:_editableInitView()
	local currencyCfg = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V2a3Dungeon)

	if currencyCfg then
		local currencyName = string.format("%s_1", currencyCfg and currencyCfg.icon)

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagestoreicon, currencyName)
	end

	local storeActInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_3Enum.ActivityId.DungeonStore]

	self._txtstorename.text = storeActInfoMo.config.name

	NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)
	TaskDispatcher.runRepeat(self._everyMinuteCall, self, TimeUtil.OneMinuteSecond)
	RedDotController.instance:addRedDot(self._goTaskReddot, RedDotEnum.DotNode.V2a3DungeonTask)
	self:_act165RedDot()
	gohelper.setActive(self._btnrestaurant.gameObject, false)
end

function VersionActivity2_3DungeonMapView:_everyMinuteCall()
	self:refreshUI()
end

function VersionActivity2_3DungeonMapView:onUpdateParam()
	self:onOpen()
end

function VersionActivity2_3DungeonMapView:onOpen()
	VersionActivity2_3DungeonController.instance:onVersionActivityDungeonMapViewOpen()
	self:refreshUI()
end

function VersionActivity2_3DungeonMapView:checkLoadingAndRefresh()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function VersionActivity2_3DungeonMapView:refreshUI()
	self:refreshRestaurantBtn()
	self:refreshActivityCurrency()
	self:refreshMask()
	self:refreshStoreRemainTime()
end

function VersionActivity2_3DungeonMapView:refreshActivityCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a3Dungeon)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtstorenum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivity2_3DungeonMapView:onRefreshActivityState(updateActId)
	if updateActId == VersionActivity2_3Enum.ActivityId.Dungeon then
		local status = ActivityHelper.getActivityStatusAndToast(updateActId)
		local isNormal = status == ActivityEnum.ActivityStatus.Normal

		if not isNormal then
			self:closeThis()
			GameFacade.showToast(ToastEnum.ActivityEnd)

			return
		end
	end

	local actId = Activity165Model.instance:getActivityId()

	if updateActId and updateActId ~= actId then
		return
	end

	local isOnline = ActivityModel.instance:isActOnLine(actId)

	if isOnline then
		Activity165Model.instance:onInitInfo()
	else
		gohelper.setActive(self._btnrestaurant.gameObject, false)
	end
end

function VersionActivity2_3DungeonMapView:_onOpenView(viewName)
	if viewName ~= ViewName.VersionActivity2_3DungeonMapLevelView then
		return
	end

	self._rectmask2D.padding = RECT_MASK_PADDING_OPEN_MAP_LEVEL

	gohelper.setActive(self._btncloseview, true)
	self:hideBtnUI()
end

function VersionActivity2_3DungeonMapView:hideBtnUI()
	self.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_3DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	TaskDispatcher.runDelay(self.playCloseAnimaDone, self, ANIMA_TIME)
end

function VersionActivity2_3DungeonMapView:playCloseAnimaDone()
	gohelper.setActive(self._gotopright, false)
	gohelper.setActive(self._goswitchmodecontainer, false)
	UIBlockMgr.instance:endBlock(VersionActivity2_3DungeonEnum.BlockKey.MapViewPlayCloseAnim)
end

function VersionActivity2_3DungeonMapView:_onCloseView(viewName)
	if viewName ~= ViewName.VersionActivity2_3DungeonMapLevelView then
		return
	end

	self._rectmask2D.padding = RECT_MASK_PADDING

	gohelper.setActive(self._btncloseview, false)
	self:showBtnUI()
end

function VersionActivity2_3DungeonMapView:showBtnUI()
	self:setNavBtnIsShow(true)
	gohelper.setActive(self._gotopright, true)
	gohelper.setActive(self._goswitchmodecontainer, true)
	self:refreshRestaurantBtn()
	self.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_3DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	TaskDispatcher.runDelay(self.playOpenAnimaDone, self, ANIMA_TIME)
end

function VersionActivity2_3DungeonMapView:refreshRestaurantBtn()
	local isUnlockAct165Btn = VersionActivity2_3DungeonModel.instance:isUnlockAct165Btn()

	gohelper.setActive(self._btnrestaurant.gameObject, false)
end

function VersionActivity2_3DungeonMapView:playOpenAnimaDone()
	UIBlockMgr.instance:endBlock(VersionActivity2_3DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivity2_3DungeonMapView:setNavBtnIsShow(isShow)
	gohelper.setActive(self._gotopleft, isShow)
end

function VersionActivity2_3DungeonMapView:onClickElement()
	self:hideBtnUI()
	self:setNavBtnIsShow(false)
end

function VersionActivity2_3DungeonMapView:_onRecheckInteractive(isShow)
	if isShow then
		self._rectmask2D.padding = RECT_MASK_PADDING

		gohelper.setActive(self._btncloseview, false)
		self:showBtnUI()
	else
		self:hideBtnUI()
		self:setNavBtnIsShow(false)
	end
end

function VersionActivity2_3DungeonMapView:onModeChange()
	self:refreshMask()
end

function VersionActivity2_3DungeonMapView:refreshMask()
	local isHardMode = self.activityDungeonMo:isHardMode()

	gohelper.setActive(self._simagenormalmask.gameObject, not isHardMode)
	gohelper.setActive(self._simagehardmask.gameObject, isHardMode)
end

function VersionActivity2_3DungeonMapView:refreshStoreRemainTime()
	local isReactivity = ReactivityEnum.ActivityDefine[VersionActivity2_3Enum.ActivityId.Dungeon]
	local actInfoMo = ActivityModel.instance:getActMO((isReactivity or nil) and VersionActivity2_9Enum.ActivityId.ReactivityStore)
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

function VersionActivity2_3DungeonMapView:_act165RedDot()
	local isShow = Activity165Model.instance:isShowAct165Reddot()

	gohelper.setActive(self._goact165Reddot.gameObject, isShow)
end

function VersionActivity2_3DungeonMapView:_OnUpdateMapElementState(mapId)
	local elements = Activity165Model.instance:getAllElements()

	if elements then
		for _, element in pairs(elements) do
			local co = DungeonConfig.instance:getChapterMapElement(element)

			if co and co.mapId == mapId then
				Activity165Model.instance:onInitInfo()

				return
			end
		end
	end
end

function VersionActivity2_3DungeonMapView:onClose()
	self._showRewardView = false

	TaskDispatcher.cancelTask(self._everyMinuteCall, self)
	UIBlockMgr.instance:endBlock(VersionActivity2_3DungeonEnum.BlockKey.MapViewPlayOpenAnim)
	UIBlockMgr.instance:endBlock(VersionActivity2_3DungeonEnum.BlockKey.MapViewPlayCloseAnim)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivity2_3DungeonMapView:onDestroyView()
	return
end

return VersionActivity2_3DungeonMapView
