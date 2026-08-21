-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/RogueScenePickerHandler.lua

module("logic.extensions.roguelike.flow.component.RogueScenePickerHandler", package.seeall)

local M = class("RogueScenePickerHandler", IRogueFlowComp)
local kDragFactor = 8
local kUICamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
local kQuaternion = Quaternion.AngleAxis(45, Vector3.right)
local kTempVec3 = Vector3.New()

function M:onInit()
	self._originalFollowPosition = Vector3.New()
	self._beginDragPosition = Vector3.New()
end

function M:onStart()
	self._boardMgr = self.flow.boardMgr or false
	self._boardModel = self.flow.boardModel or false
	self._unitMgr = self.flow.unitMgr or false
	self._pathArrow = self.flow.pathArrow or false
	self._pathFinder = self.flow.pathFinder or false

	self:setForNormal()
end

function M:onClear()
	self:_setAsNormalEvent(false)

	self._boardMgr = false
	self._boardModel = false
	self._unitOperator = false
	self._unitMgr = false
	self._pathArrow = false
	self._pathFinder = false
end

function M:setForNormal()
	self:_setAsNormalEvent(true)
end

function M:_setAsNormalEvent(add)
	if add then
		if self._isAdd then
			return
		end

		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDragNormal, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDragNormal, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDragNormal, self)

		self._isAdd = true
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDragNormal, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDragNormal, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDragNormal, self)

		self._isAdd = false
	end
end

function M:_onBeginDragNormal(e, position)
	position.z = 40

	local followPosition = VirtualCameraMgr.instance:getFollowPosition()

	self._originalFollowPosition:Set(followPosition:Get())

	position = kUICamera:ScreenToWorldPoint(position)
	self._beginDragPosition = position
end

function M:_onEndDragNormal(e, position)
	if RoguelikeController.instance:isDelayEntering() then
		return
	end

	RogueMgr.instance:getMapMgr():resetCameraPosition()
end

function M:_onDragNormal(e, position)
	if RoguelikeController.instance:getIsInJudgeScene() then
		return
	end

	position.z = 40
	position = kUICamera:ScreenToWorldPoint(position)

	local p = VirtualCameraMgr.instance:getFollowPosition()
	local factor = kDragFactor * Time.deltaTime
	local deltaX = (self._beginDragPosition.x - position.x) * factor
	local deltaY = (self._beginDragPosition.y - position.y) * factor

	self._beginDragPosition = position

	local deltaP = kTempVec3

	deltaP:Set(deltaX, 0, deltaY)

	deltaP = kQuaternion * deltaP

	VirtualCameraMgr.instance:setFollowPosition(p.x + deltaP.x, RoguelikeConst.MAP_ROLE_OFFSET_Y, p.z + deltaP.z)
end

return M
