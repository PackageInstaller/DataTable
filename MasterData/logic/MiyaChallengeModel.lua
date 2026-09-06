-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miyachallenge/model/MiyaChallengeModel.lua

module("logic.extensions.miyachallenge.model.MiyaChallengeModel", package.seeall)

local MiyaChallengeModel = class("MiyaChallengeModel", BaseModel)

MiyaChallengeModel.ReadFlag = "MiyaChallengeModel.ReadFlag"
MiyaChallengeModel.ActTypeMiya = 1
MiyaChallengeModel.ActTypeJieHuang = 2

function MiyaChallengeModel:ctor()
	self._activityId = 0
	self._tierId = 0
	self._firstFinishIds = nil
	self._secondFinishIds = nil
	self._thirdFinishIds = nil
	self._buyTime = 0
	self._bigStage = 0
	self._showStageId = 0
	self._showStageBuff = nil
	self._exchangeBuff = nil
end

function MiyaChallengeModel:onInit()
	self:onReset()
end

function MiyaChallengeModel:onReset()
	self._activityId = 0
	self._tierId = 0
	self._firstFinishIds = nil
	self._secondFinishIds = nil
	self._thirdFinishIds = nil
	self._damage = nil
	self._bigStagePass = {}
	self._stageSelect = {}
	self._passBigStage = nil
	self._buyTime = 0
	self._bigStage = 0
	self._showStageId = 0
	self._showStageBuff = nil
	self._exchangeBuff = nil

	RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_MIYACHALLENGE_ENTER)
end

function MiyaChallengeModel:setActivityId(activityId)
	self._activityId = activityId
end

function MiyaChallengeModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.MiyaChallenge)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.MiyaChallenge)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.MiyaChallenge, v.activityId) then
			local cfg = MiyaChallengeConfig.instance:getActivityCfg(v.activityId)

			if cfg then
				actId = cfg.activityId

				break
			end

			printError("====t_liu_dao_activity no cfg, id = " .. v, actId)

			break
		end
	end

	return actId
end

function MiyaChallengeModel:getMiyaTimeGateActivityId()
	return 218001
end

function MiyaChallengeModel:getJieHuangTimeGateActivityId()
	return 218002
end

function MiyaChallengeModel:setActiveData(msg)
	local data = GameUtil.pbToTable(msg)

	self._activityId = data.activityId
	self._tierId = data.tierId
	self._damage = data.firstMaxDamages

	local bigStagePassed = false

	self._firstFinishIds = {}

	if data.firstFinishIds then
		for i, v in ipairs(data.firstFinishIds) do
			self._firstFinishIds[v] = true
		end
	end

	self._secondFinishIds = {}

	if data.secondFinishIds then
		for i, v in ipairs(data.secondFinishIds) do
			self._secondFinishIds[v] = true
		end
	end

	self._thirdFinishIds = {}

	if data.thirdFinishIds then
		for i, v in ipairs(data.thirdFinishIds) do
			self._thirdFinishIds[v] = true
		end
	end

	self._actCfg = MiyaChallengeConfig.instance:getActivityCfg(self._activityId)
	self._tierCfg = MiyaChallengeConfig.instance:getTierStageCfg(self._actCfg.tierPlanId, self._tierId)

	if self._bigStagePass[1] == false then
		bigStagePassed = true
	end

	self._bigStagePass[1] = true

	local firstStageInfo = MiyaChallengeConfig.instance:getStagesCfg(self._tierCfg.firstPlanId)

	for i, v in ipairs(firstStageInfo) do
		if self._firstFinishIds[v.stageId] and self._stageSelect[1] and self._stageSelect[1] == v.stageId then
			self._stageSelect[1] = nil
		end
	end

	for i, v in ipairs(firstStageInfo) do
		if not self._firstFinishIds[v.stageId] then
			self._bigStagePass[1] = false
			self._stageSelect[1] = self._stageSelect[1] or v.stageId

			break
		end
	end

	if bigStagePassed == true and self._bigStagePass[1] == true then
		self._passBigStage = 1
	end

	if self._bigStagePass[2] == false then
		bigStagePassed = true
	end

	self._bigStagePass[2] = true

	local secondStageInfo = MiyaChallengeConfig.instance:getStagesCfg(self._tierCfg.secondPlanId)

	for i, v in ipairs(secondStageInfo) do
		if self._secondFinishIds[v.stageId] and self._stageSelect[2] and self._stageSelect[2] == v.stageId then
			self._stageSelect[2] = nil
		end
	end

	for i, v in ipairs(secondStageInfo) do
		if not self._secondFinishIds[v.stageId] then
			self._bigStagePass[2] = false
			self._stageSelect[2] = self._stageSelect[2] or v.stageId

			break
		end
	end

	if bigStagePassed == true and self._bigStagePass[2] == true then
		self._passBigStage = 2
	end

	if self._bigStagePass[3] == false then
		bigStagePassed = true
	end

	self._bigStagePass[3] = true

	local thirdStageInfo = MiyaChallengeConfig.instance:getStagesCfg(self._tierCfg.thirdPlanId)

	for i, v in ipairs(thirdStageInfo) do
		if self._thirdFinishIds[v.stageId] and self._stageSelect[3] and self._stageSelect[3] == v.stageId then
			self._stageSelect[3] = nil

			break
		end
	end

	for i, v in ipairs(thirdStageInfo) do
		if not self._thirdFinishIds[v.stageId] then
			self._bigStagePass[3] = false
			self._stageSelect[3] = self._stageSelect[3] or v.stageId

			break
		end
	end

	if bigStagePassed == true and self._bigStagePass[3] == true then
		self._passBigStage = 3
	end
end

function MiyaChallengeModel:setStageId(bigStage, stageId)
	self._bigStage = bigStage
	self._showStageId = stageId
end

function MiyaChallengeModel:setStageData(msg)
	local data = GameUtil.pbToTable(msg)

	self._showStageBuff = data.param
	self._exchangeBuff = data.exchangeParam
	self._buyTime = data.buyTime
end

function MiyaChallengeModel:repaceStageData(msg)
	local data = GameUtil.pbToTable(msg)

	self._showStageBuff = data.finalParam
	self._exchangeBuff = nil
end

function MiyaChallengeModel:getTierId()
	return self._tierId
end

function MiyaChallengeModel:getFirstFinishIds()
	return self._firstFinishIds
end

function MiyaChallengeModel:getSecondFinishIds()
	return self._secondFinishIds
end

function MiyaChallengeModel:getThirdFinishIds()
	return self._thirdFinishIds
end

function MiyaChallengeModel:getBigStagePass(bigStage)
	return self._bigStagePass[bigStage] or false
end

function MiyaChallengeModel:setStageSelect(bigStage, index)
	self._stageSelect[bigStage] = index
end

function MiyaChallengeModel:getStageSelect(bigStage)
	return self._stageSelect[bigStage]
end

function MiyaChallengeModel:getBigStage()
	return self._bigStage
end

function MiyaChallengeModel:getBuyTime()
	return self._buyTime
end

function MiyaChallengeModel:getBuff()
	return self._showStageBuff
end

function MiyaChallengeModel:getExchangeBuff()
	return self._exchangeBuff
end

function MiyaChallengeModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = MiyaChallengeFmtMo.New()
	end

	return self._customFmtMo
end

function MiyaChallengeModel:getActivityId()
	return self._activityId
end

function MiyaChallengeModel:getBigStageId()
	return self._bigStage
end

function MiyaChallengeModel:getShowStageId()
	return self._showStageId
end

function MiyaChallengeModel:getDamage(stageId)
	if self._damage then
		return self._damage[stageId]
	else
		return 0
	end
end

function MiyaChallengeModel:getDailyGameStart()
	return GameUtil.getUserDayData(MiyaChallengeModel.ReadFlag .. "#Enter")
end

function MiyaChallengeModel:setDailyGameStart()
	GameUtil.saveUserDayData(MiyaChallengeModel.ReadFlag .. "#Enter", true)
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_MIYACHALLENGE_ENTER)
end

function MiyaChallengeModel:getPassBigStage()
	return self._passBigStage
end

function MiyaChallengeModel:resetPassBigStage()
	self._passBigStage = nil
end

MiyaChallengeModel.instance = MiyaChallengeModel.New()

return MiyaChallengeModel
