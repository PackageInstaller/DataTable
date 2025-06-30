-- chunkname: @IQIGame\\UIExternalApi\\HomeLandPlantUIApi.lua

HomeLandPlantUIApi = BaseLangApi:Extend()

function HomeLandPlantUIApi:Init()
	self:RegisterApi("CameraPosition", self.GetCameraPosition)
	self:RegisterApi("CameraSize", self.GetCameraSize)
	self:RegisterApi("TextHelp", self.GetTextHelp)
	self:RegisterApi("TextNull", self.GetTextNull)
	self:RegisterApi("TextFinish2", self.GetTextFinish2)
	self:RegisterApi("TextFinish3", self.GetTextFinish3)
	self:RegisterApi("TextGrowUp2", self.GetTextGrowUp2)
	self:RegisterApi("TextNullPutView", self.GetTextNullPutView)
	self:RegisterApi("TextFinishMsg", self.GetTextFinishMsg)
	self:RegisterApi("TextTag1", self.GetTextTag1)
	self:RegisterApi("TextTag2", self.GetTextTag2)
	self:RegisterApi("TextBtnCleanCD", self.GetTextBtnCleanCD)
	self:RegisterApi("TextHelpNum", self.GetTextHelpNum)
	self:RegisterApi("TextCleanUpMsg", self.GetTextCleanUpMsg)
	self:RegisterApi("TextBtnGetReward", self.GetTextBtnGetReward)
	self:RegisterApi("TextBtnCleanUp", self.GetTextBtnCleanUp)
	self:RegisterApi("ToggleTitle", self.GetToggleTitle)
	self:RegisterApi("TextSeedTime", self.GetTextSeedTime)
	self:RegisterApi("TextHaveNum", self.GetTextHaveNum)
	self:RegisterApi("TextBtnPlant", self.GetTextBtnPlant)
	self:RegisterApi("ErrorMsg", self.GetErrorMsg)
	self:RegisterApi("TextNullCome", self.GetTextNullCome)
	self:RegisterApi("SeedCome", self.GetSeedCom)
	self:RegisterApi("TextTip", self.GetTextTip)
	self:RegisterApi("TextBtnPlant", self.GetTextBtnPlant)
end

function HomeLandPlantUIApi:GetTextBtnPlant()
	return self:GetCfgText(1015107)
end

function HomeLandPlantUIApi:GetTextTip()
	return self:GetCfgText(1015140)
end

function HomeLandPlantUIApi:GetSeedCom()
	return {
		{
			10202062,
			self:GetCfgText(1109001)
		},
		{
			10206029,
			self:GetCfgText(49)
		}
	}
end

function HomeLandPlantUIApi:GetTextNullCome()
	return self:GetCfgText(1015142)
end

function HomeLandPlantUIApi:GetTextHelp(num1, num2)
	return num1 .. "/" .. num2 .. self:GetCfgText(1015530)
end

function HomeLandPlantUIApi:GetErrorMsg()
	return self:GetCfgText(1015157)
end

function HomeLandPlantUIApi:GetTextBtnPlant()
	return self:GetCfgText(1015107)
end

function HomeLandPlantUIApi:GetTextHaveNum(num1, num2)
	return num1 .. "/" .. num2
end

function HomeLandPlantUIApi:GetTextSeedTime()
	return self:GetCfgText(1015144)
end

function HomeLandPlantUIApi:GetToggleTitle()
	return {
		{
			0,
			self:GetCfgText(1200103)
		},
		{
			1,
			self:GetCfgText(1015105)
		},
		{
			2,
			self:GetCfgText(1015104)
		},
		{
			3,
			self:GetCfgText(1015103)
		}
	}
end

function HomeLandPlantUIApi:GetTextBtnCleanUp()
	return self:GetCfgText(1015145)
end

function HomeLandPlantUIApi:GetTextBtnGetReward()
	return self:GetCfgText(1015024)
end

function HomeLandPlantUIApi:GetTextCleanUpMsg()
	return self:GetCfgText(1015146)
end

function HomeLandPlantUIApi:GetTextHelpNum(num1, num2)
	return self:GetCfgText(1015156) .. "：" .. num1 .. "/<Size=20>" .. num2 .. self:GetCfgText(1238073) .. "</Size>"
end

function HomeLandPlantUIApi:GetTextBtnCleanCD()
	return self:GetCfgText(1015147)
end

function HomeLandPlantUIApi:GetTextTag2()
	return self:GetCfgText(1015148)
end

function HomeLandPlantUIApi:GetTextTag1()
	return self:GetCfgText(1015149)
end

function HomeLandPlantUIApi:GetTextFinishMsg()
	return self:GetCfgText(1015150)
end

function HomeLandPlantUIApi:GetTextNullPutView()
	return self:GetCfgText(1015151)
end

function HomeLandPlantUIApi:GetTextGrowUp2()
	return self:GetCfgText(1015152)
end

function HomeLandPlantUIApi:GetTextFinish3()
	return self:GetCfgText(1015153)
end

function HomeLandPlantUIApi:GetTextFinish2()
	return self:GetCfgText(1015154)
end

function HomeLandPlantUIApi:GetTextNull()
	return self:GetCfgText(1015155)
end

function HomeLandPlantUIApi:GetTextHelp(num1, num2)
	return num1 .. "<Size=20>/" .. num2 .. self:GetCfgText(1238073) .. "</Size>"
end

function HomeLandPlantUIApi:GetCameraSize(id)
	return 3.1
end

function HomeLandPlantUIApi:GetCameraPosition(id)
	return Vector3.New(65.43, -21.3, -47)
end

HomeLandPlantUIApi:Init()
