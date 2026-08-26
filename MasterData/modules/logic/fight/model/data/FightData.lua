-- chunkname: @modules/logic/fight/model/data/FightData.lua

module("modules.logic.fight.model.data.FightData", package.seeall)

local FightData = FightDataClass("FightData")

function FightData:onConstructor(proto)
	self.attacker = FightTeamData.New(proto.attacker)
	self.defender = FightTeamData.New(proto.defender)
	self.curRound = proto.curRound
	self.maxRound = proto.maxRound
	self.isFinish = proto.isFinish
	self.curWave = proto.curWave
	self.battleId = proto.battleId

	if proto:HasField("magicCircle") then
		self.magicCircle = FightMagicCircleInfoData.New(proto.magicCircle)
	end

	self.version = proto.version
	self.isRecord = proto.isRecord
	self.episodeId = proto.episodeId
	self.fightActType = proto.fightActType
	self.lastChangeHeroUid = proto.lastChangeHeroUid
	self.progress = proto.progress
	self.progressMax = proto.progressMax
	self.param = FightParamData.New(proto.param)
	self.customData = FightCustomData.New(proto.customData)
	self.fightTaskBox = FightTaskBoxData.New(proto.fightTaskBox)
	self.progressDic = FightProgressInfoData.New(proto.progressList)
end

return FightData
