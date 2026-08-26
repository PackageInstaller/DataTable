-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheOutsidePropMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheOutsidePropMo", package.seeall)

local SodacheOutsidePropMo = pureTable("SodacheOutsidePropMo")

function SodacheOutsidePropMo:init(data)
	self.level = data.level
	self.exp = data.exp
	self.clientData = data.clientData
	self.rookie = data.rookie
end

function SodacheOutsidePropMo:updateProp(level, exp)
	self.oldExp = self.exp

	if level > self.level then
		self.oldLevel = self.level
	end

	self.level = level
	self.exp = exp
end

function SodacheOutsidePropMo:clearOldLevel()
	self.oldLevel = nil
end

function SodacheOutsidePropMo:clearOldExp()
	self.oldExp = nil
end

return SodacheOutsidePropMo
