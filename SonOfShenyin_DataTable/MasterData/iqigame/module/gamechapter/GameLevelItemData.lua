-- chunkname: @IQIGame\\Module\\GameChapter\\GameLevelItemData.lua

GameLevelItemData = {
	isUnLock = false
}

function GameLevelItemData.New()
	return Clone(GameLevelItemData)
end

function GameLevelItemData:UpdateData(_id, data, isunlock)
	self.Id = _id
	self.MonsterTeam = self:GetCfg().MonsterTeam
	self.isUnLock = isunlock

	if data == {} or data == nil then
		return
	end

	self.star = data.star
	self.formationId = data.formationId
	self.heros = data.heros
end

function GameLevelItemData:GetCfg()
	return CfgChapterPassTable[self.Id]
end

function GameLevelItemData:GetLevelMonsterTeam()
	return CfgMonsterTeamTable[self.MonsterTeam]
end
