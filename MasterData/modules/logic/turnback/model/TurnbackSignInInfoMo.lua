-- chunkname: @modules/logic/turnback/model/TurnbackSignInInfoMo.lua

module("modules.logic.turnback.model.TurnbackSignInInfoMo", package.seeall)

local TurnbackSignInInfoMo = pureTable("TurnbackSignInInfoMo")

function TurnbackSignInInfoMo:ctor()
	self.turnbackId = 0
	self.id = 0
	self.state = 0
	self.config = nil
end

function TurnbackSignInInfoMo:init(info, turnbackId)
	self.turnbackId = turnbackId
	self.id = info.id
	self.state = info.state
	self.config = TurnbackConfig.instance:getTurnbackSignInDayCo(self.turnbackId, self.id)
end

function TurnbackSignInInfoMo:updateState(state)
	self.state = state
end

return TurnbackSignInInfoMo
