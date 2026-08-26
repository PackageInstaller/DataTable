-- chunkname: @modules/logic/partygamelobby/controller/PartyGameTrialController.lua

module("modules.logic.partygamelobby.controller.PartyGameTrialController", package.seeall)

local PartyGameTrialController = class("PartyGameTrialController", BaseController)

require("tolua.reflection")
tolua.loadassembly("PartyGame")

local PartyGameTrialPlayUtil_Type = tolua.findtype("PartyGame.Runtime.Utils.PartyGameTrialPlayUtil")
local GenerateGameLocalData = tolua.getmethod(PartyGameTrialPlayUtil_Type, "GenerateGameLocalData", typeof("System.Int32"))
local SetMainPlayerInfo = tolua.getmethod(PartyGameTrialPlayUtil_Type, "SetMainPlayerInfo", typeof("System.Int64"), typeof("System.String"))
local SetRobotName = tolua.getmethod(PartyGameTrialPlayUtil_Type, "SetRobotName", typeof("System.String"))
local UpdateGamePlayerDataByScore = tolua.getmethod(PartyGameTrialPlayUtil_Type, "UpdateGamePlayerDataByScore", typeof("System.Int32"), typeof("System.Boolean"))
local GetMainPlayerRank = tolua.getmethod(PartyGameTrialPlayUtil_Type, "GetMainPlayerRank")
local AddMainPlayerCard = tolua.getmethod(PartyGameTrialPlayUtil_Type, "AddMainPlayerCard", typeof("System.Int32"))
local GetBattleCardRewardList = tolua.getmethod(PartyGameTrialPlayUtil_Type, "GetBattleCardRewardList")
local GetBattleCardRewardCount = tolua.getmethod(PartyGameTrialPlayUtil_Type, "GetBattleCardRewardCount")
local SetCurGameTrial = tolua.getmethod(PartyGameTrialPlayUtil_Type, "SetCurGameTrial", typeof("System.Boolean"))
local InitPlayerCard = tolua.getmethod(PartyGameTrialPlayUtil_Type, "InitPlayerCard")
local GetGameEndRequest = tolua.getmethod(PartyGameTrialPlayUtil_Type, "GetGameEndRequest")
local SetMainPlayerSkin = tolua.getmethod(PartyGameTrialPlayUtil_Type, "SetMainPlayerSkin", typeof("System.Int32"), typeof("System.Int32"), typeof("System.Int32"), typeof("System.Int32"), typeof("System.Int32"), typeof("System.Int32"))

function PartyGameTrialController:setPlayerInfo(playerUid, playerName)
	self._mainPlayerUid = playerUid

	if SetMainPlayerInfo then
		SetMainPlayerInfo:Call(playerUid, playerName)
	end
end

function PartyGameTrialController:setRobotName(robotName)
	if SetRobotName then
		SetRobotName:Call(robotName)
	end
end

function PartyGameTrialController:generalPlayer(playerNum)
	if GenerateGameLocalData then
		return (GenerateGameLocalData:Call(playerNum))
	end

	return nil
end

function PartyGameTrialController:updatePlayerDataByScore(gameId, needDel)
	if UpdateGamePlayerDataByScore then
		return (UpdateGamePlayerDataByScore:Call(gameId, needDel))
	end

	return nil
end

function PartyGameTrialController:setGameTrial(isTrial)
	if SetCurGameTrial then
		SetCurGameTrial:Call(isTrial)
	end
end

function PartyGameTrialController:initPlayerCard()
	if InitPlayerCard then
		local playerList = InitPlayerCard:Call()

		PartyGameController.instance:gamePlayerPush(playerList)
	end
end

function PartyGameTrialController:initPlayerSkin()
	if SetMainPlayerSkin then
		local wearClothIdMap = PartyClothModel.instance:getWearClothIdMap()

		SetMainPlayerSkin:Call(wearClothIdMap[PartyClothEnum.ClothType.Hat] or -1, wearClothIdMap[PartyClothEnum.ClothType.Jacket] or -1, wearClothIdMap[PartyClothEnum.ClothType.Pant] or -1, wearClothIdMap[PartyClothEnum.ClothType.Shoes] or -1, wearClothIdMap[PartyClothEnum.ClothType.Head] or -1, wearClothIdMap[PartyClothEnum.ClothType.Body] or -1)
	end
end

function PartyGameTrialController:_trialToNextGame(gameId, allPlayer)
	PartyGameEnum.PartyGameConfigData.RandomSeed = math.random(10, 1000000)

	local transToGamePushMsg = {}

	transToGamePushMsg.GameId = gameId
	transToGamePushMsg.Player = allPlayer
	transToGamePushMsg.isTrial = true

	PartyGameController.instance:transToGamePush(transToGamePushMsg)
end

function PartyGameTrialController:enterTrialView()
	self.isInTrial = true

	ViewMgr.instance:openView(ViewName.PartyGameLobbyTrialView)
end

function PartyGameTrialController:exitTrialView()
	self.isInTrial = false
end

function PartyGameTrialController:enterTrial(gameId, playerCount)
	PartyGameController.instance:setPartyGameIsEnd(false)

	playerCount = playerCount or PartyGameTrialPlayEnum.trialPlayerNumStep[1]

	local allPlayer = PartyGameTrialController.instance:generalPlayer(playerCount)

	PartyGameTrialController.instance:_trialToNextGame(gameId, allPlayer)
end

function PartyGameTrialController:getMainPlayerRank()
	if GetMainPlayerRank then
		return (GetMainPlayerRank:Call())
	end

	return nil
end

function PartyGameTrialController:setSelectCard(selectCards)
	if AddMainPlayerCard then
		for _, v in ipairs(selectCards) do
			AddMainPlayerCard:Call(v)
		end
	end

	PartyGameRpc.instance:SelectCardRewardReply(0)
end

function PartyGameTrialController:trialToNextGame()
	if self._nextGame == nil or self._nextNeedDel == nil then
		return
	end

	local allPlayer = PartyGameTrialController.instance:updatePlayerDataByScore(self._nextGame, self._nextNeedDel)

	self:_trialToNextGame(self._nextGame, allPlayer)

	self._nextGame = nil
	self._nextNeedDel = nil
end

function PartyGameTrialController:trialGameEnd(id, needDel)
	local gameResult = GetGameEndRequest:Call()

	PartyGameRpc.instance:GameEndPush(gameResult)

	if gameResult.GameId == PartyGameEnum.GameId.CardDrop and not CardDropEndFlowController.instance:checkMainPlayerMoWin(gameResult) then
		local count = gameResult.ScoreList.Count
		local rank = 5

		if count == 4 then
			rank = 3
		end

		PartyGameRpc.instance:PartyEndPush((count == 2 or nil) and 2)

		return
	end

	self._nextGame = id
	self._nextNeedDel = needDel

	if gameResult.GameId ~= PartyGameEnum.GameId.CardDrop then
		local battleCardReward = {}

		battleCardReward.CardIds = GetBattleCardRewardList:Call()
		battleCardReward.SelectCount = GetBattleCardRewardCount:Call()
		battleCardReward.RewardHp = 0

		PartyGameRpc.instance:BattleCardRewardListPush(battleCardReward)
	end
end

function PartyGameTrialController:trialEnd()
	self:clearTrialData()

	local rank = self:getMainPlayerRank()

	PartyGameRpc.instance:PartyEndPush(rank)
end

function PartyGameTrialController:clearTrialData()
	self._nextGame = nil
	self._nextNeedDel = nil

	PartyGameTrialPlayModel.instance:clearTrialGame()

	self.isInTrial = false
end

function PartyGameTrialController:InTrial()
	return self.isInTrial
end

PartyGameTrialController.instance = PartyGameTrialController.New()

return PartyGameTrialController
