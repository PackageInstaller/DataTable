-- chunkname: @modules/logic/equip/model/EquipSkillCharacterListModel.lua

module("modules.logic.equip.model.EquipSkillCharacterListModel", package.seeall)

local EquipSkillCharacterListModel = class("EquipSkillCharacterListModel", ListScrollModel)

EquipSkillCharacterListModel.instance = EquipSkillCharacterListModel.New()

return EquipSkillCharacterListModel
