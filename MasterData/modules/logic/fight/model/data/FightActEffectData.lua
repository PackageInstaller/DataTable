-- chunkname: @modules/logic/fight/model/data/FightActEffectData.lua

module("modules.logic.fight.model.data.FightActEffectData", package.seeall)

local FightActEffectData = FightDataClass("FightActEffectData")
local idCounter = 1

function FightActEffectData:onConstructor(proto)
	self.clientId = idCounter
	idCounter = idCounter + 1

	self:initClientData()

	if not proto then
		return
	end

	self.targetId = proto.targetId
	self.effectType = proto.effectType
	self.effectNum = proto.effectNum

	if proto:HasField("buff") then
		self.buff = FightBuffInfoData.New(proto.buff, self.targetId)
	end

	if proto:HasField("entity") then
		self.entity = FightEntityInfoData.New(proto.entity)
	end

	self.configEffect = proto.configEffect
	self.buffActId = proto.buffActId
	self.reserveId = proto.reserveId
	self.reserveStr = proto.reserveStr

	if proto:HasField("summoned") then
		self.summoned = FightSummonedInfoData.New(proto.summoned)
	end

	if proto:HasField("magicCircle") then
		self.magicCircle = FightMagicCircleInfoData.New(proto.magicCircle)
	end

	if proto:HasField("cardInfo") then
		self.cardInfo = FightCardInfoData.New(proto.cardInfo)
	end

	self.cardInfoList = {}

	for i, v in ipairs(proto.cardInfoList) do
		table.insert(self.cardInfoList, FightCardInfoData.New(v))
	end

	self.teamType = proto.teamType

	if proto:HasField("fightStep") then
		self.fightStep = FightStepData.New(proto.fightStep)
	end

	if proto:HasField("assistBossInfo") then
		self.assistBossInfo = FightAssistBossInfoData.New(proto.assistBossInfo)
	end

	self.effectNum1 = proto.effectNum1

	if proto:HasField("emitterInfo") then
		self.emitterInfo = FightEmitterInfoData.New(proto.emitterInfo)
	end

	if proto:HasField("playerFinisherInfo") then
		self.playerFinisherInfo = FightPlayerFinisherInfoData.New(proto.playerFinisherInfo)
	end

	if proto:HasField("powerInfo") then
		self.powerInfo = FightPowerInfoData.New(proto.powerInfo)
	end

	if proto:HasField("cardHeatValue") then
		self.cardHeatValue = FightCardHeatValueData.New(proto.cardHeatValue)
	end

	self.fightTasks = {}

	for i, v in ipairs(proto.fightTasks) do
		table.insert(self.fightTasks, FightTaskData.New(v))
	end

	if proto:HasField("fight") then
		self.fight = FightData.New(proto.fight)
	end

	if proto:HasField("buffActInfo") then
		self.buffActInfo = FightBuffActInfoData.New(proto.buffActInfo)
	end

	if proto:HasField("hurtInfo") then
		self.hurtInfo = FightHurtInfoData.New(proto.hurtInfo)
	end

	if proto:HasField("rouge2FightMusicInfo") then
		self.rouge2MusicInfo = FightRouge2MusicInfo.New(proto.rouge2FightMusicInfo)
	end

	if proto:HasField("deviceAreaInfo") then
		self.deviceAreaInfo = FightDeviceAreaInfoData.New(proto.deviceAreaInfo)
	end

	if proto:HasField("jsonParam") then
		self.jsonParam = cjson.decode(proto.jsonParam)
	end
end

function FightActEffectData:isDone()
	return self.CUSTOM_ISDONE
end

function FightActEffectData:setDone()
	self.CUSTOM_ISDONE = true
end

function FightActEffectData:revertDone()
	self.CUSTOM_ISDONE = false
end

function FightActEffectData:initClientData()
	self.custom_nuoDiKaDamageSign = nil
end

return FightActEffectData
