-- chunkname: @IQIGame\\UIExternalApi\\MazeSubmitItemUIApi.lua

MazeSubmitItemUIApi = BaseLangApi:Extend()

function MazeSubmitItemUIApi:Init()
	self:RegisterApi("CloseBtnText", self.GetCloseBtnText)
	self:RegisterApi("SubmitBtnTipText", self.GetSubmitBtnTipText)
	self:RegisterApi("SubmitBtnText", self.GetSubmitBtnText)
	self:RegisterApi("SelectBtnTipText", self.GetSelectBtnTipText)
	self:RegisterApi("SelectBtnText", self.GetSelectBtnText)
end

function MazeSubmitItemUIApi:GetCloseBtnText()
	return self:GetCfgText(1009024)
end

function MazeSubmitItemUIApi:GetSubmitBtnTipText()
	return self:GetCfgText(1130055)
end

function MazeSubmitItemUIApi:GetSubmitBtnText()
	return self:GetCfgText(1130051)
end

function MazeSubmitItemUIApi:GetSelectBtnTipText()
	return self:GetCfgText(1130054)
end

function MazeSubmitItemUIApi:GetSelectBtnText()
	return self:GetCfgText(1130052)
end

MazeSubmitItemUIApi:Init()
