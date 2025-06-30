-- chunkname: @IQIGame\\UIExternalApi\\ChapterStageMapUIApi.lua

ChapterStageMapUIApi = BaseLangApi:Extend()

function ChapterStageMapUIApi:Init()
	self:RegisterApi("", self.Get)
end

function ChapterStageMapUIApi:GetLevelTipsTitle()
	return self:GetCfgText(110001)
end

function ChapterStageMapUIApi:GetHeroTipsTitle()
	return self:GetCfgText(110002)
end

function ChapterStageMapUIApi:GetResourceDiffTitle()
	return self:GetCfgText(110003)
end

function ChapterStageMapUIApi:GetResourceLevelTitle()
	return self:GetCfgText(110004)
end

function ChapterStageMapUIApi:GetLvText()
	return self:GetCfgText(6000035)
end

function ChapterStageMapUIApi:GetElementTitleText()
	return self:GetCfgText(110006)
end

function ChapterStageMapUIApi:GetMapTitleText()
	return self:GetCfgText(110007)
end

function ChapterStageMapUIApi:GetRewardTitleText()
	return self:GetCfgText(110008)
end

function ChapterStageMapUIApi:GetStoryRoleHeadImgPath(roleId)
	return string.format(self:GetResUrl(1600009), CfgHeroSkinTable[roleId].HeadIcon)
end

function ChapterStageMapUIApi:GetElementImgPath(element)
	return string.format(self:GetResUrl(17001), element)
end

function ChapterStageMapUIApi:GetMapInfoImgPath(index)
	return string.format(self:GetResUrl(2304), index)
end

function ChapterStageMapUIApi:GetStageItemTypeText(type)
	if type == Constant.MapStageType.MainLine then
		return self:GetCfgText(111024)
	elseif type == Constant.MapStageType.BranchLine then
		return self:GetCfgText(111025)
	else
		return self:GetCfgText(111026)
	end
end

function ChapterStageMapUIApi:GetStageTypeTitleImage(type)
	return string.format(self:GetResUrl(2305), type)
end

function ChapterStageMapUIApi:GetStageTypeListImage(type)
	return string.format(self:GetResUrl(2306), type)
end

function ChapterStageMapUIApi:GetStageDetailsTypeImage(type)
	return string.format(self:GetResUrl(2307), type)
end

function ChapterStageMapUIApi:GetMapWeatherImage(weatherType)
	return string.format(self:GetResUrl(2308), weatherType)
end

function ChapterStageMapUIApi:GetStageTypeText(type)
	if type == 1 then
		return self:GetCfgText(111027)
	elseif type == 2 then
		return self:GetCfgText(110005)
	elseif type == 3 then
		return self:GetCfgText(111028)
	else
		return self:GetCfgText(110005)
	end
end

function ChapterStageMapUIApi:GetMarkImagePath(img)
	return string.format(self:GetResUrl(2310), img)
end

function ChapterStageMapUIApi:GetChallengeText(type)
	if type == 1 then
		return self:GetCfgText(112001), self:GetCfgText(112002)
	elseif type == 2 then
		return self:GetCfgText(112003), self:GetCfgText(112004)
	end
end

function ChapterStageMapUIApi:GetPlayerHeroImagePath(sex)
	if sex == Constant.PlayerSex.Man then
		return UIGlobalApi.GetImagePath("/DataResource/UIResource/ChapterCommonImg/Common_PlayerHeadImg_Man.png")
	elseif sex == Constant.PlayerSex.WoMen then
		return UIGlobalApi.GetImagePath("/DataResource/UIResource/ChapterCommonImg/Common_PlayerHeadImg_Women.png")
	else
		return UIGlobalApi.GetImagePath("/DataResource/UIResource/ChapterCommonImg/Common_PlayerHeadImg_Man.png")
	end
end

ChapterStageMapUIApi:Init()
