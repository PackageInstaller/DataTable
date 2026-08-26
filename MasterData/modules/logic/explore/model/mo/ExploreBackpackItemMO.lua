-- chunkname: @modules/logic/explore/model/mo/ExploreBackpackItemMO.lua

module("modules.logic.explore.model.mo.ExploreBackpackItemMO", package.seeall)

local ExploreBackpackItemMO = pureTable("ExploreBackpackItemMO")

function ExploreBackpackItemMO:ctor()
	self.id = 0
	self.ids = {}
	self.quantity = 0
	self.itemId = 0
end

function ExploreBackpackItemMO:init(info)
	self.id = info.uid
	self.ids = {
		self.id
	}
	self.quantity = info.quantity
	self.itemId = info.itemId
	self.status = info.status
	self.config = ExploreConfig.instance:getItemCo(self.itemId)
	self.isStackable = self.config.isClientStackable
	self.isActiveTypeItem = ExploreConfig.instance:isActiveTypeItem(self.config.type)
	self.itemEffect = string.split(self.config.effect, "#")[1] or "1"
end

function ExploreBackpackItemMO:updateStackable(info)
	if info.quantity == 0 then
		tabletool.removeValue(self.ids, info.uid)
	elseif tabletool.indexOf(self.ids, info.uid) == nil then
		table.insert(self.ids, info.uid)
	end

	self.id = self.ids[1] or 0
	self.quantity = #self.ids
end

return ExploreBackpackItemMO
