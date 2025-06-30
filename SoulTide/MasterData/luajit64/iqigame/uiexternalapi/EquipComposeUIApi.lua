-- chunkname: @IQIGame\\UIExternalApi\\EquipComposeUIApi.lua

EquipComposeUIApi = BaseLangApi:Extend()

function EquipComposeUIApi:Init()
	self:RegisterApi("goTitle", self.GetTitleText)
	self:RegisterApi("goBtnComposeTxt", self.GetBtnComposeTxt)
	self:RegisterApi("goClipNum", self.GetClipNum)
end

function EquipComposeUIApi:GetTitleText()
	return self:GetCfgText(1314151)
end

function EquipComposeUIApi:GetBtnComposeTxt()
	return self:GetCfgText(1314152)
end

function EquipComposeUIApi:GetClipNum(curNum, needNum)
	return curNum .. "/" .. needNum
end

EquipComposeUIApi:Init()
