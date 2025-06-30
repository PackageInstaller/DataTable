-- chunkname: @IQIGame\\UIExternalApi\\LibraryEquipApi.lua

LibraryEquipApi = BaseLangApi:Extend()

function LibraryEquipApi:Init()
	self:RegisterApi("EquipListTitle", self.GetEquipListTitle)
	self:RegisterApi("TextReward", self.GetTextReward)
	self:RegisterApi("TextEquipName", self.GetTextEquipName)
	self:RegisterApi("ImgTypePath", self.GetImgTypePath)
	self:RegisterApi("EquipType", self.GetEquipType)
	self:RegisterApi("EquipInfoTitles", self.GetEquipInfoTitles)
	self:RegisterApi("TextMaxLv", self.GetTextMaxLv)
	self:RegisterApi("TextMaxStar", self.GetTextMaxStar)
	self:RegisterApi("TextAbility", self.GetTextAbility)
	self:RegisterApi("HiddenStoryTitle", self.GetHiddenStoryTitle)
	self:RegisterApi("HiddenStoryValue", self.GetHiddenStoryValue)
	self:RegisterApi("TextNum", self.GetTextNum)
	self:RegisterApi("EquipTypePath", self.GetEquipTypePath)
	self:RegisterApi("HiddenStorySkinValue", self.GetHiddenStorySkinValue)
end

function LibraryEquipApi:GetHiddenStorySkinValue(index)
	return self:GetCfgText(1106207)
end

function LibraryEquipApi:GetTextNum(num1, num2)
	return string.format("%s/%s", num1, num2)
end

function LibraryEquipApi:GetHiddenStoryValue(index)
	return string.format(self:GetCfgText(1106100), index)
end

function LibraryEquipApi:GetHiddenStoryTitle(index)
	return string.format(self:GetCfgText(1106101) .. "%s", index)
end

function LibraryEquipApi:GetTextAbility(str)
	return self:SkillValueColor(str, 29)
end

function LibraryEquipApi:GetTextMaxStar()
	return self:GetCfgText(1106102)
end

function LibraryEquipApi:GetTextMaxLv()
	return self:GetCfgText(1106103)
end

function LibraryEquipApi:GetEquipInfoTitles(index)
	if index == 1 then
		return self:GetCfgText(1106104)
	elseif index == 2 then
		return self:GetCfgText(1314419)
	elseif index == 3 then
		return self:GetCfgText(1314420)
	elseif index == 4 then
		return self:GetCfgText(1314428)
	elseif index == 5 then
		return self:GetCfgText(1106105)
	elseif index == 6 then
		return self:GetCfgText(1106106)
	elseif index == 7 then
		return self:GetCfgText(1106208)
	end

	return ""
end

function LibraryEquipApi:GetEquipType(Quality)
	if Quality == 2 then
		return "N"
	elseif Quality == 3 then
		return "R"
	elseif Quality == 4 then
		return "SR"
	elseif Quality == 5 then
		return "SSR"
	elseif Quality == 6 then
		return "UR"
	elseif Quality == -1 then
		return self:GetCfgText(1314429)
	end

	return "N"
end

function LibraryEquipApi:GetEquipTypePath(Quality)
	if Quality == 1 then
		return self:GetResUrl(1401001)
	elseif Quality == 2 then
		return self:GetResUrl(1401002)
	elseif Quality == 3 then
		return self:GetResUrl(1401003)
	elseif Quality == 4 then
		return self:GetResUrl(1401004)
	elseif Quality == 5 then
		return self:GetResUrl(1401005)
	end

	return self:GetResUrl(1401001)
end

function LibraryEquipApi:GetImgTypePath(Quality)
	if Quality == 1 then
		return self:GetResUrl(1401006)
	elseif Quality == 2 then
		return self:GetResUrl(1401007)
	elseif Quality == 3 then
		return self:GetResUrl(1401008)
	elseif Quality == 4 then
		return self:GetResUrl(1401009)
	elseif Quality == 5 then
		return self:GetResUrl(1401010)
	end

	return self:GetResUrl(1401006)
end

function LibraryEquipApi:GetTextEquipName(name, isLock)
	if isLock then
		return name
	end

	return name
end

function LibraryEquipApi:GetTextReward(num1, num2)
	local per = math.floor(num1 / num2 * 100)

	if per == 0 and num1 > 0 then
		per = 1
	end

	return string.format(self:GetCfgText(1106107) .. "：%s", per .. "%")
end

function LibraryEquipApi:GetEquipListTitle()
	return self:GetCfgText(1106108)
end

LibraryEquipApi:Init()
