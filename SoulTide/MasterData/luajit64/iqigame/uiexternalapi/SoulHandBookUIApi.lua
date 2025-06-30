-- chunkname: @IQIGame\\UIExternalApi\\SoulHandBookUIApi.lua

SoulHandBookUIApi = BaseLangApi:Extend()

function SoulHandBookUIApi:Init()
	self:RegisterApi("TextGoUp", self.SetTextGoUp)
	self:RegisterApi("TextGoDown", self.SetTextGoDown)
	self:RegisterApi("TextTog1", self.SetTextTog1)
	self:RegisterApi("TextTog2", self.SetTextTog2)
	self:RegisterApi("TextTog3", self.SetTextTog3)
	self:RegisterApi("TextTog4", self.SetTextTog4)
	self:RegisterApi("Title", self.SetTitle)
	self:RegisterApi("TextBtnTitle", self.SetTextBtnTitle)
	self:RegisterApi("GetWayType", self.GetWayTypeStr)
	self:RegisterApi("TextTitleName", self.GetTextTitleName)
	self:RegisterApi("TogPath", self.GetTogPath)
	self:RegisterApi("ProgressTitle1", self.GetProgressTitle1)
	self:RegisterApi("ProgressTitle2", self.GetProgressTitle2)
	self:RegisterApi("ProgressTitle3", self.GetProgressTitle3)
	self:RegisterApi("TextRewardTitle", self.GetTextRewardTitle)
	self:RegisterApi("TextLv", self.GetTextLv)
	self:RegisterApi("TextName", self.GetTextName)
	self:RegisterApi("TextHeight", self.GetTextHeight)
	self:RegisterApi("TextWeight", self.GetTextWeight)
	self:RegisterApi("TextConstellation", self.GetTextConstellation)
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("SoulMaxLv", self.GetSoulMaxLv)
	self:RegisterApi("TextTogNum", self.GetTextTogNum)
	self:RegisterApi("TextCondition", self.GetTextCondition)
	self:RegisterApi("BtnIconPath", self.GetBtnIconPath)
	self:RegisterApi("HandBookName", self.GetHandBookName)
end

function SoulHandBookUIApi:GetHandBookName(name, isLock)
	if isLock then
		return "<color=#67cfff>" .. name .. "</color>"
	end

	return "<color=#ffffff>" .. name .. "</color>"
end

function SoulHandBookUIApi:GetBtnIconPath(type)
	if type == Constant.BookType.BookTypeCG then
		return self:GetResUrl(2006001)
	elseif type == Constant.BookType.BookTypeCV then
		return self:GetResUrl(2006002)
	elseif type == Constant.BookType.BookTypeDialog then
		return self:GetResUrl(2006003)
	elseif type == Constant.BookType.BookTypeMovie then
		return self:GetResUrl(2006004)
	end

	return self:GetResUrl(2006001)
end

function SoulHandBookUIApi:GetTextCondition(condition, needLv, top)
	local str1 = condition
	local str2 = string.format(self:GetCfgText(2300700), needLv)

	if top then
		str2 = string.format(self:GetCfgText(2300701), needLv)
	end

	return str1 .. "\n" .. str2
end

function SoulHandBookUIApi:GetTextTogNum(num, maxNum)
	return num .. "/" .. maxNum
end

function SoulHandBookUIApi:GetSoulMaxLv()
	return 60
end

function SoulHandBookUIApi:GetTextTitle(title)
	return self:GetCfgText(2300702) .. "：" .. title
end

function SoulHandBookUIApi:GetTextConstellation(constellation)
	return self:GetCfgText(2300703) .. "：" .. constellation
end

function SoulHandBookUIApi:GetTextWeight(weight)
	return self:GetCfgText(2300704) .. "：" .. weight .. " kg"
end

function SoulHandBookUIApi:GetTextHeight(height)
	return self:GetCfgText(2300705) .. "：" .. height .. " cm"
end

function SoulHandBookUIApi:GetTextName(name1, name2)
	return self:GetCfgText(2300706) .. "：" .. name1 .. " " .. name2
end

function SoulHandBookUIApi:GetTextLv(lv)
	return "Lv." .. lv
end

function SoulHandBookUIApi:GetTextRewardTitle()
	return self:GetCfgText(2300707)
end

function SoulHandBookUIApi:GetProgressTitle3()
	return self:GetCfgText(2300708)
end

function SoulHandBookUIApi:GetProgressTitle2()
	return self:GetCfgText(2300709)
end

function SoulHandBookUIApi:GetProgressTitle1()
	return self:GetCfgText(2300710)
end

function SoulHandBookUIApi:GetTogPath(isSelect)
	if isSelect then
		return self:GetResUrl(2006011)
	end

	return self:GetResUrl(2006010)
end

function SoulHandBookUIApi:GetTextTitleName()
	return self:GetCfgText(2300711)
end

function SoulHandBookUIApi:GetWayTypeStr(type)
	if type == 1 then
		return self:GetCfgText(2300712)
	elseif type == 2 then
		return self:GetCfgText(2300713)
	elseif type == 3 then
		return self:GetCfgText(2300714)
	elseif type == 4 then
		return self:GetCfgText(2300715)
	elseif type == 5 then
		return self:GetCfgText(2300716)
	elseif type == 6 then
		return self:GetCfgText(2300717)
	elseif type == 7 then
		return self:GetCfgText(2300718)
	elseif type == 8 then
		return self:GetCfgText(2300719)
	end

	return ""
end

function SoulHandBookUIApi:SetTextGoUp()
	return self:GetCfgText(1103000)
end

function SoulHandBookUIApi:SetTextGoDown()
	return self:GetCfgText(1103001)
end

function SoulHandBookUIApi:SetTextTog1(bookType)
	if bookType == 1 then
		return self:GetCfgText(1103002)
	end

	return self:GetCfgText(2300712)
end

function SoulHandBookUIApi:SetTextTog2()
	return self:GetCfgText(1103003)
end

function SoulHandBookUIApi:SetTextTog3()
	return self:GetCfgText(2300720)
end

function SoulHandBookUIApi:SetTextTog4()
	return self:GetCfgText(2300721)
end

function SoulHandBookUIApi:SetTitle(name)
	return self:GetCfgText(1103004) .. name
end

function SoulHandBookUIApi:SetTextBtnTitle()
	return self:GetCfgText(1103005)
end

SoulHandBookUIApi:Init()
