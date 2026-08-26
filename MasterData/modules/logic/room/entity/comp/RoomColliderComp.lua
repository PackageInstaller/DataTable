-- chunkname: @modules/logic/room/entity/comp/RoomColliderComp.lua

module("modules.logic.room.entity.comp.RoomColliderComp", package.seeall)

local RoomColliderComp = class("RoomColliderComp", LuaCompBase)

function RoomColliderComp:ctor(entity)
	self.entity = entity
	self._colliderEffectKey = RoomEnum.EffectKey.BuildingGOKey
end

function RoomColliderComp:init(go)
	self.go = go
	self._colliderGO = nil
	self._scene = GameSceneMgr.instance:getCurScene()
	self._colliderParamList = nil
	self._isEnabled = true

	self:refreshPosition()
end

function RoomColliderComp:addEventListeners()
	RoomMapController.instance:registerCallback(RoomEvent.CameraUpdateFinish, self._cameraUpdateFinish, self)
end

function RoomColliderComp:removeEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraUpdateFinish, self._cameraUpdateFinish, self)
end

function RoomColliderComp:_cameraUpdateFinish()
	self:refreshPosition()
end

function RoomColliderComp:setEnable(isEnabled)
	self._isEnabled = isEnabled

	self:_updateEnable()
	self:refreshPosition()
end

function RoomColliderComp:_updateEnable()
	if not self._colliderParamList then
		return
	end

	for i, colliderParam in ipairs(self._colliderParamList) do
		colliderParam.collider.enabled = self._isEnabled
	end
end

function RoomColliderComp:refreshPosition()
	if not self.entity.effect:isHasEffectGOByKey(self._colliderEffectKey) then
		return
	end

	if not self._colliderParamList then
		self._colliderParamList = self:getUserDataTb_()

		local colliders = self.entity.effect:getComponentsByKey(self._colliderEffectKey, RoomEnum.ComponentName.BoxCollider)

		if colliders then
			for i = 1, #colliders do
				local collider = colliders[i]

				if collider.gameObject.layer == UnityLayer.SceneOpaque then
					table.insert(self._colliderParamList, {
						collider = collider,
						trans = collider.transform,
						center = collider.center
					})
				end
			end
		end

		self:_updateEnable()
	end

	for i, colliderParam in ipairs(self._colliderParamList) do
		local trans = colliderParam.trans
		local goPos = trans.position
		local bendingPos = RoomBendingHelper.worldToBendingSimple(goPos)
		local offsetCenter = bendingPos:Sub(goPos)
		local lossyScale = trans.lossyScale

		if lossyScale.x ~= 0 then
			offsetCenter.x = offsetCenter.x / lossyScale.x or 0
		end

		if lossyScale.y ~= 0 then
			offsetCenter.y = offsetCenter.y / lossyScale.y or 0
		end

		if lossyScale.z ~= 0 then
			offsetCenter.z = offsetCenter.z / lossyScale.z or 0
		end

		colliderParam.collider.center = offsetCenter:Add(colliderParam.center)
	end
end

function RoomColliderComp:clearColliderGOList()
	if not self._colliderParamList then
		return
	end

	for i, colliderParam in ipairs(self._colliderParamList) do
		colliderParam.collider.center = colliderParam.center
	end

	self._colliderParamList = nil
end

function RoomColliderComp:beforeDestroy()
	TaskDispatcher.cancelTask(self._onUpdate, self)
	self:clearColliderGOList()
	self:removeEventListeners()
end

return RoomColliderComp
