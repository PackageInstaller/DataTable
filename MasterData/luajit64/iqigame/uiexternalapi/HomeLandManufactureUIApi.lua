-- chunkname: @IQIGame\\UIExternalApi\\HomeLandManufactureUIApi.lua

HomeLandManufactureUIApi = BaseLangApi:Extend()

function HomeLandManufactureUIApi:Init()
	self:RegisterApi("CameraPosition", self.GetCameraPosition)
	self:RegisterApi("CameraSize", self.GetCameraSize)
	self:RegisterApi("TextBtnClose", self.GetTextBtnClose)
	self:RegisterApi("TextMaking2", self.GetTextMaking2)
	self:RegisterApi("TextMaking4", self.GetTextMaking4)
	self:RegisterApi("Finish2", self.GetFinish2)
	self:RegisterApi("Finish3", self.GetFinish3)
	self:RegisterApi("TextLock1", self.GetTextLock1)
	self:RegisterApi("TextLock2", self.GetTextLock2)
	self:RegisterApi("TextBtnGetReward", self.GetTextBtnGetReward)
	self:RegisterApi("TextBtnCleanCD", self.GetTextBtnCleanCD)
	self:RegisterApi("ErrorMsg", self.GetErrorMsg)
	self:RegisterApi("ErrorMsg1", self.GetErrorMsg1)
	self:RegisterApi("HelpText", self.GetHelpText)
	self:RegisterApi("TextQueueTitle", self.GetTextQueueTitle)
	self:RegisterApi("TextQueueNum", self.GetTextQueueNum)
	self:RegisterApi("ErrorMsg2", self.GetErrorMsg2)
	self:RegisterApi("TextManufacture", self.GetTextManufacture)
	self:RegisterApi("TextManufactureMsg", self.GetTextManufactureMsg)
	self:RegisterApi("TextBtnUpgrade", self.GetTextBtnUpgrade)
	self:RegisterApi("UnLockErrorMsg", self.GetUnLockErrorMsg)
	self:RegisterApi("ToggleTitle", self.GetToggleTitle)
	self:RegisterApi("TextToggleNullDown", self.GetTextToggleNullDown)
	self:RegisterApi("TextToggleNullUp", self.GetTextToggleNullUp)
	self:RegisterApi("BtnDecomposeLabel", self.GetBtnDecomposeLabel)
end

function HomeLandManufactureUIApi:GetBtnDecomposeLabel()
	return self:GetCfgText(1015355)
end

function HomeLandManufactureUIApi:GetTextToggleNullUp()
	return self:GetCfgText(1238082)
end

function HomeLandManufactureUIApi:GetTextToggleNullDown()
	return self:GetCfgText(1238082)
end

function HomeLandManufactureUIApi:GetToggleTitle()
	return {
		{
			0,
			self:GetCfgText(1240002)
		},
		{
			1,
			self:GetCfgText(1015161)
		},
		{
			2,
			self:GetCfgText(1015162)
		},
		{
			3,
			self:GetCfgText(1015163)
		},
		{
			4,
			self:GetCfgText(1015164)
		},
		{
			5,
			self:GetCfgText(1015165)
		},
		{
			7,
			self:GetCfgText(1015178)
		}
	}
end

function HomeLandManufactureUIApi:GetUnLockErrorMsg(str)
	return str .. self:GetCfgText(1190014)
end

function HomeLandManufactureUIApi:GetTextBtnUpgrade()
	return self:GetCfgText(1015085)
end

function HomeLandManufactureUIApi:GetTextMaking4()
	return self:GetCfgText(1238066)
end

function HomeLandManufactureUIApi:GetTextItemOpen()
	return self:GetCfgText(1015171)
end

function HomeLandManufactureUIApi:GetTextManufactureMsg(lv)
	if lv == 1 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "1级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "1%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 2 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "2级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "2%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 3 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "3级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "3%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 4 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "4级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "4%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 5 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "5级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "5%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 6 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "6级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "6%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 7 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "7级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "7%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 8 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "8级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "8%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 9 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "9级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "9%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 10 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "10级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "10%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 11 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "11级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "11%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 12 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "12级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "12%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 13 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "13级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "13%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 14 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "14级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "14%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 15 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "15级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "15%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 16 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "16级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "16%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 17 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "17级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "17%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 18 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "18级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "18%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 19 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "19级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "19%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 20 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "20级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "20%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	elseif lv == 21 then
		return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. "21级" .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "21%" .. self.TextColor[0] .. self:GetCfgText(1015169)
	end

	return "1." .. self:GetCfgText(1015165) .. self.TextColor[32] .. self:GetCfgText(1015166) .. self.TextColor[0] .. self:GetCfgText(1015167) .. self.TextColor[32] .. self:GetCfgText(1238077) .. self.TextColor[0] .. self:GetCfgText(1015168) .. self.TextColor[32] .. "24%" .. self.TextColor[0] .. self:GetCfgText(1015169)
end

function HomeLandManufactureUIApi:GetTextManufacture()
	return self:GetCfgText(1015063)
end

function HomeLandManufactureUIApi:GetErrorMsg2()
	return self:GetCfgText(1238059)
end

function HomeLandManufactureUIApi:GetTextQueueNum(num1, num2)
	return self.TextColor[12] .. "<Size=24>" .. num1 .. "</Size>" .. self.TextColor[0] .. self.TextColor[213] .. "/" .. num2 .. self.TextColor[0]
end

function HomeLandManufactureUIApi:GetTextQueueTitle()
	return self:GetCfgText(1015170)
end

function HomeLandManufactureUIApi:GetHelpText(num1, num2)
	return num1 .. "/<Size=20>" .. num2 .. self:GetCfgText(1238073) .. "</Size>"
end

function HomeLandManufactureUIApi:GetErrorMsg1()
	return self:GetCfgText(1015172)
end

function HomeLandManufactureUIApi:GetErrorMsg()
	return self:GetCfgText(1014015)
end

function HomeLandManufactureUIApi:GetTextBtnCleanCD()
	return self:GetCfgText(1238055)
end

function HomeLandManufactureUIApi:GetTextBtnGetReward()
	return self:GetCfgText(1015177)
end

function HomeLandManufactureUIApi:GetTextLock2()
	return self:GetCfgText(1015173)
end

function HomeLandManufactureUIApi:GetTextLock1()
	return self:GetCfgText(1238063)
end

function HomeLandManufactureUIApi:GetFinish3()
	return self:GetCfgText(1238064)
end

function HomeLandManufactureUIApi:GetFinish2(type)
	if type == 1 then
		return self:GetCfgText(1015063)
	end

	return self:GetCfgText(1015174)
end

function HomeLandManufactureUIApi:GetTextMaking2(type)
	if type == 1 then
		return self:GetCfgText(1015175)
	end

	return self:GetCfgText(1015176)
end

function HomeLandManufactureUIApi:GetTextBtnClose(name, lv)
	return string.format("%s <Size=16>Lv.%s</Size>", name, lv)
end

function HomeLandManufactureUIApi:GetCameraSize()
	return 2.2
end

function HomeLandManufactureUIApi:GetCameraPosition(lv, suitCid)
	return Vector3.New(-24.63, -28.8, -100)
end

HomeLandManufactureUIApi:Init()
