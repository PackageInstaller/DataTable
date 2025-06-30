-- chunkname: @IQIGame\\UIExternalApi\\ActivityCreditUIApi.lua

ActivityCreditUIApi = BaseLangApi:Extend()

function ActivityCreditUIApi:Init()
	self:RegisterApi("goBtnCloseTxt", self.GetBtnCloseTxt)
	self:RegisterApi("FRBtnJumpTxt", self.GetFRBtnJumpTxt)
	self:RegisterApi("FRBtnJumpTxtEng", self.GetFRBtnJumpTxtEng)
	self:RegisterApi("FRDesc1", self.GetFRDesc1)
	self:RegisterApi("FRBtnPVTxt", self.GetFRBtnPVTxt)
	self:RegisterApi("FRBtnDetailTxt_1", self.GetBtnDetailTxt_1)
	self:RegisterApi("FRBtnDetailTxt_2", self.GetBtnDetailTxt_2)
	self:RegisterApi("FRcgid", self.GetFRcgid)
	self:RegisterApi("FRBtnGetTxt", self.GetFRBtnGetTxt)
	self:RegisterApi("FRBtnGetTxtEng", self.GetFRBtnGetTxtEng)
end

function ActivityCreditUIApi:GetBtnCloseTxt()
	return self:GetCfgText(2900502)
end

function ActivityCreditUIApi:GetFRBtnGetTxtEng()
	return self:GetCfgText(2900504)
end

function ActivityCreditUIApi:GetFRBtnGetTxt()
	return self:GetCfgText(2900503)
end

function ActivityCreditUIApi:GetFRcgid()
	return 5001101
end

function ActivityCreditUIApi:GetBtnDetailTxt_1()
	return self:GetCfgText(2900505)
end

function ActivityCreditUIApi:GetBtnDetailTxt_2()
	return self:GetCfgText(2900506)
end

function ActivityCreditUIApi:GetFRBtnPVTxt()
	return self:GetCfgText(2900507)
end

function ActivityCreditUIApi:GetFRDesc1()
	return self:GetCfgText(2900508)
end

function ActivityCreditUIApi:GetFRBtnJumpTxt()
	return self:GetCfgText(2900509)
end

function ActivityCreditUIApi:GetFRBtnJumpTxtEng()
	return self:GetCfgText(2900510)
end

ActivityCreditUIApi:Init()
