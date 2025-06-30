-- chunkname: @IQIGame\\UIExternalApi\\HomeLandManufactureListUIApi.lua

HomeLandManufactureListUIApi = BaseLangApi:Extend()

function HomeLandManufactureListUIApi:Init()
	self:RegisterApi("TextHave", self.GetTextHave)
	self:RegisterApi("TextBtnMake", self.GetTextBtnMake)
	self:RegisterApi("TextSpendTitle", self.GetTextSpendTitle)
	self:RegisterApi("TextDown", self.GetTextDown)
	self:RegisterApi("TextUp", self.GetTextUp)
	self:RegisterApi("TextItemHave", self.GetTextItemHave)
	self:RegisterApi("TextItemNeed", self.GetTextItemNeed)
	self:RegisterApi("TextLock1", self.GetTextLock1)
	self:RegisterApi("TextLock2", self.GetTextLock2)
end

function HomeLandManufactureListUIApi:GetTextLock2()
	return self:GetCfgText(1015181)
end

function HomeLandManufactureListUIApi:GetTextLock1()
	return self:GetCfgText(1015180)
end

function HomeLandManufactureListUIApi:GetTextItemNeed(needNum, top)
	if top then
		return "/" .. tostring(needNum)
	end

	return "/" .. tostring(needNum)
end

function HomeLandManufactureListUIApi:GetTextItemHave(haveNum, top)
	if top then
		return BaseLangApi.TextColor[30] .. string.format("%s", haveNum) .. BaseLangApi.TextColor[0]
	end

	return BaseLangApi.TextColor[203] .. string.format("%s", haveNum) .. BaseLangApi.TextColor[0]
end

function HomeLandManufactureListUIApi:GetTextUp(num, totalNum)
	return string.format("%s<Size=32>/%s</Size>", num, totalNum)
end

function HomeLandManufactureListUIApi:GetTextDown(num, totalNum)
	return string.format("%s<Size=32>/%s</Size>", num, totalNum)
end

function HomeLandManufactureListUIApi:GetTextSpendTitle()
	return self:GetCfgText(1015182)
end

function HomeLandManufactureListUIApi:GetTextBtnMake()
	return self:GetCfgText(1015087)
end

function HomeLandManufactureListUIApi:GetTextHave(num)
	return self:GetCfgText(1015183) .. ":" .. num
end

HomeLandManufactureListUIApi:Init()
