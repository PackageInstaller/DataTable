-- chunkname: @modules/logic/equip/model/EquipCategoryListModel.lua

module("modules.logic.equip.model.EquipCategoryListModel", package.seeall)

local EquipCategoryListModel = class("EquipCategoryListModel", ListScrollModel)

EquipCategoryListModel.ViewIndex = {
	EquipInfoViewIndex = 1,
	EquipRefineViewIndex = 3,
	EquipStrengthenViewIndex = 2,
	EquipStoryViewIndex = 4
}

function EquipCategoryListModel:initCategory(equipMO, config)
	local data = {}

	table.insert(data, self:packMo(luaLang("equip_lang_18"), luaLang("p_equip_35"), EquipCategoryListModel.ViewIndex.EquipInfoViewIndex))

	if equipMO and config.isExpEquip ~= 1 and config.id ~= EquipConfig.instance:getEquipUniversalId() and not EquipHelper.isSpRefineEquip(config) then
		table.insert(data, self:packMo(luaLang("equip_lang_19"), luaLang("p_equip_36"), EquipCategoryListModel.ViewIndex.EquipStrengthenViewIndex))
		table.insert(data, self:packMo(luaLang("equip_lang_21"), luaLang("p_equip_39"), EquipCategoryListModel.ViewIndex.EquipRefineViewIndex))
	end

	table.insert(data, self:packMo(luaLang("equip_lang_20"), luaLang("p_equip_38"), EquipCategoryListModel.ViewIndex.EquipStoryViewIndex))
	self:setList(data)
end

function EquipCategoryListModel:packMo(cnName, enName, index)
	self._moList = self._moList or {}

	local t = self._moList[index]

	if not t then
		t = {}
		self._moList[index] = t
		t.cnName = cnName
		t.enName = enName
		t.resIndex = index
	end

	return t
end

EquipCategoryListModel.instance = EquipCategoryListModel.New()

return EquipCategoryListModel
