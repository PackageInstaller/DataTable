-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qichallenge/model/QiChallengeModel.lua

module("logic.extensions.qichallenge.model.QiChallengeModel", package.seeall)

local QiChallengeModel = class("QiChallengeModel", BaseModel)

QiChallengeModel.ReadFlag = "QiChallengeModel.ReadFlag"

function QiChallengeModel:onInit()
	self:onReset()
end

function QiChallengeModel:onReset()
	return
end

function QiChallengeModel:setInfo(msg)
	self._activityId = msg.activityId

	local allChallengeFinishIds = {}

	if msg.allChallengeFinishIds then
		for i, v in ipairs(msg.allChallengeFinishIds) do
			allChallengeFinishIds[v] = true
		end
	end

	self._allChallengeInfos = {}

	if msg.allChallengeIds then
		for i, v in ipairs(msg.allChallengeIds) do
			self._allChallengeInfos[i] = {
				id = v,
				isFinish = (allChallengeFinishIds[v] == true or nil) and true
			}
		end
	end

	self._usedRaceIds = {}

	if msg.usedRaceIds then
		for i, v in ipairs(msg.usedRaceIds) do
			self._usedRaceIds[v] = true
		end
	end

	self._sealRaceIds = {}
	self._blockRaceCount = 0

	if msg.sealRaceIds then
		for i, v in ipairs(msg.sealRaceIds) do
			self._sealRaceIds[v] = true
			self._blockRaceCount = self._blockRaceCount + 1
		end
	end

	self._canSealRaceInfos = {}

	if msg.canSealRaceIds then
		for i, v in ipairs(msg.canSealRaceIds) do
			table.insert(self._canSealRaceInfos, {
				id = v,
				isBlock = (self._sealRaceIds[v] == true or nil) and true
			})
		end
	end

	table.sort(self._canSealRaceInfos, function(a, b)
		if a.isBlock ~= b.isBlock then
			if a.isBlock == true and b.isBlock == false then
				return false
			else
				return true
			end
		else
			return a.id < b.id
		end
	end)

	self._passStage = msg.passStage or 0
	self._gainPrizeStage = msg.gainPrizeStage or 0
	self._hardChallengePetInfo = GameUtil.pbToTable(msg.petInfo) or {}

	table.sort(self._hardChallengePetInfo, function(a, b)
		if a.time ~= b.time then
			return a.time > b.time
		else
			return a.raceId < b.raceId
		end
	end)

	self._hardChallengePetInfoMap = {}

	for i, v in ipairs(self._hardChallengePetInfo) do
		self._hardChallengePetInfoMap[v.raceId] = v.time
	end
end

function QiChallengeModel:setBlockRaceInfo(msg)
	self._blockRaceIds = {}
	self._blockRaceCount = 0

	if msg.sealRaceIds then
		for i, v in ipairs(msg.sealRaceIds) do
			self._blockRaceIds[v] = true
			self._blockRaceCount = self._blockRaceCount + 1
		end
	end

	for i, v in ipairs(self._canSealRaceInfos) do
		if self._blockRaceIds[v.id] == true then
			v.isBlock = true
		end
	end

	table.sort(self._canSealRaceInfos, function(a, b)
		if a.isBlock ~= b.isBlock then
			if a.isBlock == true and b.isBlock == false then
				return false
			else
				return true
			end
		else
			return a.id < b.id
		end
	end)
end

function QiChallengeModel:setHardChallengePetInfo(msg)
	self._hardChallengePetInfo = GameUtil.pbToTable(msg.petInfo) or {}
	self._hardChallengePetInfoMap = {}

	for i, v in ipairs(self._hardChallengePetInfo) do
		self._hardChallengePetInfoMap[v.raceId] = v.time
	end
end

function QiChallengeModel:setAllBattleEnd(msg)
	if msg.win and msg.usedRaceIds and self._usedRaceIds then
		for i, v in ipairs(msg.usedRaceIds) do
			self._usedRaceIds[v] = true
		end
	end
end

function QiChallengeModel:getAllChallengeInfo(index)
	return self._allChallengeInfos[index]
end

function QiChallengeModel:getBlockRaceCount()
	return checknumber(self._blockRaceCount)
end

function QiChallengeModel:getDailyFmtMo()
	if self._dailyFmtMo == nil then
		self._dailyFmtMo = QiChallengeDailyFmtMo.New()
	end

	return self._dailyFmtMo
end

function QiChallengeModel:getHardFmtMo()
	if self._hardFmtMo == nil then
		self._hardFmtMo = QiChallengeHardFmtMo.New()
	end

	return self._hardFmtMo
end

function QiChallengeModel:getUsedRaceInfos()
	return self._usedRaceIds or {}
end

function QiChallengeModel:getCanSealRaceInfos()
	return self._canSealRaceInfos or {}
end

function QiChallengeModel:getBlockRaceIds()
	return self._blockRaceIds or {}
end

function QiChallengeModel:getPassStage()
	return checknumber(self._passStage)
end

function QiChallengeModel:getGainPrizeStage()
	return checknumber(self._gainPrizeStage)
end

function QiChallengeModel:getHardChallengePets()
	return self._hardChallengePetInfo or {}
end

function QiChallengeModel:getHardChallengePetMap()
	return self._hardChallengePetInfoMap or {}
end

function QiChallengeModel:setEnterHardChallenge()
	GameUtil.saveUserDayData(QiChallengeModel.ReadFlag .. "#hardEnter", true)
end

function QiChallengeModel:getEnterHardChallenge()
	return GameUtil.getUserDayData(QiChallengeModel.ReadFlag .. "#hardEnter")
end

function QiChallengeModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.QI_CHALLENGE)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.QI_CHALLENGE)

		return false
	end

	for i, v in pairs(cfgs) do
		local cfg = QiChallengeConfig.instance:getActivityCfg(v.activityId)

		if not cfg then
			printError("====t_qi_challenge no cfg, id = " .. v, activityId)

			break
		end

		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.QI_CHALLENGE, v.activityId) then
			actId = cfg.activityId

			break
		end
	end

	return actId
end

QiChallengeModel.instance = QiChallengeModel.New()

return QiChallengeModel
