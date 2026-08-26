-- chunkname: @modules/logic/seasonver/act123/model/Season123CardPackageItemMO.lua

local Season123CardPackageItemMO = pureTable("Season123CardPackageItemMO")

function Season123CardPackageItemMO:ctor()
	return
end

function Season123CardPackageItemMO:init(itemId)
	self.id = itemId
	self.itemId = itemId
	self.count = 1
	self.config = Season123Config.instance:getSeasonEquipCo(itemId)
end

return Season123CardPackageItemMO
