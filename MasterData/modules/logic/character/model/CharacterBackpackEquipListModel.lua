-- chunkname: @modules/logic/character/model/CharacterBackpackEquipListModel.lua

module("modules.logic.character.model.CharacterBackpackEquipListModel", package.seeall)

local CharacterBackpackEquipListModel = class("CharacterBackpackEquipListModel", ListScrollModel)

function CharacterBackpackEquipListModel:init()
	self._levelAscend = false
	self._qualityAscend = false
	self._timeAscend = false
	self._btnTag = 1
end

function CharacterBackpackEquipListModel:getBtnTag()
	return self._btnTag
end

function CharacterBackpackEquipListModel:getRankState()
	return self._levelAscend and 1 or -1, self._qualityAscend and 1 or -1, self._timeAscend and 1 or -1
end

function CharacterBackpackEquipListModel:updateModel()
	self._equipList = self._equipList or {}

	self:setList(self._equipList)
end

function CharacterBackpackEquipListModel:getCount()
	return (self._equipList or nil) and (#self._equipList or 0)
end

function CharacterBackpackEquipListModel:setEquipList()
	self._equipList = {}

	local list = EquipModel.instance:getEquips()

	for i, v in ipairs(list) do
		if v.config then
			table.insert(self._equipList, v)
		end
	end

	self:sortEquipList()
	self:setList(self._equipList)
end

function CharacterBackpackEquipListModel:setEquipListNew(equipList)
	self._equipList = equipList

	self:sortEquipList()
	self:setList(self._equipList)
end

function CharacterBackpackEquipListModel:sortEquipList()
	if self._btnTag == 1 then
		self:_sortByLevel()
	elseif self._btnTag == 2 then
		self:_sortByQuality()
	elseif self._btnTag == 3 then
		self:_sortByTime()
	end
end

function CharacterBackpackEquipListModel:sortByLevel()
	self._qualityAscend = false
	self._timeAscend = false

	if self._btnTag == 1 then
		self._levelAscend = not self._levelAscend
	else
		self._btnTag = 1
	end

	self:_sortByLevel()
	self:setList(self._equipList)
end

function CharacterBackpackEquipListModel:_sortByLevel()
	table.sort(self._equipList, EquipHelper.sortByLevelFunc)
end

function CharacterBackpackEquipListModel:sortByQuality()
	self._levelAscend = false
	self._timeAscend = false

	if self._btnTag == 2 then
		self._qualityAscend = not self._qualityAscend
	else
		self._btnTag = 2
	end

	self:_sortByQuality()
	self:setList(self._equipList)
end

function CharacterBackpackEquipListModel:_sortByQuality()
	table.sort(self._equipList, EquipHelper.sortByQualityFunc)
end

function CharacterBackpackEquipListModel:sortByTime()
	self._levelAscend = false
	self._qualityAscend = false

	if self._btnTag == 3 then
		self._timeAscend = not self._timeAscend
	else
		self._btnTag = 3
	end

	self:_sortByTime()
	self:setList(self._equipList)
end

function CharacterBackpackEquipListModel:_sortByTime()
	table.sort(self._equipList, EquipHelper.sortByTimeFunc)
end

function CharacterBackpackEquipListModel:_getEquipList()
	return self._equipList
end

function CharacterBackpackEquipListModel:openEquipView()
	self:init()

	self.equipUidToHeroMo = {}

	local groupMO = HeroGroupModel.instance:getCurGroupMO()
	local groupAllEquips = groupMO:getAllPosEquips()
	local heroUidList = groupMO.heroList

	for index, heroGroupEquipMO in pairs(groupAllEquips) do
		self.equipUidToHeroMo[heroGroupEquipMO.equipUid[1]] = HeroModel.instance:getById(heroUidList[index + 1])
	end
end

function CharacterBackpackEquipListModel:getHeroMoByEquipUid(equipUid)
	return self.equipUidToHeroMo and self.equipUidToHeroMo[equipUid]
end

function CharacterBackpackEquipListModel:clearEquipList()
	self._equipList = nil
	self.equipUidToHeroMo = nil

	self:clear()
end

CharacterBackpackEquipListModel.instance = CharacterBackpackEquipListModel.New()

return CharacterBackpackEquipListModel
