-- chunkname: @modules/logic/fight/model/data/FightEntityInfoData.lua

module("modules.logic.fight.model.data.FightEntityInfoData", package.seeall)

local FightEntityInfoData = FightDataClass("FightEntityInfoData")

function FightEntityInfoData:onConstructor(proto)
	self.id = proto.uid
	self.uid = proto.uid
	self.modelId = proto.modelId
	self.skin = proto.skin
	self.position = proto.position
	self.entityType = proto.entityType
	self.userId = proto.userId
	self.exPoint = proto.exPoint
	self.level = proto.level
	self.currentHp = proto.currentHp
	self.attr = FightHeroAttributeData.New(proto.attr)
	self.buffs = {}

	for i, oneBuffProto in ipairs(proto.buffs) do
		table.insert(self.buffs, FightBuffInfoData.New(oneBuffProto, self.id))
	end

	self.skillGroup1 = {}

	for i, v in ipairs(proto.skillGroup1) do
		table.insert(self.skillGroup1, v)
	end

	self.skillGroup2 = {}

	for i, v in ipairs(proto.skillGroup2) do
		table.insert(self.skillGroup2, v)
	end

	self.passiveSkill = {}

	for i, v in ipairs(proto.passiveSkill) do
		table.insert(self.passiveSkill, v)
	end

	self.exSkill = proto.exSkill
	self.shieldValue = proto.shieldValue
	self.expointMaxAdd = proto.expointMaxAdd
	self.equipUid = proto.equipUid

	if proto:HasField("trialEquip") then
		local trialEquip = proto.trialEquip

		self.trialEquip = {}
		self.trialEquip.equipUid = trialEquip.equipUid
		self.trialEquip.equipId = trialEquip.equipId
		self.trialEquip.equipLv = trialEquip.equipLv
		self.trialEquip.refineLv = trialEquip.refineLv
	end

	self.exSkillLevel = proto.exSkillLevel
	self.powerInfos = {}

	for i, v in ipairs(proto.powerInfos) do
		local powerData = FightPowerInfoData.New(v)

		table.insert(self.powerInfos, powerData)
	end

	self.act104EquipUids = {}

	for i, v in ipairs(proto.act104EquipUids) do
		table.insert(self.act104EquipUids, v)
	end

	self.SummonedList = {}

	for i, v in ipairs(proto.SummonedList) do
		table.insert(self.SummonedList, FightSummonedInfoData.New(v))
	end

	self.exSkillPointChange = proto.exSkillPointChange
	self.teamType = proto.teamType

	if proto:HasField("enhanceInfoBox") then
		self.enhanceInfoBox = FightEnhanceInfoBoxData.New(proto.enhanceInfoBox)
	end

	self.trialId = proto.trialId
	self.career = proto.career
	self.status = proto.status
	self.guard = proto.guard
	self.subCd = proto.subCd
	self.exPointType = proto.exPointType

	local equipData = proto.equips[1]

	if equipData then
		self.equipRecord = FightEquipRecordData.New(equipData)
	end

	if proto:HasField("destinyStone") and proto:HasField("destinyRank") then
		self.destinyStone = proto.destinyStone
		self.destinyRank = proto.destinyRank
	end

	self.customUnitId = proto.customUnitId
	self.weakCareers = {}

	for i, v in ipairs(proto.weakCareers) do
		table.insert(self.weakCareers, v)
	end

	self.toughnessValue = proto.toughnessValue
	self.toughnessPoint = proto.toughnessPoint
	self.isBroken = proto.isBroken
	self.exPointMax = proto.exPointMax
end

return FightEntityInfoData
