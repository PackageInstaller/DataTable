-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/model/ChuangJingRoadChallengeFmtMo.lua

module("logic.extensions.chuangjingroad.model.ChuangJingRoadChallengeFmtMo", package.seeall)

local ChuangJingRoadChallengeFmtMo = class("ChuangJingRoadChallengeFmtMo", BaseCustomFmtMo)

function ChuangJingRoadChallengeFmtMo:initParams(activityId, zoneId, stageId)
	self.activityId = activityId
	self.zoneId = zoneId
	self.stageId = stageId

	local cfg = ChuangJingRoadConfig.instance:getStageConfigById(activityId, zoneId, stageId) or {}

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = ChuangJingRoadConfig.instance:getMonsterCfgById(self.creepsMasterId) or {}
	self.creeps = ChuangJingRoadConfig.instance:getCreepsCfgById(self.creepsMasterId) or {}

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "ChuangJingRoadChallengeFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true

	self:clearAllPetList()
end

function ChuangJingRoadChallengeFmtMo:initPetList()
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

function ChuangJingRoadChallengeFmtMo:getMonsterConfigList()
	return self.creeps
end

function ChuangJingRoadChallengeFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function ChuangJingRoadChallengeFmtMo:initFightHandler()
	self:setFightHandler(function()
		local cfg = ChuangJingRoadConfig.instance:getStageConfigById(self.activityId, self.zoneId, self.stageId) or {}
		local type, id, num = MaterialMgr.getMatParams(cfg.cost)
		local name = MaterialMgr.getMaterialsName(type, id)
		local content = langPara("确定要消耗%s%s进行挑战吗？", num, name)

		TipsFacade.instance:openPopupCostMatViewNew(type, id, num, content, function()
			UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
			ChuangJingRoadController.instance:sendChallengeFight(self.activityId, self.zoneId, self.stageId, self:getCurSimpleForm())
		end, nil, nil, nil, function()
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
		end)
	end, nil)
end

function ChuangJingRoadChallengeFmtMo:getExtendViewName()
	return ViewName.ChuangjingroadextView
end

function ChuangJingRoadChallengeFmtMo:refreshPetList(changePetMoMap)
	return
end

return ChuangJingRoadChallengeFmtMo
