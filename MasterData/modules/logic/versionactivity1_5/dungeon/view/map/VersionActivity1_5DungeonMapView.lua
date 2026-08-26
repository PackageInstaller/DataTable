-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/map/VersionActivity1_5DungeonMapView.lua

module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapView", package.seeall)

local VersionActivity1_5DungeonMapView = class("VersionActivity1_5DungeonMapView", BaseView)

function VersionActivity1_5DungeonMapView:onInitView()
	self._topLeftGo = gohelper.findChild(self.viewGO, "#go_topleft")
	self._topRightGo = gohelper.findChild(self.viewGO, "#go_topright")
	self.simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_mask")
	self._goSwitchModeContainer = gohelper.findChild(self.viewGO, "#go_switchmodecontainer")
	self._btnactivitystore = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_activitystore")
	self._btnactivitytask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_activitytask")
	self._btnrevivaltask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_revivaltask")
	self._btnbuildingtask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_buildingtask")
	self._txtstorenum = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitystore/#txt_num")
	self._imagestoreicon = gohelper.findChildImage(self.viewGO, "#go_topright/#btn_activitystore/icon")
	self.switchGroupId = AudioMgr.instance:getIdFromString("music_vocal_filter")
	self.originalStateId = AudioMgr.instance:getIdFromString("original")
	self.accompanimentStateId = AudioMgr.instance:getIdFromString("accompaniment")
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5DungeonMapView:addEvents()
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
	self._btnactivitystore:AddClickListener(self.btnActivityStoreOnClick, self)
	self._btnactivitytask:AddClickListener(self.btnActivityTaskOnClick, self)
	self._btnrevivaltask:AddClickListener(self.btnRevivalTaskOnClick, self)
	self._btnbuildingtask:AddClickListener(self.btnBuildingTaskOnClick, self)
end

function VersionActivity1_5DungeonMapView:removeEvents()
	self._btnactivitystore:RemoveClickListener()
	self._btnactivitytask:RemoveClickListener()
	self._btnrevivaltask:RemoveClickListener()
	self._btnbuildingtask:RemoveClickListener()
	self._btncloseview:RemoveClickListener()
end

function VersionActivity1_5DungeonMapView:btnActivityStoreOnClick()
	ReactivityController.instance:openReactivityStoreView(VersionActivity1_5Enum.ActivityId.Dungeon)
end

function VersionActivity1_5DungeonMapView:btnActivityTaskOnClick()
	ReactivityController.instance:openReactivityTaskView(VersionActivity1_5Enum.ActivityId.Dungeon)
end

function VersionActivity1_5DungeonMapView:btnRevivalTaskOnClick()
	VersionActivity1_5DungeonController.instance:openRevivalTaskView()
end

function VersionActivity1_5DungeonMapView:btnBuildingTaskOnClick()
	VersionActivity1_5DungeonController.instance:openBuildView()
end

function VersionActivity1_5DungeonMapView:_editableInitView()
	self.playedRevivalTaskAnim = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey("unlockRevivalAnim"), 0) == 1
	self.playedBuildAnim = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey("unlockBuildAnim"), 0) == 1

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagestoreicon, "10501_1")

	self.goTaskRedDot = gohelper.findChild(self.viewGO, "#go_topright/#btn_activitytask/#go_reddot")
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)

	RedDotController.instance:addRedDot(self.goTaskRedDot, RedDotEnum.DotNode.V1a5DungeonTask)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, self.hideBtnUI, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnHideInteractUI, self.showBtnUI, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self.refreshBtnVisible, self, LuaEventSystem.Low)
	self.addEventCb(self, StoryController.instance, StoryEvent.FinishFromServer, self.refreshBtnVisible, self, LuaEventSystem.Low)
	self.addEventCb(self, DialogueController.instance, DialogueEvent.OnDialogueInfoChange, self.onDialogueInfoChange, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnRecheckInteractive, self._onRecheckInteractive, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.SetRevivalTaskBtnActive, self.setRevivalTaskBtnActive, self)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.SetBuildingBtnActive, self.setBuildingBtnActive, self)
	gohelper.setActive(self._btnactivitystore.gameObject, false)
	gohelper.setActive(self._btnactivitytask.gameObject, false)
end

function VersionActivity1_5DungeonMapView:onUpdateParam()
	self:refreshUI()
end

function VersionActivity1_5DungeonMapView:_onEscBtnClick()
	if VersionActivity1_5DungeonModel.instance:checkIsShowInteractView() then
		self.viewContainer.interactView:hide()

		return
	end

	self:closeThis()
end

function VersionActivity1_5DungeonMapView:onOpen()
	NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)
	self:refreshUI()
	self:closeBgmLeadSinger()
end

function VersionActivity1_5DungeonMapView:_onRecheckInteractive(isShow)
	if isShow then
		self:showBtnUI()
	else
		self:hideBtnUI()
	end
end

function VersionActivity1_5DungeonMapView:closeBgmLeadSinger()
	AudioMgr.instance:setSwitch(self.switchGroupId, self.accompanimentStateId)
end

function VersionActivity1_5DungeonMapView:openBgmLeadSinger()
	AudioMgr.instance:setSwitch(self.switchGroupId, self.originalStateId)
end

function VersionActivity1_5DungeonMapView:refreshUI()
	self:refreshBtnVisible()
	self:refreshActivityCurrency()
	self:refreshMask()
end

function VersionActivity1_5DungeonMapView:customRefreshExploreRedDot(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		redDotIcon.show = VersionActivity1_5RevivalTaskModel.instance:checkNeedShowElementRedDot()

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end
end

function VersionActivity1_5DungeonMapView:refreshBtnVisible()
	local isUnlock = DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.revivalTaskUnlockEpisodeId)

	gohelper.setActive(self._btnrevivaltask.gameObject, isUnlock)
	self:playRevivalAnim()

	if isUnlock and not self.revivalTaskRedDot then
		local goRevivalTaskRedDot = gohelper.findChild(self.viewGO, "#go_topright/#btn_revivaltask/#go_reddot")

		self.revivalTaskRedDot = RedDotController.instance:addRedDot(goRevivalTaskRedDot, RedDotEnum.DotNode.V1a5DungeonRevivalTask, nil, self.customRefreshExploreRedDot, self)
	end

	isUnlock = DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId)

	gohelper.setActive(self._btnbuildingtask.gameObject, isUnlock)
	self:playBuildAnim()

	if isUnlock and not self.buildTaskRedDot then
		local goBuildRedDot = gohelper.findChild(self.viewGO, "#go_topright/#btn_buildingtask/#go_reddot")

		self.buildTaskRedDot = RedDotController.instance:addRedDot(goBuildRedDot, RedDotEnum.DotNode.V1a5DungeonBuildTask)
	end
end

function VersionActivity1_5DungeonMapView:setRevivalTaskBtnActive(param)
	local active = param == "1"
	local isUnlock = DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.revivalTaskUnlockEpisodeId)

	active = active and isUnlock

	gohelper.setActive(self._btnrevivaltask.gameObject, active)

	if active then
		self:_playRevivalAnimImpl()
	end
end

function VersionActivity1_5DungeonMapView:setBuildingBtnActive(param)
	local active = param == "1"
	local isUnlock = DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId)

	active = active and isUnlock

	gohelper.setActive(self._btnbuildingtask.gameObject, active and isUnlock)

	if active then
		self:_playBuildAnimImpl()
	end
end

function VersionActivity1_5DungeonMapView:playRevivalAnim()
	if self.playedRevivalTaskAnim then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	local isUnlock = DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.revivalTaskUnlockEpisodeId)

	if isUnlock then
		self:_playRevivalAnimImpl()

		local key = PlayerModel.instance:getPlayerPrefsKey("unlockRevivalAnim")

		PlayerPrefsHelper.setNumber(key, 1)

		self.playedRevivalTaskAnim = true
	end
end

function VersionActivity1_5DungeonMapView:_playRevivalAnimImpl()
	local revivalTaskAnimator = self._btnrevivaltask:GetComponent(typeof(UnityEngine.Animator))

	revivalTaskAnimator:Play("unlock")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_flame)
end

function VersionActivity1_5DungeonMapView:playBuildAnim()
	if self.playedBuildAnim then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		return
	end

	local isUnlock = DungeonModel.instance:hasPassLevelAndStory(VersionActivity1_5DungeonConfig.instance.buildUnlockEpisodeId)

	if isUnlock then
		self:_playBuildAnimImpl()

		local key = PlayerModel.instance:getPlayerPrefsKey("unlockBuildAnim")

		PlayerPrefsHelper.setNumber(key, 1)

		self.playedBuildAnim = true
	end
end

function VersionActivity1_5DungeonMapView:_playBuildAnimImpl()
	local buildAnimator = self._btnbuildingtask:GetComponent(typeof(UnityEngine.Animator))

	buildAnimator:Play("unlock")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_flame)
end

function VersionActivity1_5DungeonMapView:refreshActivityCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a5Dungeon)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtstorenum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivity1_5DungeonMapView:refreshMask()
	local imageUrl = self.activityDungeonMo:isHardMode() and ResUrl.getV1a5DungeonSingleBg("v1a5_dungeon_hardlevelmapmask") or ResUrl.getV1a5DungeonSingleBg("v1a5_dungeon_normallevelmapmask")

	self.simagemask:LoadImage(imageUrl)
end

VersionActivity1_5DungeonMapView.BlockKey = "VersionActivity1_5DungeonMapView_OpenAnim"

function VersionActivity1_5DungeonMapView:showBtnUI()
	gohelper.setActive(self._btncloseview, false)
	gohelper.setActive(self._topLeftGo, true)
	gohelper.setActive(self._topRightGo, true)
	self.animator:Play("open", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity1_5DungeonMapView.BlockKey)
	TaskDispatcher.runDelay(self.onOpenAnimaDone, self, 0.667)
end

function VersionActivity1_5DungeonMapView:onOpenAnimaDone()
	UIBlockMgr.instance:endBlock(VersionActivity1_5DungeonMapView.BlockKey)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivity1_5DungeonMapView:hideBtnUI()
	gohelper.setActive(self._btncloseview, true)
	self.animator:Play("close", 0, 0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity1_5DungeonMapView.BlockKey)
	TaskDispatcher.runDelay(self.onCloseAnimaDone, self, 0.667)
end

function VersionActivity1_5DungeonMapView:onCloseAnimaDone()
	UIBlockMgr.instance:endBlock(VersionActivity1_5DungeonMapView.BlockKey)
	gohelper.setActive(self._topLeftGo, false)
	gohelper.setActive(self._topRightGo, false)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function VersionActivity1_5DungeonMapView:_onOpenView(viewName)
	if viewName == ViewName.VersionActivity1_5DungeonMapLevelView then
		self:hideBtnUI()
	end
end

function VersionActivity1_5DungeonMapView:_onCloseView(viewName)
	if viewName == ViewName.VersionActivity1_5DungeonMapLevelView then
		self:showBtnUI()
	end

	self:playRevivalAnim()
	self:playBuildAnim()
end

function VersionActivity1_5DungeonMapView:onModeChange()
	self:refreshMask()
end

function VersionActivity1_5DungeonMapView:onDialogueInfoChange()
	self:refreshExploreRedDot()
end

function VersionActivity1_5DungeonMapView:onUpdateDungeonInfo()
	self:refreshBtnVisible()
	self:refreshExploreRedDot()
end

function VersionActivity1_5DungeonMapView:refreshExploreRedDot()
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
		[RedDotEnum.DotNode.V1a5DungeonExploreTask] = true
	})
end

function VersionActivity1_5DungeonMapView:_btncloseviewOnClick()
	ViewMgr.instance:closeView(ViewName.VersionActivity1_5DungeonMapLevelView)
end

function VersionActivity1_5DungeonMapView:onClose()
	UIBlockMgr.instance:endBlock(VersionActivity1_5DungeonMapView.BlockKey)
	TaskDispatcher.cancelTask(self.onCloseAnimaDone, self)
	TaskDispatcher.cancelTask(self.onOpenAnimaDone, self)
	self:openBgmLeadSinger()
end

function VersionActivity1_5DungeonMapView:onDestroyView()
	self.simagemask:UnLoadImage()
end

return VersionActivity1_5DungeonMapView
