﻿-- chunkname: @IQIGame\\UIExternalApi\\AmusementParkBossRankRewardUIApi.lua

AmusementParkBossRankRewardUIApi = BaseLangApi:Extend()

function AmusementParkBossRankRewardUIApi:Init()
	self:RegisterApi("TextRewardIndex", self.GetTextRewardIndex)
	self:RegisterApi("RankRewardIconPath", self.GetRankRewardIconPath)
	self:RegisterApi("MazeBossRankIconPath", self.GetMazeBossRankIconPath)
end

function AmusementParkBossRankRewardUIApi:GetMazeBossRankIconPath(rank, mySelf, type)
	if type == 1 then
		if rank < 11 then
			return self:GetResUrl(2700101)
		elseif rank < 51 then
			return self:GetResUrl(2700101)
		elseif rank < 101 then
			return self:GetResUrl(2700102)
		elseif rank < 501 then
			return self:GetResUrl(2700103)
		elseif rank <= 1000 then
			return self:GetResUrl(2700104)
		end
	elseif type == 2 then
		if rank < 11 then
			return self:GetResUrl(2700105)
		elseif rank < 21 then
			return self:GetResUrl(2700106)
		elseif rank < 31 then
			return self:GetResUrl(2700107)
		elseif rank < 41 then
			return self:GetResUrl(2700108)
		elseif rank < 61 then
			return self:GetResUrl(2700109)
		elseif rank < 81 then
			return self:GetResUrl(2700110)
		elseif rank <= 100 then
			return self:GetResUrl(2700111)
		end
	else
		return self:GetResUrl(2700111)
	end
end

function AmusementParkBossRankRewardUIApi:GetTextRewardIndex(num1, num2, type)
	if type == 1 and num1 > 3 then
		return string.format("%s-%s", num1, num2)
	elseif type == 2 then
		if num1 == 1 then
			return string.format("1001-" .. "%s" .. "%%", num2)
		elseif num1 > 1 then
			return string.format("%s" .. "%%-" .. "%s" .. "%%", num1, num2)
		end
	end

	return ""
end

function AmusementParkBossRankRewardUIApi:GetRankRewardIconPath(num1, num2, type)
	if type == 1 then
		if num1 == 4 then
			return self:GetResUrl(2700101)
		elseif num1 == 11 then
			return self:GetResUrl(2700101)
		elseif num1 == 51 then
			return self:GetResUrl(2700102)
		elseif num1 == 101 then
			return self:GetResUrl(2700103)
		elseif num1 == 501 then
			return self:GetResUrl(2700104)
		end

		return self:GetResUrl(2700104)
	elseif type == 2 then
		if num1 == 1 then
			return self:GetResUrl(2700105)
		elseif num1 == 11 then
			return self:GetResUrl(2700106)
		elseif num1 == 21 then
			return self:GetResUrl(2700107)
		elseif num1 == 31 then
			return self:GetResUrl(2700108)
		elseif num1 == 41 then
			return self:GetResUrl(2700109)
		elseif num1 == 61 then
			return self:GetResUrl(2700110)
		elseif num1 == 81 then
			return self:GetResUrl(2700111)
		end

		return self:GetResUrl(2700111)
	end
end

AmusementParkBossRankRewardUIApi:Init()
