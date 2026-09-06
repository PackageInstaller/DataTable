-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/villaintrial/model/VillaintrialModel.lua

module("logic.extensions.villaintrial.model.VillaintrialModel", package.seeall)

local VillaintrialModel = class("VillaintrialModel", BaseModel)

function VillaintrialModel:ctor()
	VillaintrialModel.super.ctor(self)

	self.curLevel = 1
	self.curTeamId = 1
	self.villaintrialMainInfo = {}
	self.villaintrialRankInfo = {}
	self.villaintrialEquipInfo = {}
end

function VillaintrialModel:onInit()
	VillaintrialModel.super.onInit(self)
	self:onReset()
end

function VillaintrialModel:onReset()
	self.curSelectStageId = 0
end

function VillaintrialModel:setVillaintrialMainInfo(msg)
	self.villaintrialMainInfo = msg

	self:setCurTeamId(msg.curTeamId)
end

function VillaintrialModel:getVillaintrialMainInfo()
	return self.villaintrialMainInfo
end

function VillaintrialModel:setVillaintrialRankInfo(msg)
	self.villaintrialRankInfo = msg
end

function VillaintrialModel:getVillaintrialRankInfo()
	return self.villaintrialRankInfo
end

function VillaintrialModel:setVillaintrialEquipInfo(msg)
	self.villaintrialEquipInfo = msg
end

function VillaintrialModel:getVillaintrialEquipInfo()
	return self.villaintrialEquipInfo
end

function VillaintrialModel:setCurTeamId(teamId)
	self.curTeamId = checknumber(teamId)
end

function VillaintrialModel:getCurTeamId()
	return self.curTeamId
end

function VillaintrialModel:isAboveThreeLevel()
	local stageCfg = VillaintrialConfig.instance:getStageCfg(self.villaintrialMainInfo.curStagePlanId, self:getCurStageId())

	return stageCfg.isLayout
end

function VillaintrialModel:setCurSelectStageId(stageId)
	self.curSelectStageId = checknumber(stageId)
end

function VillaintrialModel:getCurSelectStageId()
	return self.curSelectStageId > 5 and 5 or self.curSelectStageId
end

function VillaintrialModel:setCurStageId(stageId)
	self.curLevel = checknumber(stageId)
end

function VillaintrialModel:getCurStageId()
	if self.curLevel > 5 and self:getCurSelectStageId() > 0 then
		return self:getCurSelectStageId()
	end

	return self.curLevel > 5 and 5 or self.curLevel
end

function VillaintrialModel:getCreepsMasterId()
	local stagePlanId = self.villaintrialMainInfo.curStagePlanId
	local stageCfg = VillaintrialConfig.instance:getStageCfg(stagePlanId, self:getCurStageId())

	if stageCfg then
		return stageCfg.creepsMasterIds[1]
	end

	return nil
end

function VillaintrialModel:GetAllPetList()
	if self._allPetList == nil then
		self:initPetList()
	end

	return self._allPetList
end

function VillaintrialModel:initPetList()
	local pets = VillaintrialConfig.instance:getVillainPets(self.curTeamId)
	local list = {}

	self._curPetMap = {}

	if not pets then
		printError("系统精灵的组别id或者配置是不是有问题啊", self.curTeamId)
	end

	for k, v in pairs(pets) do
		if v then
			local petMo = self:getPet(v)

			table.insert(list, petMo)

			self._curPetMap[petMo.petId] = petMo
		end
	end

	if self:isAboveThreeLevel() then
		local pets = VillaintrialConfig.instance:getRandomPets(self.curTeamId)

		for i, petId in ipairs(pets) do
			local petCfg = VillaintrialConfig.instance:getSsSupportCfgByCSId(petId)

			if petCfg then
				local petMo = self:getPet(petCfg)

				table.insert(list, petMo)

				self._curPetMap[petMo.petId] = petMo
			end
		end
	end

	self._allPetList = list
end

function VillaintrialModel:getPet(petCfg)
	local fMo = FightingPowerPetMo.New()

	fMo:fromChallengeCreepCo(petCfg)

	return (fMo:toBaseBagPetMo())
end

function VillaintrialModel:onResetInfo()
	self.formationMo = nil
	self._allPetList = nil
	self._curPetMap = nil
end

function VillaintrialModel:GetCurFormation()
	if self:isAboveThreeLevel() then
		return self:isLayoutFMo()
	end

	return self:notLayotFmo()
end

function VillaintrialModel:isLayoutFMo()
	self.isLayoutFmo = self.isLayoutFmo or FormationMO.New(GameUtil.handler(self.getPetMo, self))

	return self.isLayoutFmo
end

function VillaintrialModel:notLayotFmo()
	if not self.formationMo then
		self.formationMo = FormationMO.New(GameUtil.handler(self.getPetMo, self))

		self:_setPetPos()
	end

	return self.formationMo
end

function VillaintrialModel:getPetMo(petId)
	if self._allPetList == nil then
		self:initPetList()
	end

	if self._curPetMap then
		return self._curPetMap[petId]
	end

	return nil
end

function VillaintrialModel:_setPetPos()
	local pos = self.formationMo:GetPositions()
	local pets = VillaintrialConfig.instance:getVillainPets(self.curTeamId)

	for i, v in ipairs(pets) do
		self.formationMo:SetPosition(v.posId, v.creepsId)
	end
end

function VillaintrialModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = VillaintrialCustomFmtMo.New()
	end

	return self._customFmtMo
end

function VillaintrialModel:getMaxPetCount()
	local cfg = VillaintrialConfig.instance:getTeamCfg(self.curTeamId)

	if cfg then
		return cfg.formStrategy
	end

	return 5
end

VillaintrialModel.instance = VillaintrialModel.New()

return VillaintrialModel
