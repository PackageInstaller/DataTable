-- chunkname: @IQIGame\\Module\\CommonActivity\\FishingActivity\\FishingActivitySkillData.lua

local m = {
	lv = 1,
	cid = 0
}

function m.New(cid, lv)
	local o = Clone(m)

	o:Init(cid, lv)

	return o
end

function m:Init(cid, lv)
	self.cid = cid

	self:SetLv(lv)
end

function m:SetLv(lv)
	self.lv = lv > self:GetCfgData().LevelMax and self:GetCfgData().LevelMax or lv
end

function m:isMaxLv()
	return self.lv >= self:GetCfgData().LevelMax
end

function m:GetCfgData()
	return CfgFishActiveSkillTable[self.cid]
end

function m:GetCfgLvData()
	local skillLevelID = self:GetCfgData().SkillGroup[self.lv]

	return CfgFishActiveSkillLevelTable[skillLevelID]
end

return m
