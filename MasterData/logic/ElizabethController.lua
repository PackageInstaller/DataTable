-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/controller/ElizabethController.lua

module("logic.extensions.timelimitedchallenge.controller.ElizabethController", package.seeall)

local ElizabethController = class("ElizabethController", BaseController)

function ElizabethController:onInit()
	return
end

function ElizabethController:onReset()
	return
end

function ElizabethController:getRemaingBuyTimes()
	local buyedTimes = ElizabethModel.instance:getBuyedTimes()
	local timesPlanId = ElizabethModel.instance:getTimesPlanId()
	local buyCfgs = ElizabethConfig.instance:getBuyTimesCfgs(timesPlanId)

	return #buyCfgs - buyedTimes
end

function ElizabethController:getCurAndTotalTimes()
	local planId = ElizabethModel.instance:getCurPlanId()
	local usedTimes = ElizabethModel.instance:getUsedTimes()
	local buyedTimes = ElizabethModel.instance:getBuyedTimes()
	local dailyFreeTimes = ElizabethConfig.instance:getConstantValue("DAILY_FREE_GAME_TIMES", true)

	return dailyFreeTimes + buyedTimes - usedTimes, dailyFreeTimes
end

function ElizabethController:addTimes()
	local buyedTimes = ElizabethModel.instance:getBuyedTimes()
	local planId = ElizabethModel.instance:getTimesPlanId()
	local buyCfgs = ElizabethConfig.instance:getBuyTimesCfgs(planId)
	local buyCfg = ElizabethConfig.instance:getBuyTimesCfg(planId, buyedTimes + 1)
	local costNum = 0

	if buyCfg then
		_, _, costNum = unpack(string.splitToNumber(buyCfg.consume, ":"))
	end

	local cur, total = buyedTimes, #buyCfgs
	local leftTimes = total - cur

	if leftTimes < 1 then
		TipsFacade.instance:openTipWindow("提示", "今日购买次数已达上限，\n次日5点刷新免费次数和购买次数！", nil, "知道了")

		return
	end

	local content = string.format("今日没有免费次数了，确定花费%d钻购买次数吗？\n每天最多可购买%d次，还能购买%d次", costNum, total, leftTimes)

	TipsFacade:openPopupCostDiamondView(costNum, content, function()
		ElizabethChallengeAgent.instance:sendPM_ElizabethClgBuyTimesReq()
	end)
end

function ElizabethController:sendStartGameReq()
	local clientKey = ElizabethModel.instance:randomClientKey()

	ElizabethChallengeAgent.instance:sendPM_ElizabethClgStartGameReq(clientKey)
end

function ElizabethController:sendEndGameReq(clicks, scale)
	local encryptedKey = ElizabethModel.instance:getEncryptedKey(clicks, scale)
	local isPass = 0

	if clicks > 0 or scale > 0 then
		isPass = 1
	end

	ElizabethChallengeAgent.instance:sendPM_ElizabethClgEndGameReq(1, clicks, scale, encryptedKey, self._onEndGameRes, self)
end

function ElizabethController:sendReliveReq()
	ElizabethChallengeAgent.instance:sendPM_ElizabethClgReliveReq(self._onReliveRes, self)
end

function ElizabethController:sendGainPrizeReq()
	ElizabethChallengeAgent.instance:sendPM_ElizabethClgGainPrizeReq(self._onGainPrizeRes, self)
end

ElizabethController.instance = ElizabethController.New()

return ElizabethController
