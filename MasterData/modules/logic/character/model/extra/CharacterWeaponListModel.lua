-- chunkname: @modules/logic/character/model/extra/CharacterWeaponListModel.lua

module("modules.logic.character.model.extra.CharacterWeaponListModel", package.seeall)

local CharacterWeaponListModel = class("CharacterWeaponListModel", MixScrollModel)

function CharacterWeaponListModel:setMoList(heroMo)
	local moList = self:getMoList(heroMo)

	self:setList(moList)
end

function CharacterWeaponListModel:getMoList(heroMo)
	local coList = CharacterExtraConfig.instance:getEzioWeaponGroupConfigTable().configList
	local moList = {}
	local exSkillLevel = heroMo.exSkillLevel

	for i, co in ipairs(coList) do
		if co.secondId ~= 0 and co.skillLevel == exSkillLevel then
			local mo = CharacterWeaponEffectMO.New()

			mo:initMo(co)
			table.insert(moList, mo)
		end
	end

	return moList
end

CharacterWeaponListModel.instance = CharacterWeaponListModel.New()

return CharacterWeaponListModel
