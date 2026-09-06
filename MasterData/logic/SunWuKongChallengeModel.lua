-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/model/SunWuKongChallengeModel.lua

module("logic.extensions.sunwukongchallenge.model.SunWuKongChallengeModel", package.seeall)

local SunWuKongChallengeModel = class("SunWuKongChallengeModel", BaseModel)

SunWuKongChallengeModel.MiniGameType = {
	FlipGame = 2,
	Balloon = 1
}
SunWuKongChallengeModel.HiddenType = {
	Battle = 5,
	Balloon = 1,
	CollectMaterials = 4,
	VerifyPet = 3,
	FilpGame = 2
}
SunWuKongChallengeModel.ReadFlag = "SunWuKongChallengeModel.ReadFlag"

function SunWuKongChallengeModel:onInit()
	self:onReset()
	RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_SUNWUKONGCHALLENGE_DAILY_OPEN)
end

function SunWuKongChallengeModel:onReset()
	self._clientKey = 0
	self._maxedKey = 0
	self._fmtMo = nil
	self._msgPool = {}
	self._cimeliaInfosPool = {}
end

function SunWuKongChallengeModel:getMsgData(activityId)
	return self._msgPool[activityId]
end

function SunWuKongChallengeModel:setStageData(msg)
	local data = GameUtil.pbToTable(msg)

	self._curStageId = data.curStageId
	self._finishedHiddenStageIds = {}

	if data.finishedHiddenStageIds then
		for i, v in ipairs(data.finishedHiddenStageIds) do
			self._finishedHiddenStageIds[v] = true
		end
	end

	local activityId = data.activityId

	self._msgPool[activityId] = data
end

function SunWuKongChallengeModel:upateDailyPirze(msg)
	local activityId = msg.activityId
	local data = self._msgPool[activityId]

	if data then
		data.hadGainedDailyPrize = true
	end
end

function SunWuKongChallengeModel:setCimeliaData(msg)
	local data = GameUtil.pbToTable(msg)

	self._cimeliaData = {}

	for i, v in pairs(data.cimeliaInfos) do
		self._cimeliaData[v.cimeliaId] = v.lv
	end

	local activityId = data.activityId

	self._cimeliaInfosPool[activityId] = activityId
end

function SunWuKongChallengeModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.SunWuKongChallenge)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.SunWuKongChallenge)

		return false
	end

	for i, v in pairs(cfgs) do
		local cfg = SunWuKongChallengeConfig.instance:getActivityCfg(v.activityId)

		if not cfg then
			printError("====t_xiu_nuo_brotherhood_activity no cfg, id = " .. v.activityId)

			break
		end

		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.SunWuKongChallenge, v.activityId) then
			actId = cfg.activityId

			break
		end
	end

	return actId
end

function SunWuKongChallengeModel:isPassNomalStage(actId, index)
	local curStageId = self:getCurStageId(actId)

	return checknumber(curStageId) > checknumber(index)
end

function SunWuKongChallengeModel:isPassHiddenStage(actId, index)
	local data = self._msgPool[actId]

	if data and data.finishedHiddenStageIds then
		return table.indexof(data.finishedHiddenStageIds, index) ~= false
	end

	return false
end

function SunWuKongChallengeModel:getCurStageId(actId)
	local data = self._msgPool[actId]

	if data then
		return checknumber(data.curStageId)
	end

	return 0
end

function SunWuKongChallengeModel:getFmtMo()
	if self._fmtMo == nil then
		self._fmtMo = SunWukongChallengeFmtMo.New()
	end

	return self._fmtMo
end

function SunWuKongChallengeModel:setMiniGameClintKey(clientKey)
	self._clientKey = clientKey
end

function SunWuKongChallengeModel:getMiniGameClintKey()
	return self._clientKey
end

function SunWuKongChallengeModel:setMiniGameMixedKey(maxedKey)
	self._maxedKey = maxedKey
end

function SunWuKongChallengeModel:getMiniGameMixedKey()
	return self._maxedKey
end

function SunWuKongChallengeModel:getCimeliaData(cimeliaId)
	return self._cimeliaData[cimeliaId]
end

function SunWuKongChallengeModel:checkNewCimelia(actId, stageId)
	local actCfg = SunWuKongChallengeConfig.instance:getActivityCfg(actId)
	local cimeliaCfgs = SunWuKongChallengeConfig.instance:getCimeliaCfgs(actCfg.cimeliaPlanId)

	for i, v in ipairs(cimeliaCfgs) do
		if v.unlockStageId - 1 == stageId then
			GameUtil.saveUserData(SunWuKongChallengeModel.ReadFlag .. "#NewCimelia#" .. actId .. "#" .. v.cimeliaId, true)

			if GameUtil.getUserData(SunWuKongChallengeModel.ReadFlag .. "#NewCimelia#" .. actId) == false then
				GameUtil.saveUserData(SunWuKongChallengeModel.ReadFlag .. "#NewCimelia#" .. actId, true)
				RedPointController.instance:setRedPointInfo(RedPointModel.ID_SUNWUKONGCHALLENGE_NEW_CIMELIA, true)
			end
		end
	end
end

function SunWuKongChallengeModel:saveNewCimelia(actId, cimeliaId)
	local actCfg = SunWuKongChallengeConfig.instance:getActivityCfg(actId)
	local cimeliaCfgs = SunWuKongChallengeConfig.instance:getCimeliaCfgs(actCfg.cimeliaPlanId)

	GameUtil.saveUserData(SunWuKongChallengeModel.ReadFlag .. "#NewCimelia#" .. actId .. "#" .. cimeliaId, false)

	local result = false

	for i, v in ipairs(cimeliaCfgs) do
		if GameUtil.getUserData(SunWuKongChallengeModel.ReadFlag .. "#NewCimelia#" .. actId .. "#" .. v.cimeliaId) == true then
			result = true

			break
		end
	end

	if result == false and GameUtil.getUserData(SunWuKongChallengeModel.ReadFlag .. "#NewCimelia#" .. actId) == true then
		GameUtil.saveUserData(SunWuKongChallengeModel.ReadFlag .. "#NewCimelia#" .. actId, false)
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_SUNWUKONGCHALLENGE_NEW_CIMELIA, false)
	end
end

function SunWuKongChallengeModel:getNewCimelia(actId, cimeliaId)
	return GameUtil.getUserData(SunWuKongChallengeModel.ReadFlag .. "#NewCimelia#" .. actId .. "#" .. cimeliaId)
end

SunWuKongChallengeModel.instance = SunWuKongChallengeModel.New()

return SunWuKongChallengeModel
