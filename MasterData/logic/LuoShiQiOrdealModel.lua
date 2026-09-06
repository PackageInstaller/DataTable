-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luoshiqiordeal/model/LuoShiQiOrdealModel.lua

module("logic.extensions.luoshiqiordeal.model.LuoShiQiOrdealModel", package.seeall)

local LuoShiQiOrdealModel = class("LuoShiQiOrdealModel", BaseModel)

function LuoShiQiOrdealModel:ctor()
	return
end

function LuoShiQiOrdealModel:onInit()
	self:onReset()
end

function LuoShiQiOrdealModel:onReset()
	self._activityId = self:getActivityId()
	self._playGameNum = 0
	self._buyGameNum = 0
	self._scoreProgress = 0
	self._giftProgress = 0
	self._scorePrizeIds = {}
	self._giftGain = false
	self._normalMaxScoreMap = {}
	self._rankInfo = {}
	self._rankInfo[1] = {
		rankSize = 0,
		myRank = -1,
		rankList = {}
	}
	self._rankInfo[2] = {
		rankSize = 0,
		myRank = -1,
		rankList = {}
	}

	self:resetTemp()
end

function LuoShiQiOrdealModel:resetTemp()
	self._curScore = 0
	self._passStage = 0
	self._changeSetId = nil
end

function LuoShiQiOrdealModel:getActivityId()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.XiaoNuoBirthdayGift)

	self._activityId = cfg and cfg.activityId or 220001

	return self._activityId
end

function LuoShiQiOrdealModel:onXiaoNuoBirthdayGetInfoRes(msg)
	self._playGameNum = msg.playGameNum
	self._buyGameNum = msg.buyGameNum
	self._scoreProgress = msg.scoreProgress
	self._giftProgress = msg.giftProgress
	self._scorePrizeIds = GameUtil.pbToTable(msg.scorePrizeIds) or {}
	self._giftGain = msg.giftGain

	if msg.normalMaxScore then
		for _, pair in ipairs(msg.normalMaxScore) do
			local diffLv = pair.left

			self._normalMaxScoreMap[diffLv] = pair.right
		end
	end

	self._crazyMaxNum = msg.crazyMaxNum
end

function LuoShiQiOrdealModel:onXiaoNuoBirthdayStartNormalGameRes(msg)
	return
end

function LuoShiQiOrdealModel:onXiaoNuoBirthdayEndNormalGameRes(msg)
	self._giftProgress = msg.giftProgress
	self._scoreProgress = msg.scoreProgress
	self._changeSetId = msg.changeSetId
	self._playGameNum = self._playGameNum + 1
end

function LuoShiQiOrdealModel:onXiaoNuoBirthdayStartCrazyGameRes(msg)
	return
end

function LuoShiQiOrdealModel:onXiaoNuoBirthdayEndCrazyGameRes(msg)
	self._giftProgress = msg.giftProgress
	self._scoreProgress = msg.scoreProgress
	self._curScore = msg.curScore
	self._changeSetId = msg.changeSetId
	self._playGameNum = self._playGameNum + 1
end

function LuoShiQiOrdealModel:onXiaoNuoBirthdayBuyPlayNumRes(msg)
	self._buyGameNum = msg.buyGameNum
end

function LuoShiQiOrdealModel:onXiaoNuoBirthdayGameProgressPrizeRes(msg)
	self._scorePrizeIds = GameUtil.pbToTable(msg.scorePrizeIds) or {}
end

function LuoShiQiOrdealModel:onXiaoNuoBirthdayOpenGiftRes(msg)
	self._changeSetId = msg.changeSetId
end

function LuoShiQiOrdealModel:onXiaoNuoBirthdayGetRankRes(msg)
	local index = msg.crazy and 2 or 1
	local info = self._rankInfo[index]

	info.rankList = GameUtil.pbToTable(msg.rankList) or {}
	info.rankSize = msg.rankSize
	info.myRank = msg:HasField("myRank") and msg.myRank or -1
end

function LuoShiQiOrdealModel:getUsedGameNum()
	return self._playGameNum
end

function LuoShiQiOrdealModel:getBuyGameNum()
	return self._buyGameNum
end

function LuoShiQiOrdealModel:getLeftGameNum(defaultMaxNum)
	local realMaxNum = self._buyGameNum + defaultMaxNum
	local leftNum = realMaxNum - self._playGameNum

	leftNum = leftNum > 0 and leftNum or 0

	return leftNum
end

function LuoShiQiOrdealModel:getGiftProgress()
	return self._giftProgress
end

function LuoShiQiOrdealModel:isGainGift()
	return self._giftGain
end

function LuoShiQiOrdealModel:getScoreProgress()
	return self._scoreProgress
end

function LuoShiQiOrdealModel:isPlayerRewardCanGet(prizeId, needScore)
	local isScoreEnough = needScore <= self._scoreProgress

	if isScoreEnough then
		local isGeted = self:isPlayerRewardGeted(prizeId)

		return not isGeted
	else
		return false
	end
end

function LuoShiQiOrdealModel:isPlayerRewardGeted(prizeId)
	return TableUtil.isHad(self._scorePrizeIds, prizeId)
end

function LuoShiQiOrdealModel:setCurScore(curScore)
	self._curScore = curScore
end

function LuoShiQiOrdealModel:getCurScore()
	return self._curScore
end

function LuoShiQiOrdealModel:setPassStage(passNum)
	self._passStage = passNum
end

function LuoShiQiOrdealModel:getCrazyPassLevelNum()
	return self._passStage
end

function LuoShiQiOrdealModel:getMyRank(gameType)
	if self._rankInfo[gameType] then
		return self._rankInfo[gameType].myRank
	end

	return -1
end

function LuoShiQiOrdealModel:getRankList(gameType)
	if self._rankInfo[gameType] then
		return self._rankInfo[gameType].rankList
	end

	return {}
end

function LuoShiQiOrdealModel:getChangeSetId()
	self._changeSetId = nil

	return self._changeSetId
end

function LuoShiQiOrdealModel:setChangeSetId(id)
	self._changeSetId = id
end

function LuoShiQiOrdealModel:getMaxScoreNormal(diffLv)
	return checknumber(self._normalMaxScoreMap[diffLv])
end

function LuoShiQiOrdealModel:getMaxNumCrazy()
	return self._crazyMaxNum
end

function LuoShiQiOrdealModel:handlePM_XiaoNuoBirthdaySweepNormalGameRes(msg)
	if self._normalMaxScoreMap then
		self._normalMaxScoreMap[msg.diffLv] = msg.score
	end

	self._playGameNum = msg.times + checknumber(self._playGameNum)
end

function LuoShiQiOrdealModel:handlePM_XiaoNuoBirthdaySweepCrazyGameRes(msg)
	self._playGameNum = msg.times + checknumber(self._playGameNum)
end

LuoShiQiOrdealModel.instance = LuoShiQiOrdealModel.New()

return LuoShiQiOrdealModel
