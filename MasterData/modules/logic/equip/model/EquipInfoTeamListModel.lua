-- chunkname: @modules/logic/equip/model/EquipInfoTeamListModel.lua

module("modules.logic.equip.model.EquipInfoTeamListModel", package.seeall)

local EquipInfoTeamListModel = class("EquipInfoTeamListModel", EquipInfoBaseListModel)

function EquipInfoTeamListModel:onOpen(viewParam, filterMo)
	self.viewParam = viewParam
	self.heroMo = viewParam.heroMo

	self:initTeamEquipList(viewParam, filterMo)

	self.curGroupMO = viewParam.heroGroupMo or HeroGroupModel.instance:getCurGroupMO()
	self.maxHeroNum = viewParam.maxHeroNum
	self.posIndex = viewParam.posIndex

	if viewParam and viewParam.heroMo and viewParam.heroMo:isOtherPlayerHero() then
		self.otherPlayerHeroMo = viewParam.heroMo
	end

	local equipMo = viewParam.equipMo

	equipMo = equipMo or self.equipMoList and self.equipMoList[1]

	self:setCurrentSelectEquipMo(equipMo)
	self:initInTeamEquipUidToHero()
end

function EquipInfoTeamListModel:initTeamEquipList(viewParam, filterMo)
	if viewParam.equipMo then
		if viewParam.equipMo == EquipEnum.ClientEquipType.TrialHero then
			self.equipMoList = {
				viewParam.equipMo
			}
		else
			self:initEquipList(filterMo)
		end
	end
end

function EquipInfoTeamListModel:initEquipList(filterMo)
	self.equipMoList = {}
	self.recommendEquip = self.heroMo and self.heroMo:getRecommendEquip() or {}

	local isHasRecommed = LuaUtil.tableNotEmpty(self.recommendEquip)
	local isFilter = filterMo:isFiltering()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
		for _, equipMo in ipairs(EquipModel.instance:getEquips()) do
			if EquipHelper.isNormalEquip(equipMo.config) then
				if isFilter then
					if filterMo:checkIsIncludeTag(equipMo.config) then
						self:_initCharacterEquipMO(isHasRecommed, equipMo)
					end
				else
					self:_initCharacterEquipMO(isHasRecommed, equipMo)
				end
			end
		end
	end

	for _, equipMo in ipairs(HeroGroupTrialModel.instance:getTrialEquipList()) do
		if isFilter then
			if filterMo:checkIsIncludeTag(equipMo.config) then
				self:_initCharacterEquipMO(isHasRecommed, equipMo)
			end
		else
			self:_initCharacterEquipMO(isHasRecommed, equipMo)
		end
	end

	self:resortEquip()
end

function EquipInfoTeamListModel:_initCharacterEquipMO(isHasRecommed, equipMo)
	local index = isHasRecommed and tabletool.indexOf(self.recommendEquip, equipMo.equipId) or -1

	equipMo:setRecommedIndex(index)
	table.insert(self.equipMoList, equipMo)
end

function EquipInfoTeamListModel:initInTeamEquipUidToHero()
	self.equipUidToHeroMo = {}

	local heroUidList = self.curGroupMO.heroList

	if self.viewParam.fromView == EquipEnum.FromViewEnum.V3a9_BossRush_HeroGroupListView and self.viewParam.stage then
		heroUidList = V3a9_BossRushModel.instance:getHeroUIds(self.viewParam.stage)
	end

	local _, assistMo = HeroGroupModel.instance:getAssistMo()

	if assistMo then
		heroUidList[assistMo.id] = assistMo.heroUid
	end

	for index, heroGroupEquipMO in pairs(self.curGroupMO.equips) do
		if not self.maxHeroNum or index + 1 <= self.maxHeroNum then
			local uid = heroUidList[index + 1]

			self.equipUidToHeroMo[heroGroupEquipMO.equipUid[1]] = uid and tonumber(uid) < 0 and HeroGroupTrialModel.instance:getById(uid) or self.otherPlayerHeroMo and self.otherPlayerHeroMo.uid == uid and self.otherPlayerHeroMo or HeroModel.instance:getById(uid)
		end
	end
end

function EquipInfoTeamListModel:getGroupCurrentPosEquip(posIndex)
	return self.curGroupMO:getPosEquips(posIndex or self.posIndex).equipUid
end

function EquipInfoTeamListModel:getCurrentPosIndex()
	return self.posIndex
end

function EquipInfoTeamListModel:getRequestData(posIndex, equipUid)
	local equips = {}

	equips[1] = equipUid

	return self.curGroupMO.groupId, posIndex, equips
end

function EquipInfoTeamListModel:getHeroMoByEquipUid(equipUid)
	return self.equipUidToHeroMo and self.equipUidToHeroMo[equipUid]
end

function EquipInfoTeamListModel:clear()
	self:onInit()

	self.selectedEquipMo = nil
	self.curGroupMO = nil
	self.posIndex = nil
	self.equipUidToHeroMo = nil
end

EquipInfoTeamListModel.instance = EquipInfoTeamListModel.New()

return EquipInfoTeamListModel
