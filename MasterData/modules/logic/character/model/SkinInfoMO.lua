-- chunkname: @modules/logic/character/model/SkinInfoMO.lua

module("modules.logic.character.model.SkinInfoMO", package.seeall)

local SkinInfoMO = pureTable("SkinInfoMO")

function SkinInfoMO:init(info)
	self.skin = info.skin
	self.expireSec = info.expireSec
end

return SkinInfoMO
