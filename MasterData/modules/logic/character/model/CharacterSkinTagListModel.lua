-- chunkname: @modules/logic/character/model/CharacterSkinTagListModel.lua

module("modules.logic.character.model.CharacterSkinTagListModel", package.seeall)

local CharacterSkinTagListModel = class("CharacterSkinTagListModel", ListScrollModel)

function CharacterSkinTagListModel:updateList(config)
	local moList = {}

	if string.nilorempty(config.storeTag) == false then
		local arr = string.splitToNumber(config.storeTag, "|")

		for i, v in ipairs(arr) do
			table.insert(moList, SkinConfig.instance:getSkinStoreTagConfig(v))
		end
	end

	self:setList(moList)
end

CharacterSkinTagListModel.instance = CharacterSkinTagListModel.New()

return CharacterSkinTagListModel
