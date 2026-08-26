-- chunkname: @modules/logic/fight/model/data/FightTeamData.lua

module("modules.logic.fight.model.data.FightTeamData", package.seeall)

local FightTeamData = FightDataClass("FightTeamData")

function FightTeamData:onConstructor(proto)
	self.entitys = {}

	for i, v in ipairs(proto.entitys) do
		table.insert(self.entitys, FightEntityInfoData.New(v))
	end

	self.subEntitys = {}

	for i, v in ipairs(proto.subEntitys) do
		table.insert(self.subEntitys, FightEntityInfoData.New(v))
	end

	self.power = proto.power
	self.clothId = proto.clothId
	self.skillInfos = {}

	for i, v in ipairs(proto.skillInfos) do
		table.insert(self.skillInfos, FightPlayerSkillInfoData.New(v))
	end

	self.spEntitys = {}

	for i, v in ipairs(proto.spEntitys) do
		table.insert(self.spEntitys, FightEntityInfoData.New(v))
	end

	self.indicators = {}

	for i, v in ipairs(proto.indicators) do
		table.insert(self.indicators, FightIndicatorInfoData.New(v))
	end

	self.exTeamStr = proto.exTeamStr

	if proto:HasField("assistBoss") then
		self.assistBoss = FightEntityInfoData.New(proto.assistBoss)
	end

	if proto:HasField("assistBossInfo") then
		self.assistBossInfo = FightAssistBossInfoData.New(proto.assistBossInfo)
	end

	if proto:HasField("emitter") then
		self.emitter = FightEntityInfoData.New(proto.emitter)
	end

	if proto:HasField("emitterInfo") then
		self.emitterInfo = FightEmitterInfoData.New(proto.emitterInfo)
	end

	if proto:HasField("playerEntity") then
		self.playerEntity = FightEntityInfoData.New(proto.playerEntity)
	end

	if proto:HasField("playerFinisherInfo") then
		self.playerFinisherInfo = FightPlayerFinisherInfoData.New(proto.playerFinisherInfo)
	end

	self.energy = proto.energy

	if proto:HasField("cardHeat") then
		self.cardHeat = FightCardHeatInfoData.New(proto.cardHeat)
	end

	self.cardDeckSize = proto.cardDeckSize

	if proto:HasField("bloodPool") then
		self.bloodPool = FightDataBloodPool.New(proto.bloodPool)
	end

	if proto:HasField("heatScale") then
		self.heatScale = FightDataHeatScale.New(proto.heatScale)
	end

	if proto:HasField("vorpalith") then
		self.vorpalith = FightEntityInfoData.New(proto.vorpalith)
	end

	if proto:HasField("itemSkillGroup") then
		self.itemSkillInfos = {}

		for i, v in ipairs(proto.itemSkillGroup.itemSkillInfos) do
			table.insert(self.itemSkillInfos, FightItemPlayerSkillInfoData.New(v))
		end
	end

	self.spFightEntities = {}

	for i, v in ipairs(proto.spFightEntities) do
		table.insert(self.spFightEntities, FightEntityInfoData.New(v))
	end

	if proto:HasField("musicInfo") then
		self.rouge2MusicInfo = FightRouge2MusicInfo.New(proto.musicInfo)
	end

	self.deviceCardDeckSize = proto.deviceCardDeckSize

	if proto:HasField("deviceArea") then
		self.deviceArea = FightDeviceAreaInfoData.New(proto.deviceArea)
	end
end

return FightTeamData
