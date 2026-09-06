-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/model/RankRaceResultModel.lua

module("logic.extensions.rankrace.model.RankRaceResultModel", package.seeall)

local RankRaceResultModel = class("RankRaceResultModel", BaseListModel)

RankRaceResultModel.State_Normal = 1
RankRaceResultModel.State_Exit = 2
RankRaceResultModel.State_PlayerExit = 3
RankRaceResultModel.State_Failed = -1
RankRaceResultModel.BattleRes_Lose = -1
RankRaceResultModel.BattleRes_DogFall = 0
RankRaceResultModel.BattleRes_Win = 1
RankRaceResultModel.ResStage_Mine = 1
RankRaceResultModel.ResStage_Enermy = 2
RankRaceResultModel.ResStage_Result = 3

function RankRaceResultModel:onInit()
	RankRaceResultModel.super.onInit(self)
end

function RankRaceResultModel:onReset()
	RankRaceResultModel.super.onReset(self)

	self._rankRaceResult = nil
	self._battleResultStage = nil
end

function RankRaceResultModel:notifyGameResult(msg)
	self._rankRaceResult = msg

	self:setBattleResultStage(RankRaceResultModel.ResStage_Mine)
end

function RankRaceResultModel:clearGameResult()
	self._rankRaceResult = nil
	self._battleResultStage = nil
end

function RankRaceResultModel:setBattleResultStage(stage)
	self._battleResultStage = stage
end

function RankRaceResultModel:getBattleResultStage()
	return self._battleResultStage
end

function RankRaceResultModel:hasGameResult()
	return self._rankRaceResult ~= nil
end

function RankRaceResultModel:getRankRaceState()
	if self._rankRaceResult then
		return self._rankRaceResult.state
	end

	return RankRaceResultModel.State_Exit
end

function RankRaceResultModel:getOriginStar()
	if self._rankRaceResult then
		return self._rankRaceResult.originStar
	end

	return 0
end

function RankRaceResultModel:getAddStar()
	if self._rankRaceResult then
		return self._rankRaceResult.addStar
	end

	return 0
end

function RankRaceResultModel:getOriginRank()
	if self._rankRaceResult then
		return self._rankRaceResult.originRank
	end

	return 0
end

function RankRaceResultModel:getCurrRank()
	if self._rankRaceResult then
		return self._rankRaceResult.curRank
	end

	return 0
end

function RankRaceResultModel:getBattleResult()
	if self._rankRaceResult then
		return self._rankRaceResult.result
	end

	return RankRaceResultModel.BattleRes_Lose
end

function RankRaceResultModel:getWinMyDeclaration()
	if self._rankRaceResult then
		return self._rankRaceResult.myWinDeclaration
	end

	return -1
end

function RankRaceResultModel:getMyLoseDeclaration()
	if self._rankRaceResult then
		return self._rankRaceResult.myLoseDeclaration
	end

	return -1
end

function RankRaceResultModel:getOpWinDeclaration()
	if self._rankRaceResult then
		return self._rankRaceResult.opWinDeclaration
	end

	return -1
end

function RankRaceResultModel:getOpLoseDeclaration()
	if self._rankRaceResult then
		return self._rankRaceResult.opLoseDeclaration
	end

	return -1
end

function RankRaceResultModel:getMyPetLeftCount()
	if self._rankRaceResult then
		return self._rankRaceResult.myPetLeftCount
	end

	return 0
end

function RankRaceResultModel:getOpPetLeftCount()
	if self._rankRaceResult then
		return self._rankRaceResult.opPetLeftCount
	end

	return 0
end

function RankRaceResultModel:getAttackResult()
	if self._rankRaceResult and self._rankRaceResult:HasField("attackResult") then
		return self._rankRaceResult.attackResult
	end
end

function RankRaceResultModel:getDefenseResult()
	if self._rankRaceResult and self._rankRaceResult:HasField("defenseResult") then
		return self._rankRaceResult.defenseResult
	end
end

function RankRaceResultModel:getRemainPetHpsFromResult(result)
	local allPets = self:_getAllPetsFromResult(result)

	if not result then
		return
	end

	local oneFightResult = result.oneFightResult

	for i = 1, #oneFightResult.roundList do
		local round = oneFightResult.roundList[i]

		if round:HasField("oneCircleBeforeResult") then
			local characterResult = round.oneCircleBeforeResult.circleBeforeOneRoundCharacterResult

			self:_parseAliveFromCharactorResults(allPets, characterResult.targetCharacterResults)
		end

		if round:HasField("oneRoundCharacterResult") then
			self:_parseAliveFromCharactorResults(allPets, round.oneRoundCharacterResult.targetCharacterResults)
		end

		if round:HasField("oneCircleAfterResult") then
			self:_parseAliveFromCharactorResults(allPets, round.oneCircleAfterResult.targetCharacterResults)
		end
	end

	local finalPets = {}

	for k, v in pairs(allPets) do
		local pets = finalPets[k]

		if not pets then
			pets = {}
			finalPets[k] = pets
		end

		for k1, v1 in pairs(v) do
			pets[v1.pos] = v1
		end
	end

	return finalPets
end

function RankRaceResultModel:_getAllPetsFromResult(result)
	local allPets = {}

	if not result then
		return
	end

	local teams = result.originalStates.teams

	for k, v in ipairs(teams) do
		local pets = allPets[v.teamId]

		if not pets then
			pets = {}
			allPets[v.teamId] = pets
		end

		local characterViews = v.playerView.characterViews

		for i = 1, #characterViews do
			if not characterViews[i].isDoppelganger then
				local id = characterViews[i].id
				local petInfo = {}

				petInfo.id = id
				petInfo.pos = characterViews[i].y * 3 + characterViews[i].x + 1
				petInfo.raceId = characterViews[i].raceId
				petInfo.curFaceId = characterViews[i].curFaceId
				pets[id] = petInfo
			end
		end
	end

	return allPets
end

function RankRaceResultModel:_parseAliveFromCharactorResults(allPets, targetCharacterResults)
	for i = 1, #targetCharacterResults do
		local tgtCharacterResult = targetCharacterResults[i]
		local target = allPets[tgtCharacterResult.target.targetTeamId][tgtCharacterResult.target.targetCharacterId]

		if target then
			local targetNum = tgtCharacterResult.targetNum

			if targetNum and targetNum:HasField("afterRoundHp") then
				target.isDead = targetNum.afterRoundHp == 0
			end
		end
	end
end

function RankRaceResultModel:setReason(flag)
	self._reason = flag
end

function RankRaceResultModel:getReason()
	return self._reason
end

function RankRaceResultModel:getOriginLegendRankScore()
	if self._rankRaceResult then
		return self._rankRaceResult.originLegendRankScore
	end

	return 0
end

function RankRaceResultModel:getCurrLegendRankScore()
	if self._rankRaceResult then
		return self._rankRaceResult.curLegendRankScore
	end

	return 0
end

RankRaceResultModel.instance = RankRaceResultModel.New()

return RankRaceResultModel
