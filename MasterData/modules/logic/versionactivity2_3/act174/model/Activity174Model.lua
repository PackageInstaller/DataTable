-- chunkname: @modules/logic/versionactivity2_3/act174/model/Activity174Model.lua

module("modules.logic.versionactivity2_3.act174.model.Activity174Model", package.seeall)

local Activity174Model = class("Activity174Model", BaseModel)

function Activity174Model:onInit()
	self:reInit()
end

function Activity174Model:reInit()
	self.actInfoDic = {}
	self.turnShowUnlockTeamTipDict = nil
end

function Activity174Model:getCurActId()
	return self.curActId
end

function Activity174Model:getActInfo(actId)
	local id = actId or self:getCurActId()
	local actInfo = self.actInfoDic[id]

	if not actInfo then
		logError("actInfo not exist" .. actId)
	end

	return actInfo
end

function Activity174Model:setActInfo(actId, actInfo)
	self.actInfoDic[actId] = self.actInfoDic[actId] or Act174MO.New()

	self.actInfoDic[actId]:initBadgeInfo(actId)
	self.actInfoDic[actId]:init(actInfo)

	self.curActId = actId
end

function Activity174Model:updateGameInfo(actId, gameInfo, filter)
	local actInfo = self:getActInfo(actId)

	actInfo:updateGameInfo(gameInfo, filter)
	Activity174Controller.instance:dispatchEvent(Activity174Event.UpdateGameInfo)
end

function Activity174Model:updateShopInfo(actId, shopInfo, coin)
	local actInfo = self:getActInfo(actId)

	actInfo:updateShopInfo(shopInfo)

	actInfo.gameInfo.coin = coin
end

function Activity174Model:updateTeamInfo(actId, teamInfo)
	local actInfo = self:getActInfo(actId)

	actInfo:updateTeamInfo(teamInfo)
end

function Activity174Model:updateIsBet(actId, isBet)
	local actInfo = self:getActInfo(actId)

	actInfo:updateIsBet(isBet)
end

function Activity174Model:endGameReply(actId, gaemEndInfo)
	local actInfo = self:getActInfo(actId)

	actInfo.gameInfo.state = Activity174Enum.GameState.None

	actInfo:setEndInfo(gaemEndInfo)
	Activity174Controller.instance:dispatchEvent(Activity174Event.EndGame)
end

function Activity174Model:triggerEffectPush(actId, effectId, param)
	local actInfo = self:getActInfo(actId)

	actInfo:triggerEffectPush(effectId, param)
end

function Activity174Model:initUnlockNewTeamTipCache()
	if self.turnShowUnlockTeamTipDict then
		return
	end

	local strCacheData = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.DouQuQuHasUnlockNewTeam, "")

	if not string.nilorempty(strCacheData) then
		self.turnShowUnlockTeamTipDict = cjson.decode(strCacheData)
	end

	self.turnShowUnlockTeamTipDict = self.turnShowUnlockTeamTipDict or {}
end

function Activity174Model:clearUnlockNewTeamTipCache()
	self.turnShowUnlockTeamTipDict = nil

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.DouQuQuHasUnlockNewTeam, "")
end

function Activity174Model:setHasShowUnlockNewTeamTip(turn)
	self:initUnlockNewTeamTipCache()

	self.turnShowUnlockTeamTipDict[tostring(turn)] = true

	local strData = cjson.encode(self.turnShowUnlockTeamTipDict) or ""

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.DouQuQuHasUnlockNewTeam, strData)
end

function Activity174Model:getIsShowUnlockNewTeamTip(turn)
	local result = false
	local isUnlockNewTeam = Activity174Config.instance:isUnlockNewTeamTurn(turn)

	if isUnlockNewTeam then
		self:initUnlockNewTeamTipCache()

		result = not self.turnShowUnlockTeamTipDict[tostring(turn)]
	end

	return result
end

function Activity174Model:geAttackStatisticsByServerData(serverAttackStatistics, heroUidDict)
	if not serverAttackStatistics then
		return
	end

	local result = {}

	for i, serverStatInfo in ipairs(serverAttackStatistics) do
		local heroId = heroUidDict[serverStatInfo.heroUid]

		if heroId then
			local statInfo = {}

			statInfo.heroUid = serverStatInfo.heroUid
			statInfo.harm = serverStatInfo.harm
			statInfo.hurt = serverStatInfo.hurt
			statInfo.heal = serverStatInfo.heal

			local cards = {}

			for j, v in ipairs(serverStatInfo.cards) do
				local card = {}

				card.skillId = v.skillId
				card.useCount = v.useCount
				cards[j] = card
			end

			statInfo.cards = cards
			statInfo.getBuffs = serverStatInfo.getBuffs

			local roleCo = Activity174Config.instance:getRoleCoByHeroId(heroId)

			statInfo.entityMO = Activity174Helper.getEmptyFightEntityMO(statInfo.heroUid, roleCo)
			result[i] = statInfo
		end
	end

	return result
end

Activity174Model.instance = Activity174Model.New()

return Activity174Model
