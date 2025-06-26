-- chunkname: @IQIGame\\UIExternalApi\\LotteryRecordsUIApi.lua

LotteryRecordsUIApi = BaseLangApi:Extend()

function LotteryRecordsUIApi:GetBottomTips()
	return self:GetCfgText(1600053)
end

function LotteryRecordsUIApi:GetTopTitles(index)
	if index == 1 then
		return self:GetCfgText(1600054)
	elseif index == 2 then
		return self:GetCfgText(1600055)
	elseif index == 3 then
		return self:GetCfgText(1600056)
	elseif index == 4 then
		return self:GetCfgText(1600057)
	elseif index == 5 then
		return self:GetCfgText(1600052)
	end
end

function LotteryRecordsUIApi:GetItemTypeText(type, subType)
	if type == Constant.ItemType.Skill then
		return self:GetCfgText(2000002)
	elseif type == Constant.ItemType.Hero then
		return self:GetCfgText(1300009)
	elseif type == Constant.ItemType.HeroDebris then
		return self:GetCfgText(1600058)
	elseif type == Constant.ItemType.HeroDebris then
		return self:GetCfgText(1600058)
	elseif type == Constant.ItemType.Item and subType ~= nil then
		if subType == Constant.ItemSubType[Constant.ItemType.Item].LifeCore then
			return self:GetCfgText(1600060)
		else
			return self:GetCfgText(400)
		end
	end
end
