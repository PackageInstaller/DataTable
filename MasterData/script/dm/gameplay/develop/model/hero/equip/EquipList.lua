-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/equip/EquipList.lua

require("dm.gameplay.develop.model.hero.equip.HeroEquip")
require("dm.gameplay.develop.model.hero.equip.HeroEquipAttr")

EquipList = class("EquipList", objectlua.Object, _M)

EquipList:has("_equipMap", {
	is = "rw"
})
EquipList:has("_equipPositionMap", {
	is = "rw"
})

function EquipList:initialize(Player)
	super.initialize(self)

	self._equipMap = {}
	self._equipPositionMap = {}

	for i, type in pairs(HeroEquipType) do
		self._equipPositionMap[type] = {}
	end

	self._bag = Player._bag
end

function EquipList:synchronize(data)
	for id, value in pairs(data) do
		self._equipMap[id] = self._equipMap[id] or HeroEquip:new(id)

		self._equipMap[id]:synchronize(value)

		local type = self._equipMap[id]:getPosition()

		self._equipPositionMap[type][id] = 1
	end

	self._bag:synEquipList(self._equipMap)
end

function EquipList:deleteEquip(data)
	for id, v in pairs(data) do
		if self._equipMap[id] then
			local type = self._equipMap[id]:getPosition()

			self._equipPositionMap[type][id] = nil
			self._equipMap[id] = nil
		end
	end

	self._bag:delEquipList(data)
end

function EquipList:getEquips()
	return self._equipMap
end

function EquipList:getEquipById(id)
	return self._equipMap[id]
end

function EquipList:getEquipsByType(type)
	return self._equipPositionMap[type]
end

function EquipList:getEquipsAll()
	return self._equipPositionMap
end

function EquipList:getEquipList()
	local list = {}

	for id, equip in pairs(self._equipMap) do
		list[#list + 1] = equip
	end

	return list
end
