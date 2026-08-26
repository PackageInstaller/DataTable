-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyEquipInfoTeamListModel.lua

module("modules.logic.sp01.odyssey.model.OdysseyEquipInfoTeamListModel", package.seeall)

local OdysseyEquipInfoTeamListModel = class("OdysseyEquipInfoTeamListModel", EquipInfoBaseListModel)

function OdysseyEquipInfoTeamListModel:setSeatLevel(value)
	self._seatLevel = value
end

function OdysseyEquipInfoTeamListModel:getSeatLevel()
	return self._seatLevel
end

function OdysseyEquipInfoTeamListModel:onOpen(viewParam, filterMo)
	self.viewParam = viewParam
	self.sortBy = EquipInfoBaseListModel.SortBy.Level

	self:initTeamEquipList(viewParam, filterMo)

	self.curGroupMO = viewParam.heroGroupMo or HeroGroupModel.instance:getCurGroupMO()
	self.posIndex = viewParam.posIndex

	local equipMo = viewParam.equipMo

	equipMo = equipMo or self.equipMoList and self.equipMoList[1]

	self:setCurrentSelectEquipMo(equipMo)
	self:initInTeamEquipUidToHero()
end

function OdysseyEquipInfoTeamListModel:initTeamEquipList(viewParam, filterMo)
	if viewParam.equipMo and viewParam.equipMo.equipType == EquipEnum.ClientEquipType.TrialHero then
		self.equipMoList = {
			viewParam.equipMo
		}
	else
		self:initEquipList(filterMo)
	end
end

function OdysseyEquipInfoTeamListModel:initEquipList(filterMo)
	local sourceList = {}

	if self.viewParam.fromView == EquipEnum.FromViewEnum.FromCachotHeroGroupFightView then
		local teamInfo = V1a6_CachotModel.instance:getTeamInfo()

		for i, v in ipairs(teamInfo.equipUids) do
			table.insert(sourceList, EquipModel.instance:getEquip(v))
		end
	else
		sourceList = EquipModel.instance:getEquips()
	end

	self.equipMoList = {}

	local isFilter = filterMo:isFiltering()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		for _, equipMo in ipairs(sourceList) do
			if EquipHelper.isNormalEquip(equipMo.config) then
				if isFilter then
					if filterMo:checkIsIncludeTag(equipMo.config) then
						table.insert(self.equipMoList, equipMo)
					end
				else
					table.insert(self.equipMoList, equipMo)
				end
			end
		end
	end

	self:resortEquip()
end

function OdysseyEquipInfoTeamListModel:initInTeamEquipUidToHero()
	self.equipUidToHeroMo = {}

	local heroUidList = self.curGroupMO.heroList

	for index, heroGroupEquipMO in pairs(self.curGroupMO.equips) do
		local uid = heroUidList[index + 1]

		self.equipUidToHeroMo[heroGroupEquipMO.equipUid[1]] = tonumber(uid) < 0 and HeroGroupTrialModel.instance:getById(uid) or HeroModel.instance:getById(uid)
	end
end

function OdysseyEquipInfoTeamListModel:getGroupCurrentPosEquip(posIndex)
	return self.curGroupMO:getPosEquips(posIndex or self.posIndex).equipUid
end

function OdysseyEquipInfoTeamListModel:getCurrentPosIndex()
	return self.posIndex
end

function OdysseyEquipInfoTeamListModel:getRequestData(posIndex, equipUid)
	local equips = {}

	equips[1] = equipUid

	return self.curGroupMO.groupId, posIndex, equips
end

function OdysseyEquipInfoTeamListModel:getHeroMoByEquipUid(equipUid)
	return self.equipUidToHeroMo and self.equipUidToHeroMo[equipUid]
end

function OdysseyEquipInfoTeamListModel:clear()
	self:onInit()

	self.selectedEquipMo = nil
	self.curGroupMO = nil
	self.posIndex = nil
	self.equipUidToHeroMo = nil
end

OdysseyEquipInfoTeamListModel.instance = OdysseyEquipInfoTeamListModel.New()

return OdysseyEquipInfoTeamListModel
