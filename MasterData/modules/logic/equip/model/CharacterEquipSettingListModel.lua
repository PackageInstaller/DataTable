-- chunkname: @modules/logic/equip/model/CharacterEquipSettingListModel.lua

module("modules.logic.equip.model.CharacterEquipSettingListModel", package.seeall)

local CharacterEquipSettingListModel = class("CharacterEquipSettingListModel", EquipInfoBaseListModel)

function CharacterEquipSettingListModel:onInit()
	CharacterEquipSettingListModel.super.onInit(self)

	self._tempEquipMos = {}
end

function CharacterEquipSettingListModel:onOpen(viewParam, filterMo)
	self.heroMo = viewParam.heroMo

	self:initEquipList(filterMo)
	self:setCurrentShowHeroMo(viewParam.heroMo)

	self._defaultEquipUid = viewParam.heroMo.defaultEquipUid

	self:selectFirstEquip()
end

function CharacterEquipSettingListModel:selectFirstEquip()
	local equipMo = EquipModel.instance:getEquip(self._defaultEquipUid)

	equipMo = equipMo or self.equipMoList and self.equipMoList[1]

	self:setCurrentSelectEquipMo(equipMo)
end

function CharacterEquipSettingListModel:initEquipList(filterMo)
	self.equipMoList = {}
	self.recommendEquip = self.heroMo and self.heroMo:getRecommendEquip() or {}

	local isHasRecommed = LuaUtil.tableNotEmpty(self.recommendEquip)
	local isFilter = filterMo:isFiltering()
	local recommendEqiuipMos = {}

	for _, equipMo in ipairs(EquipModel.instance:getEquips()) do
		if EquipHelper.isNormalEquip(equipMo.config) then
			if isFilter then
				if filterMo:checkIsIncludeTag(equipMo.config) then
					self:_initCharacterEquipMO(isHasRecommed, equipMo, recommendEqiuipMos)
				end
			else
				self:_initCharacterEquipMO(isHasRecommed, equipMo, recommendEqiuipMos)
			end
		end
	end

	for index, id in ipairs(self.recommendEquip) do
		local equipMo = recommendEqiuipMos[id]

		if not equipMo then
			equipMo = self._tempEquipMos[id]

			if not self._tempEquipMos[id] then
				equipMo = CharacterEquipMO.New()

				equipMo:setTempMo(id)

				self._tempEquipMos[id] = equipMo
			end

			equipMo:setRecommedIndex(index)

			recommendEqiuipMos[id] = equipMo

			if not isFilter or filterMo:checkIsIncludeTag(equipMo.config) then
				table.insert(self.equipMoList, equipMo)
			end
		end
	end

	self:resortEquip()
end

function CharacterEquipSettingListModel:_initCharacterEquipMO(isHasRecommed, equipMo, recommendEqiuipMos)
	local index = isHasRecommed and tabletool.indexOf(self.recommendEquip, equipMo.equipId) or -1

	equipMo:setRecommedIndex(index)
	table.insert(self.equipMoList, equipMo)

	if index ~= -1 then
		recommendEqiuipMos[equipMo.equipId] = equipMo
	end
end

function CharacterEquipSettingListModel:setCurrentShowHeroMo(heroMo)
	self.currentShowHeroMo = heroMo
end

CharacterEquipSettingListModel.instance = CharacterEquipSettingListModel.New()

return CharacterEquipSettingListModel
