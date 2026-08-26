-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheInsidePropMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheInsidePropMo", package.seeall)

local SodacheInsidePropMo = pureTable("SodacheInsidePropMo")

function SodacheInsidePropMo:init(data)
	self.mapId = data.mapId
	self.copyId = data.copyId
	self.timeCardId = data.timeCardId
	self.offerRelicIds = data.offerRelicIds
	self.status = data.status
	self.win = data.win
	self.clientData = data.clientData
	self.battleInfo = GameUtil.rpcInfoToMo(data.battleInfo, SodacheBattleInfoMo, self.battleInfo)
	self.bossCareerIds = data.bossCareerIds
	self.escapeCardCountLimit = data.escapeCardCountLimit
	self.altarSkillIds = data.altarSkillIds
	self.hotfix = data.hotfix
end

return SodacheInsidePropMo
