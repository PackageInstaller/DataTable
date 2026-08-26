-- chunkname: @modules/logic/versionactivity3_8/echosong/view/V3a8EchoSongGameView.lua

module("modules.logic.versionactivity3_8.echosong.view.V3a8EchoSongGameView", package.seeall)

local V3a8EchoSongGameView = class("V3a8EchoSongGameView", BaseView)

function V3a8EchoSongGameView:onInitView()
	self._godrag = gohelper.findChild(self.viewGO, "#go_drag")
	self._goTargetStar1 = gohelper.findChild(self.viewGO, "Left/Target/TargetStar/#go_TargetStar1")
	self._goTargetStar2 = gohelper.findChild(self.viewGO, "Left/Target/TargetStar/#go_TargetStar2")
	self._gojoyRightPoint = gohelper.findChild(self.viewGO, "Left/#go_joyRightPoint")
	self._gojoystick = gohelper.findChild(self.viewGO, "Left/#go_joyRightPoint/#go_joystick")
	self._gobackground = gohelper.findChild(self.viewGO, "Left/#go_joyRightPoint/#go_joystick/#go_background")
	self._gohandle = gohelper.findChild(self.viewGO, "Left/#go_joyRightPoint/#go_joystick/#go_background/#go_handle")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Reset")
	self._goCancel = gohelper.findChild(self.viewGO, "Right/#go_Cancel")
	self._goscene = gohelper.findChild(self.viewGO, "#go_scene")
	self._goroot = gohelper.findChild(self.viewGO, "#go_scene/#go_root")
	self._goball = gohelper.findChild(self.viewGO, "#go_scene/#go_root/#go_ball")
	self._gohitball = gohelper.findChild(self.viewGO, "#go_scene/#go_root/#go_hitball")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8EchoSongGameView:addEvents()
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
end

function V3a8EchoSongGameView:removeEvents()
	self._btnReset:RemoveClickListener()
end

function V3a8EchoSongGameView:_btnResetOnClick()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.EchoSongInGuide) then
		logNormal("V3a8EchoSongGameView _btnResetOnClick 指引中，不能操作")

		return
	end

	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.PauseGame)
	GameFacade.showMessageBox(MessageBoxIdDefine.EchoSongResetConfirm, MsgBoxEnum.BoxType.Yes_No, self._onChooseReset, self._onCancelReset, nil, self, self)
end

function V3a8EchoSongGameView:_onChooseReset()
	V3a8EchoSongController.instance:sendGameReset()
	V3a8EchoSongController.instance:clearGameResult()
	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.ResumeGame)
	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.ResetGame)
end

function V3a8EchoSongGameView:_onCancelReset()
	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.ResumeGame)
end

function V3a8EchoSongGameView:_editableInitView()
	self._cancelAnimState = V3a8EchoSongEnum.CancelState.Dark

	gohelper.setActive(self._goCancel, false)

	self._cancelAnimator = ZProj.ProjAnimatorPlayer.Get(self._goCancel)
end

function V3a8EchoSongGameView:_onScaleChange(param, value)
	return
end

function V3a8EchoSongGameView:_clickDownHandler()
	self._clickDownTime = Time.time
end

function V3a8EchoSongGameView:_clickUp()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.EchoSongDragJoystick) or GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.EchoSongDragScreen) then
		logNormal("V3a8EchoSongGameView _clickUp 指引中，不能操作")

		return
	end

	if not self._clickDownTime then
		return
	end

	local deltaTime = Time.time - self._clickDownTime

	if deltaTime > V3a8EchoSongEnum.LongClickTime then
		V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.TouchEmitted, V3a8EchoSongEnum.TouchEmittedType.Long)
	else
		V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.TouchEmitted, V3a8EchoSongEnum.TouchEmittedType.Short)
	end
end

function V3a8EchoSongGameView:_onDragBegin(param, pointerEventData)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.EchoSongDragJoystick) then
		return
	end

	self._dragBeginPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.viewGO.transform)
	self._dragBeginScreenPos = pointerEventData.position
	self._clickDownTime = nil
	self._dragBeginTime = Time.time
	self._cancelAnimState = V3a8EchoSongEnum.CancelState.Dark

	TaskDispatcher.cancelTask(self._checkShowCancel, self)
	TaskDispatcher.runRepeat(self._checkShowCancel, self, 0)
end

function V3a8EchoSongGameView:_onHideCancelBtn()
	gohelper.setActive(self._goCancel, self._showCancelBtn)
end

function V3a8EchoSongGameView:_onDragEnd(param, pointerEventData)
	TaskDispatcher.cancelTask(self._checkShowCancel, self)

	local dragBeginTime = self._dragBeginTime

	self._dragBeginTime = nil

	if self._showCancelBtn then
		self._showCancelBtn = false

		self._cancelAnimator:Play("close" .. tostring(self._cancelAnimState), self._onHideCancelBtn, self)

		self._cancelAnimState = V3a8EchoSongEnum.CancelState.Dark
	end

	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.DragEnd)

	if not self._dragBeginPos then
		return
	end

	self._dragBeginPos = nil
	self._dragBeginScreenPos = nil

	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.DragLine, false)

	local showCancelBtn = dragBeginTime and Time.time - dragBeginTime > V3a8EchoSongEnum.DragShowCancelTime

	if showCancelBtn then
		if UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(self._goCancel.transform, pointerEventData.position, CameraMgr.instance:getUICamera()) then
			return
		end
	else
		return
	end

	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.DragExplore)
end

function V3a8EchoSongGameView:_onDrag(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	local pos = recthelper.screenPosToAnchorPos(pointerEventData.position, self.viewGO.transform)
	local deltaPos = pos - self._dragBeginPos
	local magnitude = deltaPos.magnitude

	self._dragPos = pointerEventData.position

	V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.DragLine, true, self._dragBeginScreenPos, self._dragPos, magnitude)
	self:_checkCancelSwitch(self._dragPos)
end

function V3a8EchoSongGameView:_checkCancelSwitch(position)
	if self._showCancelBtn then
		if UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(self._goCancel.transform, position, CameraMgr.instance:getUICamera()) then
			if self._cancelAnimState ~= V3a8EchoSongEnum.CancelState.Light then
				self._cancelAnimState = V3a8EchoSongEnum.CancelState.Light

				self._cancelAnimator:Play("switch1")
			end
		elseif self._cancelAnimState ~= V3a8EchoSongEnum.CancelState.Dark then
			self._cancelAnimState = V3a8EchoSongEnum.CancelState.Dark

			self._cancelAnimator:Play("switch2")
		end
	end
end

function V3a8EchoSongGameView:_checkShowCancel()
	if self._dragBeginTime then
		local showCancelBtn = Time.time - self._dragBeginTime > V3a8EchoSongEnum.DragShowCancelTime

		gohelper.setActive(self._goCancel, showCancelBtn)

		if showCancelBtn then
			if self._dragPos then
				if UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(self._goCancel.transform, self._dragPos, CameraMgr.instance:getUICamera()) then
					self._cancelAnimator:Play("open1")

					self._cancelAnimState = V3a8EchoSongEnum.CancelState.Light
				else
					self._cancelAnimator:Play("open2")

					self._cancelAnimState = V3a8EchoSongEnum.CancelState.Dark
				end
			end

			TaskDispatcher.cancelTask(self._checkShowCancel, self)
		end

		self._showCancelBtn = showCancelBtn
	end
end

function V3a8EchoSongGameView:_onExecuteGuideStep(guideId, stepId)
	if guideId == V3a8EchoSongEnum.FirstGuideId then
		if stepId == 2 then
			self._fixStartTime = nil

			TaskDispatcher.runRepeat(self._frameFixGuideView, self, 0)
		elseif stepId == 3 then
			self._fixStartTime = Time.time

			TaskDispatcher.cancelTask(self._frameFixGuideView, self)
			TaskDispatcher.runRepeat(self._frameFixGuideView, self, 0)
			self:_frameFixGuideView()
		end
	end
end

function V3a8EchoSongGameView:_frameFixGuideView()
	local maskView = ViewMgr.instance:getContainer(ViewName.GuideView)
	local maskViewGO = maskView and maskView.viewGO
	local type4 = maskViewGO and gohelper.findChild(maskViewGO, "type4")

	if not self._fixStartTime then
		gohelper.setActive(type4, false)

		return
	end

	if self._fixStartTime and Time.time - self._fixStartTime <= 0.8 then
		gohelper.setActive(type4, false)
	else
		gohelper.setActive(type4, true)
		TaskDispatcher.cancelTask(self._frameFixGuideView, self)

		self._fixStartTime = nil
	end
end

function V3a8EchoSongGameView:_onFinishGuideLastStep(guideId)
	guideId = tonumber(guideId)

	if guideId == V3a8EchoSongEnum.FirstGuideId then
		self:_clearGuideFlags()
	end
end

function V3a8EchoSongGameView:_onInterruptGuide(guideId)
	guideId = tonumber(guideId)

	if guideId == V3a8EchoSongEnum.FirstGuideId then
		self:_clearGuideFlags()
	end
end

function V3a8EchoSongGameView:_clearGuideFlags()
	GuideModel.instance:clearFlagValue(GuideModel.GuideFlag.EchoSongDragJoystick)
	GuideModel.instance:clearFlagValue(GuideModel.GuideFlag.EchoSongDragScreen)
	GuideModel.instance:clearFlagValue(GuideModel.GuideFlag.EchoSongInGuide)
	TaskDispatcher.cancelTask(self._frameFixGuideView, self)
end

function V3a8EchoSongGameView:onOpen()
	self.addEventCb(self, V3a8EchoSongController.instance, V3a8EchoSongEvent.ShowResultView, self._onShowResultView, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.InterruptGuide, self._onInterruptGuide, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.FinishGuideLastStep, self._onFinishGuideLastStep, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.ExecuteGuideStep, self._onExecuteGuideStep, self)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._godrag)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)

	self._click = SLFramework.UGUI.UIClickListener.Get(self._godrag)

	self._click:AddClickDownListener(self._clickDownHandler, self)
	self._click:AddClickUpListener(self._clickUp, self)

	self._sliderScale = gohelper.findChildSlider(self.viewGO, "Right/Slider")

	self._sliderScale:AddOnValueChanged(self._onScaleChange, self)
	self._sliderScale:SetValue(1)
	gohelper.setActive(self._sliderScale, false)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "V3a8EchoSongGameView", true)
end

function V3a8EchoSongGameView:onOpenFinish()
	if SLFramework.FrameworkSettings.IsEditor then
		TaskDispatcher.runRepeat(self._frameHandler, self, 0)
	end
end

function V3a8EchoSongGameView:_frameHandler()
	if SLFramework.FrameworkSettings.IsEditor and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
		V3a8EchoSongController.instance:dispatchGameResult(true)
	end
end

function V3a8EchoSongGameView:_onShowResultView(isSuccess)
	V3a8EchoSongController.instance:openV3a8EchoSongResultView({
		isSuccess = isSuccess
	})

	if isSuccess then
		V3a8EchoSongController.instance:sendGameSuccess()
	else
		V3a8EchoSongController.instance:sendGameFail()
	end
end

function V3a8EchoSongGameView:onClose()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "V3a8EchoSongGameView", false)

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	if self._click then
		self._click:RemoveClickDownListener()
		self._click:RemoveClickUpListener()
	end

	if self._sliderScale then
		self._sliderScale:RemoveOnValueChanged()
	end

	TaskDispatcher.cancelTask(self._frameHandler, self)
	TaskDispatcher.cancelTask(self._checkShowCancel, self)
	V3a8EchoSongModel.instance:clearAllData()
	self:_clearGuideFlags()
end

function V3a8EchoSongGameView:onDestroyView()
	return
end

return V3a8EchoSongGameView
