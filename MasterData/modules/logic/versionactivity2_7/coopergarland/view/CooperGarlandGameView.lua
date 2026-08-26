-- chunkname: @modules/logic/versionactivity2_7/coopergarland/view/CooperGarlandGameView.lua

module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandGameView", package.seeall)

local CooperGarlandGameView = class("CooperGarlandGameView", BaseView)

function CooperGarlandGameView:onInitView()
	self._goleft = gohelper.findChild(self.viewGO, "Left")
	self._goTargetStar1 = gohelper.findChild(self.viewGO, "Left/Target/TargetStar/#go_TargetStar1")
	self._goTargetStar2 = gohelper.findChild(self.viewGO, "Left/Target/TargetStar/#go_TargetStar2")
	self._btnControl = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Control/#btn_Control")
	self._animControl = gohelper.findChildAnim(self.viewGO, "Left/Control")
	self._goJoystickMode = gohelper.findChild(self.viewGO, "Left/Control/#go_Joystick")
	self._txtjoystick = gohelper.findChildText(self.viewGO, "Left/Control/#go_Joystick/txt_Joystick")
	self._imgjoystick = gohelper.findChildImage(self.viewGO, "Left/Control/#go_Joystick/image_Joystick")
	self._goGyroscopeMode = gohelper.findChild(self.viewGO, "Left/Control/#go_Gyroscope")
	self._transJoyLeftPoint = gohelper.findChild(self.viewGO, "Left/#go_joyLeftPoint").transform
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Reset")
	self._goRemove = gohelper.findChild(self.viewGO, "Right/Collect")
	self._animCollect = gohelper.findChildAnim(self.viewGO, "Right/Collect")
	self._goIcon1 = gohelper.findChild(self.viewGO, "Right/Collect/#go_Icon1")
	self._goIcon2 = gohelper.findChild(self.viewGO, "Right/Collect/#go_Icon2")
	self._goselectRemove = gohelper.findChild(self.viewGO, "Right/Collect/#go_select")
	self._txtLightNum = gohelper.findChildText(self.viewGO, "Right/Collect/#txt_LightNum")
	self._btnRemoveMode = gohelper.findChildClickWithAudio(self.viewGO, "Right/Collect/#btn_modeClick")
	self._transJoyRightPoint = gohelper.findChild(self.viewGO, "Right/#go_joyRightPoint").transform
	self._gojoystick = gohelper.findChild(self.viewGO, "Right/#go_joyRightPoint/#go_joystick")
	self._goTopTips = gohelper.findChild(self.viewGO, "#go_TopTips")
	self._goGameTips = gohelper.findChild(self.viewGO, "#go_TopTips2")
	self._txtGameTips = gohelper.findChildText(self.viewGO, "#go_TopTips2/#txt_Tips")
	self._goExtraTips = gohelper.findChild(self.viewGO, "#go_ExtraTips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CooperGarlandGameView:addEvents()
	self._btnControl:AddClickListener(self._btnControlOnClick, self)
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
	self._btnRemoveMode:AddClickListener(self._btnRemoveModeClick, self)
	NavigateMgr.instance:addEscape(ViewName.CooperGarlandGameView, self._onEscapeBtnClick, self)
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnChangeControlMode, self._onChangeControlMode, self)
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, self._onRemoveModeChange, self)
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnRemoveComponent, self._onRemoveComponent, self)
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.PlayEnterNextRoundAnim, self._onPlayEnterNextRoundAnim, self)
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnEnterNextRound, self._onEnterNextRound, self)
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnResetGame, self._onResetGame, self)
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.PlayFinishEpisodeStarVX, self._onPlayStarFinishVx, self)
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.ResetJoystick, self._resetJoystick, self)
end

function CooperGarlandGameView:removeEvents()
	self._btnControl:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnRemoveMode:RemoveClickListener()
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnChangeControlMode, self._onChangeControlMode, self)
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, self._onRemoveModeChange, self)
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnRemoveComponent, self._onRemoveComponent, self)
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.PlayEnterNextRoundAnim, self._onPlayEnterNextRoundAnim, self)
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnEnterNextRound, self._onEnterNextRound, self)
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnResetGame, self._onResetGame, self)
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.PlayFinishEpisodeStarVX, self._onPlayStarFinishVx, self)
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.ResetJoystick, self._resetJoystick, self)
end

function CooperGarlandGameView:_btnControlOnClick()
	CooperGarlandController.instance:changeControlMode()

	local isJoystick = CooperGarlandGameModel.instance:getIsJoystick()
	local tips = luaLang(isJoystick and "v2a7_coopergarland_change_control_mode1" or "v2a7_coopergarland_change_control_mode2")

	self:_showGameTips(tips)
end

function CooperGarlandGameView:_btnResetOnClick()
	CooperGarlandController.instance:setStopGame(true)
	GameFacade.showMessageBox(MessageBoxIdDefine.CooperGarlandResetGame, MsgBoxEnum.BoxType.Yes_No, self._confirmReset, self._closeResetMessBox, nil, self, self)
end

function CooperGarlandGameView:_confirmReset()
	CooperGarlandStatHelper.instance:sendMapReset(self.viewName)
	CooperGarlandController.instance:resetGame()
end

function CooperGarlandGameView:_closeResetMessBox()
	CooperGarlandController.instance:setStopGame(false)
end

function CooperGarlandGameView:_btnRemoveModeClick()
	CooperGarlandController.instance:changeRemoveMode()
end

function CooperGarlandGameView:_onEscapeBtnClick()
	self.viewContainer:overrideClose()
end

function CooperGarlandGameView:_onChangeControlMode()
	self:refreshControlMode(true)
end

function CooperGarlandGameView:_onRemoveModeChange()
	self:refreshControlMode()
	self:refreshRemoveMode()

	local isRemoveMode = CooperGarlandGameModel.instance:getIsRemoveMode()

	if isRemoveMode then
		self:_showGameTips()
		AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_trap_choose)
	end
end

function CooperGarlandGameView:_onRemoveComponent()
	self:_btnRemoveModeClick()
	self:refreshRemoveCount(true)
	self:_showGameTips(luaLang("v2a7_coopergarland_remove_comp"))
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_trap_dispel)
end

function CooperGarlandGameView:_onPlayEnterNextRoundAnim()
	if not self.animator then
		return
	end

	self.animator.enabled = true

	self.animator:Play("switch", 0, 0)
end

function CooperGarlandGameView:_onEnterNextRound()
	self:refreshRemoveCount()
end

function CooperGarlandGameView:_onResetGame()
	self:refresh()
end

function CooperGarlandGameView:_onPlayStarFinishVx()
	self:setTargetStar(true, true)
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_pkls_star_light)
	TaskDispatcher.runDelay(self._afterPlayStarFinish, self, TimeUtil.OneSecond)
end

function CooperGarlandGameView:_afterPlayStarFinish()
	local episodeId = CooperGarlandGameModel.instance:getEpisodeId()

	CooperGarlandController.instance:finishEpisode(episodeId, true)
end

function CooperGarlandGameView:_resetJoystick()
	if not self.joystick then
		return
	end

	self.joystick:reset()
end

function CooperGarlandGameView:_showGameTips(tips)
	gohelper.setActive(self._goGameTips, false)

	if string.nilorempty(tips) then
		return
	end

	self._txtGameTips.text = tips

	gohelper.setActive(self._goGameTips, true)
end

function CooperGarlandGameView:_editableInitView()
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._gyroSensitivity = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.GyroSensitivity, true)
	self._cubeResetSpeed = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.CubeBalanceRestSpeed, true)
	self.joystick = MonoHelper.addNoUpdateLuaComOnceToGo(self._gojoystick, VirtualFixedJoystick)

	if not self._isRunning then
		self._isRunning = true

		LateUpdateBeat:Add(self._onLateUpdate, self)
	end

	self.originalAutoLeft = UnityEngine.Screen.autorotateToLandscapeLeft
	self.originalAutoRight = UnityEngine.Screen.autorotateToLandscapeRight
	UnityEngine.Screen.autorotateToLandscapeLeft = false
	UnityEngine.Screen.autorotateToLandscapeRight = false
	self._isMobilePlayer = GameUtil.isMobilePlayerAndNotEmulator()

	if self._isMobilePlayer then
		self.gyro = UnityEngine.Input.gyro
		self.originalGyroStatus = self.gyro.enabled
		self.gyro.enabled = true
	end

	self:setTargetStar(false)

	local actId = CooperGarlandModel.instance:getAct192Id()
	local episodeId = CooperGarlandGameModel.instance:getEpisodeId()
	local isExtra = CooperGarlandConfig.instance:isExtraEpisode(actId, episodeId)

	gohelper.setActive(self._goExtraTips, isExtra)
end

local RTPC_FACTOR = 3

function CooperGarlandGameView:_onLateUpdate()
	local isJoystick = CooperGarlandGameModel.instance:getIsJoystick()

	if isJoystick then
		local pressKeyX, pressKeyY

		if not self._isMobilePlayer then
			if UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) then
				pressKeyX = 1
			elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) then
				pressKeyX = -1
			end

			if UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
				pressKeyY = 1
			elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.S) then
				pressKeyY = -1
			end
		end

		if pressKeyX or pressKeyY then
			self.joystick:setInPutValue(pressKeyX, pressKeyY)
		end

		local isDragging = self.joystick:getIsDragging()

		if isDragging or pressKeyX or pressKeyY then
			local input = self.joystick:getInputValue()

			CooperGarlandController.instance:changePanelBalance(input.x, input.y)

			self._needReset = true
		elseif self._needReset then
			self:_resetJoystick()
			CooperGarlandController.instance:resetPanelBalance(self._cubeResetSpeed)

			self._needReset = false
		end
	else
		local x, y = 0, 0

		if self.gyro then
			local gravity = self.gyro.gravity.normalized

			x = gravity.x
			y = gravity.y
		end

		x = Mathf.Clamp(self._gyroSensitivity * x, -1, 1)
		y = Mathf.Clamp(self._gyroSensitivity * y, -1, 1)

		CooperGarlandController.instance:changePanelBalance(x, y)
	end

	local v = CooperGarlandGameEntityMgr.instance:getBallVelocity()
	local rtpcValue = v.magnitude * RTPC_FACTOR

	AudioMgr.instance:setRTPCValue(AudioEnum2_7.CooperGarlandBallRTPC, rtpcValue)
end

function CooperGarlandGameView:onUpdateParam()
	return
end

function CooperGarlandGameView:onOpen()
	self:refresh()
end

function CooperGarlandGameView:refresh()
	self:refreshRemoveCount()
	self:refreshRemoveMode()
	self:refreshControlMode()
end

function CooperGarlandGameView:refreshRemoveCount(needPlayAnim)
	local gameId = CooperGarlandGameModel.instance:getGameId()
	local round = CooperGarlandGameModel.instance:getGameRound()
	local cfgRemoveCount = CooperGarlandConfig.instance:getRemoveCount(gameId, round)
	local isShowRemoveBtn = cfgRemoveCount and cfgRemoveCount > 0

	if isShowRemoveBtn then
		local removeCount = CooperGarlandGameModel.instance:getRemoveCount()
		local isHasCount = removeCount and removeCount > 0

		gohelper.setActive(self._goIcon1, not isHasCount)
		gohelper.setActive(self._goIcon2, isHasCount)

		if needPlayAnim then
			self._animCollect:Play("switch", 0, 0)
		end

		self._txtLightNum.text = luaLang("multiple") .. (removeCount or 0)
	end

	gohelper.setActive(self._goRemove, isShowRemoveBtn)
end

function CooperGarlandGameView:refreshRemoveMode()
	local isRemoveMode = CooperGarlandGameModel.instance:getIsRemoveMode()

	gohelper.setActive(self._goleft, not isRemoveMode)
	gohelper.setActive(self._btnReset, not isRemoveMode)
	gohelper.setActive(self._goTopTips, isRemoveMode)
	gohelper.setActive(self._goselectRemove, isRemoveMode)
end

function CooperGarlandGameView:refreshControlMode(needPlayAnim)
	local isJoystick = CooperGarlandGameModel.instance:getIsJoystick()

	if isJoystick then
		local joyPoint = self._transJoyRightPoint
		local joyTxt = "v2a7_coopergarland_right_joystick"
		local joyImg = "v2a7_coopergarland_game_controlicon1"
		local controlMode = CooperGarlandGameModel.instance:getControlMode()

		if controlMode == CooperGarlandEnum.Const.JoystickModeLeft then
			joyPoint = self._transJoyLeftPoint
			joyTxt = "v2a7_coopergarland_left_joystick"
			joyImg = "v2a7_coopergarland_game_controlicon3"
		end

		self._txtjoystick.text = luaLang(joyTxt)

		self._gojoystick.transform:SetParent(joyPoint, false)
		UISpriteSetMgr.instance:setV2a7CooperGarlandSprite(self._imgjoystick, joyImg)
	end

	local isRemoveMode = CooperGarlandGameModel.instance:getIsRemoveMode()

	gohelper.setActive(self._gojoystick, not isRemoveMode and isJoystick)
	gohelper.setActive(self._goGyroscopeMode, not isJoystick)
	gohelper.setActive(self._goJoystickMode, isJoystick)

	if needPlayAnim then
		local animName = isJoystick and "switch2" or "switch1"

		self._animControl:Play(animName, 0, 0)
	end
end

function CooperGarlandGameView:setTargetStar(isFinish, disAnimator)
	if disAnimator and self.animator then
		self.animator.enabled = false
	end

	gohelper.setActive(self._goTargetStar1, not isFinish)
	gohelper.setActive(self._goTargetStar2, isFinish)
end

function CooperGarlandGameView:onClose()
	if self._isRunning then
		self._isRunning = false

		LateUpdateBeat:Remove(self._onLateUpdate, self)
	end

	if self.originalAutoLeft ~= nil then
		UnityEngine.Screen.autorotateToLandscapeLeft = self.originalAutoLeft
	end

	if self.originalAutoRight ~= nil then
		UnityEngine.Screen.autorotateToLandscapeRight = self.originalAutoRight
	end

	if self.gyro then
		self.gyro.enabled = self.originalGyroStatus
	end

	TaskDispatcher.cancelTask(self._afterPlayStarFinish, self)
end

function CooperGarlandGameView:onDestroyView()
	return
end

return CooperGarlandGameView
