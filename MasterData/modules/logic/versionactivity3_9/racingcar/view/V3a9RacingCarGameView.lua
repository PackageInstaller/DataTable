-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/V3a9RacingCarGameView.lua

module("modules.logic.versionactivity3_9.racingcar.view.V3a9RacingCarGameView", package.seeall)

local V3a9RacingCarGameView = class("V3a9RacingCarGameView", BaseView)

function V3a9RacingCarGameView:onInitView()
	self._gotouch = gohelper.findChild(self.viewGO, "#go_touch")
	self._gostart = gohelper.findChild(self.viewGO, "root/Top/#go_start")
	self._imageCount = gohelper.findChildImage(self.viewGO, "root/Top/#go_start/#image_Count")
	self._golight1 = gohelper.findChild(self.viewGO, "root/Top/#go_start/#go_light_1")
	self._golight2 = gohelper.findChild(self.viewGO, "root/Top/#go_start/#go_light_2")
	self._golight3 = gohelper.findChild(self.viewGO, "root/Top/#go_start/#go_light_3")
	self._golight4 = gohelper.findChild(self.viewGO, "root/Top/#go_start/#go_light_4")
	self._gopause = gohelper.findChild(self.viewGO, "root/Top/#go_pause")
	self._txttime = gohelper.findChildText(self.viewGO, "root/Top/#go_pause/#txt_time")
	self._goround = gohelper.findChild(self.viewGO, "root/Top/#go_round")
	self._simageRound = gohelper.findChildSingleImage(self.viewGO, "root/Top/#go_round/#simage_Round")
	self._txtround1 = gohelper.findChildText(self.viewGO, "root/Top/#go_round/#txt_round1")
	self._gofirst = gohelper.findChild(self.viewGO, "root/Top/#go_first")
	self._txtfirst = gohelper.findChildText(self.viewGO, "root/Top/#go_first/#txt_first")
	self._btnspeedUp = gohelper.findChildButtonWithAudio(self.viewGO, "root/Right/#btn_speedUp")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "root/Right/#btn_speedUp/#image_progress")
	self._goThumb = gohelper.findChild(self.viewGO, "root/Right/#btn_speedUp/#image_progress/#go_Thumb")
	self._goclickable = gohelper.findChild(self.viewGO, "root/Right/#btn_speedUp/#go_clickable")
	self._goThumb2 = gohelper.findChild(self.viewGO, "root/Right/#btn_speedUp/#go_clickable/image_progress/#go_Thumb2")
	self._golevel1 = gohelper.findChild(self.viewGO, "root/Right/Combo/#go_level1")
	self._golevel2 = gohelper.findChild(self.viewGO, "root/Right/Combo/#go_level2")
	self._golevel3 = gohelper.findChild(self.viewGO, "root/Right/Combo/#go_level3")
	self._btnnextUse = gohelper.findChildButtonWithAudio(self.viewGO, "root/Right/#btn_nextUse")
	self._imageicon1 = gohelper.findChildImage(self.viewGO, "root/Right/#btn_nextUse/has/#image_icon1")
	self._goempty1 = gohelper.findChild(self.viewGO, "root/Right/#btn_nextUse/#go_empty1")
	self._btncurUse = gohelper.findChildButtonWithAudio(self.viewGO, "root/Right/#btn_curUse")
	self._imageicon2 = gohelper.findChildImage(self.viewGO, "root/Right/#btn_curUse/has/#image_icon2")
	self._imageicon3 = gohelper.findChildImage(self.viewGO, "root/Right/#btn_curUse/random/#image_icon3")
	self._goempty2 = gohelper.findChild(self.viewGO, "root/Right/#btn_curUse/#go_empty2")
	self._goTime = gohelper.findChild(self.viewGO, "root/Left/#go_Time")
	self._txttime2 = gohelper.findChildText(self.viewGO, "root/Left/#go_Time/#txt_time2")
	self._goround2 = gohelper.findChild(self.viewGO, "root/Left/#go_round2")
	self._txtround2 = gohelper.findChildText(self.viewGO, "root/Left/#go_round2/#txt_round2")
	self._txtbuffinfo = gohelper.findChildText(self.viewGO, "root/Left/#txt_buffinfo")
	self._goround3 = gohelper.findChild(self.viewGO, "root/Left/#go_round3")
	self._txtcurRank = gohelper.findChildText(self.viewGO, "root/Left/#go_round3/#txt_curRank")
	self._txttotalRank = gohelper.findChildText(self.viewGO, "root/Left/#go_round3/#txt_totalRank")
	self._imageRank = gohelper.findChildImage(self.viewGO, "root/Left/#go_round3/#image_Rank")
	self._goperform = gohelper.findChild(self.viewGO, "root/Left/#go_perform")
	self._txtname = gohelper.findChildText(self.viewGO, "root/Left/#go_perform/#txt_name")
	self._txtstatus = gohelper.findChildText(self.viewGO, "root/Left/#go_perform/#txt_status")
	self._txtspeed = gohelper.findChildText(self.viewGO, "root/Bottom/#txt_speed")
	self._goblock = gohelper.findChild(self.viewGO, "root/#go_block")
	self._golefttop = gohelper.findChild(self.viewGO, "root/#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9RacingCarGameView:addEvents()
	self._btnspeedUp:AddClickListener(self._btnspeedUpOnClick, self)
	self._btnnextUse:AddClickListener(self._btnnextUseOnClick, self)
	self._btncurUse:AddClickListener(self._btncurUseOnClick, self)
end

function V3a9RacingCarGameView:removeEvents()
	self._btnspeedUp:RemoveClickListener()
	self._btnnextUse:RemoveClickListener()
	self._btncurUse:RemoveClickListener()
end

function V3a9RacingCarGameView:_btnspeedUpOnClick()
	return
end

function V3a9RacingCarGameView:_btnnextUseOnClick()
	return
end

function V3a9RacingCarGameView:_btncurUseOnClick()
	local playerCtrl = V3a9RacingCarModel.instance:getPlayerVehicleController()
	local hasFirst = playerCtrl:getHeldItem()

	if hasFirst then
		playerCtrl:tryUseHeldItem()
		self:_updateItems()
	end
end

function V3a9RacingCarGameView:_updateItems()
	local playerCtrl = V3a9RacingCarModel.instance:getPlayerVehicleController()
	local secondItem = playerCtrl:getHeldItem()
	local firstItem = playerCtrl:getBackupItem()

	gohelper.setActive(self._imageicon1, firstItem)
	gohelper.setActive(self._goempty1, not firstItem)
	gohelper.setActive(self._imageicon2, secondItem)
	gohelper.setActive(self._goempty2, not secondItem)

	if firstItem then
		UISpriteSetMgr.instance:setV3a9RacingSprite(self._imageicon1, firstItem.icon)
	end

	if secondItem then
		UISpriteSetMgr.instance:setV3a9RacingSprite(self._imageicon2, secondItem.icon)

		self._itemName.text = secondItem.name
	end

	gohelper.setActive(self._itemNameRoot, secondItem ~= nil)
end

function V3a9RacingCarGameView:_onGuideWaitChangeLane(distance)
	local value = tonumber(distance)

	if not value then
		logError("_onGuideWaitChangeLane distance is nil")

		return
	end

	V3a9RacingCarModel.instance:setGuideParams(V3a9RacingCarEnum.GuideParam.Distance, value)
end

function V3a9RacingCarGameView:_onGuideWaitItem()
	V3a9RacingCarModel.instance:setGuideParams(V3a9RacingCarEnum.GuideParam.Item, true)
end

function V3a9RacingCarGameView:_onGuideWaitCoin()
	V3a9RacingCarModel.instance:setGuideParams(V3a9RacingCarEnum.GuideParam.Coin, true)
end

function V3a9RacingCarGameView:_onGuideWaitObstacle(distance)
	local value = tonumber(distance)

	if not value then
		logError("_onGuideWaitObstacle distance is nil")

		return
	end

	V3a9RacingCarModel.instance:setGuideParams(V3a9RacingCarEnum.GuideParam.Obstacle, value)
end

function V3a9RacingCarGameView:_onGuidePauseGame(param)
	if tonumber(param) == 1 then
		V3a9RacingCarModel.instance:setGameState(V3a9RacingCarEnum.RacingGameState.GuidePaused)
	else
		V3a9RacingCarModel.instance:setGameState(V3a9RacingCarEnum.RacingGameState.Racing)
	end
end

function V3a9RacingCarGameView:_onGuidePauseChangeLane(param)
	if tonumber(param) == 1 then
		V3a9RacingCarModel.instance:setPauseChangeLane(true)
	else
		V3a9RacingCarModel.instance:setPauseChangeLane(false)
	end
end

function V3a9RacingCarGameView:_onGuideCloseTouch()
	if self._touchEventMgr then
		TouchEventMgrHepler.remove(self._touchEventMgr)

		self._touchEventMgr = nil
	end
end

function V3a9RacingCarGameView:_onGuideOpenTouch()
	if self._touchEventMgr then
		return
	end

	self._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(self.viewGO)

	self._touchEventMgr:SetIgnoreUI(true)
	self._touchEventMgr:SetOnlyTouch(true)
	self._touchEventMgr:SetOnDragBeginCb(self._onTouchDragBegin, self)
	self._touchEventMgr:SetOnDragCb(self._onTouchDrag, self)
	self._touchEventMgr:SetOnDragEndCb(self._onTouchDragEnd, self)
end

function V3a9RacingCarGameView:_onTouchDragBegin(screenPos)
	self._curPos = screenPos
	self._dragTriggered = false
end

function V3a9RacingCarGameView:_onTouchDrag(screenPos)
	if self._curPos then
		local deltaX = screenPos.x - self._curPos.x
		local deltaY = screenPos.y - self._curPos.y

		self:_checkDrag(deltaX, deltaY)
	end
end

function V3a9RacingCarGameView:_onTouchDragEnd(screenPos)
	self._curPos = nil
	self._dragTriggered = false
end

function V3a9RacingCarGameView:_onResetGuideStatus(guideId)
	if guideId >= 39025 and guideId <= 39032 then
		V3a9RacingCarModel.instance:setGameState(V3a9RacingCarEnum.RacingGameState.Racing)
		V3a9RacingCarModel.instance:setPauseChangeLane(false)

		if self._touchEventMgr then
			TouchEventMgrHepler.remove(self._touchEventMgr)

			self._touchEventMgr = nil
		end
	end
end

function V3a9RacingCarGameView:_editableInitView()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gotouch)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.OnLapUpdate, self._onLapUpdate, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.OnRestartGame, self._onRestartGame, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.OnStoreItemChange, self._onStoreItemChange, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.OnPauseGame, self._onPauseGame, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.OnPlayerReach, self._onPlayerReach, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._OnCloseViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._OnOpenViewFinish, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.GuideWaitChangeLane, self._onGuideWaitChangeLane, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.GuideWaitItem, self._onGuideWaitItem, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.GuideWaitCoin, self._onGuideWaitCoin, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.GuideWaitObstacle, self._onGuideWaitObstacle, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.GuidePauseGame, self._onGuidePauseGame, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.GuidePauseChangeLane, self._onGuidePauseChangeLane, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.GuideOpenTouch, self._onGuideOpenTouch, self)
	self.addEventCb(self, V3a9RacingCarController.instance, V3a9RacingCarEvent.GuideCloseTouch, self._onGuideCloseTouch, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.InterruptGuide, self._onResetGuideStatus, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.FinishGuideLastStep, self._onResetGuideStatus, self)
	gohelper.setActive(self._gofirst, false)
	gohelper.setActive(self._gostart, false)
	gohelper.setActive(self._gopause, false)
	gohelper.setActive(self._goround, false)
	gohelper.setActive(self._goperform, false)

	local comboGo = gohelper.findChild(self.viewGO, "root/Right/Combo")

	gohelper.setActive(comboGo, true)

	self._goNormalBg = gohelper.findChild(self.viewGO, "root/Bottom/#normal_bg")
	self._goSpeedBg = gohelper.findChild(self.viewGO, "root/Bottom/#speed_bg")
	self._goBottom = gohelper.findChild(self.viewGO, "root/Bottom")

	gohelper.setActive(self._goNormalBg, true)
	gohelper.setActive(self._goSpeedBg, false)
	gohelper.setActive(self._goblock, false)

	self._itemNameRoot = gohelper.findChild(self.viewGO, "root/Right/#go_name_2")
	self._itemName = gohelper.findChildText(self.viewGO, "root/Right/#go_name_2/#txt_name")

	gohelper.setActive(self._itemNameRoot, false)
end

function V3a9RacingCarGameView:_onRefreshActivityState()
	if not ActivityHelper.isOpen(VersionActivity3_9Enum.ActivityId.Racing) then
		self:_onPauseGame(true)
	end
end

function V3a9RacingCarGameView:_OnCloseViewFinish(viewName)
	if viewName == ViewName.V3a9RacingCarLoadingView and self._waitLoadingClose then
		self._waitLoadingClose = false

		self:_showCountDown(self._gostart)
	end
end

function V3a9RacingCarGameView:_OnOpenViewFinish(viewName)
	if viewName == ViewName.V3a9RacingCarRecordView then
		AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.StopChongranRippleAmb)
		self:_stopFlyingLoopIfActive()
		self:_stopWaterSplashLoopIfActive()
	end
end

function V3a9RacingCarGameView:_onStoreItemChange()
	self:_updateItems()
end

function V3a9RacingCarGameView:_onPlayerReach()
	gohelper.setActive(self._goblock, true)

	local player = V3a9RacingCarModel.instance:getPlayerVehicleController()

	player.buffManager:addBuffById(100116)
	V3a9RacingCarController.instance:openV3a9RacingCarResultView()
	gohelper.setActive(self._goBottom, false)
end

function V3a9RacingCarGameView:_onPauseGame(isPause)
	if isPause then
		V3a9RacingCarModel.instance:setGameState(V3a9RacingCarEnum.RacingGameState.Paused)
		gohelper.setActive(self._gopause, false)
		TaskDispatcher.cancelTask(self._countDownFinish, self)

		self._firstPlaceTime = 0

		AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.StopChongranSplashWater)
	else
		local playerCtrl = V3a9RacingCarModel.instance:getPlayerVehicleController()

		if playerCtrl:isPostFinish() then
			self:_countDownFinish()
		else
			self:_showCountDown(self._gopause)
		end
	end

	logNormal("V3a9RacingCarGameView:_onPauseGame:", tostring(isPause))
end

function V3a9RacingCarGameView:_onDragBegin(param, pointerEventData)
	self._dragBeginPos = pointerEventData.position
	self._dragTriggered = false
end

function V3a9RacingCarGameView:_onDrag(param, pointerEventData)
	self:_tryTriggerLaneSwitchByDrag(pointerEventData)
end

function V3a9RacingCarGameView:_onDragEnd(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	self:_tryTriggerLaneSwitchByDrag(pointerEventData)

	self._dragBeginPos = nil
	self._dragTriggered = false
end

local LaneSwitchDragWidthRatioConstId = 1016
local LaneSwitchDragMinPixelsConstId = 1017
local LaneSwitchDragMaxPixelsConstId = 1018

local function GetRacingConstNumber(constId, defaultValue)
	local var_30_0 = lua_racing_const

	if lua_racing_const then
		var_30_0 = lua_racing_const.configDict

		if lua_racing_const.configDict then
			local activityConfig = lua_racing_const.configDict[13920]
			local config = activityConfig and activityConfig[constId]

			return config and tonumber(config.value) or defaultValue
		end
	end
end

function V3a9RacingCarGameView:_tryTriggerLaneSwitchByDrag(pointerEventData)
	if self._dragTriggered or not self._dragBeginPos then
		return
	end

	local deltaX = pointerEventData.position.x - self._dragBeginPos.x
	local deltaY = pointerEventData.position.y - self._dragBeginPos.y

	self:_checkDrag(deltaX, deltaY)
end

function V3a9RacingCarGameView:_checkDrag(deltaX, deltaY)
	self._dragWidthRatio = self._dragWidthRatio or GetRacingConstNumber(LaneSwitchDragWidthRatioConstId, 0.025)
	self._dragMinPixels = self._dragMinPixels or GetRacingConstNumber(LaneSwitchDragMinPixelsConstId, 24)
	self._dragMaxPixels = self._dragMaxPixels or GetRacingConstNumber(LaneSwitchDragMaxPixelsConstId, 48)

	local minPixels = self._dragMinPixels
	local maxPixels = math.max(minPixels, self._dragMaxPixels)
	local threshold = Mathf.Clamp(UnityEngine.Screen.width * self._dragWidthRatio, minPixels, maxPixels)

	if threshold > math.abs(deltaX) or math.abs(deltaX) < math.abs(deltaY) then
		return
	end

	self._dragTriggered = true

	local controller = V3a9RacingCarModel.instance:getPlayerVehicleController()

	if controller then
		controller:setSteeringInput(deltaX > 0 and -1 or 1)
	end
end

function V3a9RacingCarGameView:_onLapUpdate(currentLap, totalLaps)
	if not self._isOnMainRoad then
		return
	end

	self._txtround2.text = string.format("%d/%d", currentLap, totalLaps)

	if currentLap <= 0 or currentLap == totalLaps then
		return
	end

	self._simageRound:LoadImage(string.format("singlebg_lang/txt_v3a9_racing_singlebg/v3a9_racing_game_round%s.png", currentLap))
	gohelper.setActive(self._goround, true)
	TaskDispatcher.cancelTask(self._hideRoundTip, self)
	TaskDispatcher.runDelay(self._hideRoundTip, self, 3)
end

function V3a9RacingCarGameView:_hideRoundTip()
	gohelper.setActive(self._goround, false)
end

function V3a9RacingCarGameView:_onRestartGame()
	V3a9RacingCarController.instance:startStat()
	gohelper.setActive(self._goNormalBg, true)
	gohelper.setActive(self._goSpeedBg, false)
	gohelper.setActive(self._goBottom, true)
	gohelper.setActive(self._goblock, false)
	V3a9RacingCarModel.instance:resetGameState()
	self:_updateItems()
	self:_stopFlyingLoopIfActive()
	self:_stopWaterSplashLoopIfActive()
	self:_initInfo()
	TaskDispatcher.cancelTask(self._frameUpdate, self)
	TaskDispatcher.runRepeat(self._frameUpdate, self, 0)
	self:_showCountDown(self._gostart)
end

function V3a9RacingCarGameView:_initInfo()
	self._txtspeed.text = "0 KM/H"
	self._txttime2.text = self:_formatRaceTime(0)
	self._raceTimeUiElapsed = 0
	self._lastRaceTimeDisplayCs = 0
	self._txtcurRank.text = tostring(0)
	self._txttotalRank.text = tostring(0)

	local trackConfig = V3a9RacingCarModel.instance:getTrackConfig()

	self._txtround2.text = string.format("0/%d", (trackConfig and trackConfig.level or nil) and (trackConfig.level.lapCount or 1))
	self._raceElapsedSec = 0
	self._raceBegin = false
	self._isOnMainRoad = true
	self._firstPlaceTime = 0
	self._firstAnimPlaying = false

	gohelper.setActive(self._gofirst, false)
end

function V3a9RacingCarGameView:onOpenFinish()
	self._oriRolesStoryMaskActive = PostProcessingMgr.instance:getUnitPPValue("rolesStoryMaskActive")
	self._oriRolesStoryMaskActive2 = PostProcessingMgr.instance:getUnitPPValue("RolesStoryMaskActive")

	PostProcessingMgr.instance:setUnitPPValue("rolesStoryMaskActive", false)
	PostProcessingMgr.instance:setUnitPPValue("RolesStoryMaskActive", false)
end

function V3a9RacingCarGameView:onOpen()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "V3a9RacingCarGameView", true)
	V3a9RacingCarController.instance:startStat()
	self:_initInfo()
	TaskDispatcher.cancelTask(self._frameUpdate, self)
	TaskDispatcher.runRepeat(self._frameUpdate, self, 0)
	self:_updateItems()

	local str = lua_racing_const.configDict[13920][1005].value2

	self._speedConstList = string.splitToNumber(str, "#")

	if ViewMgr.instance:isOpen(ViewName.V3a9RacingCarLoadingView) then
		self._waitLoadingClose = true

		return
	end

	self:_showCountDown()
end

function V3a9RacingCarGameView:_frameUpdate()
	local gameState = V3a9RacingCarModel.instance:getGameState()
	local isEditor = SLFramework.FrameworkSettings.IsEditor

	if gameState == V3a9RacingCarEnum.RacingGameState.Racing then
		self._raceElapsedSec = (self._raceElapsedSec or 0) + Time.deltaTime

		V3a9RacingCarModel.instance:setRaceTime(self._raceElapsedSec)

		local playerCtrl = V3a9RacingCarModel.instance:getPlayerVehicleController()
		local isOnMainRoad = not playerCtrl.getNormalizedRouteId or playerCtrl:getNormalizedRouteId() == "main"

		self._isOnMainRoad = isOnMainRoad and not playerCtrl:isRaceDistanceFrozen()

		if not playerCtrl:isPostFinish() then
			self:_updateRaceTime()
		end

		self:_updateRaceRank()
		self:_updateSpeed()
		self:_updateFlyingLoopAudio()

		if isEditor then
			self:_updateBuffInfo()
		end

		if V3a9RacingCarModel.instance:isRaceFinished() then
			self:_onRaceFinished()
		end
	end

	if isEditor and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) and not V3a9RacingCarModel.instance:isRaceFinished() then
		V3a9RacingCarModel.instance:setRaceFinished(true)
		self:_onRaceFinished()
		V3a9RacingCarController.instance:openV3a9RacingCarResultView()
		gohelper.setActive(self._goBottom, false)
	end
end

local SpeedUpdateInterval = 0.15
local BuffUpdateInterval = 0.2

function V3a9RacingCarGameView:_updateBuffInfo()
	self._buffUpdateElapsed = (self._buffUpdateElapsed or 0) + Time.deltaTime

	if self._buffUpdateElapsed < BuffUpdateInterval then
		return
	end

	self._buffUpdateElapsed = 0

	local playerCtrl = V3a9RacingCarModel.instance:getPlayerVehicleController()

	if not playerCtrl then
		self._txtbuffinfo.text = ""

		return
	end

	local buffLines = {}

	if playerCtrl.getCurrentEnergy and playerCtrl.getMaxEnergy then
		local curEnergy = playerCtrl:getCurrentEnergy()
		local maxEnergy = playerCtrl:getMaxEnergy()

		table.insert(buffLines, string.format("Energy: %.0f/%.0f", curEnergy, maxEnergy))
	end

	local passiveIds = playerCtrl._passiveSkillEffectIds

	if passiveIds and #passiveIds > 0 then
		for _, effectId in ipairs(passiveIds) do
			local effectMo = V3a9RacingCarConfig.instance:getRacingEffectConfig(effectId)

			if effectMo then
				::label_40_0::

				local var_40_1 = effectMo.paramData

				if effectMo.paramData then
					local triggerType = effectMo.paramData.triggerType
					local line = string.format("Passive %d: %s", effectId, tostring(triggerType or "?"))

					table.insert(buffLines, line)
				end
			end
		end
	end

	if playerCtrl.buffManager then
		local buffs = playerCtrl.buffManager:getAllBuffs()

		if buffs then
			for _, buff in ipairs(buffs) do
				if not buff.buffId then
					local buffId = 0
					local remainingTime = math.max(0, (not buff.remainingTime or nil) and 0)

					if not buff.duration then
						local duration = 0
						local line = string.format("Buff %d: %.1f/%.1f", buffId, remainingTime, duration)

						table.insert(buffLines, line)
					end
				end
			end
		end
	end

	self._txtbuffinfo.text = table.concat(buffLines, "\n")
end

function V3a9RacingCarGameView:_updateSpeed()
	self._speedUpdateElapsed = (self._speedUpdateElapsed or 0) + Time.deltaTime

	if self._speedUpdateElapsed < SpeedUpdateInterval then
		return
	end

	self._speedUpdateElapsed = 0

	local playerCtrl = V3a9RacingCarModel.instance:getPlayerVehicleController()

	if not playerCtrl then
		return
	end

	local speed = playerCtrl:getForwardSpeed()
	local kmh = math.floor(speed * 3.6)

	self._txtspeed.text = kmh .. " KM/H"

	if self._speedConstList then
		local isFast = speed >= self._speedConstList[2]

		gohelper.setActive(self._goNormalBg, not isFast)
		gohelper.setActive(self._goSpeedBg, isFast)
	end
end

function V3a9RacingCarGameView:_updateRaceRank()
	local playerCtrl = V3a9RacingCarModel.instance:getPlayerVehicleController()

	if not playerCtrl then
		return
	end

	if not self._isOnMainRoad then
		RacingCarSkillManager.instance:executePassiveSkills(playerCtrl, RacingCarPropEnum.TriggerType.Rank, playerCtrl, self._oldRank)
		self:_updateFirstPlaceAnimation(self._oldRank)

		return
	end

	local playerDist = playerCtrl:getTotalTrackDistance()
	local aiRacers = V3a9RacingCarModel.instance:getAIRacers()
	local count = 1
	local playerRank = 1

	for _, ai in ipairs(aiRacers) do
		if ai and ai.getTotalTrackDistance then
			count = count + 1

			if playerDist < ai:getTotalTrackDistance() then
				playerRank = playerRank + 1
			end
		end
	end

	if self._oldRank ~= playerRank and not playerCtrl:isPostFinish() then
		self._oldRank = playerRank

		UISpriteSetMgr.instance:setV3a9RacingSprite(self._imageRank, "v3a9_racing_game_rank" .. playerRank)
	end

	RacingCarSkillManager.instance:executePassiveSkills(playerCtrl, RacingCarPropEnum.TriggerType.Rank, playerCtrl, self._oldRank)
	self:_updateFirstPlaceAnimation(self._oldRank)
end

function V3a9RacingCarGameView:_updateFirstPlaceAnimation(playerRank)
	if playerRank == 1 then
		if self._firstAnimPlaying then
			return
		end

		if self._firstPlaceTime == 0 then
			self._firstPlaceTime = Time.time
		end

		if Time.time - self._firstPlaceTime >= V3a9RacingCarEnum.FirstPlaceSafeTime then
			self:_playFirstPlaceAnim()
		end
	else
		self._firstPlaceTime = 0

		if self._firstAnimPlaying then
			self._firstAnimPlaying = false

			gohelper.setActive(self._gofirst, false)
		end
	end
end

function V3a9RacingCarGameView:_playFirstPlaceAnim()
	self._firstAnimPlaying = true
	self._firstPlaceTime = 0

	AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayFuleyuanTansuoSuccess2)
	gohelper.setActive(self._gofirst, true)
end

local RaceTimeUiUpdateInterval = 0.05

function V3a9RacingCarGameView:_updateRaceTime()
	self._raceTimeUiElapsed = (self._raceTimeUiElapsed or 0) + Time.deltaTime

	if self._raceTimeUiElapsed < RaceTimeUiUpdateInterval then
		return
	end

	self._raceTimeUiElapsed = self._raceTimeUiElapsed - RaceTimeUiUpdateInterval

	local totalCs = math.floor((self._raceElapsedSec or 0) * 100)

	if totalCs == self._lastRaceTimeDisplayCs then
		return
	end

	self._lastRaceTimeDisplayCs = totalCs
	self._txttime2.text = self:_formatRaceTimeCs(totalCs)
end

function V3a9RacingCarGameView:_formatRaceTime(sec)
	return self:_formatRaceTimeCs(math.floor(sec * 100))
end

function V3a9RacingCarGameView:_formatRaceTimeCs(totalCs)
	local m = math.floor(totalCs / 6000)
	local s = math.floor(totalCs % 6000 / 100)
	local cs = totalCs % 100

	return string.format("%02d:%02d:%02d", m, s, cs)
end

function V3a9RacingCarGameView:_onRaceFinished()
	V3a9RacingCarModel.instance:setRaceTime(self._raceElapsedSec or 0)
	TaskDispatcher.cancelTask(self._frameUpdate, self)
	self:_stopFlyingLoopIfActive()
	self:_stopWaterSplashLoopIfActive()

	self._firstAnimPlaying = false
	self._firstPlaceTime = 0

	gohelper.setActive(self._gofirst, false)
end

function V3a9RacingCarGameView:_showCountDown(go)
	gohelper.setActive(go, true)
	AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.StopChongranRippleAmb)
	AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.StopChongranSplashWater)

	self._countDownId = AudioMgr.instance:trigger(AudioEnum3_10.OperationActivity.play_ui_bulaochuan_countdown_start)

	TaskDispatcher.cancelTask(self._countDownFinish, self)
	TaskDispatcher.runDelay(self._countDownFinish, self, 3)
end

function V3a9RacingCarGameView:_countDownFinish()
	self._countDownId = nil

	gohelper.setActive(self._gostart, false)
	gohelper.setActive(self._gopause, false)
	V3a9RacingCarModel.instance:setGameState(V3a9RacingCarEnum.RacingGameState.Racing)
	AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayChongranRippleAmb)

	if not self._raceBegin then
		self._raceBegin = true

		V3a9RacingCarController.instance:dispatchEvent(V3a9RacingCarEvent.OnRaceBegin)
		AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayChongranSeagull)
	end

	AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayChongranSplashWater)

	self._wasWaterSplashLoopPlaying = true
end

function V3a9RacingCarGameView:_updateFlyingLoopAudio()
	local playerCtrl = V3a9RacingCarModel.instance:getPlayerVehicleController()

	if not playerCtrl then
		return
	end

	local isFlying = playerCtrl:isInFlyingState() == true

	if not self._wasFlyingLoopPlaying then
		local wasFlying = false

		if isFlying and not wasFlying then
			AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayChongranFlyLoop)
			AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayChongranFlyby)
			AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.StopChongranSplashWater)

			self._wasFlyingLoopPlaying = true
			self._wasWaterSplashLoopPlaying = false
		elseif not isFlying and wasFlying then
			AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.StopChongranFlyLoop)
			AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.PlayChongranSplashWater)

			self._wasWaterSplashLoopPlaying = true
			self._wasFlyingLoopPlaying = false
		end
	end
end

function V3a9RacingCarGameView:_stopFlyingLoopIfActive()
	if self._wasFlyingLoopPlaying then
		AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.StopChongranFlyLoop)

		self._wasFlyingLoopPlaying = false
	end
end

function V3a9RacingCarGameView:_stopWaterSplashLoopIfActive()
	if self._wasWaterSplashLoopPlaying then
		AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.StopChongranSplashWater)

		self._wasWaterSplashLoopPlaying = false
	end
end

function V3a9RacingCarGameView:onClose()
	if self._oriRolesStoryMaskActive ~= nil then
		PostProcessingMgr.instance:setUnitPPValue("rolesStoryMaskActive", self._oriRolesStoryMaskActive)
	end

	if self._oriRolesStoryMaskActive2 ~= nil then
		PostProcessingMgr.instance:setUnitPPValue("RolesStoryMaskActive", self._oriRolesStoryMaskActive2)
	end

	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "V3a9RacingCarGameView", false)
	TaskDispatcher.cancelTask(self._hideRoundTip, self)
	TaskDispatcher.cancelTask(self._frameUpdate, self)
	TaskDispatcher.cancelTask(self._countDownFinish, self)
	AudioMgr.instance:trigger(V3a9RacingCarEnum.AudioId.StopChongranRippleAmb)
	self:_stopFlyingLoopIfActive()
	self:_stopWaterSplashLoopIfActive()

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	if self._touchEventMgr then
		TouchEventMgrHepler.remove(self._touchEventMgr)

		self._touchEventMgr = nil
	end

	if self._countDownId then
		AudioMgr.instance:stopPlayingID(self._countDownId)

		self._countDownId = nil
	end

	V3a9RacingCarModel.instance:clearAll()
	V3a9RacingCarModel.instance:resetGameState()
end

function V3a9RacingCarGameView:onDestroyView()
	return
end

return V3a9RacingCarGameView
