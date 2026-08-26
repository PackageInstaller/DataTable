-- chunkname: @modules/logic/fight/model/data/FightDouQuQuDataMgr.lua

module("modules.logic.fight.model.data.FightDouQuQuDataMgr", package.seeall)

local FightDouQuQuDataMgr = FightDataClass("FightDouQuQuDataMgr")

function FightDouQuQuDataMgr:onConstructor()
	return
end

function FightDouQuQuDataMgr:cachePlayIndex(tab)
	self.playIndexTab = tab
	self.maxIndex = 0

	for k, v in pairs(self.playIndexTab) do
		if v > self.maxIndex then
			self.maxIndex = v
		end
	end
end

function FightDouQuQuDataMgr:cacheFightProto(proto)
	self.proto = proto
	self.index = proto.index
	self.round = proto.round

	if proto.round == 0 then
		self.isFinish = proto.startRound.isFinish or proto.fightRound.isFinish
	end
end

function FightDouQuQuDataMgr:cacheGMProto(proto)
	self.gmProto = proto
end

return FightDouQuQuDataMgr
