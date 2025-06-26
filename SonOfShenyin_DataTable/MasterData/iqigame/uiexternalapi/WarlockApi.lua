-- chunkname: @IQIGame\\UIExternalApi\\WarlockApi.lua

WarlockApi = BaseLangApi:Extend()

function WarlockApi:Init()
	self:RegisterApi("ElementDes_1", self.GetTextTitle_1)
	self:RegisterApi("ElementDes_2", self.GetTextTitle_2)
	self:RegisterApi("ElementDes_3", self.GetTextTitle_3)
	self:RegisterApi("ElementDes_4", self.GetTextTitle_4)
	self:RegisterApi("PrefessionDes_1", self.GetTextTitle_5)
	self:RegisterApi("PrefessionDes_2", self.GetTextTitle_6)
	self:RegisterApi("PrefessionDes_3", self.GetTextTitle_7)
	self:RegisterApi("PrefessionDes_4", self.GetTextTitle_8)
	self:RegisterApi("InfluenceDes_1", self.GetTextTitle_9)
	self:RegisterApi("InfluenceDes_2", self.GetTextTitle_10)
	self:RegisterApi("InfluenceDes_3", self.GetTextTitle_11)
	self:RegisterApi("ElementDes", self.GetTextTitle_15)
	self:RegisterApi("ProfessionDes", self.GetTextTitle_16)
	self:RegisterApi("InfluenceDes", self.GetTextTitle_17)
	self:RegisterApi("OtherDes1", self.GetTextTitle_14)
	self:RegisterApi("OtherDes2", self.GetTextTitle_18)

	self.WarlockImagePath = UIGlobalApi.ImagePath .. "/Warlock"
end

function WarlockApi:GetTextTitle_1()
	return self:GetCfgText(1600017)
end

function WarlockApi:GetTextTitle_2()
	return self:GetCfgText(1600018)
end

function WarlockApi:GetTextTitle_3()
	return self:GetCfgText(1600020)
end

function WarlockApi:GetTextTitle_4()
	return self:GetCfgText(1600016)
end

function WarlockApi:GetTextElement(elementType)
	if elementType == Constant.ElementType.ELEMENT_TYPE_WIND then
		return self:GetCfgText(1600020)
	elseif elementType == Constant.ElementType.ELEMENT_TYPE_FIRE then
		return self:GetCfgText(1600017)
	elseif elementType == Constant.ElementType.ELEMENT_TYPE_THUNDER then
		return self:GetCfgText(1600016)
	elseif elementType == Constant.ElementType.ELEMENT_TYPE_WATER then
		return self:GetCfgText(1600018)
	end

	return "null"
end

function WarlockApi:PrefessionDes_1()
	return self:GetCfgText(1600009)
end

function WarlockApi:PrefessionDes_2()
	return self:GetCfgText(1600010)
end

function WarlockApi:PrefessionDes_3()
	return self:GetCfgText(1600011)
end

function WarlockApi:PrefessionDes_4()
	return self:GetCfgText(1600012)
end

function WarlockApi:InfluenceDes_1()
	return self:GetCfgText(1800001)
end

function WarlockApi:InfluenceDes_2()
	return self:GetCfgText(1800002)
end

function WarlockApi:InfluenceDes_3()
	return self:GetCfgText(1800006)
end

function WarlockApi:GetTextTitle_12()
	return self:GetCfgText(1600002)
end

function WarlockApi:GetTextTitle_13()
	return self:GetCfgText(1600003)
end

function WarlockApi:OtherDes1()
	return self:GetCfgText(1960001)
end

function WarlockApi:ElementDes()
	return self:GetCfgText(1600013)
end

function WarlockApi:ProfessionDes()
	return self:GetCfgText(1600014)
end

function WarlockApi:InfluenceDes()
	return self:GetCfgText(1600021)
end

function WarlockApi:OtherDes2()
	return self:GetCfgText(1960002)
end

function WarlockApi:GetTextTitle_Target(id)
	return self:GetCfgText(id)
end

function WarlockApi:GetSortType(type)
	if type == Constant.WarlockSortType.Level then
		return self:GetTextTitle_12()
	elseif type == Constant.WarlockSortType.Quality then
		return self:GetTextTitle_13()
	elseif type == Constant.WarlockSortType.Element then
		return self:ElementDes()
	end

	return nil
end

function WarlockApi:GetEaseElementType(type)
	if type == WarlockModule.EaseElement.EaseFire then
		return self:GetTextTitle_1()
	elseif type == WarlockModule.EaseElement.EaseWater then
		return self:GetTextTitle_2()
	elseif type == WarlockModule.EaseElement.EaseWind then
		return self:GetTextTitle_3()
	elseif type == WarlockModule.EaseElement.EaseMine then
		return self:GetTextTitle_4()
	end

	return nil
end

function WarlockApi:GetEaseProfessionType(type)
	if type == WarlockModule.EaseProfession.EaseConjuring then
		return self:GetTextTitle_5()
	elseif type == WarlockModule.EaseProfession.EaseImplement then
		return self:GetTextTitle_6()
	elseif type == WarlockModule.EaseProfession.EaseSpeech then
		return self:GetTextTitle_7()
	elseif type == WarlockModule.EaseProfession.EaseRune then
		return self:GetTextTitle_8()
	end

	return nil
end

function WarlockApi:GetEaseInfluenceType(type)
	return self:GetTextTitle_Target(type)
end

function WarlockApi:GetQualityImagePath(WarlockData)
	local quality = WarlockData.BaseData.Quality
	local qualitypath = WarlockApi:GetWarlockChooseUIQuality(quality)
	local qualitybgPath = WarlockApi:GetWarlockChooseUIQualityBg(quality)

	return qualitypath, qualitybgPath
end

function WarlockApi:GetGradPathImagePath(BreakLv)
	return string.format(self:GetResUrl(1400004), BreakLv)
end

function WarlockApi:GetProfessionIconPath(Profession)
	return UIGlobalApi.GetImagePath(string.format("/Common/Warlock/Profession/Profession_%s.png", Profession))
end

function WarlockApi:GetElementIconPath(Elements)
	return UIGlobalApi.GetImagePath(string.format("/Common/Warlock/Warlock_Element/Role_Element_%s.png", Elements))
end

function WarlockApi:GetFightingImgPath(FightingImg)
	return UIGlobalApi.ImagePath .. FightingImg
end

function WarlockApi:GetInfluenceImgPath(Influence)
	return UIGlobalApi.GetImagePath(string.format("/Common/Warlock/Influence/Influence_%s.png", Influence))
end

function WarlockApi:GetForceImgPath(type)
	return UIGlobalApi.GetImagePath(string.format("/Common/ComForce/Hero_ComForce_0%s.png", type))
end

function WarlockApi:GetBoxHeroKuangImagePath(quality)
	return string.format(self:GetResUrl(1100034), Constant.ItemType.Item, quality)
end

function WarlockApi:GetBoxHeroJiaoImagePath(quality)
	return UIGlobalApi.GetIconPath(string.format("/Common/Icon_QualityFrame_Corner_%s.png", quality))
end

function WarlockData:GetFightingImgPath(path)
	return UIGlobalApi.GetImagePath(path)
end

function WarlockData:GetHeroImagePath(path)
	return UIGlobalApi.GetImagePath(path)
end

function WarlockApi:GetAttributePrefabPath()
	return self:GetResUrl(1100004)
end

function WarlockApi:FavorabilityPositive()
	return self:GetResUrl(1100013)
end

function WarlockApi:FavorabilityAntitone()
	return self:GetResUrl(1100014)
end

function WarlockApi:GetWarlockChooseUIQuality(quality)
	return string.format(self:GetResUrl(1400001), quality)
end

function WarlockApi:GetWarlockChooseUIQualityBg(quality)
	return string.format(self:GetResUrl(1400002), quality)
end

WarlockApi:Init()
