-- chunkname: @modules/logic/room/entity/RoomFakeBlockEntity.lua

module("modules.logic.room.entity.RoomFakeBlockEntity", package.seeall)

local RoomFakeBlockEntity = class("RoomFakeBlockEntity", RoomBaseBlockEntity)

function RoomFakeBlockEntity:getTag()
	return SceneTag.RoomFakeBlock
end

function RoomFakeBlockEntity:init(go)
	RoomFakeBlockEntity.super.init(self, go)
end

function RoomFakeBlockEntity:initComponents()
	RoomFakeBlockEntity.super.initComponents(self)
end

function RoomFakeBlockEntity:refreshLand()
	RoomFakeBlockEntity.super.refreshLand(self)
	self.effect:changeParams({
		landGO = {
			shadow = false,
			batch = false,
			layer = UnityLayer.SceneOrthogonalOpaque
		}
	})
	self.effect:refreshEffect()
end

function RoomFakeBlockEntity:getMO()
	return RoomInventoryBlockModel.instance:getFakeBlockMOById(self.id)
end

return RoomFakeBlockEntity
