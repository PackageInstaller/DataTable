-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenvsjiu/controller/JieShenVsJiuController.lua

module("logic.extensions.jieshenvsjiu.controller.JieShenVsJiuController", package.seeall)

local JieShenVsJiuController = class("JieShenVsJiuController", BaseController)

function JieShenVsJiuController:onInit()
	self:onReset()
end

function JieShenVsJiuController:onReset()
	self._lastGameIds = -1
end

function JieShenVsJiuController:culRemaingTimes(activityId)
	local curTimes = JieShenVsJiuModel.instance:getTodayGameTimes(activityId)
	local maxTimes = JieShenVsJiuConfig.instance:getActivityCfg(activityId).dailyGameTimes

	print(curTimes, maxTimes, maxTimes - curTimes)

	return maxTimes - curTimes
end

function JieShenVsJiuController:onThisGameTimesEnd(activityId, score)
	local clientKey = JieShenVsJiuModel.instance:getMyClientKey()
	local serverKey = JieShenVsJiuModel.instance:getMyServerKey()
	local encryptedKey = GameUtil.getClientEncryptedKey(clientKey, serverKey, {
		activityId,
		score
	})

	print("当前安全密钥 = ", encryptedKey)
	JieShenVsJiuAgent.instance:sendPM_JieShenVsJiuEndGameReq(activityId, score, encryptedKey)
end

function JieShenVsJiuController:getTheGameId()
	local curGameId = math.random(1, 20)

	if curGameId == self._lastGameIds then
		curGameId = curGameId + 1 < 20 and curGameId + 1 or curGameId - 1
	end

	self._lastGameIds = curGameId

	return curGameId
end

function JieShenVsJiuController:culMyTeamSupportPercentage(activityId)
	local info = JieShenVsJiuModel.instance:getInfo(activityId)

	if not info then
		return 0
	end

	local left = info.percentPair.left
	local right = info.percentPair.right
	local total = left + right

	return left / total
end

function JieShenVsJiuController:getIsGainPrize(gainPrizeIds, pirzeId)
	return table.keyof(gainPrizeIds, pirzeId)
end

JieShenVsJiuController.instance = JieShenVsJiuController.New()

return JieShenVsJiuController
