-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/model/ChuangJingRoadResBossFmtMo.lua

module("logic.extensions.chuangjingroad.model.ChuangJingRoadResBossFmtMo", package.seeall)

local ChuangJingRoadResBossFmtMo = class("ChuangJingRoadResBossFmtMo", BaseCustomFmtMo)

function ChuangJingRoadResBossFmtMo:initParams(activityId)
	self.activityId = activityId

	local cfg = ChuangJingRoadConfig.instance:getActivityCfgById(activityId) or {}

	self.creepsMasterId = cfg.bossCreepsMasterId
	self.masterCfg = ChuangJingRoadConfig.instance:getMonsterCfgById(self.creepsMasterId) or {}
	self.creeps = ChuangJingRoadConfig.instance:getCreepsCfgById(self.creepsMasterId) or {}

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "ChuangJingRoadResBossFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true

	self:clearAllPetList()
end

function ChuangJingRoadResBossFmtMo:initPetList()
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

function ChuangJingRoadResBossFmtMo:getMonsterConfigList()
	return self.creeps
end

function ChuangJingRoadResBossFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function ChuangJingRoadResBossFmtMo:initFightHandler()
	self:setFightHandler(function()
		local info = ChuangJingRoadModel.instance:getInfo(self.activityId) or {}
		local todayPaidBoss = checkbool(info.todayPaidBoss)

		if todayPaidBoss then
			UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
			ChuangJingRoadController.instance:sendResBossFight(self.activityId, self:getCurSimpleForm())
		else
			local cfg = ChuangJingRoadConfig.instance:getActivityCfgById(self.activityId) or {}
			local type, id, num = MaterialMgr.getMatParams(cfg.fightBossCost)
			local name = MaterialMgr.getMaterialsName(type, id)
			local content = langPara("每日首次挑战要消耗%s%s，确定要进行挑战吗？", num, name)

			TipsFacade.instance:openPopupCostMatViewNew(type, id, num, content, function()
				UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
				ChuangJingRoadController.instance:sendResBossFight(self.activityId, self:getCurSimpleForm())
			end, nil, nil, nil, function()
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
			end)
		end
	end, nil)
end

function ChuangJingRoadResBossFmtMo:refreshPetList(changePetMoMap)
	return
end

return ChuangJingRoadResBossFmtMo
