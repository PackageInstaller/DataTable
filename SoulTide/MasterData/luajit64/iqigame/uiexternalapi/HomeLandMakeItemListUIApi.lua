-- chunkname: @IQIGame\\UIExternalApi\\HomeLandMakeItemListUIApi.lua

HomeLandMakeItemListUIApi = BaseLangApi:Extend()

function HomeLandMakeItemListUIApi:Init()
	self:RegisterApi("CameraPosition", self.GetCameraPosition)
	self:RegisterApi("CameraSize", self.GetCameraSize)
	self:RegisterApi("TextBtnLevelUp", self.GetTextBtnLevelUp)
	self:RegisterApi("PropsType", self.GetPropsType)
	self:RegisterApi("ProcessingType", self.GetProcessingType)
	self:RegisterApi("TextLock", self.GetTextLock)
	self:RegisterApi("TextSpend", self.GetTextSpend)
	self:RegisterApi("TextBtnClose", self.GetTextBtnClose)
	self:RegisterApi("TextBtnMin", self.GetTextBtnMin)
	self:RegisterApi("TextBtnReduce", self.GetTextBtnReduce)
	self:RegisterApi("TextBtnAdd", self.GetTextBtnAdd)
	self:RegisterApi("TextBtnMax", self.GetTextBtnMax)
	self:RegisterApi("TextBtnProcess", self.GetTextBtnProcess)
	self:RegisterApi("ErrorMsg", self.GetErrorMsg)
	self:RegisterApi("ErrorMsg1", self.GetErrorMsg1)
	self:RegisterApi("ImgDown", self.GetImgDownPath)
	self:RegisterApi("ImgUp", self.GetImgUpPath)
	self:RegisterApi("TextName", self.GetTextName)
	self:RegisterApi("CompoundText", self.GetCompoundText)
	self:RegisterApi("DeComposeText", self.GetDeComposeText)
end

function HomeLandMakeItemListUIApi:GetDeComposeText()
	return self:GetCfgText(1314203)
end

function HomeLandMakeItemListUIApi:GetCompoundText()
	return self:GetCfgText(1314427)
end

function HomeLandMakeItemListUIApi:GetTextName(name)
	return string.format("<%s>", name)
end

function HomeLandMakeItemListUIApi:GetImgUpPath(type)
	if type == 1 then
		return self:GetResUrl(3001001)
	elseif type == 2 then
		return self:GetResUrl(3001002)
	elseif type == 3 then
		return self:GetResUrl(3001003)
	end

	return self:GetResUrl(3001003)
end

function HomeLandMakeItemListUIApi:GetImgDownPath(type)
	if type == 1 then
		return self:GetResUrl(3001004)
	elseif type == 2 then
		return self:GetResUrl(3001005)
	elseif type == 3 then
		return self:GetResUrl(3001006)
	end

	return self:GetResUrl(3001006)
end

function HomeLandMakeItemListUIApi:GetErrorMsg1(type)
	if type == 1 then
		return self:GetCfgText(1015093)
	elseif type == 2 then
		return self:GetCfgText(1015583)
	end

	return self:GetCfgText(1015583)
end

function HomeLandMakeItemListUIApi:GetErrorMsg(type)
	if type == 1 then
		return self:GetCfgText(1015190)
	elseif type == 2 then
		return self:GetCfgText(1015191)
	end

	return self:GetCfgText(1015192)
end

function HomeLandMakeItemListUIApi:GetTextBtnProcess(type)
	if type == 1 then
		return self:GetCfgText(1314427)
	elseif type == 2 then
		return self:GetCfgText(1314203)
	end

	return ""
end

function HomeLandMakeItemListUIApi:GetTextBtnMax()
	return self:GetCfgText(1015189)
end

function HomeLandMakeItemListUIApi:GetTextBtnAdd()
	return "+"
end

function HomeLandMakeItemListUIApi:GetTextBtnReduce()
	return "-"
end

function HomeLandMakeItemListUIApi:GetTextBtnMin()
	return self:GetCfgText(1015193)
end

function HomeLandMakeItemListUIApi:GetTextBtnClose(lv)
	return string.format(self:GetCfgText(1015194) .. "<Size=16>Lv.%s</Size>", lv)
end

function HomeLandMakeItemListUIApi:GetTextSpend(haveNum, needNum)
	if needNum <= haveNum then
		return self.TextColor[30] .. haveNum .. self.TextColor[0] .. "/" .. needNum
	end

	return self.TextColor[28] .. haveNum .. self.TextColor[0] .. "/" .. needNum
end

function HomeLandMakeItemListUIApi:GetTextLock(lv)
	return string.format(self:GetCfgText(1015195), lv)
end

function HomeLandMakeItemListUIApi:GetProcessingType()
	return {
		{
			1,
			self:GetCfgText(1314427)
		},
		{
			2,
			self:GetCfgText(1314203)
		}
	}
end

function HomeLandMakeItemListUIApi:GetPropsType()
	return {
		{
			1,
			self:GetCfgText(1015196)
		},
		{
			2,
			self:GetCfgText(1211023)
		},
		{
			3,
			self:GetCfgText(1015197)
		}
	}
end

function HomeLandMakeItemListUIApi:GetTextBtnLevelUp()
	return self:GetCfgText(1015022)
end

function HomeLandMakeItemListUIApi:GetCameraSize()
	return 1.8
end

function HomeLandMakeItemListUIApi:GetCameraPosition(lv)
	return Vector3.New(-27.2, -28.1, -100)
end

HomeLandMakeItemListUIApi:Init()
