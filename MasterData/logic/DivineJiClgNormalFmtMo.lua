-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/model/DivineJiClgNormalFmtMo.lua

module("logic.extensions.divinejiclg.model.DivineJiClgNormalFmtMo", package.seeall)

local DivineJiClgNormalFmtMo = class("DivineJiClgNormalFmtMo", BaseCustomFmtMo)

function DivineJiClgNormalFmtMo:initParams(activityId, creepsMasterId, teamOrderId)
	self.activityId = activityId
	self.useMaxFightPower = true
	self.creepsMasterId = creepsMasterId
	self.teamOrderId = teamOrderId
	self.creepCfg = DivineJiClgConfig.instance:getNormalCreepsCfgByCreepsId(self.creepsMasterId)
	self.masterCfg = DivineJiClgConfig.instance:getNormalCreepsMasterCfgByCreepsId(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "DivineJiClgNormalFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
end

function DivineJiClgNormalFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function DivineJiClgNormalFmtMo:getMonsterConfigList()
	return self.creepCfg
end

function DivineJiClgNormalFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function DivineJiClgNormalFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		DivineJiClgController.instance:sendNormalClgStartFight(self.activityId, self, self:getCurSimpleForm())
	end, nil)
end

return DivineJiClgNormalFmtMo
