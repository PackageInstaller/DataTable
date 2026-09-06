-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elizabethgame/controller/ElizabethgameController.lua

module("logic.extensions.elizabethgame.controller.ElizabethgameController", package.seeall)

local ElizabethgameController = class("ElizabethgameController", BaseController)

function ElizabethgameController:ctor()
	return
end

function ElizabethgameController:onInit()
	self:onReset()
end

function ElizabethgameController:onReset()
	return
end

function ElizabethgameController:getCurAndTotalTimes(activityId)
	local usedTimes = ElizabethgameModel.instance:getUsedTimes(activityId)
	local buyedTimes = ElizabethgameModel.instance:getBuyedTimes(activityId)
	local actCfg = ElizabethgameConfig.instance:getActCfg(activityId)
	local dailyFreeTimes = actCfg.dailyFreeGameTimes

	return dailyFreeTimes + buyedTimes - usedTimes, dailyFreeTimes
end

function ElizabethgameController:getRemaingBuyTimes(activityId)
	local buyedTimes = ElizabethgameModel.instance:getBuyedTimes(activityId)
	local actCfg = ElizabethgameConfig.instance:getActCfg(activityId)
	local buyCfgs = ElizabethgameConfig.instance:getBuyTimesCfgs(actCfg.gameBuyTimesPlanId)

	return #buyCfgs - buyedTimes
end

function ElizabethgameController:sendStartGameReq(activityId)
	local clientKey = ElizabethgameModel.instance:randomClientKey(activityId)

	ElizabethGameAgent.instance:sendPM_ElizabethGameStartGameReq(activityId, clientKey)
end

function ElizabethgameController:addTimes(activityId)
	local buyedTimes = ElizabethgameModel.instance:getBuyedTimes(activityId)
	local actCfg = ElizabethgameConfig.instance:getActCfg(activityId)
	local buyCfgs = ElizabethgameConfig.instance:getBuyTimesCfgs(actCfg.gameBuyTimesPlanId)
	local buyCfg = ElizabethgameConfig.instance:getBuyTimesCfg(planId, buyedTimes + 1)
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
		ElizabethGameAgent.instance:sendPM_ElizabethGameBuyTimesReq(activityId)
	end)
end

function ElizabethgameController:sendEndGameReq(activityId, clicks, scale)
	scale = math.floor(scale)

	local encryptedKey = ElizabethgameModel.instance:getEncryptedKey(activityId, clicks, scale)

	ElizabethGameAgent.instance:sendPM_ElizabethGameEndGameReq(activityId, 1, clicks, scale, encryptedKey)
end

function ElizabethgameController:isCanGet(activityId, prizeId)
	if self:isGainPrize(activityId, prizeId) then
		return false
	end

	local acfg = ElizabethgameConfig.instance:getActCfg(activityId)
	local cfg = ElizabethgameConfig.instance:getGamePrizeCfg(acfg.prizePlanId, prizeId)
	local cur = ElizabethgameModel.instance:getProgress(activityId)

	return cur >= cfg.flowerNum
end

function ElizabethgameController:isGainPrize(activityId, prizeId)
	local ids = ElizabethgameModel.instance:getGianPrizeIds(activityId)

	return table.indexof(ids, prizeId)
end

function ElizabethgameController:sendPM_ElizabethGameGainPrizeReq(activityId, prizeId)
	self._gainPrizeId = prizeId

	ElizabethGameAgent.instance:sendPM_ElizabethGameGainPrizeReq(activityId, prizeId)
end

function ElizabethgameController:handlePM_ElizabethGameGainPrizeRes(activityId)
	ElizabethgameModel.instance:gainPrizeRes(activityId, self._gainPrizeId)
end

function ElizabethgameController:handlePM_ElizabethGameEndGameRes(msg)
	ElizabethgameModel.instance:updateGameInfo(msg)
	self:_calRedPoint()
end

function ElizabethgameController:handlePM_ElizabethGameGetInfoRes(msg)
	ElizabethgameModel.instance:setGameInfo(msg)
	self:_calRedPoint()
end

function ElizabethgameController:_calRedPoint()
	local isActive = false
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.ElizabethGame)

	if activityId > 0 then
		local useTime = ElizabethgameModel.instance:getUsedTimes(activityId)
		local actCfg = ElizabethgameConfig.instance:getActCfg(activityId)

		isActive = useTime < actCfg.dailyFreeGameTimes
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_ELIZABETHGAME_TIME, isActive)
end

ElizabethgameController.instance = ElizabethgameController.New()

return ElizabethgameController
