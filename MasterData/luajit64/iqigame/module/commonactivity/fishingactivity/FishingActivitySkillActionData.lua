-- chunkname: @IQIGame\\Module\\CommonActivity\\FishingActivity\\FishingActivitySkillActionData.lua

local m = {
	lv = 0,
	isUnlock = false
}

function m.New(cid, lv)
	local o = Clone(m)

	o:Init(cid, lv)

	return o
end

function m:Init(cid, lv)
	self.cid = cid

	self:SetLv(lv)
	self:RefreshUnlock()
end

function m:SetLv(lv)
	self.lv = lv > self:GetCfgData().LevelMax and self:GetCfgData().LevelMax or lv
end

function m:RefreshUnlock()
	if not self.isUnlock then
		self.isUnlock = FishingActivityModule.SkillActionIsUnlock(self.cid)
	end
end

function m:IsMaxLv()
	return self.lv >= self:GetCfgData().LevelMax
end

function m:GetCfgData()
	return CfgFishActiveSkillActionTable[self.cid]
end

function m:GetCfgLvData()
	local actionLevelID = self:GetCfgData().SkillActionGroup[self.lv]

	return CfgFishActiveSkillActionLevelTable[actionLevelID]
end

return m
