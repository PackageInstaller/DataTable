-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/mo/EliminateTeamChessWarMO.lua

module("modules.logic.versionactivity2_2.eliminate.model.mo.EliminateTeamChessWarMO", package.seeall)

local EliminateTeamChessWarMO = class("EliminateTeamChessWarMO")

function EliminateTeamChessWarMO:init(warInfo)
	self.id = warInfo.id
	self.myCharacter = WarChessCharacterMO.New()
	self.enemyCharacter = WarChessCharacterMO.New()
	self.strongholds = {}
	self.winCondition = warInfo.winCondition
	self.extraWinCondition = warInfo.extraWinCondition

	self.myCharacter:init(warInfo.myCharacter)
	self.enemyCharacter:init(warInfo.enemyCharacter)
	self:updateInfo(warInfo)
end

function EliminateTeamChessWarMO:updateInfo(warInfo)
	self.round = warInfo.round

	self.myCharacter:updateInfo(warInfo.myCharacter)
	self.enemyCharacter:updateInfo(warInfo.enemyCharacter)

	if warInfo.stronghold then
		tabletool.clear(self.strongholds)

		self.strongholds = GameUtil.rpcInfosToList(warInfo.stronghold, WarChessStrongholdMO)

		table.sort(self.strongholds, function(a, b)
			return a.id < b.id
		end)
	end

	self.winCondition = warInfo.winCondition
	self.extraWinCondition = warInfo.extraWinCondition

	self:updateStar()
end

function EliminateTeamChessWarMO:updateCondition(winCondition, extraWinCondition)
	local isChange = self.winCondition ~= winCondition or self.extraWinCondition ~= extraWinCondition

	self.winCondition = winCondition
	self.extraWinCondition = extraWinCondition

	self:updateStar()

	return isChange
end

function EliminateTeamChessWarMO:updateStar()
	local star = 0

	if self:winConditionIsFinish() then
		star = star + 1
	end

	if self:extraWinConditionIsFinish() then
		star = star + 1
	end

	EliminateLevelModel.instance:setStar(star)
end

function EliminateTeamChessWarMO:updateForecastBehavior(forecastChessIds)
	self.enemyCharacter:updateForecastBehavior(forecastChessIds)
end

function EliminateTeamChessWarMO:getSlotIds()
	return self.myCharacter.slotIds
end

function EliminateTeamChessWarMO:getStrongholds()
	return self.strongholds
end

function EliminateTeamChessWarMO:getStronghold(id)
	for _, data in ipairs(self.strongholds) do
		if data.id == id then
			return data
		end
	end

	return nil
end

function EliminateTeamChessWarMO:updateChessPower(uid, diffValue)
	if self.strongholds then
		for i = 1, #self.strongholds do
			local data = self.strongholds[i]

			if data:updateChessPower(uid, diffValue) then
				return
			end
		end
	end
end

function EliminateTeamChessWarMO:updateSkillGrowUp(uid, skillId, upValue)
	if self.strongholds then
		for i = 1, #self.strongholds do
			local data = self.strongholds[i]

			if data:updateSkillGrowUp(uid, skillId, upValue) then
				return
			end
		end
	end
end

function EliminateTeamChessWarMO:updateDisplacementState(uid, displacementState)
	if self.strongholds then
		for i = 1, #self.strongholds do
			local data = self.strongholds[i]

			if data:updateDisplacementState(uid, displacementState) then
				return
			end
		end
	end
end

function EliminateTeamChessWarMO:updateStrongholdsScore(strongholdId, teamType, diffValue)
	if self.strongholds then
		for i = 1, #self.strongholds do
			local data = self.strongholds[i]

			if data.id == strongholdId then
				data:updateScore(teamType, diffValue)

				return
			end
		end
	end
end

function EliminateTeamChessWarMO:updateMainCharacterHp(teamType, diffValue)
	if teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		self.myCharacter:updateHp(diffValue)
	end

	if teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		self.enemyCharacter:updateHp(diffValue)
	end
end

function EliminateTeamChessWarMO:updateMainCharacterPower(teamType, diffValue)
	if teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		self.myCharacter:updatePower(diffValue)
	end

	if teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		self.enemyCharacter:updatePower(diffValue)
	end
end

function EliminateTeamChessWarMO:updateResourceData(resourceId, diffValue)
	if self.myCharacter then
		self.myCharacter:updateDiamondInfo(resourceId, diffValue)
	end
end

function EliminateTeamChessWarMO:removeStrongholdChess(strongholdId, uid)
	if self.strongholds then
		for i = 1, #self.strongholds do
			local data = self.strongholds[i]

			if data.id == strongholdId then
				data:removeChess(uid)

				return
			end
		end
	end
end

function EliminateTeamChessWarMO:getChess(uid)
	if self.strongholds then
		for i = 1, #self.strongholds do
			local data = self.strongholds[i]
			local chess = data:getChess(uid)

			if chess then
				return chess
			end
		end
	end

	return nil
end

function EliminateTeamChessWarMO:strongHoldSettle(strongholdId, state)
	if self.strongholds then
		for i = 1, #self.strongholds do
			local data = self.strongholds[i]

			if data.id == strongholdId then
				data:updateStatus(state)

				return
			end
		end
	end
end

function EliminateTeamChessWarMO:diamondsIsEnough(diamondId, needCount)
	if not self.myCharacter then
		return false
	end

	return self.myCharacter:diamondsIsEnough(diamondId, needCount)
end

function EliminateTeamChessWarMO:winConditionIsFinish()
	return self.winCondition == 1
end

function EliminateTeamChessWarMO:extraWinConditionIsFinish()
	return self.extraWinCondition == 1
end

function EliminateTeamChessWarMO:diffTeamChess(diffChessWarMo)
	local isSame = self.id == diffChessWarMo.id

	if not self.myCharacter:diffData(diffChessWarMo.myCharacter) then
		isSame = false
	end

	if not self.enemyCharacter:diffData(diffChessWarMo.enemyCharacter) then
		isSame = false
	end

	if #self.strongholds ~= #diffChessWarMo.strongholds then
		isSame = false
	end

	if self.round ~= diffChessWarMo.round then
		isSame = false
	end

	for i = 1, #self.strongholds do
		local data = self.strongholds[i]
		local diffData = diffChessWarMo:getStronghold(data.id)

		if not data:diffData(diffData) then
			isSame = false
		end
	end

	return isSame
end

return EliminateTeamChessWarMO
