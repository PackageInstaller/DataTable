-- chunkname: @modules/logic/equip/model/EquipTeamListModel.lua

module("modules.logic.equip.model.EquipTeamListModel", package.seeall)

local EquipTeamListModel = class("EquipTeamListModel", ListScrollModel)
local levelType = 1
local qualityType = 2
local timeType = 3

function EquipTeamListModel:onInit()
	self._levelAscend = false
	self._qualityAscend = false
	self._timeAscend = false
	self._btnTag = levelType
	self.isDown = false
end

function EquipTeamListModel:getHero()
	return self._heroMO
end

function EquipTeamListModel:getRequestData(uid)
	return self:_getRequestData(self._posIndex, uid)
end

function EquipTeamListModel:getRequestDataByTargetUid(targetUid, uid)
	local posIndex = self:getEquipTeamPos(targetUid)

	if posIndex then
		return self:_getRequestData(posIndex, uid)
	end
end

function EquipTeamListModel:_getRequestData(teamPos, uid)
	local equips = {}

	equips[1] = uid

	return self._curGroupMO.groupId, teamPos, equips
end

function EquipTeamListModel:openTeamEquip(posIndex, heroMO, groupMO)
	self._curGroupMO = groupMO or HeroGroupModel.instance:getCurGroupMO()
	self._posIndex = posIndex
	self._heroMO = heroMO
end

function EquipTeamListModel:getCurPosIndex()
	return self._posIndex
end

function EquipTeamListModel:initInTeamEquips()
	self._allInTeamEquips = {}

	local equips = self._curGroupMO:getAllPosEquips()

	for posIndex, v in pairs(equips) do
		for _, uid in pairs(v.equipUid) do
			self._allInTeamEquips[uid] = posIndex
		end
	end
end

function EquipTeamListModel:getEquipTeamPos(uid)
	return self._allInTeamEquips[uid]
end

function EquipTeamListModel:equipInTeam(uid)
	return self._allInTeamEquips[uid] ~= nil
end

function EquipTeamListModel:getTeamEquip(posIndex)
	posIndex = posIndex or self._posIndex

	return self._curGroupMO:getPosEquips(posIndex).equipUid
end

function EquipTeamListModel:getCurGroupMo()
	return self._curGroupMO
end

function EquipTeamListModel:getBtnTag()
	return self._btnTag
end

function EquipTeamListModel:getRankState()
	return self._levelAscend and 1 or -1, self._qualityAscend and 1 or -1, self._timeAscend and 1 or -1
end

function EquipTeamListModel:_sortByInTeam(a, b)
	local valueA = self:equipInTeam(a.uid)
	local valueB = self:equipInTeam(b.uid)

	if valueA == valueB then
		return nil
	end

	if valueA then
		return true
	end

	return false
end

function EquipTeamListModel:setEquipList(forceUpdate)
	if forceUpdate then
		self:initInTeamEquips()
	end

	self._equipList = {}

	local list = EquipModel.instance:getEquips()

	for i, v in ipairs(list) do
		local co = EquipConfig.instance:getEquipCo(v.equipId)

		if co and co.isExpEquip ~= 1 and not EquipHelper.isRefineUniversalMaterials(v.equipId) then
			table.insert(self._equipList, v)
		end
	end

	if self._btnTag == levelType then
		self:_sortByLevel()
	elseif self._btnTag == qualityType then
		self:_sortByQuality()
	elseif self._btnTag == timeType then
		self:_sortByTime()
	end

	self:setList(self._equipList)
end

function EquipTeamListModel:sortByLevel()
	self._qualityAscend = false
	self._timeAscend = false

	if self._btnTag == levelType then
		self._levelAscend = not self._levelAscend
	else
		self._btnTag = levelType
	end

	self:_sortByLevel()
	self:setList(self._equipList)
end

function EquipTeamListModel._sortByLevelFunc(a, b)
	local result = EquipTeamListModel.instance:_sortByInTeam(a, b)

	if result ~= nil then
		return result
	end

	if a.level ~= b.level then
		if EquipTeamListModel.instance._levelAscend then
			return a.level < b.level
		else
			return a.level > b.level
		end
	elseif a.config.rare ~= b.config.rare then
		return a.config.rare > b.config.rare
	else
		return a.id > b.id
	end
end

function EquipTeamListModel:_sortByLevel()
	table.sort(self._equipList, EquipTeamListModel._sortByLevelFunc)
end

function EquipTeamListModel:sortByQuality()
	self._levelAscend = false
	self._timeAscend = false

	if self._btnTag == qualityType then
		self._qualityAscend = not self._qualityAscend
	else
		self._btnTag = qualityType
	end

	self:_sortByQuality()
	self:setList(self._equipList)
end

function EquipTeamListModel._sortByQualityFunc(a, b)
	local result = EquipTeamListModel.instance:_sortByInTeam(a, b)

	if result ~= nil then
		return result
	end

	if a.config.rare ~= b.config.rare then
		if EquipTeamListModel.instance._qualityAscend then
			return a.config.rare < b.config.rare
		else
			return a.config.rare > b.config.rare
		end
	elseif a.level ~= b.level then
		return a.level > b.level
	else
		return a.id > b.id
	end
end

function EquipTeamListModel:_sortByQuality()
	table.sort(self._equipList, EquipTeamListModel._sortByQualityFunc)
end

function EquipTeamListModel:sortByTime()
	self._levelAscend = false
	self._qualityAscend = false

	if self._btnTag == timeType then
		self._timeAscend = not self._timeAscend
	else
		self._btnTag = timeType
	end

	self:_sortByTime()
	self:setList(self._equipList)
end

function EquipTeamListModel._sortByTimeFunc(a, b)
	local result = EquipTeamListModel.instance:_sortByInTeam(a, b)

	if result ~= nil then
		return result
	end

	if a.id ~= b.id then
		if EquipTeamListModel.instance._timeAscend then
			return a.id < b.id
		else
			return a.id > b.id
		end
	elseif a.level ~= b.level then
		return a.level > b.level
	else
		return a.config.rare > b.config.rare
	end
end

function EquipTeamListModel:_sortByTime()
	table.sort(self._equipList, EquipTeamListModel._sortByTimeFunc)
end

function EquipTeamListModel:clearEquipList()
	self._equipList = nil

	self:clear()
end

function EquipTeamListModel:getEquipList()
	return self._equipList
end

EquipTeamListModel.instance = EquipTeamListModel.New()

return EquipTeamListModel
