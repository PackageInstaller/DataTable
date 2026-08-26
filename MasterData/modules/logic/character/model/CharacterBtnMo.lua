-- chunkname: @modules/logic/character/model/CharacterBtnMo.lua

module("modules.logic.character.model.CharacterBtnMo", package.seeall)

local CharacterBtnMo = pureTable("CharacterBtnMo")

function CharacterBtnMo:ctor()
	self.id = 0
	self.name = ""
	self.icon = ""
end

function CharacterBtnMo:init(info)
	self.id = info.id
	self.name = info.name
	self.icon = info.iconres
end

return CharacterBtnMo
