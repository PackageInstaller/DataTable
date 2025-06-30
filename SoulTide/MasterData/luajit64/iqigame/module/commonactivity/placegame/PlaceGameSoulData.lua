-- chunkname: @IQIGame\\Module\\CommonActivity\\PlaceGame\\PlaceGameSoulData.lua

local m = {}

function m.New(cid, placeGameSoulPOD)
	local o = Clone(m)

	o:Init(cid, placeGameSoulPOD)

	return o
end

function m:Init(cid, placeGameSoulPOD)
	self.cid = cid

	self:UpdatePOD(placeGameSoulPOD)
end

function m:UpdatePOD(placeGameSoulPOD)
	self.placeGameSoulPOD = placeGameSoulPOD
end

function m:GetCfgPlaceGameSoulData()
	return CfgPlaceGameSoulTable[self.cid]
end

function m:GetCfgPlaceGameSoulLevelData()
	return CfgPlaceGameSoulLevelTable[self.placeGameSoulPOD.level]
end

function m:GetCfgSoulData()
	return CfgSoulTable[self:GetCfgPlaceGameSoulData().SoulID]
end

function m:GetSoulCanUpdateMaxLv()
	local soulUpdateMaxLv = 1
	local finishTowerLV = 0
	local maxFinish = PlaceGameModule.DailyDupPOD.placeGamePOD.customs

	if maxFinish > 0 then
		finishTowerLV = CfgPlaceGameTowerTable[maxFinish].Floor
	end

	for i, v in pairsCfg(CfgPlaceGameSoulLevelTable) do
		if v.Group == PlaceGameModule.GlobalCid and soulUpdateMaxLv < v.Level and finishTowerLV >= v.NeedTower then
			soulUpdateMaxLv = v.Level
		end
	end

	return soulUpdateMaxLv
end

function m:GetSkillStrengthenLevel()
	local skillStrengthens = {}

	for i = 1, #self:GetCfgPlaceGameSoulData().SkillStrengthenId do
		local unlockSkillStrengthIds = self:GetCfgPlaceGameSoulData().SkillStrengthenId[i]

		for j = 1, #unlockSkillStrengthIds do
			local skillStrengthenID = unlockSkillStrengthIds[j]
			local needLv = self:GetCfgPlaceGameSoulData().UnLockSkillStrengthenLevel[j]

			if needLv <= self.placeGameSoulPOD.level then
				table.insert(skillStrengthens, skillStrengthenID)
			end
		end
	end

	local lv = 0

	for i = 1, #self:GetCfgPlaceGameSoulData().UnLockSkillStrengthenLevel do
		local needLv = self:GetCfgPlaceGameSoulData().UnLockSkillStrengthenLevel[i]

		if needLv <= self.placeGameSoulPOD.level then
			lv = lv + 1
		end
	end

	return skillStrengthens, lv
end

function m:GetFeatureEffectDesc(skillId)
	local effectTxt = CfgSkillTable[skillId].EffectText
	local ret

	for i, v in pairs(self:GetCfgPlaceGameSoulData().ADDSkillStrengthen) do
		local cfgStrengthenData = CfgSkillStrengthenTable[v]

		if cfgStrengthenData.INSkill == skillId and cfgStrengthenData.StrengthenType == 2 then
			if ret == nil then
				ret = cfgStrengthenData
			elseif cfgStrengthenData.Order > ret.Order then
				ret = cfgStrengthenData
			end
		end
	end

	if ret ~= nil then
		effectTxt = ret.Describe
	end

	return effectTxt
end

return m
