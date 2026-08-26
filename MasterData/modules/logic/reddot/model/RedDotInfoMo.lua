-- chunkname: @modules/logic/reddot/model/RedDotInfoMo.lua

module("modules.logic.reddot.model.RedDotInfoMo", package.seeall)

local RedDotInfoMo = pureTable("RedDotInfoMo")

function RedDotInfoMo:init(info)
	self.uid = tonumber(info.id)
	self.value = tonumber(info.value)
	self.time = info.time
	self.ext = info.ext
end

function RedDotInfoMo:reset(info)
	self.value = tonumber(info.value)
	self.time = info.time
	self.ext = info.ext
end

return RedDotInfoMo
