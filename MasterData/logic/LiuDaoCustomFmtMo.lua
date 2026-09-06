-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liudao/model/LiuDaoCustomFmtMo.lua

module("logic.extensions.liudao.model.LiuDaoCustomFmtMo", package.seeall)

local LiuDaoCustomFmtMo = class("LiuDaoCustomFmtMo", ICustomFmtMo)

LiuDaoCustomFmtMo.ReadFlag = "LiuDaoCustomFmtMo.ReadFlag"

function LiuDaoCustomFmtMo:initParams(activityId, stageType, stageIndex, posIndex)
	self._stageType = stageType
	self._stageIndex = stageIndex
	self._activityId = activityId

	if self._stageType == "daily" then
		local dailyStages = LiuDaoModel.instance:getDailyStage()

		self._stage = dailyStages[self._stageIndex]
	else
		local weekStages = LiuDaoModel.instance:getWeeklyStage()

		self._stage = weekStages[self._stageIndex]
	end

	self._stageCfg = LiuDaoConfig.instance:getStageCfg(self._activityId, self._stage)
	self._masterList = LiuDaoConfig.instance:getMonsterTeamCfg(self._stageCfg.creepsMasterId)
	self._cfgEnemy = LiuDaoConfig.instance:getMonsterCfg(self._stageCfg.creepsMasterId)

	LiuDaoModel.instance:saveTempIdx(posIndex)
end

function LiuDaoCustomFmtMo:updateData()
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.ruleDesc
	self.isPopRuleDesc = true
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_DailyOnce
	self.strShowRuleFlagKey = LiuDaoCustomFmtMo.ReadFlag .. "#RuleKey#" .. self._stage
	self.isHideFmtZdl = true

	self:setFormCondition(self._cfgEnemy.formCondition)
	self:initPetList()

	if LiuDaoModel.instance:getFmt() ~= nil then
		self.formationMo = LiuDaoModel.instance:getFmt()
	end
end

function LiuDaoCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:pushOneStack(ViewName.LiuDaoMainView, true)

		local simpleForm = self:getCurSimpleForm()

		LiuDaoModel.instance:saveFmt(self:getCurFormation())
		LiuDaoAgent.instance:sendPM_LiuDaoChallengeReq(self._activityId, self._stageType, self._stageIndex - 1, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function LiuDaoCustomFmtMo:initPetList()
	self:clearAllPetList()

	local bagPetMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(bagPetMoList) do
		self:addPetToList(petMo)
	end
end

function LiuDaoCustomFmtMo:getMonsterConfigList()
	return self._masterList
end

function LiuDaoCustomFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function LiuDaoCustomFmtMo:initSaveHandler()
	local function handler()
		return
	end

	self:setSaveHandler(handler, nil)
end

return LiuDaoCustomFmtMo
