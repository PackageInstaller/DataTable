-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/model/ChuangJingRoadGrassBossFmtMo.lua

module("logic.extensions.chuangjingroad.model.ChuangJingRoadGrassBossFmtMo", package.seeall)

local ChuangJingRoadGrassBossFmtMo = class("ChuangJingRoadGrassBossFmtMo", BaseCustomFmtMo)

function ChuangJingRoadGrassBossFmtMo:initParams(activityId, zoneId, stageId)
	self.activityId = activityId
	self.zoneId = zoneId
	self.stageId = stageId

	local cfg = ChuangJingRoadConfig.instance:getGrassBossCfgById(activityId, zoneId, stageId) or {}

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = ChuangJingRoadConfig.instance:getMonsterCfgById(self.creepsMasterId) or {}
	self.creeps = ChuangJingRoadConfig.instance:getCreepsCfgById(self.creepsMasterId) or {}

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "ChuangJingRoadGrassBossFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true

	self:clearAllPetList()
end

function ChuangJingRoadGrassBossFmtMo:initPetList()
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

function ChuangJingRoadGrassBossFmtMo:getMonsterConfigList()
	return self.creeps
end

function ChuangJingRoadGrassBossFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function ChuangJingRoadGrassBossFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		ChuangJingRoadController.instance:sendGrassBossFight(self.activityId, self.zoneId, self.stageId, self:getCurSimpleForm())
	end, nil)
end

function ChuangJingRoadGrassBossFmtMo:refreshPetList(changePetMoMap)
	return
end

return ChuangJingRoadGrassBossFmtMo
