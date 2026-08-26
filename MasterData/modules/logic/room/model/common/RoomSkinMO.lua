-- chunkname: @modules/logic/room/model/common/RoomSkinMO.lua

module("modules.logic.room.model.common.RoomSkinMO", package.seeall)

local RoomSkinMO = pureTable("RoomSkinMO")

function RoomSkinMO:init(skinId)
	self.id = skinId
end

function RoomSkinMO:setIsEquipped(isEquipped)
	self._isEquipped = isEquipped
end

function RoomSkinMO:getId()
	return self.id
end

function RoomSkinMO:getBelongPartId()
	local skinId = self.id

	return (RoomConfig.instance:getBelongPart(skinId))
end

function RoomSkinMO:isUnlock()
	local result = false
	local unlockItemId = RoomConfig.instance:getRoomSkinUnlockItemId(self.id)

	if unlockItemId and unlockItemId ~= 0 then
		local itemCount = ItemModel.instance:getItemCount(unlockItemId)

		result = itemCount > 0
	else
		result = true
	end

	return result
end

function RoomSkinMO:isEquipped()
	return self._isEquipped
end

return RoomSkinMO
