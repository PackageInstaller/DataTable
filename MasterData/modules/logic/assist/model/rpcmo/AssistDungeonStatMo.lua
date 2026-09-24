-- chunkname: @modules/logic/assist/model/rpcmo/AssistDungeonStatMo.lua

module("modules.logic.assist.model.rpcmo.AssistDungeonStatMo", package.seeall)

local AssistDungeonStatMo = pureTable("AssistDungeonStatMo")

function AssistDungeonStatMo:init(info)
	self.type = info.type
	self.count = info.count
	self.maxResult = info.maxResult
end

return AssistDungeonStatMo
