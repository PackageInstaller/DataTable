-- chunkname: @modules/logic/room/entity/RoomBasicBuildingEntityBase.lua

module("modules.logic.room.entity.RoomBasicBuildingEntityBase", package.seeall)

local RoomBasicBuildingEntityBase = class("RoomBasicBuildingEntityBase", RoomBaseEntity)

function RoomBasicBuildingEntityBase:ctor(...)
	RoomBasicBuildingEntityBase.super.ctor(self, ...)
end

function RoomBasicBuildingEntityBase:onStart()
	RoomBasicBuildingEntityBase.super.onStart(self)
	RoomSkinController.instance:registerCallback(RoomSkinEvent.ChangeEquipRoomSkin, self.onChangeEquipRoomSkin, self)
end

function RoomBasicBuildingEntityBase:beforeDestroy()
	RoomSkinController.instance:unregisterCallback(RoomSkinEvent.ChangeEquipRoomSkin, self.onChangeEquipRoomSkin, self)
	RoomBasicBuildingEntityBase.super.beforeDestroy(self)
end

function RoomBasicBuildingEntityBase:onEffectRebuild()
	self:_refreshSuitEffect()
end

function RoomBasicBuildingEntityBase:_refreshSuitEffect()
	local bActiveSuit1 = RoomSkinModel.instance:bAllowPlaySuit1Eff()

	self:_setActiveSuit1Effct(bActiveSuit1)
end

function RoomBasicBuildingEntityBase:_setActiveSuit1Effct(bActive)
	local goList = self.effect:getGameObjectsByName(RoomEnum.EffectKey.BuildingGOKey, RoomEnum.EntityChildKey.Suit1GoKey)

	if goList then
		for _, go in ipairs(goList) do
			gohelper.setActive(go, bActive)
		end
	end
end

function RoomBasicBuildingEntityBase:onChangeEquipRoomSkin()
	self:_refreshSuitEffect()
end

return RoomBasicBuildingEntityBase
