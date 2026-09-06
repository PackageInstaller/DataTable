-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/model/ChuangJingRoadLightBossFmtMo.lua

module("logic.extensions.chuangjingroad.model.ChuangJingRoadLightBossFmtMo", package.seeall)

local ChuangJingRoadLightBossFmtMo = class("ChuangJingRoadLightBossFmtMo", BaseCustomFmtMo)

function ChuangJingRoadLightBossFmtMo:initParams(activityId, zoneId)
	self.activityId = activityId
	self.zoneId = zoneId

	local cfg = ChuangJingRoadConfig.instance:getLightBossCfgById(activityId, zoneId) or {}

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = ChuangJingRoadConfig.instance:getMonsterCfgById(self.creepsMasterId) or {}
	self.creeps = ChuangJingRoadConfig.instance:getCreepsCfgById(self.creepsMasterId) or {}

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "ChuangJingRoadLightBossFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true

	self:clearAllPetList()
end

function ChuangJingRoadLightBossFmtMo:initPetList()
	local petsMap = ChuangJingRoadModel.instance:getPetMoMap(self.activityId) or {}
	local info = ChuangJingRoadModel.instance:getPetInfo(self.activityId) or {}

	if not info.unlockCreepIds then
		local unlockCreepIds = {}
		local level = checknumber(info.level)
		local awakenLv = checknumber(info.awakenLv)
		local equipmentLv = checknumber(info.equipmentLv)
		local starGodPlusLv = checknumber(info.starGodPlusLv)
		local holyStripeLv = checknumber(info.holyStripeLv)

		for i, petId in ipairs(unlockCreepIds) do
			local petMo = petsMap[petId]

			if petMo then
				petMo = ChuangJingRoadModel.instance:updatePetMo(self.activityId, petMo, level, awakenLv, equipmentLv, starGodPlusLv, holyStripeLv)

				self:addPetToList(self:_changePetMo(petMo))
			end
		end
	end
end

function ChuangJingRoadLightBossFmtMo:getMonsterConfigList()
	return self.creeps
end

function ChuangJingRoadLightBossFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function ChuangJingRoadLightBossFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		ChuangJingRoadController.instance:sendLightBossFight(self.activityId, self.zoneId, self:getCurSimpleForm())
	end, nil)
end

function ChuangJingRoadLightBossFmtMo:refreshPetList(changePetMoMap)
	return
end

return ChuangJingRoadLightBossFmtMo
