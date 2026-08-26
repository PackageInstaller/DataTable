-- chunkname: @modules/logic/antique/model/AntiqueMo.lua

module("modules.logic.antique.model.AntiqueMo", package.seeall)

local AntiqueMo = pureTable("AntiqueMo")

function AntiqueMo:ctor()
	self.id = 0
	self.getTime = 0
end

function AntiqueMo:init(info)
	self.id = tonumber(info.antiqueId)
	self.getTime = info.getTime
end

function AntiqueMo:reset(info)
	self.id = tonumber(info.antiqueId)
	self.getTime = info.getTime
end

return AntiqueMo
