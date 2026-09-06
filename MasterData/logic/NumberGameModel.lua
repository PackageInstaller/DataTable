-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/model/NumberGameModel.lua

module("logic.extensions.numberbomb.model.NumberGameModel", package.seeall)

local NumberGameModel = class("NumberGameModel", BaseModel)

NumberGameModel.CallBackTypes_MathSuccess = "MathSuccess"
NumberGameModel.CallBackTypes_MathFail = "MathFail"
NumberGameModel.CallBackTypes_RuningExit = "RuningExit"
NumberGameModel.CallBackTypes_GameEnd = "GameEnd"

function NumberGameModel:ctor()
	self.gameBaseInfo = nil
	self.playerInfoList = nil
	self.annalInfoList = nil
	self.rankInfoList = nil
	self.myRankNum = 0
	self.gameOverInfo = nil
	self._finishCallBackPool = {}
end

function NumberGameModel:onInit()
	NumberGameModel.super.onInit(self)
	self:onReset()
end

function NumberGameModel:onReset()
	self.gameBaseInfo = nil
	self.playerInfoList = nil
	self.annalInfoList = nil
	self.rankInfoList = nil
	self.myRankNum = 0
	self.gameOverInfo = nil
	self._finfishCallBackAfterResultViewClose = nil

	table.clear(self._finishCallBackPool)
end

function NumberGameModel:_setInitGameBaseInfo()
	if self.gameBaseInfo and self.gameBaseInfo.isInit then
		return
	end

	self.gameBaseInfo = {}
	self.gameBaseInfo.isInit = true
	self.gameBaseInfo.maxScore = 0
	self.gameBaseInfo.curScore = 0
	self.gameBaseInfo.befScore = 0
	self.gameBaseInfo.rank = 0
	self.gameBaseInfo.totalGameTimes = 0
	self.gameBaseInfo.winGameTimes = 0
	self.gameBaseInfo.todayCoinCount = 0
	self.gameBaseInfo.allCoinCount = 0
	self.gameBaseInfo.prizeIds = {}
	self.gameBaseInfo.doingInfo = {}
	self.gameBaseInfo.proPrizeIds = {}
end

function NumberGameModel:isNumberGameOpen()
	local actiId = NumberGameConfig.instance:getOpenActivityId()

	return checknumber(actiId) > 0
end

function NumberGameModel:isNumberGameDoing()
	if not self:isNumberGameOpen() then
		return false, "活动结束"
	end

	local commonInfo = NumberGameConfig.instance:getCommonInfo()

	if commonInfo == nil then
		return false, "未在活动时间"
	end

	if commonInfo.openTimes == nil or #commonInfo.openTimes == 0 then
		return false, "未在活动时间"
	end

	for _, str in pairs(commonInfo.openTimes) do
		local list = string.split(str, "#")

		if list and #list >= 2 and GameUtil.checkIsInTimePeriod(list[1], list[2], true) then
			local des = list[1] .. " - " .. list[2]

			return true, des
		end
	end

	return false, "未在活动时间"
end

function NumberGameModel:getGameBaseInfo()
	self:_setInitGameBaseInfo()

	return self.gameBaseInfo
end

function NumberGameModel:getAllPlayerData()
	if self.playerInfoList == nil or self.playerInfoList[4] == nil then
		return
	end

	if self.playerInfoList[4].isMyInfo then
		return self.playerInfoList
	end

	return self:_allPlayerDataSort(self.playerInfoList)
end

function NumberGameModel:getAndSetGameOverData(isGet)
	if isGet then
		return self.gameOverInfo
	end

	self.gameOverInfo = nil
end

function NumberGameModel:getGameAnnalList()
	return self.annalInfoList or {}
end

function NumberGameModel:getGameRankList()
	return self.rankInfoList, self.myRankNum
end

function NumberGameModel:getGameScoreAwardList()
	local actiId = NumberGameConfig.instance:getOpenActivityId()

	if checknumber(actiId) <= 0 then
		return
	end

	local cfg = NumberGameConfig.instance:getActivityCfg(actiId)

	if cfg == nil or checknumber(cfg.scorePrizePlan) < 0 then
		return
	end

	local scoreAllCfgs = NumberGameConfig.instance:getScorePrizeCfg(cfg.scorePrizePlan)

	if scoreAllCfgs == nil or #scoreAllCfgs == 0 then
		return
	end

	local scoreList = {}

	for i = 1, #scoreAllCfgs do
		if scoreAllCfgs[i] and checknumber(scoreAllCfgs[i].needScore) > 0 then
			local data = {}

			data.prizeId = scoreAllCfgs[i].prizeId
			data.isReceive = table.indexof((self.gameBaseInfo and self.gameBaseInfo.prizeIds or nil) and self.gameBaseInfo.prizeIds, scoreAllCfgs[i].prizeId) ~= false
			data.needScore = scoreAllCfgs[i].needScore
			data.prizeStr = scoreAllCfgs[i].prize

			table.insert(scoreList, data)
		end
	end

	if #scoreList > 1 then
		table.sort(scoreList, function(a, b)
			return a.prizeId < b.prizeId
		end)
	end

	return scoreList
end

function NumberGameModel:getGameRankAwardList()
	local actiId = NumberGameConfig.instance:getOpenActivityId()

	if checknumber(actiId) <= 0 then
		return
	end

	local cfg = NumberGameConfig.instance:getActivityCfg(actiId)

	if cfg == nil or checknumber(cfg.rankPlan) < 0 then
		return
	end

	local rankAllCfgs = NumberGameConfig.instance:getAllRankCfgs(cfg.rankPlan)
	local rankList = {}

	for _, cfg in pairs(rankAllCfgs or {}) do
		if cfg and checknumber(cfg.rightTop) > 0 then
			local data = {}

			data.rankId = cfg.rightTop
			data.rankDes = cfg.rankDes
			data.goodsList = string.split(cfg.prize, "#")

			table.insert(rankList, data)
		end
	end

	if #rankList > 1 then
		table.sort(rankList, function(a, b)
			return a.rankId < b.rankId
		end)
	end

	return rankList
end

function NumberGameModel:getGameRewardRedpoint()
	local socreList = self:getGameScoreAwardList()

	if socreList == nil or #socreList == 0 then
		return false
	end

	if self.gameBaseInfo then
		if not self.gameBaseInfo.maxScore then
			local have = 0

			for i = 1, #socreList do
				if socreList[i] and not socreList[i].isReceive and have >= socreList[i].needScore then
					return true
				end
			end

			return false
		end
	end
end

function NumberGameModel:getGameShopRedpoint()
	local value = GameUtil.getUserData("NumberBombShopRed")

	return checknumber(value) ~= 1
end

function NumberGameModel:scSendGameBaseInfo(msg)
	self:_setInitGameBaseInfo()

	if msg then
		self.gameBaseInfo.befScore = self.gameBaseInfo.curScore
		self.gameBaseInfo.maxScore = checknumber(msg.maxScore)
		self.gameBaseInfo.curScore = checknumber(msg.curScore)
		self.gameBaseInfo.rank = checknumber(msg.rank)
		self.gameBaseInfo.totalGameTimes = checknumber(msg.totalGameTimes)
		self.gameBaseInfo.winGameTimes = checknumber(msg.winGameTimes)
		self.gameBaseInfo.todayCoinCount = checknumber(msg.todayCoinCount)
		self.gameBaseInfo.prizeIds = msg.prizeIds or {}
		self.gameBaseInfo.allCoinCount = msg.allCoinCount
		self.gameBaseInfo.proPrizeIds = msg.progressPrizeIds or {}
	end

	GlobalDispatcher:dispatch(GlobalNotify.NumberGameBaseInfo)
end

function NumberGameModel:scSendBeginMatchGame()
	GlobalDispatcher:dispatch(GlobalNotify.NumberGameMatch, 1)
end

function NumberGameModel:scSendCancelMatchGame()
	GlobalDispatcher:dispatch(GlobalNotify.NumberGameMatch, 2)
end

function NumberGameModel:scSendMatchGameFail()
	GlobalDispatcher:dispatch(GlobalNotify.NumberGameMatch, 3)
end

function NumberGameModel:scSendAllPlayerData(msg)
	self.playerInfoList = self:_allPlayerDataSort(msg.players)

	self:_scSendGameDoingData(msg.initNumMin, msg.initNumMax, msg.startPlayerSeq)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataPlayerGameInfo)
end

function NumberGameModel:_allPlayerDataSort(list)
	local allCount = 4
	local roleId = RoleModel.instance:getUserId()
	local tempValue = 0
	local tempList = {}

	for _, info in pairs(list or {}) do
		if info and info.headInfo then
			if not info.seq then
				local data = {}

				data.index = info.seq
				data.sortIndex = info.seq
				data.headInfo = info.headInfo
				data.areaName = info.areaName
				data.isLeave = false
				data.choisNum = 0

				print("sr---炸弹数字   下发数据信息 = ", info.headInfo.userId, roleId, type(info.headInfo.userId), type(roleId))

				if checknumber(info.headInfo.userId) == checknumber(roleId) then
					tempValue = allCount - info.seq
					data.isMyInfo = true
				end

				table.insert(tempList, data)
			end
		end
	end

	if tempList == nil or #tempList ~= allCount then
		printError("sr---炸弹数字   获取匹配玩家数据为毛不是 = " .. allCount)

		return
	end

	if tempValue > 0 then
		for i = 1, #tempList do
			if tempList[i] and checknumber(tempList[i].index) > 0 then
				local tempIndex = tempList[i].index + tempValue

				tempList[i].sortIndex = tempIndex <= allCount and tempIndex or tempIndex - math.floor(tempIndex / allCount) * allCount
			end
		end
	end

	table.sort(tempList, function(a, b)
		return a.sortIndex < b.sortIndex
	end)

	return tempList
end

function NumberGameModel:_scSendGameDoingData(min, max, index)
	self:_setInitGameBaseInfo()

	if min == nil or max == nil then
		return
	end

	self.gameBaseInfo.doingInfo.minNum = checknumber(min)
	self.gameBaseInfo.doingInfo.maxNum = checknumber(max)
	self.gameBaseInfo.doingInfo.nextIndex = index

	GlobalDispatcher:dispatch(GlobalNotify.UpdataNumberGameDoing)
end

function NumberGameModel:scSendUpdataPlayerData(msg)
	local sortIndex = 0
	local index = checknumber(msg.seq)

	for _, info in pairs(self.playerInfoList or {}) do
		if info and info.index == index then
			info.choisNum = checknumber(msg.number)
			sortIndex = info.sortIndex
			info.isLeave = msg.boom

			break
		end
	end

	if checknumber(sortIndex) > 0 then
		GlobalDispatcher:dispatch(GlobalNotify.UpdataPlayerGameInfo, 1, sortIndex, msg.number, msg.boom)
	end

	self:_scSendGameDoingData(msg.leftN, msg.rightN, msg.nextSeq)
end

function NumberGameModel:scSendNumberGameOver(msg)
	self.gameOverInfo = {
		endType = checknumber(msg.endType),
		endRank = checknumber(msg.myNO),
		setId = msg.changeSetId,
		endScore = checknumber(msg.gainedScore),
		endDaibi = checknumber(msg.gainedCoin)
	}

	GlobalDispatcher:dispatch(GlobalNotify.NumberGameEndData, checknumber(msg.endType))

	self.playerInfoList = nil
end

function NumberGameModel:scSendGameChatMsg(msg)
	if msg == nil or not msg.inCd then
		return
	end
end

function NumberGameModel:scSendGameChatAndLeave(msg)
	if msg == nil or checknumber(msg.seq) <= 0 then
		return
	end

	local sortIndex = 0
	local opType = 2
	local allInfoList = self:getAllPlayerData()

	for _, info in pairs(allInfoList) do
		if info and info.index == msg.seq then
			sortIndex = info.sortIndex

			if checknumber(msg.operationType) == 1 then
				info.isLeave = true
				opType = 3
			end

			break
		end
	end

	if checknumber(sortIndex) > 0 then
		GlobalDispatcher:dispatch(GlobalNotify.UpdataPlayerGameInfo, opType, sortIndex, msg.chatMsgId)
	end
end

function NumberGameModel:scSendGameAnnalList(annals)
	self.annalInfoList = nil

	if annals and #annals > 0 then
		self.annalInfoList = annals
	end

	if self.annalInfoList and #self.annalInfoList > 1 then
		table.sort(self.annalInfoList, function(a, b)
			return a.gameTimeMillis > b.gameTimeMillis
		end)
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdataGameAnnalList)
end

function NumberGameModel:scSendGameRankList(msg)
	self.rankInfoList = nil
	self.myRankNum = 0

	if msg and msg.rankInfos and #msg.rankInfos > 0 then
		self.myRankNum = checknumber(msg.myRank)
		self.rankInfoList = msg.rankInfos
	end

	if self.rankInfoList and #self.rankInfoList > 1 then
		table.sort(self.rankInfoList, function(a, b)
			return a.rank < b.rank
		end)
	end

	GlobalDispatcher:dispatch(GlobalNotify.UpdataGameRankList)
end

function NumberGameModel:scSendGameSocrePrize(actId, prizeId)
	local isHave = false

	for _, id in pairs(self.gameBaseInfo.prizeIds) do
		if checknumber(id) == checknumber(prizeId) then
			isHave = true

			break
		end
	end

	if not isHave then
		table.insert(self.gameBaseInfo.prizeIds, prizeId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.ReceiveGameSocrePrize, prizeId)
end

function NumberGameModel:scSendNGGainProgressPrize(actId, prizeId)
	local isHave = false

	for _, id in pairs(self.gameBaseInfo.proPrizeIds) do
		if checknumber(id) == checknumber(prizeId) then
			isHave = true

			break
		end
	end

	if not isHave then
		table.insert(self.gameBaseInfo.proPrizeIds, prizeId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.ReceiveGameProPrize, prizeId)
end

function NumberGameModel:getFinishCallBack(callBackType)
	return self._finishCallBackPool[callBackType]
end

function NumberGameModel:setFinishCallBack(callBackType, callBack)
	self._finishCallBackPool[callBackType] = callBack
end

function NumberGameModel:clearFinishCallBack()
	table.clear(self._finishCallBackPool)
end

NumberGameModel.instance = NumberGameModel.New()

return NumberGameModel
