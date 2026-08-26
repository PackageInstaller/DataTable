-- chunkname: @modules/logic/partygame/model/PartyGameModel.lua

module("modules.logic.partygame.model.PartyGameModel", package.seeall)

local PartyGameModel = class("PartyGameModel", BaseModel)

function PartyGameModel:onInit()
	self._playerList = {}
	self._curBattleReward = nil
	self.curLoadedPlayerCount = 1
	self.robotCount = 0
	self.humanCount = 0
	self.playerCount = 0
end

function PartyGameModel:initOrUpdateGamePlayer(players)
	local count = players.Count

	if self._playerList == nil then
		self._playerList = {}
	end

	if tabletool.len(self._playerList) > 0 then
		tabletool.clear(self._playerList)
	end

	self.curLoadedPlayerCount = 1
	self.playerCount = count
	self.robotCount = 0
	self.humanCount = 0

	for i = 1, count do
		local info = players[i - 1]
		local playerData = GamePartyPlayerMo.New()

		playerData:update(info)
		table.insert(self._playerList, playerData)

		if playerData.isRobot == 1 then
			self.curLoadedPlayerCount = self.curLoadedPlayerCount + 1
			self.robotCount = self.robotCount + 1
		else
			self.humanCount = self.humanCount + 1
		end
	end
end

function PartyGameModel:getPlayerCount()
	return self.playerCount
end

function PartyGameModel:getRobotCount()
	return self.robotCount
end

function PartyGameModel:getHumanCount()
	return self.humanCount
end

function PartyGameModel:addGamePlayer(player)
	if self._playerList == nil then
		self._playerList = {}
	end

	table.insert(self._playerList, player)
end

function PartyGameModel:getCurGamePlayerList()
	return self._playerList
end

function PartyGameModel:clearCurGameData()
	if self._playerList then
		tabletool.clear(self._playerList)
	end
end

function PartyGameModel:reInit()
	return
end

local UseLmScenePrefKey = "GM_PartyGame_useLmScene"
local lmSceneGameIds = {
	[1] = true
}

function PartyGameModel:isUseLmScene()
	return PlayerPrefsHelper.getNumber(UseLmScenePrefKey, 0) == 1
end

function PartyGameModel:setUseLmScene(value)
	PlayerPrefsHelper.setNumber(UseLmScenePrefKey, value and 1 or 0)
end

function PartyGameModel:getCurGameResPath()
	local curGame = PartyGameController.instance:getCurPartyGame()

	if curGame == nil then
		logError("当前游戏为nil")

		return ""
	end

	local curGameId = curGame:getGameId()
	local paramCo = lua_partygame_param.configDict[curGameId]
	local assetId = paramCo and paramCo.sceneAssetId

	if not assetId then
		logError("未定义游戏场景资源ID" .. tostring(curGame:getGameId()))

		return ""
	end

	local co = lua_partygame_asset.configDict[assetId]

	if co then
		if not co.filePath then
			local path = ""

			if self:isUseLmScene() and lmSceneGameIds[curGameId] then
				return string.format("%s_lm.prefab", path)
			end

			return string.format("%s.prefab", path)
		end
	end
end

function PartyGameModel:updateCurBattleRewardInfo(data)
	if self._curBattleReward == nil then
		self._curBattleReward = BattleCardRewardMo.New()
	end

	self._curBattleReward:update(data)
end

function PartyGameModel:getCurBattleRewardInfo()
	return self._curBattleReward
end

function PartyGameModel:getCurGameIsTeamType()
	if self._playerList == nil or tabletool.len(self._playerList) <= 0 then
		return false
	end

	return self._playerList[1].tempType ~= PartyGameEnum.GamePlayerTeamType.None
end

function PartyGameModel:setCacheNeedTranGameMsg(msg)
	self._nextTranToGameMsg = msg
end

function PartyGameModel:getCacheNeedTranGameMsg()
	return self._nextTranToGameMsg
end

function PartyGameModel:getMainPlayerMo()
	local curGame = PartyGameController.instance:getCurPartyGame()

	if curGame ~= nil then
		return self:getPlayerMoByUid(curGame:getMainPlayerUid())
	end

	return nil
end

function PartyGameModel:getPlayerMoByUid(uid)
	for i = 1, #self._playerList do
		local mo = self._playerList[i]

		if tostring(mo.uid) == tostring(uid) then
			return mo
		end
	end

	return nil
end

function PartyGameModel:getPlayerMoByIndex(index)
	for i = 1, #self._playerList do
		local mo = self._playerList[i]

		if mo.index == index then
			return mo
		end
	end

	return nil
end

function PartyGameModel:IsMainUid(uid)
	local curGame = PartyGameController.instance:getCurPartyGame()

	if curGame ~= nil then
		return tostring(curGame:getMainPlayerUid()) == tostring(uid)
	end

	return false
end

function PartyGameModel:getAllTeamPlayerMoByUid(teamType)
	local allPlayerMo = {}

	for i = 1, #self._playerList do
		local mo = self._playerList[i]

		if mo.tempType == teamType then
			table.insert(allPlayerMo, mo)
		end
	end

	return allPlayerMo
end

function PartyGameModel:getAllCardByServerPlayers(serverPlayers, uid)
	if serverPlayers == nil then
		return nil
	end

	local allCard = {}
	local count = serverPlayers.Count

	for i = 1, count do
		local info = serverPlayers[i - 1]

		if info.Uid == uid then
			local cardIds = info.CardIds

			if cardIds ~= nil then
				for j = 0, cardIds.Count - 1 do
					table.insert(allCard, cardIds[j])
				end
			end
		end
	end

	return allCard
end

function PartyGameModel:clear()
	if self._playerList then
		tabletool.clear(self._playerList)
	end
end

PartyGameModel.instance = PartyGameModel.New()

return PartyGameModel
