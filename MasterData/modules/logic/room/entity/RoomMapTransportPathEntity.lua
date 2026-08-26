-- chunkname: @modules/logic/room/entity/RoomMapTransportPathEntity.lua

module("modules.logic.room.entity.RoomMapTransportPathEntity", package.seeall)

local RoomMapTransportPathEntity = class("RoomMapTransportPathEntity", RoomBaseEntity)

function RoomMapTransportPathEntity:ctor(entityId)
	RoomMapTransportPathEntity.super.ctor(self)

	self.id = entityId
	self.entityId = self.id
end

function RoomMapTransportPathEntity:getTag()
	return SceneTag.Untagged
end

function RoomMapTransportPathEntity:init(go)
	self.containerGO = gohelper.create3d(go, RoomEnum.EntityChildKey.ContainerGOKey)
	self.staticContainerGO = gohelper.create3d(go, RoomEnum.EntityChildKey.StaticContainerGOKey)
	self.goTrs = go.transform

	RoomMapTransportPathEntity.super.init(self, go)
end

function RoomMapTransportPathEntity:initComponents()
	self:addComp("effect", RoomEffectComp)
end

function RoomMapTransportPathEntity:onStart()
	RoomMapTransportPathEntity.super.onStart(self)
end

function RoomMapTransportPathEntity:setLocalPos(x, y, z)
	transformhelper.setLocalPos(self.goTrs, x, y, z)
end

function RoomMapTransportPathEntity:getMO()
	return nil
end

function RoomMapTransportPathEntity:_refreshCanPlaceEffect()
	local canPlaceEffect = self:_isCanShowPlaceEffect()
	local tRoomMapBlockModel = RoomMapBlockModel.instance
	local addParams, removeParams
	local effectComp = self.entity.effect
	local transportPathMO = RoomMapTransportPathModel.instance:getTempTransportPathMO()
	local hexPointList = transportPathMO:getHexPointList()

	for index, hexPoint in ipairs(hexPointList) do
		local effectKey = self:getEffectKeyById(index)

		if canPlaceEffect and self:_checkByXY(hexPoint.x, hexPoint.y, tRoomMapBlockModel) then
			if not effectComp:isHasKey(effectKey) then
				if addParams == nil then
					addParams = {}
				end

				local vec2 = HexMath.hexToPosition(hexPoint, RoomBlockEnum.BlockSize)

				addParams[effectKey] = {
					res = RoomScenePreloader.ResEffectD03,
					localPos = Vector3(vec2.x, -0.12, vec2.y)
				}
			end
		elseif effectComp:getEffectRes(effectKey) then
			if removeParams == nil then
				removeParams = {}
			end

			table.insert(removeParams, effectKey)
		end
	end

	if addParams then
		effectComp:addParams(addParams)
		effectComp:refreshEffect()
	end

	if removeParams then
		self:removeParamsAndPlayAnimator(removeParams, "close", RoomBlockEnum.PlaceEffectAnimatorCloseTime)
	end
end

return RoomMapTransportPathEntity
