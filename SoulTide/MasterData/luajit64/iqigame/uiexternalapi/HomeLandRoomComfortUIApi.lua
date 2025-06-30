-- chunkname: @IQIGame\\UIExternalApi\\HomeLandRoomComfortUIApi.lua

HomeLandRoomComfortUIApi = BaseLangApi:Extend()

function HomeLandRoomComfortUIApi:Init()
	self:RegisterApi("TextTitle2", self.GetTextTitle2)
	self:RegisterApi("TextTitle3", self.GetTextTitle3)
	self:RegisterApi("TextTitle5", self.GetTextTitle5)
	self:RegisterApi("TextDes", self.GetTextDes)
	self:RegisterApi("TextDecorateName", self.GetTextDecorateName)
	self:RegisterApi("TextTip", self.GetTextTip)
	self:RegisterApi("TextTitle4", self.GetTextTitle4)
	self:RegisterApi("TextTitle6", self.GetTextTitle6)
	self:RegisterApi("TextBaseComfort", self.GetTextBaseComfort)
	self:RegisterApi("TextThemeComfort", self.GetTextThemeComfort)
	self:RegisterApi("TextThemeName", self.GetTextThemeName)
end

function HomeLandRoomComfortUIApi:GetTextThemeName(name, haveNum, totalNum)
	return string.format("%s: %s/%s", name, haveNum, totalNum)
end

function HomeLandRoomComfortUIApi:GetTextThemeComfort(num, maxNum)
	return string.format(self:GetCfgText(1015604) .. " %s/%s", num, maxNum)
end

function HomeLandRoomComfortUIApi:GetTextBaseComfort(num, maxNum)
	return string.format(self:GetCfgText(1015605) .. " %s/%s", num, maxNum)
end

function HomeLandRoomComfortUIApi:GetTextTitle6()
	return self:GetCfgText(1015049)
end

function HomeLandRoomComfortUIApi:GetTextTitle4()
	return self:GetCfgText(1015051)
end

function HomeLandRoomComfortUIApi:GetTextTip(lv)
	return self:GetCfgText(1015601)
end

function HomeLandRoomComfortUIApi:GetTextDecorateName(str, themeName, isTheme)
	if isTheme then
		return "<color=#56D884>" .. str .. "(" .. themeName .. ")" .. "</color>"
	end

	return str
end

function HomeLandRoomComfortUIApi:GetTextTitle2()
	return self:GetCfgText(1015602)
end

function HomeLandRoomComfortUIApi:GetTextDes()
	return self:GetCfgText(1015603)
end

function HomeLandRoomComfortUIApi:GetTextTitle5()
	return self:GetCfgText(1015048)
end

function HomeLandRoomComfortUIApi:GetTextTitle3()
	return self:GetCfgText(1015050)
end

HomeLandRoomComfortUIApi:Init()
