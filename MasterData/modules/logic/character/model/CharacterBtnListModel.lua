-- chunkname: @modules/logic/character/model/CharacterBtnListModel.lua

module("modules.logic.character.model.CharacterBtnListModel", package.seeall)

local CharacterBtnListModel = class("CharacterBtnListModel", ListScrollModel)

function CharacterBtnListModel:setCharacterBtnList(Infos)
	local moList = {}

	if Infos then
		for _, v in LuaUtil.pairsByKeys(Infos) do
			local btnMo = CharacterBtnMo.New()

			btnMo:init(v)
			table.insert(moList, btnMo)
		end
	end

	self:setList(moList)
end

CharacterBtnListModel.instance = CharacterBtnListModel.New()

return CharacterBtnListModel
