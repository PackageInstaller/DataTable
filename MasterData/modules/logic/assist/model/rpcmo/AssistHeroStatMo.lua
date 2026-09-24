-- chunkname: @modules/logic/assist/model/rpcmo/AssistHeroStatMo.lua

module("modules.logic.assist.model.rpcmo.AssistHeroStatMo", package.seeall)

local AssistHeroStatMo = pureTable("AssistHeroStatMo")

function AssistHeroStatMo:init(info)
	self.heroUid = info.heroUid
	self.count = info.count
end

return AssistHeroStatMo
