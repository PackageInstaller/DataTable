-- chunkname: @IQIGame\\UIExternalApi\\LotteryRewardListUIApi.lua

LotteryRewardListUIApi = BaseLangApi:Extend()

function LotteryRewardListUIApi:GetTabText(type)
	if type == Constant.ItemType.Hero then
		return self:GetCfgText(1300009)
	elseif type == Constant.ItemType.Skill then
		return self:GetCfgText(2000002)
	elseif type == -1 then
		return self:GetCfgText(180001)
	elseif type == -2 then
		return self:GetCfgText(180002)
	end

	return ""
end

function LotteryRewardListUIApi:GetTabHero()
	return self:GetCfgText(1300009)
end

function LotteryRewardListUIApi:GetTabSkill()
	return self:GetCfgText(2000002)
end

function LotteryRewardListUIApi:GetTabUpItem()
	return self:GetCfgText(180002)
end

function LotteryRewardListUIApi:GetTabDescription()
	return self:GetCfgText(180001)
end

function LotteryRewardListUIApi:GetRewardListTitle(num, type)
	if type == Constant.ItemType.Hero then
		return string.format(self:GetCfgText(1600050), num)
	elseif type == Constant.ItemType.Skill then
		return string.format(self:GetCfgText(1600051), num)
	else
		return "xxxx"
	end
end

function LotteryRewardListUIApi:GetPoolOtherTitle()
	return self:GetCfgText(1600052)
end
