-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyOuterItemMo.lua

module("modules.logic.sp01.odyssey.model.OdysseyOuterItemMo", package.seeall)

local OdysseyOuterItemMo = pureTable("OdysseyOuterItemMo")

function OdysseyOuterItemMo:init()
	self.addCount = 0
	self.count = 0
end

function OdysseyOuterItemMo:updateInfo(info)
	self.type = info.materilType
	self.id = info.materilId
	self.addCount = info.quantity
	self.config = ItemConfig.instance:getItemConfig(self.type, self.id)
	self.count = ItemModel.instance:getItemCount(self.id)
	self.itemType = OdysseyEnum.RewardItemType.OuterItem
end

function OdysseyOuterItemMo:cleanAddCount()
	self.addCount = 0
end

return OdysseyOuterItemMo
