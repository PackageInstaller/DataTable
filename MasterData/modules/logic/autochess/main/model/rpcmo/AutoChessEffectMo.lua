-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessEffectMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessEffectMo", package.seeall)

local AutoChessEffectMo = pureTable("AutoChessEffectMo")

function AutoChessEffectMo:init(data)
	self.effectType = data.effectType
	self.fromId = data.fromId
	self.targetId = data.targetId
	self.effectNum = data.effectNum
	self.extraData = data.extraData
	self.chessList = GameUtil.rpcInfosToList(data.chessList, AutoChessMo)
	self.nextFightStep = GameUtil.rpcInfoToMo(data.nextFightStep, AutoChessFightStepMo)
	self.targetIds = data.targetIds
	self.region = data.region
	self.fight = data.fight
	self.effectString = data.effectString

	if data.buff.id ~= 0 then
		self.buff = GameUtil.rpcInfoToMo(data.buff, AutoChessBuffMo)
	end

	if data.master.id ~= 0 then
		self.master = GameUtil.rpcInfoToMo(data.master, AutoChessMasterMo)
	end
end

return AutoChessEffectMo
