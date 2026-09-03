-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/model/ExploreEquipItem.lua

require("dm.gameplay.develop.model.bag.item.Item")

ExploreEquipItem = class("ExploreEquipItem", Item, _M)

ExploreEquipItem:has("_equipId", {
	is = "rw"
})
ExploreEquipItem:has("_star", {
	is = "rw"
})
ExploreEquipItem:has("_level", {
	is = "rw"
})

local HeroEquipExp = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipExp", "content")
local HeroEquipStar = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipStar", "content")

function ExploreEquipItem:initialize(id, equipId)
	super.initialize({})

	self._item = {
		id = id,
		type = ItemPages.kEquip,
		subType = ItemTypes.K_EQUIP_NEW
	}
	self._equipId = equipId

	self:synchronize()

	if HeroEquipType.kStarItem == self._config.position then
		self._item.subType = ItemTypes.K_EQUIP_NEW_ITEM
	end
end

function ExploreEquipItem:synchronize()
	self._config = ConfigReader:getRecordById("HeroEquipBase", self._equipId)

	local rarity = self:getRarity()

	self._star = ConfigReader:getDataByNameIdAndKey("HeroEquipStar", HeroEquipStar[tostring(rarity)], "StarLevel")
	self._level = ConfigReader:getDataByNameIdAndKey("HeroEquipExp", HeroEquipExp[tostring(rarity)], "ShowLevel")
end

function ExploreEquipItem:getId()
	return self._item.id
end

function ExploreEquipItem:getConfigId()
	return self._item.id
end

function ExploreEquipItem:getName()
	return Strings:get(self._config.Name)
end

function ExploreEquipItem:getDesc()
	return Strings:get(self._config.Desc)
end

function ExploreEquipItem:getType()
	return self._item.type
end

function ExploreEquipItem:getSubType()
	return self._item.subType
end

function ExploreEquipItem:getRarity()
	return self._config.Rareity
end

function ExploreEquipItem:getQuality()
	return self:getRarity() - 8
end

function ExploreEquipItem:getSort()
	return self._config.Sort
end

function ExploreEquipItem:getIsVisible()
	return true
end

function ExploreEquipItem:getRedVisible()
	return false
end

function ExploreEquipItem:getIsShine()
	return false
end
