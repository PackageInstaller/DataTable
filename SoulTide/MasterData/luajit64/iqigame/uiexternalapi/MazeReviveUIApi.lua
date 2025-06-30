-- chunkname: @IQIGame\\UIExternalApi\\MazeReviveUIApi.lua

MazeReviveUIApi = BaseLangApi:Extend()

function MazeReviveUIApi:Init()
	self:RegisterApi("goTitleTxt1", self.GetTitleTxt1)
	self:RegisterApi("goTitleTxt2", self.GetTitleTxt2)
	self:RegisterApi("goDescTxt", self.GetDescTxt)
	self:RegisterApi("goBtnGiveUpTxt", self.GetBtnGiveUpTxt)
	self:RegisterApi("goBtnReviveTxt", self.GetBtnReviveTxt)
	self:RegisterApi("PriceNumText", self.GetPriceNumTxt)
	self:RegisterApi("LeftCountText", self.GetLeftCountTxt)
	self:RegisterApi("goSubDescText", self.GetSubDescText)
	self:RegisterApi("PriceTextColor", self.GetPriceTextColor)
end

function MazeReviveUIApi:GetTitleTxt1()
	return self:GetCfgText(1150091)
end

function MazeReviveUIApi:GetTitleTxt2()
	return self:Blank("FAILED", 2)
end

function MazeReviveUIApi:GetDescTxt()
	return self:GetCfgText(1150092)
end

function MazeReviveUIApi:GetSubDescText(reviveType)
	return ""
end

function MazeReviveUIApi:GetBtnGiveUpTxt()
	return self:GetCfgText(1150093)
end

function MazeReviveUIApi:GetBtnReviveTxt()
	return self:GetCfgText(1150094)
end

function MazeReviveUIApi:GetPriceNumTxt(type, num, isEnough, hasNum)
	local ret = ""

	if type == 1 then
		ret = self.TextColor[12] .. self:GetCfgText(1005102) .. self.TextColor[0]
	elseif isEnough then
		ret = self.TextColor[201] .. tostring(num) .. self.TextColor[0] .. self.TextColor[12] .. "/" .. hasNum .. self.TextColor[0]
	else
		ret = self.TextColor[203] .. tostring(num) .. self.TextColor[0] .. self.TextColor[12] .. "/" .. hasNum .. self.TextColor[0]
	end

	return ret
end

function MazeReviveUIApi:GetLeftCountTxt(leftCount)
	return self:GetCfgText(1005101, leftCount)
end

function MazeReviveUIApi:GetPriceTextColor(isOK)
	if isOK then
		return "#00FF00FF"
	else
		return "#FF0000FF"
	end
end

MazeReviveUIApi:Init()
