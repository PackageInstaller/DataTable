-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/authority/new/CharacterAuthorityRingCtrl.lua

module("logic.extensions.charactersystem.view.authority.new.CharacterAuthorityRingCtrl", package.seeall)

local M = class("CharacterAuthorityRingCtrl")

M.RingTyp = {
	All = 1,
	Level = 2,
	Node = 3
}
M.RingDataDefine = {
	OverAngle = 5,
	OrgAngle = 0,
	Node = {
		Step = 11.8,
		Check = 5.9,
		Base = -22
	},
	LevelAngle = {
		Step = 55,
		Base = 0
	}
}

local DRAG_DURATION = 0.5
local DRAG_DURATION_SPEED_BASE = 40
local SPEED_FACTOR_DRAG = -0.1

function M:getMinAngle()
	local data = M.RingDataDefine
	local offsetNodeNum = 2
	local minAngle = data.Node.Base + offsetNodeNum * data.Node.Step

	return minAngle
end

function M:getMaxAngle()
	local data = M.RingDataDefine
	local maxNodeId = self._maxPowerGroup * 5
	local offsetNodeNum = -2
	local maxAngle = data.Node.Base + (maxNodeId - 1) * data.Node.Step + offsetNodeNum * data.Node.Step

	return maxAngle
end

function M:getNodeLvAngle(nodeLv)
	nodeLv = nodeLv > self._maxPowerGroup and self._maxPowerGroup or nodeLv

	local step = M.RingDataDefine.LevelAngle.Step
	local angle = M.RingDataDefine.LevelAngle.Base + step * (nodeLv - 1)

	return angle
end

function M:getNodeAngle(nodeId, fix)
	local targetAngle = M.RingDataDefine.Node.Base + (nodeId - 1) * M.RingDataDefine.Node.Step

	if fix then
		local isFixed = false

		targetAngle, isFixed = self:_fixAngle(targetAngle, false)
	end

	return targetAngle
end

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local mainGO = self:getMainGo()
	local registry = self:getRegistry()

	self._singleDragPos = Vector2.New()
	self._beginPosition = Vector2.New()
	self._beginPositionRole = Vector2.New()
	self._dragTrigger = Astral.UIDragTrigger.Get(registry:findUIElement("authority_main_panel_copy_88516964"))
	self._dragTriggerRole = Astral.UIDragTrigger.Get(registry:findUIElement("authority_main_panel_copy_-347873883"))
	self._rayCastRing = self._dragTrigger.gameObject:GetComponent(UIComponentType.EmptyRaycast)
	self._rayCastRole = self._dragTriggerRole.gameObject:GetComponent(UIComponentType.EmptyRaycast)
	self._rectTrRing = {
		[M.RingTyp.Level] = registry:findUIElement("authority_main_panel_copy_-327187171", UIComponentType.RectTransform),
		[M.RingTyp.Node] = registry:findUIElement("authority_main_panel_copy_485971355", UIComponentType.RectTransform)
	}
	self._rectTrRingLvGear = registry:findUIElement("authority_main_panel_copy_427168989", UIComponentType.RectTransform)
	self._ringRTAngle = {}
end

function M:destroyUI()
	self:_forceStopLerp()

	self.mainGO = nil
	self._handler = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = nil
	end
end

function M:bindEvents()
	self._dragTrigger:AddBeginDragListener(self._onBeginDrag, self)
	self._dragTrigger:AddDragListener(self._onDrag, self)
	self._dragTrigger:AddEndDragListener(self._onEndDrag, self)
	self._dragTriggerRole:AddBeginDragListener(self._onRoleBeginDrag, self)
	self._dragTriggerRole:AddEndDragListener(self._onRoleEndDrag, self)
end

function M:unbindEvents()
	self._dragTrigger:RemoveBeginDragListener()
	self._dragTrigger:RemoveDragListener()
	self._dragTrigger:RemoveEndDragListener()
	self._dragTriggerRole:RemoveBeginDragListener()
	self._dragTriggerRole:RemoveEndDragListener()
end

function M:onEnter()
	self._ringRTAngle = {}

	self:_showPointer(false)
	self:_setRingRTAngle(M.RingTyp.All, M.RingDataDefine.OrgAngle)

	self._rayCastRing.enabled = true
	self._rayCastRole.enabled = true
end

function M:onExit()
	self._rayCastRing.enabled = false
	self._rayCastRole.enabled = false

	self:_forceStopLerp()
	self:_setRingAngle(0)
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setMaxPowerGroupCount(maxPowerGroup)
	self._maxPowerGroup = maxPowerGroup
end

function M:_showPointer(show, duration)
	return
end

function M:_onBeginDrag(evt)
	self._isDraging = true

	local position = evt.position

	self._beginDragStartTime = os.clock()

	self._singleDragPos:Set(position:Get())
	self._beginPosition:Set(position:Get())
end

function M:_onDrag(evt)
	local position = evt.position

	if position.x < 0 or position.x > UnityEngine.Screen.width or position.y < 0 or position.y > UnityEngine.Screen.height then
		self:_onEndDrag(evt)

		return
	end

	self:_forceStopLerp()

	local offsetY = self._singleDragPos.y - position.y
	local targetAngle = self:_getRingAngle() + offsetY * SPEED_FACTOR_DRAG

	targetAngle, _ = self:_fixAngle(targetAngle, true)

	self:_setRingAngle(targetAngle)

	local nodeLv, nodeId, nodeAngle = self:_tryMatchNode(targetAngle)

	if self._handler then
		self._handler:onDragToNode(nodeLv, nodeId)
	end

	self:_showPointer(true, 0.5)
	self._singleDragPos:Set(position:Get())
end

function M:_onEndDrag(evt)
	if not self._beginDragStartTime then
		self._beginDragStartTime = 0
	end

	local offsetTime = os.clock() - self._beginDragStartTime
	local offsetY = self._beginPosition.y - evt.position.y

	self:_showPointer(false, 0.2)

	local targetAngle, outOfLimit = self:_fixAngle(self:_getRingAngle(), false)
	local nodeLv, nodeId, nodeAngle = self:_tryMatchNode(targetAngle)

	if math.abs(offsetY) > ViewMgr.instance:getUIHeight() * 0.4 and offsetTime < 0.2 then
		local _dirFactor = self._beginPosition.y > evt.position.y and -1 or 1

		nodeId = math.min(nodeId + 2 * _dirFactor, self._maxPowerGroup * 5)
		nodeId = nodeId < 1 and 1 or nodeId
		nodeLv = math.ceil(nodeLv / 5)
		outOfLimit = true
	end

	if self._handler then
		self._handler:onEndDragMatchNode(nodeLv, nodeId, outOfLimit)
	end
end

function M:_getRingAngle()
	return self._ringRTAngle[M.RingTyp.All] or 0
end

function M:_setRingAngle(angle)
	local typ = M.RingTyp.All

	self._ringRTAngle[typ] = angle

	self:_setRingRTAngle(typ, angle)
end

function M:_setRingRTAngle(typ, angle)
	if typ == M.RingTyp.All then
		TransformUtils.SetLocalEulerAngles(self._rectTrRing[M.RingTyp.Level], 0, 0, angle)
		TransformUtils.SetLocalEulerAngles(self._rectTrRingLvGear, 0, 0, angle)
		TransformUtils.SetLocalEulerAngles(self._rectTrRing[M.RingTyp.Node], 0, 0, angle)
	elseif typ == M.RingTyp.Level then
		TransformUtils.SetLocalEulerAngles(self._rectTrRing[M.RingTyp.Level], 0, 0, angle)
		TransformUtils.SetLocalEulerAngles(self._rectTrRingLvGear, 0, 0, angle)
	elseif typ == M.RingTyp.Node then
		TransformUtils.SetLocalEulerAngles(self._rectTrRing[M.RingTyp.Node], 0, 0, angle)
	end

	GlobalDispatcher:dispatchEvent(EventType.CHARACTER_AUTHORITY_SWITCH_CIRCLE, angle)
end

function M:lerpRingToAngle(targetAngle, ease, duration, forceStopLerpBefore, speedBase)
	if forceStopLerpBefore then
		self:_forceStopLerp()
	end

	duration = duration or speedBase and DRAG_DURATION_SPEED_BASE or DRAG_DURATION

	if duration > 0 then
		if self._isLerping then
			self._lerpTweener = self._lerpTweener:ChangeEndValue(targetAngle, -1, true):SetEase(ease):SetAutoKill(true):OnComplete(self._lerpFinish, self)
		else
			self._isLerping = true
			self._lerpTweener = TweenNumberUtils.FloatTo(self:_getRingAngle(), targetAngle, duration, self._lerpUpdateCB, self):SetSpeedBased(speedBase):SetEase(ease):SetAutoKill(true):OnComplete(self._lerpFinish, self)
		end
	else
		self:_lerpFinish()
		self:_setRingAngle(targetAngle)
	end
end

function M:_lerpFinish()
	self:_forceStopLerp()

	self._isDraging = false
end

function M:_forceStopLerp()
	if self._lerpTweener then
		self._lerpTweener:Kill(false)

		self._lerpTweener = nil
	end

	self._isLerping = false
end

function M:_lerpUpdateCB(updateValue)
	self:_setRingAngle(updateValue)
end

function M:_fixAngle(angle, overAngle)
	overAngle = overAngle and M.RingDataDefine.OverAngle or 0

	local isFixed = false
	local min = self:getMinAngle() - overAngle
	local max = self:getMaxAngle() + overAngle

	if angle <= min then
		isFixed = true
		angle = min
	elseif max <= angle then
		angle = max
		isFixed = true
	end

	return angle, isFixed
end

function M:_tryMatchNode(angle)
	local maxPowerGroup = self._maxPowerGroup
	local nodeLv, nodeIndexInLv, _nodeAngle = nil, nil, 0
	local check = M.RingDataDefine.Node.Check
	local step = M.RingDataDefine.Node.Step
	local base = M.RingDataDefine.Node.Base
	local max = base + (maxPowerGroup * 5 - 1) * step

	for i = 1, maxPowerGroup do
		for j = 1, 5 do
			if not nodeLv then
				_nodeAngle = i == 1 and j == 1 and base or _nodeAngle + step

				if angle >= _nodeAngle - check and angle <= _nodeAngle + check then
					nodeLv, nodeIndexInLv = i, j

					break
				end
			end
		end

		if nodeLv then
			break
		end
	end

	local nodeId = nodeLv ~= nil and nodeIndexInLv + (nodeLv - 1) * 5 or nil

	return nodeLv, nodeId, _nodeAngle
end

function M:_onRoleBeginDrag(evt)
	self._beginPositionRole:Set(0, 0)
	self._beginPositionRole:Add(evt.position)
end

function M:_onRoleEndDrag(evt)
	local position = evt.position
	local deltaX = position.x - self._beginPositionRole.x

	if deltaX >= 50 then
		GlobalDispatcher:dispatchEvent(EventType.CHARACTER_AUTHORITY_SWITCH, true)
	elseif deltaX <= -50 then
		GlobalDispatcher:dispatchEvent(EventType.CHARACTER_AUTHORITY_SWITCH, false)
	end
end

return M
