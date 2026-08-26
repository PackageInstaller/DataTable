-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotEquipInfoTeamListModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotEquipInfoTeamListModel", package.seeall)

local V1a6_CachotEquipInfoTeamListModel = class("V1a6_CachotEquipInfoTeamListModel", EquipInfoBaseListModel)

function V1a6_CachotEquipInfoTeamListModel:setSeatLevel(value)
	self._seatLevel = value
end

function V1a6_CachotEquipInfoTeamListModel:getSeatLevel()
	return self._seatLevel
end

function V1a6_CachotEquipInfoTeamListModel:onOpen(viewParam, filterMo)
	self.viewParam = viewParam

	self:initTeamEquipList(viewParam, filterMo)

	self.curGroupMO = viewParam.heroGroupMo or HeroGroupModel.instance:getCurGroupMO()
	self.posIndex = viewParam.posIndex

	local equipMo = viewParam.equipMo

	equipMo = equipMo or self.equipMoList and self.equipMoList[1]

	self:setCurrentSelectEquipMo(equipMo)
	self:initInTeamEquipUidToHero()
end

function V1a6_CachotEquipInfoTeamListModel:initTeamEquipList(viewParam, filterMo)
	if viewParam.equipMo and viewParam.equipMo.equipType == EquipEnum.ClientEquipType.TrialHero then
		self.equipMoList = {
			viewParam.equipMo
		}
	else
		self:initEquipList(filterMo)
	end
end

function V1a6_CachotEquipInfoTeamListModel:initEquipList(filterMo)
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

function V1a6_CachotEquipInfoTeamListModel:initInTeamEquipUidToHero()
	self.equipUidToHeroMo = {}

	local heroUidList = self.curGroupMO.heroList

	for index, heroGroupEquipMO in pairs(self.curGroupMO.equips) do
		local uid = heroUidList[index + 1]

		self.equipUidToHeroMo[heroGroupEquipMO.equipUid[1]] = tonumber(uid) < 0 and HeroGroupTrialModel.instance:getById(uid) or HeroModel.instance:getById(uid)
	end
end

function V1a6_CachotEquipInfoTeamListModel:getGroupCurrentPosEquip(posIndex)
	return self.curGroupMO:getPosEquips(posIndex or self.posIndex).equipUid
end

function V1a6_CachotEquipInfoTeamListModel:getCurrentPosIndex()
	return self.posIndex
end

function V1a6_CachotEquipInfoTeamListModel:getRequestData(posIndex, equipUid)
	local equips = {}

	equips[1] = equipUid

	return self.curGroupMO.groupId, posIndex, equips
end

function V1a6_CachotEquipInfoTeamListModel:getHeroMoByEquipUid(equipUid)
	return self.equipUidToHeroMo and self.equipUidToHeroMo[equipUid]
end

function V1a6_CachotEquipInfoTeamListModel:clear()
	self:onInit()

	self.selectedEquipMo = nil
	self.curGroupMO = nil
	self.posIndex = nil
	self.equipUidToHeroMo = nil
end

V1a6_CachotEquipInfoTeamListModel.instance = V1a6_CachotEquipInfoTeamListModel.New()

return V1a6_CachotEquipInfoTeamListModel
