-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/VersionActivity1_3DungeonMapView.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapView", package.seeall)

local VersionActivity1_3DungeonMapView = class("VersionActivity1_3DungeonMapView", BaseViewExtended)

function VersionActivity1_3DungeonMapView:onInitView()
	self._simagefullmask = gohelper.findChildSingleImage(self.viewGO, "#simage_fullmask")
	self._topLeftGo = gohelper.findChild(self.viewGO, "top_left")
	self._topRightGo = gohelper.findChild(self.viewGO, "#go_topright")
	self._topLeftElementGo = gohelper.findChild(self.viewGO, "top_left_element")
	self._goversionactivity = gohelper.findChild(self.viewGO, "#go_tasklist/#go_versionActivity")
	self._gomain = gohelper.findChild(self.viewGO, "#go_main")
	self._gores = gohelper.findChild(self.viewGO, "#go_res")
	self._btnactivitybuff = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_activitybuff")
	self._txtstorenum = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitystore/#txt_num")
	self._gointeractiveroot = gohelper.findChild(self.viewGO, "#go_interactive_root")
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3DungeonMapView:addEvents()
	self._btnactivitybuff:AddClickListener(self.btnActivityBuffOnClick, self)
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
end

function VersionActivity1_3DungeonMapView:removeEvents()
	self._btnactivitybuff:RemoveClickListener()
	self._btncloseview:RemoveClickListener()
end

function VersionActivity1_3DungeonMapView:_btncloseviewOnClick()
	ViewMgr.instance:closeView(ViewName.VersionActivity1_3DungeonMapLevelView)
end

function VersionActivity1_3DungeonMapView:btnActivityBuffOnClick()
	VersionActivity1_3BuffController.instance:openBuffView()
end

function VersionActivity1_3DungeonMapView:_updateBtns()
	gohelper.setActive(self._btnactivitybuff, OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_30101))
end

function VersionActivity1_3DungeonMapView:_editableInitView()
	gohelper.setActive(self._goversionactivity, true)
	self:_updateBtns()
	gohelper.setActive(self._gomain, false)
	gohelper.setActive(self._gores, false)

	self.btnBuffAnimator = self._btnactivitybuff.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self.modeAnimator = self._goversionactivity:GetComponent(typeof(UnityEngine.Animator))
	self.txtTaskGet = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitytask/#txt_get")
	self.goTaskRedDot = gohelper.findChild(self.viewGO, "#go_topright/#btn_activitytask/#go_reddot")
	self.goAstrologyRedDot = gohelper.findChild(self.viewGO, "#go_topright/#btn_activityastrology/#go_reddot")
	self.goBuffRedDot = gohelper.findChild(self.viewGO, "#go_topright/#btn_activitybuff/#go_reddot")

	RedDotController.instance:addRedDot(self.goTaskRedDot, RedDotEnum.DotNode.Activity1_3RedDot1)
	RedDotController.instance:addRedDot(self.goAstrologyRedDot, RedDotEnum.DotNode.Activity1_3RedDot3)
	RedDotController.instance:addRedDot(self.goBuffRedDot, RedDotEnum.DotNode.Activity1_3RedDot2)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshTaskUI, self)
	gohelper.removeUIClickAudio(self._btncloseview.gameObject)
end

function VersionActivity1_3DungeonMapView:_showDailyReddot()
	local result = Activity126Model.instance:receiveGetHoroscope()
	local finish = result and result > 0

	if finish then
		return false
	end

	local remainNum, totalNum = Activity126Model.instance:getRemainNum()

	if remainNum <= 0 then
		return false
	end

	local zeroTime = self:_getZeroTime()
	local saveZeroTime = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyRedDot), 0)

	if zeroTime ~= saveZeroTime then
		return true
	end

	return false
end

function VersionActivity1_3DungeonMapView:_markDailyReddot()
	local zeroTime = self:_getZeroTime()

	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyRedDot), zeroTime)
end

function VersionActivity1_3DungeonMapView:_getZeroTime()
	local nowDate = os.date("*t", os.time() - 18000)

	nowDate.hour = 0
	nowDate.min = 0
	nowDate.sec = 0

	return (os.time(nowDate))
end

function VersionActivity1_3DungeonMapView:_showMask()
	local isHard = self.activityDungeonMo:isHardMode()
	local name = isHard and "v1a3_dungeon_hardlevelmapmask" or "v1a3_dungeon_normallevelmapmask"

	self._simagefullmask:LoadImage(string.format("singlebg/v1a3_dungeon_singlebg/%s.png", name))
end

function VersionActivity1_3DungeonMapView:onUpdateParam()
	self:refreshUI()
	self:_directClickDaily()
end

function VersionActivity1_3DungeonMapView:_onEscBtnClick()
	self:closeThis()
end

function VersionActivity1_3DungeonMapView:openAmbientSound(id)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.VersionActivity1_3DungeonAmbientSound, id, AudioEnum.UI.stop_ui_noise_allarea)
	AudioMgr.instance:trigger(id)
end

function VersionActivity1_3DungeonMapView:closeAmbientSound()
	AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.VersionActivity1_3DungeonAmbientSound, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
end

function VersionActivity1_3DungeonMapView:onOpen()
	self.activityDungeonMo = self.viewContainer.versionActivityDungeonBaseMo

	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self._setEpisodeListVisible, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self)
	self.addEventCb(self, MainController.instance, MainEvent.OnFuncUnlockRefresh, self._updateBtns, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnChangeMap, self._OnChangeMap, self)
	self.addEventCb(self, VersionActivity1_3DungeonController.instance, VersionActivity1_3DungeonEvent.OpenDailyInteractiveItem, self._onOpenDailyInteractiveItem, self)
	self:refreshUI()
	self:_showMask()
	NavigateMgr.instance:addEscape(ViewName.VersionActivity1_3DungeonMapView, self._onEscBtnClick, self)
	self:_directClickDaily()
end

function VersionActivity1_3DungeonMapView:_onOpenDailyInteractiveItem()
	self:_markDailyReddot()
end

function VersionActivity1_3DungeonMapView:_OnChangeMap()
	local time = self.viewContainer.mapScene:getMapTime()

	if time then
		VersionActivity1_3DungeonController.instance:openDungeonChangeView(time)
	end

	if VersionActivity1_3DungeonController.instance:isDayTime(self.activityDungeonMo.episodeId) then
		self:openAmbientSound(AudioEnum.Bgm.VersionActivity1_3DungeonAmbientSound1)
	else
		self:openAmbientSound(AudioEnum.Bgm.VersionActivity1_3DungeonAmbientSound2)
	end
end

function VersionActivity1_3DungeonMapView:_directClickDaily()
	if self.viewParam.showDaily then
		VersionActivity1_3DungeonController.instance.directFocusDaily = true

		self:_onClickDaily()

		self.viewParam.showDaily = nil
	end
end

function VersionActivity1_3DungeonMapView:onModeChange()
	self:_showMask()
end

function VersionActivity1_3DungeonMapView:refreshUI()
	self.btnBuffAnimator:Play(UIAnimationName.Open)
	self:refreshTaskUI()
	self:refreshActivityCurrency()
	self:_showMask()
end

function VersionActivity1_3DungeonMapView:refreshTaskUI()
	self.txtTaskGet.text = string.format("%s/%s", self:getFinishTaskCount(), VersionActivityConfig.instance:getAct113TaskCount(VersionActivity1_3Enum.ActivityId.Dungeon))
end

function VersionActivity1_3DungeonMapView:refreshActivityCurrency()
	local currencyId = ReactivityModel.instance:getActivityCurrencyId(VersionActivity1_3Enum.ActivityId.Dungeon)
	local currencyMO = CurrencyModel.instance:getCurrency(currencyId)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtstorenum.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivity1_3DungeonMapView:getFinishTaskCount()
	local finishTaskCount = 0
	local taskMo

	for _, taskCo in ipairs(VersionActivityConfig.instance:getAct113TaskList(VersionActivity1_3Enum.ActivityId.Dungeon)) do
		taskMo = TaskModel.instance:getTaskById(taskCo.id)

		if taskMo and taskMo.finishCount >= taskCo.maxFinishCount then
			finishTaskCount = finishTaskCount + 1
		end
	end

	return finishTaskCount
end

function VersionActivity1_3DungeonMapView:_setEpisodeListVisible(value)
	gohelper.setActive(self._topLeftGo, value)

	if value then
		self.btnBuffAnimator:Play(UIAnimationName.Open, 0, 0)
		self.modeAnimator:Play(UIAnimationName.Open, 0, 0)
	else
		self.btnBuffAnimator:Play(UIAnimationName.Close, 0, 0)
		self.modeAnimator:Play(UIAnimationName.Close, 0, 0)
	end
end

function VersionActivity1_3DungeonMapView:_onOpenView(viewName)
	if viewName == ViewName.VersionActivity1_3DungeonMapLevelView then
		self.btnBuffAnimator:Play(UIAnimationName.Close, 0, 0)
		self.modeAnimator:Play(UIAnimationName.Close, 0, 0)
		gohelper.setActive(self._btncloseview, true)
	end
end

function VersionActivity1_3DungeonMapView:_onCloseView(viewName)
	if viewName == ViewName.VersionActivity1_3DungeonMapLevelView then
		self.btnBuffAnimator:Play(UIAnimationName.Open, 0, 0)
		self.modeAnimator:Play(UIAnimationName.Open, 0, 0)
		gohelper.setActive(self._btncloseview, false)
	end
end

function VersionActivity1_3DungeonMapView:openMapInteractiveItem()
	self._interActiveItem = self._interActiveItem or self:openSubView(DungeonMapInteractive1_3Item, self._gointeractiveroot)

	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)

	return self._interActiveItem
end

function VersionActivity1_3DungeonMapView:showInteractiveItem()
	if self._interActiveItem then
		local childViews = self._interActiveItem:getChildViews()

		if childViews and #childViews > 0 then
			return true
		end
	end
end

function VersionActivity1_3DungeonMapView:onClose()
	self:closeAmbientSound()
end

return VersionActivity1_3DungeonMapView
