-- chunkname: @IQIGame\\UIExternalApi\\MagicTowerExitUIApi.lua

MagicTowerExitUIApi = BaseLangApi:Extend()

function MagicTowerExitUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("ContentText", self.GetContentText)
	self:RegisterApi("TipText", self.GetTipText)
	self:RegisterApi("GiveUpBtnText", self.GetGiveUpBtnText)
	self:RegisterApi("AFKBtnText", self.GetAFKBtnText)
end

function MagicTowerExitUIApi:GetTitleText()
	return self:GetCfgText(2300015)
end

function MagicTowerExitUIApi:GetContentText()
	return "是否要直接退出当前关卡？"
end

function MagicTowerExitUIApi:GetTipText()
	return "暂离会保存关卡进度，放弃会直接结算并重置关卡"
end

function MagicTowerExitUIApi:GetGiveUpBtnText()
	return "放弃"
end

function MagicTowerExitUIApi:GetAFKBtnText()
	return self:GetCfgText(2300020)
end

MagicTowerExitUIApi:Init()
