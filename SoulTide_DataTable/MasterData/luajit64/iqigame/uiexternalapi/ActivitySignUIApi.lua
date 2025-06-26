-- chunkname: @IQIGame\\UIExternalApi\\ActivitySignUIApi.lua

ActivitySignUIApi = BaseLangApi:Extend()

function ActivitySignUIApi:Init()
	self:RegisterApi("dayTxt", self.GetDayTxt)
	self:RegisterApi("weekTxt", self.GetWeekTxt)
	self:RegisterApi("leftTitle1", self.GetLeftTitle1)
	self:RegisterApi("leftTitle2", self.GetLeftTitle2)
	self:RegisterApi("signDesc", self.GetSignDesc)
	self:RegisterApi("monthDesc", self.GetMonthDesc)
	self:RegisterApi("yearDesc", self.GetYearDesc)
	self:RegisterApi("signProgressTitle", self.GetSignProgressTitle)
	self:RegisterApi("signProgress", self.GetSignProgress)
	self:RegisterApi("signGotTxt", self.GetSignGotTxt)
	self:RegisterApi("signProgressRewardCount", self.GetSignProgressRewardCount)
	self:RegisterApi("btnSignTxt", self.GetBtnSignTxt)
	self:RegisterApi("signedTxt", self.GetSignedTxt)
	self:RegisterApi("itemNum", self.GetItemNum)
	self:RegisterApi("itemBg", self.GetItemBg)
	self:RegisterApi("detailCellTitle1", self.GetDetailCellTitle1)
	self:RegisterApi("detailCellTitle2", self.GetDetailCellTitle2)
	self:RegisterApi("detailCellSoulName", self.GetDetailCellSoulName)
	self:RegisterApi("detailCellRewardName", self.GetDetailCellRewardName)
	self:RegisterApi("detailCellRewardNum", self.GetDetailCellRewardNum)
	self:RegisterApi("detailCellFestivalName", self.GetDetailCellFestivalName)
	self:RegisterApi("detailCellActivityName", self.GetDetailCellActivityName)
	self:RegisterApi("detailCellBirthIcon", self.GetDetailCellBirthIcon)
end

function ActivitySignUIApi:GetDetailCellBirthIcon()
	return "/Activity/Common/ActivityUI_Image_Festival_00.png"
end

function ActivitySignUIApi:GetBtnSignTxt()
	return self:GetCfgText(3502001)
end

function ActivitySignUIApi:GetSignedTxt()
	return self:GetCfgText(3502002)
end

function ActivitySignUIApi:GetItemNum(num)
	return "x" .. num
end

function ActivitySignUIApi:GetItemBg(quality)
	return "/Activity/Common/ActivityUI_Sign_Quality_0" .. quality .. ".png"
end

function ActivitySignUIApi:GetSignProgressRewardCount(num)
	return "x" .. num
end

function ActivitySignUIApi:GetSignGotTxt()
	return self:GetCfgText(3502003)
end

function ActivitySignUIApi:GetSignProgress(cur, total)
	if cur == total then
		return self.TextColor[220] .. cur .. self.TextColor[0] .. "/" .. total
	end

	return cur .. "/" .. total
end

function ActivitySignUIApi:GetSignProgressTitle()
	return self:GetCfgText(3502004)
end

function ActivitySignUIApi:GetMonthDesc(month)
	return month .. self:GetCfgText(3502005)
end

function ActivitySignUIApi:GetYearDesc(year)
	return year
end

function ActivitySignUIApi:GetSignDesc()
	return "SignIn"
end

function ActivitySignUIApi:GetDetailCellFestivalName(name)
	return name
end

function ActivitySignUIApi:GetDetailCellActivityName(name)
	return name
end

function ActivitySignUIApi:GetDetailCellRewardName(name)
	return name
end

function ActivitySignUIApi:GetDetailCellRewardNum(num)
	return "x" .. num
end

function ActivitySignUIApi:GetDetailCellSoulName(name)
	return name
end

function ActivitySignUIApi:GetDetailCellTitle1(type)
	if type == 1 then
		return self:GetCfgText(3502006)
	elseif type == 2 then
		return self:GetCfgText(3502007)
	elseif type == 3 then
		return self:GetCfgText(3502008)
	elseif type == 4 then
		return self:GetCfgText(3502009)
	end
end

function ActivitySignUIApi:GetDetailCellTitle2(type)
	if type == 1 then
		return "birthday"
	elseif type == 2 then
		return "festival"
	elseif type == 3 then
		return "reward"
	elseif type == 4 then
		return "activity"
	end
end

function ActivitySignUIApi:GetLeftTitle1()
	return "Total"
end

function ActivitySignUIApi:GetLeftTitle2(month, day)
	return month .. "/" .. day
end

function ActivitySignUIApi:GetDayTxt(day)
	if day < 10 then
		return "0" .. day
	else
		return day
	end
end

function ActivitySignUIApi:GetWeekTxt(week)
	if week == 1 then
		return self:GetCfgText(3502011)
	elseif week == 2 then
		return self:GetCfgText(3502012)
	elseif week == 3 then
		return self:GetCfgText(3502013)
	elseif week == 4 then
		return self:GetCfgText(3502014)
	elseif week == 5 then
		return self:GetCfgText(3502015)
	elseif week == 6 then
		return self:GetCfgText(3502016)
	elseif week == 7 then
		return self:GetCfgText(3502017)
	else
		return
	end
end

ActivitySignUIApi:Init()
