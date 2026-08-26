-- chunkname: @modules/logic/room/entity/RoomBlockCanPlaceEntity.lua

module("modules.logic.room.entity.RoomBlockCanPlaceEntity", package.seeall)

local RoomBlockCanPlaceEntity = class("RoomBlockCanPlaceEntity", RoomBaseEntity)

function RoomBlockCanPlaceEntity:ctor(entityId)
	RoomBlockCanPlaceEntity.super.ctor(self)

	self.id = entityId
	self.entityId = self.id
end

function RoomBlockCanPlaceEntity:getTag()
	return SceneTag.Untagged
end

function RoomBlockCanPlaceEntity:init(go)
	self.containerGO = gohelper.create3d(go, RoomEnum.EntityChildKey.ContainerGOKey)
	self.staticContainerGO = gohelper.create3d(go, RoomEnum.EntityChildKey.StaticContainerGOKey)
	self.goTrs = go.transform

	RoomBlockCanPlaceEntity.super.init(self, go)
end

function RoomBlockCanPlaceEntity:initComponents()
	self:addComp("effect", RoomEffectComp)
	self:addComp("placeBuildingEffectComp", RoomPlaceBuildingEffectComp)
	self:addComp("placeBlockEffectComp", RoomPlaceBlockEffectComp)
	self:addComp("transportPathLinkEffectComp", RoomTransportPathLinkEffectComp)
	self:addComp("transportPathEffectComp", RoomTransportPathEffectComp)
end

function RoomBlockCanPlaceEntity:onStart()
	RoomBlockCanPlaceEntity.super.onStart(self)
end

function RoomBlockCanPlaceEntity:setLocalPos(x, y, z)
	transformhelper.setLocalPos(self.goTrs, x, y, z)
end

function RoomBlockCanPlaceEntity:getMO()
	return nil
end

return RoomBlockCanPlaceEntity
