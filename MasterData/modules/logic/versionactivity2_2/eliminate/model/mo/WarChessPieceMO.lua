-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/mo/WarChessPieceMO.lua

module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessPieceMO", package.seeall)

local WarChessPieceMO = class("WarChessPieceMO")

function WarChessPieceMO:init(info)
	self.uid = info.uid
	self.id = info.id
	self.battle = info.battle
	self.teamType = info.teamType
	self.displacementState = info.displacementState

	if info.skill then
		self.skill = GameUtil.rpcInfosToList(info.skill, WarChessPieceSkillMO)
	end
end

function WarChessPieceMO:updatePower(diffValue)
	self.battle = math.max(self.battle + diffValue, 0)
end

function WarChessPieceMO:updateDisplacementState(displacementState)
	self.displacementState = displacementState
end

function WarChessPieceMO:canActiveMove()
	if self.displacementState then
		local curRound = EliminateLevelModel.instance:getRoundNumber()
		local totalUseCountLimit = self.displacementState.totalUseCountLimit
		local totalUseCount = self.displacementState.totalUseCount
		local effectRound = self.displacementState.effectRound
		local roundUseCount = 0

		if self.displacementState.roundUseCount then
			for _, roundData in ipairs(self.displacementState.roundUseCount) do
				if roundData.round == curRound then
					roundUseCount = roundData.count
				end
			end
		end

		local roundUseCountLimit = self.displacementState.perRoundUseCountLimit

		if effectRound <= curRound and roundUseCount < roundUseCountLimit and totalUseCount < totalUseCountLimit then
			return true
		end
	end

	return false
end

function WarChessPieceMO:getDisplacementState()
	return self.displacementState
end

function WarChessPieceMO:updateSkillGrowUp(skillId, upValue)
	if self.skill == nil then
		return false
	end

	for i = 1, #self.skill do
		local skill = self.skill[i]

		if skill.id == skillId then
			skill:updateSkillGrowUp(upValue)

			return true
		end
	end

	return false
end

function WarChessPieceMO:getSkill(skillId)
	if self.skill == nil then
		return nil
	end

	for i = 1, #self.skill do
		local skill = self.skill[i]

		if skill.id == skillId then
			return skill
		end
	end

	return nil
end

function WarChessPieceMO:getActiveSkill()
	if self.skill ~= nil and #self.skill > 0 then
		return self.skill[1]
	end
end

function WarChessPieceMO:diffData(data)
	local isSame = self.battle == data.battle

	if self.teamType ~= data.teamType then
		isSame = false
	end

	if self.uid ~= data.uid then
		isSame = false
	end

	return (self.id ~= data.id or nil) and false
end

return WarChessPieceMO
