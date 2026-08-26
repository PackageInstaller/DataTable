-- chunkname: @modules/logic/season/model/Activity104RetailMo.lua

local Activity104RetailMo = pureTable("Activity104RetailMo")

function Activity104RetailMo:ctor()
	self.id = 0
	self.state = 0
	self.advancedId = 0
	self.star = 0
	self.showActivity104EquipIds = {}
	self.position = 0
	self.advancedRare = 0
	self.tag = 0
end

function Activity104RetailMo:init(info)
	self.id = info.id
	self.state = info.state
	self.advancedId = info.advancedId
	self.star = info.star
	self.showActivity104EquipIds = self:_buildEquipList(info.showActivity104EquipIds)
	self.position = info.position
	self.advancedRare = info.advancedRare
	self.tag = info.tag
end

function Activity104RetailMo:_buildEquipList(listInfo)
	local list = {}

	for _, v in ipairs(listInfo) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return Activity104RetailMo.sortEquipList(a, b, self.tag)
	end)

	return list
end

function Activity104RetailMo.sortEquipList(a, b, tag)
	local equipACo = SeasonConfig.instance:getSeasonEquipCo(a)
	local equipBCo = SeasonConfig.instance:getSeasonEquipCo(b)

	if equipACo.isOptional ~= equipBCo.isOptional then
		return equipACo.isOptional > equipBCo.isOptional
	end

	if equipACo.rare ~= equipBCo.rare then
		return equipACo.rare > equipBCo.rare
	end

	if SeasonEquipMetaUtils.isContainTag(equipACo, tag) then
		return true
	end

	return false
end

return Activity104RetailMo
