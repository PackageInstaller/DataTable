-- chunkname: @modules/logic/toughbattle/model/ToughBattleModel.lua

module("modules.logic.toughbattle.model.ToughBattleModel", package.seeall)

local ToughBattleModel = class("ToughBattleModel", BaseModel)

function ToughBattleModel:onInit()
	self._isActOnline = false
	self._actInfo = nil
	self._storyInfo = nil
	self._isJumpToActElement = false
end

function ToughBattleModel:reInit()
	self:onInit()
end

function ToughBattleModel:getIsJumpActElement()
	return self._isJumpToActElement
end

function ToughBattleModel:setIsJumpActElement(isJump)
	self._isJumpToActElement = isJump
end

function ToughBattleModel:getActIsOnline()
	return self._isActOnline
end

function ToughBattleModel:setActOffLine()
	self._isActOnline = false
	self._actInfo = nil
end

function ToughBattleModel:onGetActInfo(msg)
	self._isActOnline = true
	self._actInfo = msg

	ToughBattleController.instance:dispatchEvent(ToughBattleEvent.ToughBattleActChange)
end

function ToughBattleModel:getActInfo()
	return self._actInfo
end

function ToughBattleModel:isDropActItem()
	if not self:getActIsOnline() then
		return true
	end

	return #self._actInfo.enterDifficulty < 3
end

function ToughBattleModel:onGetStoryInfo(msg)
	self._storyInfo = msg
end

function ToughBattleModel:getStoryInfo()
	return self._storyInfo
end

function ToughBattleModel:isStoryFinish()
	if not self._storyInfo then
		return false
	end

	return self._storyInfo.openChallenge and #self._storyInfo.passChallengeIds >= 4
end

function ToughBattleModel:getEpisodeId()
	local fightParam = FightModel.instance:getFightParam()

	if not fightParam then
		return false
	end

	local episodeId = fightParam.episodeId

	if not episodeId then
		return false
	end

	local co = ToughBattleConfig.instance:getCoByEpisodeId(episodeId)

	if not co then
		return false
	end

	return episodeId
end

function ToughBattleModel:getAddTrialHeros()
	local episodeId = self:getEpisodeId()

	if not episodeId then
		return false
	end

	local co = ToughBattleConfig.instance:getCoByEpisodeId(episodeId)

	if not co then
		return false
	end

	local isAct = ToughBattleConfig.instance:isActEpisodeId(episodeId)
	local heroIds = {}

	if isAct then
		local info = self:getActInfo()

		if not info then
			return false
		end

		for _, id in ipairs(info.passChallengeIds) do
			local actCo = lua_activity158_challenge.configDict[id]

			if actCo and actCo.heroId > 0 then
				local heroCo = lua_siege_battle_hero.configDict[actCo.heroId]

				if heroCo and heroCo.type == ToughBattleEnum.HeroType.Hero then
					table.insert(heroIds, tonumber(heroCo.param))
				end
			end
		end
	else
		local info = self:getStoryInfo()

		if not info then
			return false
		end

		for _, id in ipairs(info.passChallengeIds) do
			local storyCo = lua_siege_battle.configDict[id]

			if storyCo and storyCo.heroId > 0 then
				local heroCo = lua_siege_battle_hero.configDict[storyCo.heroId]

				if heroCo and heroCo.type == ToughBattleEnum.HeroType.Hero then
					table.insert(heroIds, tonumber(heroCo.param))
				end
			end
		end
	end

	if not heroIds[1] then
		return false
	end

	return heroIds
end

ToughBattleModel.instance = ToughBattleModel.New()

return ToughBattleModel
