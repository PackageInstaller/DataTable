-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanshenglong/model/CiyuanshenglongFmtMo.lua

module("logic.extensions.ciyuanshenglong.model.CiyuanshenglongFmtMo", package.seeall)

local CiyuanshenglongFmtMo = class("CiyuanshenglongFmtMo", ICustomFmtMo)

function CiyuanshenglongFmtMo:onReset()
	CiyuanshenglongFmtMo.super.onReset(self)
end

function CiyuanshenglongFmtMo:initParams(params)
	self.activityId = params.activityId
	self.stageId = params.stageId

	local cfg = CiyuanshenglongConfig.instance:getStageCfgById(self.activityId, self.stageId) or {}

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = CiyuanshenglongConfig.instance:getMonsterCfgById(cfg.creepsMasterId)
	self.creeps = CiyuanshenglongConfig.instance:getCreepsCfg(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_First
	self.strShowRuleFlagKey = "CiyuanshenglongFmtMo_" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
end

function CiyuanshenglongFmtMo:initFightHandler()
	self:setFightHandler(function()
		CiyuanshenglongController.instance:sendStartFight(self.activityId, self.stageId, self:getCurSimpleForm())
	end, nil)
end

function CiyuanshenglongFmtMo:getMonsterConfigList()
	return self.creeps
end

function CiyuanshenglongFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function CiyuanshenglongFmtMo:initPetList()
	self:clearAllPetList()

	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function CiyuanshenglongFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

return CiyuanshenglongFmtMo
