-- chunkname: @IQIGame\\UIExternalApi\\HomeLandAlchemyUIApi.lua

HomeLandAlchemyUIApi = BaseLangApi:Extend()

function HomeLandAlchemyUIApi:Init()
	self:RegisterApi("TextTitle", self.GetTextTitle)
	self:RegisterApi("ErrorMsg", self.GetErrorMsg)
	self:RegisterApi("TextCurrentValue", self.GetTextCurrentValue)
	self:RegisterApi("TextDes1", self.GetTextDes1)
	self:RegisterApi("TextDes2", self.GetTextDes2)
	self:RegisterApi("TextDes3", self.GetTextDes3)
	self:RegisterApi("TextRightTitle", self.GetTextRightTitle)
	self:RegisterApi("TextBtnLab", self.GetTextBtnLab)
	self:RegisterApi("Tog1", self.GetTog1)
	self:RegisterApi("Tog2", self.GetTog2)
	self:RegisterApi("TextTitle1", self.GetTextTitle1)
	self:RegisterApi("TextTitle2", self.GetTextTitle2)
	self:RegisterApi("TextBtnGetReward", self.GetTextBtnGetReward)
	self:RegisterApi("TextSpeed", self.GetTextSpeed)
	self:RegisterApi("TextMax", self.GetTextMax)
	self:RegisterApi("TextPer", self.GetTextPer)
	self:RegisterApi("CameraPosition", self.GetCameraPosition)
	self:RegisterApi("CameraSize", self.GetCameraSize)
	self:RegisterApi("TextOtherReward", self.GetTextOtherReward)
	self:RegisterApi("TextAssistPowerTimes", self.GetTextAssistPowerTimes)
	self:RegisterApi("TextAssistPower", self.GetTextAssistPower)
	self:RegisterApi("TextTip", self.GetTextTip)
	self:RegisterApi("ShowItem", self.GetShowItem)
	self:RegisterApi("TextBtnLevelUp", self.GetTextBtnLevelUp)
end

function HomeLandAlchemyUIApi:GetTextBtnLevelUp()
	return self:GetCfgText(1015022)
end

function HomeLandAlchemyUIApi:GetShowItem()
	return {
		11911
	}
end

function HomeLandAlchemyUIApi:GetTextTip(lv)
	if lv < 21 then
		return self:GetCfgText(1015301) .. self.TextColor[32] .. self:GetCfgText(1015302) .. self.TextColor[0] .. self:GetCfgText(1015304) .. self.TextColor[201] .. self:GetCfgText(1015305) .. self.TextColor[0]
	end

	return self:GetCfgText(1015301) .. self.TextColor[32] .. self:GetCfgText(1015302) .. self.TextColor[0] .. self:GetCfgText(1015304) .. self.TextColor[201] .. self:GetCfgText(1015305) .. self.TextColor[0]
end

function HomeLandAlchemyUIApi:GetTextAssistPower(num)
	if num > 0 then
		return self:GetCfgText(1015306) .. "：" .. self.TextColor[202] .. num .. self.TextColor[0]
	end

	return self:GetCfgText(1015309) .. self.TextColor[32] .. self:GetCfgText(1015310) .. self.TextColor[0] .. self:GetCfgText(1015311)
end

function HomeLandAlchemyUIApi:GetTextAssistPowerTimes(num1, num2)
	return num1 .. "/" .. num2 .. self:GetCfgText(1015307)
end

function HomeLandAlchemyUIApi:GetTextOtherReward()
	return self:GetCfgText(1015308)
end

function HomeLandAlchemyUIApi:GetCameraSize()
	return 2.4
end

function HomeLandAlchemyUIApi:GetCameraPosition(lv, suitCid)
	return Vector3.New(-53.63, -28.58, 1)
end

function HomeLandAlchemyUIApi:GetTextPer(num1, num2)
	return num1 .. "/" .. num2
end

function HomeLandAlchemyUIApi:GetTextMax(num, max)
	return string.format(self:GetCfgText(1015312) .. "：" .. "%s/%s", num, max)
end

function HomeLandAlchemyUIApi:GetTextSpeed(num)
	return string.format(self:GetCfgText(1015318), num)
end

function HomeLandAlchemyUIApi:GetTextBtnGetReward()
	return self:GetCfgText(1015314)
end

function HomeLandAlchemyUIApi:GetTextTitle2()
	return self:GetCfgText(1015315)
end

function HomeLandAlchemyUIApi:GetTextTitle1()
	return self:GetCfgText(1015316)
end

function HomeLandAlchemyUIApi:GetTog2()
	return self:GetCfgText(1015109)
end

function HomeLandAlchemyUIApi:GetTog1()
	return self:GetCfgText(1015110)
end

function HomeLandAlchemyUIApi:GetTextBtnLab()
	return self:GetCfgText(1015111)
end

function HomeLandAlchemyUIApi:GetTextRightTitle()
	return self:GetCfgText(1015112)
end

function HomeLandAlchemyUIApi:GetTextDes3()
	return self:GetCfgText(1015113)
end

function HomeLandAlchemyUIApi:GetTextDes2()
	return self:GetCfgText(1015114)
end

function HomeLandAlchemyUIApi:GetTextDes1()
	return self:GetCfgText(1015115)
end

function HomeLandAlchemyUIApi:GetTextCurrentValue(output)
	return self:GetCfgText(1015116) .. output
end

function HomeLandAlchemyUIApi:GetErrorMsg()
	return self:GetCfgText(1015117)
end

function HomeLandAlchemyUIApi:GetTextTitle(lv)
	return string.format(self:GetCfgText(1015317) .. " <Size=16>Lv.%s</Size>", lv)
end

HomeLandAlchemyUIApi:Init()
