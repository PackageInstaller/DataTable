-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompMeshModelMover.lua

module("logic.battle.unit.comp.BattleUnitCompMeshModelMover", package.seeall)

local BattleUnitCompMeshModelMover = class("BattleUnitCompMeshModelMover", UnitComponentBase, IBattleUnitComponent)
local kMappingLayerOrder = {
	BattleEnum.kMappingLayers.BUSINESS,
	BattleEnum.kMappingLayers.SYSTEM,
	BattleEnum.kMappingLayers.BASE
}

function BattleUnitCompMeshModelMover:onInit()
	self._trs = self._unit.go.transform
	self._animationMappingLayers = {}
	self._offsetVec3 = Vector3.New()
	self._position = Vector3.New()
	self._ignoreTerrain = false
	self._lockDirection = false
	self._mover = self._unit.mover
	self._meshModel = self._unit.meshModel

	self._unit:addInnerEventListener(UnitActionType.PosChanged, self._onPosChanged, self)
	self._unit:addInnerEventListener(UnitActionType.Arrive, self._onArrive, self)
	self._unit:addInnerEventListener(UnitActionType.Interrupt, self._onInterrupt, self)
end

function BattleUnitCompMeshModelMover:onReset()
	BattleTableUtil.clearTable(self._animationMappingLayers)
	self._offsetVec3:Set(0, 0, 0)

	self._ignoreTerrain = false
	self._lockDirection = false
end

function BattleUnitCompMeshModelMover:onDestroy()
	self._trs = nil

	self._unit:removeInnerEventListener(UnitActionType.PosChanged, self._onPosChanged, self)
	self._unit:removeInnerEventListener(UnitActionType.Arrive, self._onArrive, self)
	self._unit:removeInnerEventListener(UnitActionType.Interrupt, self._onInterrupt, self)
end

function BattleUnitCompMeshModelMover:setOffsetXYZ(x, y, z)
	self._offsetVec3:Set(x, y, z)
end

function BattleUnitCompMeshModelMover:mapBaseAnimation(keyAnimation, valueAnimation)
	self:_mapAnimationOfLayer(BattleEnum.kMappingLayers.BASE, keyAnimation, valueAnimation)
end

function BattleUnitCompMeshModelMover:mapSystemAnimation(keyAnimation, valueAnimation)
	self:_mapAnimationOfLayer(BattleEnum.kMappingLayers.SYSTEM, keyAnimation, valueAnimation)
end

function BattleUnitCompMeshModelMover:mapBusinessAnimation(keyAnimation, valueAnimation)
	self:_mapAnimationOfLayer(BattleEnum.kMappingLayers.BUSINESS, keyAnimation, valueAnimation)
end

function BattleUnitCompMeshModelMover:resetBaseMappedAnimation(keyAnimation)
	self:_resetMappedAnimationOfLayer(BattleEnum.kMappingLayers.BASE, keyAnimation)
end

function BattleUnitCompMeshModelMover:resetSystemMappedAnimation(keyAnimation)
	self:_resetMappedAnimationOfLayer(BattleEnum.kMappingLayers.SYSTEM, keyAnimation)
end

function BattleUnitCompMeshModelMover:resetBusinessMappedAnimation(keyAnimation)
	self:_resetMappedAnimationOfLayer(BattleEnum.kMappingLayers.BUSINESS, keyAnimation)
end

function BattleUnitCompMeshModelMover:getMappedAnimation(keyAnimation)
	return self:_getMappedAnimation(keyAnimation) or keyAnimation
end

function BattleUnitCompMeshModelMover:getMappedAnimationByLayer(keyAnimation, layer)
	return self:_getMappedAnimationByLayer(keyAnimation, layer) or keyAnimation
end

function BattleUnitCompMeshModelMover:playMappedAnimation(animation, loop, force)
	local mappedAnimation = self:getMappedAnimation(animation)

	self._meshModel:play(mappedAnimation, loop, force)
end

function BattleUnitCompMeshModelMover:playMappedAnimationIfExists(animation, loop, force)
	local mappedAnimation = self:getMappedAnimation(animation)

	if self._meshModel:containsAnimation(mappedAnimation) then
		self._meshModel:playAndAutoIdleIfExists(mappedAnimation)
	end
end

function BattleUnitCompMeshModelMover:playIdle(force)
	self:playMappedAnimation(UnitAnimState.Idle, true, force)
end

function BattleUnitCompMeshModelMover:playWalk(force)
	self:playMappedAnimation(UnitAnimState.Walk, true, force)
end

function BattleUnitCompMeshModelMover:getPosXYZ()
	return self._position:Get()
end

function BattleUnitCompMeshModelMover:setIgnoreTerrain(isIgnoreTerrain)
	self._ignoreTerrain = isIgnoreTerrain
end

function BattleUnitCompMeshModelMover:setLockDirection(lockDirection)
	self._lockDirection = lockDirection
end

function BattleUnitCompMeshModelMover:_mapAnimationOfLayer(layer, keyAnimation, valueAnimation)
	local animationMapping = self._animationMappingLayers[layer]

	if not animationMapping then
		animationMapping = {}
		self._animationMappingLayers[layer] = animationMapping
	end

	animationMapping[keyAnimation] = valueAnimation
end

function BattleUnitCompMeshModelMover:_resetMappedAnimationOfLayer(layer, keyAnimation)
	local animationMapping = self._animationMappingLayers[layer]

	if not animationMapping then
		return
	end

	animationMapping[keyAnimation] = false
end

function BattleUnitCompMeshModelMover:_getMappedAnimation(keyAnimation)
	for _, layer in ipairs(kMappingLayerOrder) do
		local animationMapping = self._animationMappingLayers[layer]
		local valueAnimation = animationMapping and animationMapping[keyAnimation]

		if valueAnimation then
			return valueAnimation
		end
	end

	return false
end

function BattleUnitCompMeshModelMover:_getMappedAnimationByLayer(keyAnimation, layer)
	local animationMapping = self._animationMappingLayers[layer]
	local valueAnimation = animationMapping and animationMapping[keyAnimation]

	if valueAnimation then
		return valueAnimation
	end

	return false
end

function BattleUnitCompMeshModelMover:_onPosChanged()
	local x, z = self._mover:getPos()
	local wp = self._mover:getCurWayPoint()

	if wp then
		if not self._lockDirection and (wp.x ~= x or wp.y ~= z) then
			self._meshModel:lookAt(wp.x, 0, wp.y)
		end

		self:playWalk()
	end

	local y = self._offsetVec3.y

	if not self._ignoreTerrain then
		local boardMgr = BattleMgr.instance:getBoardMgr()

		y = y + boardMgr:calculateWorldYOffset(x, z)
	end

	self._position:Set(x + self._offsetVec3.x, y, z + self._offsetVec3.z)
	Astral.TransformUtil.SetPos(self._trs, self._position:Get())
end

function BattleUnitCompMeshModelMover:_onArrive()
	self:playIdle()
end

function BattleUnitCompMeshModelMover:_onInterrupt()
	self:playIdle()
end

return BattleUnitCompMeshModelMover
