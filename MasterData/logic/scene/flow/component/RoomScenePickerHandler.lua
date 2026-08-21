-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/flow/component/RoomScenePickerHandler.lua

module("logic.scene.flow.component.RoomScenePickerHandler", package.seeall)

local M = class("RoomScenePickerHandler", SceneComponentBase)
local POSX_MIN = -2.2
local POSX_MAX = 2.2
local POSX_PERCENT_MIN = 0.72
local POSX_PERCENT_MAX = 0.72
local SPEED_FACTOR_DRAG = 0.001
local SPEED_FACTOR_END_DRAG = 0.0015
local ANGLE_Y_MIN = -16.25
local ANGLE_Y_MAX = 16.25
local ANGLE_PERCENT_MIN = 0.8
local ANGLE_PERCENT_MAX = 0.8
local ANGLE_SPEED_FACTOR_DRAG = 0.04
local ANGLE_SPEED_FACTOR_END_DRAG = 0.15
local DRAG_MIN_WIDTH_PERCENT = 0.15
local DRAG_MIN_TIME = 0.5
local CAM_DURATION = 4

function M:onInit()
	self._singleDragingId = -999
	self._singleDragPos = Vector3.New()
	self._beginDragPos = Vector3.New()
	self._unitDragPos = Vector3.New()
	self._camAngle = Vector3.New()
	self._tmpGoHitLst = {}
end

function M:onEnterScene(sceneId, bornX, bornZ)
	M.super.onEnterScene(sceneId, bornX, bornZ)
	self._camAngle:Set(0, 0, 0)
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	self._sceneId = sceneId

	self:_setEvent(true)
end

function M:onExitScene()
	self:_setEvent(false)

	self._singleDragingId = -999

	self:_forceStopLerpCam()
	goutil.destroy(self._goPath)

	self._goPath = nil
end

function M:onLeaveScene()
	self:_setEvent(false)

	self._singleDragingId = -999

	self:_forceStopLerpCam()
end

function M:onReturnScene()
	self:_setEvent(true)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_HIT, self._onSceneHit, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDrag, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDrag, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDrag, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_CAM_OFFSET_CTRL, self._handleCamOffsetCtrl, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_HIT, self._onSceneHit, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDrag, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDrag, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDrag, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_CAM_OFFSET_CTRL, self._handleCamOffsetCtrl, self)
	end
end

function M:isVaildScene(includeView, includeGuide)
	if includeView and not ViewMgr.instance:isOpen(ViewName.MainUIView) then
		return false
	end

	if includeGuide and GuideController.instance:isGuiding() then
		return false
	end

	local sceneType = SceneFace.instance:getCurSceneFlowTyp()

	return sceneType == SceneType.Room
end

function M:getCamUnit()
	local camUnit = VirtualCameraMgr.instance:getActiveCamera()

	return camUnit
end

function M:getCamOffsetComp(showLog)
	local camOffset = self._scene.camera:getCamOffset(showLog)

	return camOffset
end

function M:_onSceneHit(e, isHit, hitGO, hitPoint, clickCount)
	if not self:isVaildScene(true) then
		return
	end

	if hitGO then
		table.clear(self._tmpGoHitLst)

		local scenePickerView = ScenePickerViewFacade.instance:getScenePickerView()

		if scenePickerView then
			local raycastProxy = scenePickerView:getRaycastProxy()

			for i = 0, raycastProxy:GetHitCount() - 1 do
				local go = raycastProxy:GetHitGameObject(i)

				if go then
					table.insert(self._tmpGoHitLst, go)
				end
			end
		end

		if not (#self._tmpGoHitLst > 0) or self:_dealHitMulti(self._tmpGoHitLst, self._dealHitUnitPlayer, self) then
			-- block empty
		elseif self:_dealHitMulti(self._tmpGoHitLst, self._dealHitElementSP, self) then
			-- block empty
		end
	end

	self:_forceStopLerpCam()
end

function M:_dealHitMulti(goLst, func, handler)
	local canExcute = false

	for _, hitGO in ipairs(goLst or {}) do
		canExcute = canExcute or func(handler, hitGO)
	end

	return canExcute
end

function M:_dealHitUnitPlayer(hitGO)
	local canExcute = false
	local hitParent = hitGO.transform.parent

	if hitParent then
		local heroUnit = Astral.LuaComponentContainer.Get(hitParent.gameObject, UnitMainSceneAdjutant)

		if heroUnit then
			GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_CLICK, UnitTag.Player, heroUnit:getPointId(), heroUnit:getHeroId())

			canExcute = true
		end
	end

	return canExcute
end

function M:_dealHitElementSP(hitGO)
	local canExcute = false

	if hitGO then
		local clockComp = Astral.SimpleLuaComponentContainer.Get(hitGO.gameObject, UnitCompMainSceneElementBase)

		if clockComp and clockComp.onClickElement then
			clockComp:onClickElement()

			canExcute = true
		end
	end

	return canExcute
end

function M:_handleCamOffsetCtrl(e, durationToReset, disabledComp)
	if not self:isVaildScene() then
		return
	end

	self:_forceStopLerpCam()

	if durationToReset then
		local _resetVal = 0

		if durationToReset > 0 then
			self._isLerping = true
			self._lerpCamTweener = TweenNumberUtils.FloatTo(self:_getOrgVal(), _resetVal, durationToReset, self._lerpCamUpdateCB, self):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):OnComplete(self._lerpCamFinish, self)
		else
			self:_lerpCamUpdateCB(_resetVal)
		end
	end
end

function M:_onBeginDrag(e, position, pointerId)
	if not self:isVaildScene(true, true) then
		return
	end

	self._beginDragStartTime = os.clock()
	self._singleDragingId = pointerId

	self._singleDragPos:Set(position:Get())
	self._beginDragPos:Set(position:Get())
	self._unitDragPos:Set(position:Get())
end

function M:_onDrag(e, position, pointerId)
	if not self:isVaildScene(true, true) then
		return
	end

	if self._singleDragingId == pointerId then
		if position.x < 0 or position.x > UnityEngine.Screen.width or position.y < 0 or position.y > UnityEngine.Screen.height then
			self:_onEndDrag(e, position, pointerId)

			return
		end

		self:_forceStopLerpCam()

		local offsetX = self._singleDragPos.x - position.x

		if MainPerformEnum.DragControlAngle then
			local x, y, z = self._camAngle:Get()

			y = y + offsetX * ANGLE_SPEED_FACTOR_DRAG

			if y <= ANGLE_Y_MIN then
				y = ANGLE_Y_MIN
			end

			if y >= ANGLE_Y_MAX then
				y = ANGLE_Y_MAX
			end

			self._camAngle:Set(x, y, z)
			GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CAM_UPDATE_GYRO_ANGLE, x, y, z)
		else
			local targetPosX = self:_getOrgVal() + offsetX * SPEED_FACTOR_DRAG

			if targetPosX <= POSX_MIN then
				targetPosX = POSX_MIN
			end

			if targetPosX >= POSX_MAX then
				targetPosX = POSX_MAX
			end

			local camOffsetComp = self:getCamOffsetComp()

			if camOffsetComp then
				camOffsetComp:SetOffsetX(targetPosX)
			end
		end

		self._singleDragPos:Set(position:Get())
	end
end

function M:_onEndDrag(e, position, pointerId)
	if not self:isVaildScene(true, true) then
		return
	end

	if self._singleDragingId == pointerId then
		self._singleDragingId = -999
	end

	if not self._beginDragStartTime then
		return
	end

	local offsetTime = os.clock() - self._beginDragStartTime
	local offsetX = self._beginDragPos.x - position.x
	local outOfLimit = false

	if MainPerformEnum.DragControlAngle then
		local x, y, z = self._camAngle:Get()

		outOfLimit = y >= ANGLE_Y_MAX * ANGLE_PERCENT_MAX or y <= ANGLE_Y_MIN * ANGLE_PERCENT_MIN
	else
		outOfLimit = self:_getOrgVal() >= POSX_MAX * POSX_PERCENT_MAX or self:_getOrgVal() <= POSX_MIN * POSX_PERCENT_MIN
	end

	if outOfLimit or math.abs(offsetX) > ViewMgr.instance:getUIWidth() * DRAG_MIN_WIDTH_PERCENT and offsetTime < DRAG_MIN_TIME then
		self:_lerpCamByScreenOffset(offsetX, 0)
	end
end

function M:_lerpCamByScreenOffset(screenOffsetX, screenOffsetY)
	local duration = CAM_DURATION
	local ease = DG.Tweening.Ease.OutQuint
	local orgVal = 0
	local targetVal = 0

	if MainPerformEnum.DragControlAngle then
		local x, y, z = self._camAngle:Get()

		orgVal = y
		y = y + screenOffsetX * ANGLE_SPEED_FACTOR_END_DRAG

		if y <= ANGLE_Y_MIN * ANGLE_PERCENT_MIN then
			y = ANGLE_Y_MIN * ANGLE_PERCENT_MIN
			ease = DG.Tweening.Ease.OutBack
		end

		if y >= ANGLE_Y_MAX * ANGLE_PERCENT_MAX then
			y = ANGLE_Y_MAX * ANGLE_PERCENT_MAX
			ease = DG.Tweening.Ease.OutBack
		end

		targetVal = y
	else
		orgVal = self:_getOrgVal()

		local targetPosX = orgVal + screenOffsetX * SPEED_FACTOR_END_DRAG

		if targetPosX <= POSX_MIN * POSX_PERCENT_MIN then
			targetPosX = POSX_MIN * POSX_PERCENT_MIN
			ease = DG.Tweening.Ease.OutBack
		end

		if targetPosX >= POSX_MAX * POSX_PERCENT_MAX then
			targetPosX = POSX_MAX * POSX_PERCENT_MAX
			ease = DG.Tweening.Ease.OutBack
		end

		targetVal = targetPosX
	end

	if self._isLerping then
		self._lerpCamTweener = self._lerpCamTweener:ChangeEndValue(targetVal, -1, true):SetEase(ease):SetAutoKill(true):OnComplete(self._lerpCamFinish, self)
	else
		self._isLerping = true
		self._lerpCamTweener = TweenNumberUtils.FloatTo(orgVal, targetVal, duration, self._lerpCamUpdateCB, self):SetEase(ease):SetAutoKill(true):OnComplete(self._lerpCamFinish, self)
	end
end

function M:_forceStopLerpCam()
	if self._lerpCamTweener then
		self._lerpCamTweener:Kill(false)

		self._lerpCamTweener = nil
	end

	self._isLerping = false
end

function M:_lerpCamFinish()
	self:_forceStopLerpCam()
end

function M:_lerpCamUpdateCB(updateValue)
	if MainPerformEnum.DragControlAngle then
		self._camAngle:Set(0, updateValue, 0)
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CAM_UPDATE_GYRO_ANGLE, 0, updateValue, 0)
	else
		local camOffsetComp = self:getCamOffsetComp()

		if camOffsetComp then
			camOffsetComp:SetOffsetX(updateValue)
		end
	end
end

function M:_getOrgVal()
	local val = 0

	if MainPerformEnum.DragControlAngle then
		local x, y, z = self._camAngle:Get()

		val = y
	else
		local camOffsetComp = self:getCamOffsetComp()

		val = camOffsetComp and camOffsetComp:GetOffsetX() or 0
	end

	return val
end

return M
