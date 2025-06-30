-- chunkname: @IQIGame\\Module\\Battle\\BattleData\\BattlePreviewSkillData.lua

local BattlePreviewSkillData = {
	anchorTilePos = -1,
	skillCid = 0,
	targetTilePosTable = {}
}

BattlePreviewSkillData.EmptyAnchorTilePos = -1

function BattlePreviewSkillData.New(skillCid, args)
	local obj = Clone(BattlePreviewSkillData)

	obj:__Init(skillCid, args)

	return obj
end

function BattlePreviewSkillData:__Init(skillCid, args)
	self.skillCid = skillCid
	self.anchorTilePos = BattlePreviewSkillData.EmptyAnchorTilePos

	ForPairs(args, function(_tilePos, v)
		local tilePos = TryToNumber(_tilePos, 0)

		if self.anchorTilePos == BattlePreviewSkillData.EmptyAnchorTilePos then
			self.anchorTilePos = tilePos
		end

		self.targetTilePosTable[tilePos] = v
	end)
end

function BattlePreviewSkillData:UpdateTargetTilePosTable(param)
	self.targetTilePosTable = {}
	self.anchorTilePos = BattlePreviewSkillData.EmptyAnchorTilePos

	ForArrayByCount(2, 999, 2, function(_index)
		if param[_index] == nil then
			return true
		end

		local tilePos = TryToNumber(param[_index])

		self.targetTilePosTable[tilePos] = param[_index + 1]

		if self.anchorTilePos == BattlePreviewSkillData.EmptyAnchorTilePos then
			self.anchorTilePos = tilePos
		end
	end)
end

return BattlePreviewSkillData
