-- chunkname: @IQIGame\\UI\\LunaBattleLineTipsUI.lua

local LunaBattleLineTipsUI = {}

LunaBattleLineTipsUI = Base:Extend("LunaBattleLineTipsUI", "IQIGame.Onigao.UI.LunaBattleLineTipsUI", LunaBattleLineTipsUI)

require("IQIGame.UIExternalApi.LunaBattleLineTipsUIApi")

function LunaBattleLineTipsUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickFullScreenCloseBtn()
		self:OnClickFullScreenCloseBtn()
	end

	UGUIUtil.SetText(self.TitleText, LunaBattleLineTipsUIApi:GetString("TitleText"))
end

function LunaBattleLineTipsUI:GetPreloadAssetPaths()
	return nil
end

function LunaBattleLineTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LunaBattleLineTipsUI:IsManualShowOnOpen(userData)
	return false
end

function LunaBattleLineTipsUI:GetBGM(userData)
	return nil
end

function LunaBattleLineTipsUI:OnOpen(userData)
	local cfgLunaBattleLineGlobalData = CfgLunaBattleLineGlobalTable[LunaBattleLineModule.GlobalCid]

	UGUIUtil.SetText(self.DescText, cfgLunaBattleLineGlobalData.Desc)
end

function LunaBattleLineTipsUI:OnClose(userData)
	return
end

function LunaBattleLineTipsUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.FullScreenCloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFullScreenCloseBtn)
end

function LunaBattleLineTipsUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.FullScreenCloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFullScreenCloseBtn)
end

function LunaBattleLineTipsUI:OnPause()
	return
end

function LunaBattleLineTipsUI:OnResume()
	return
end

function LunaBattleLineTipsUI:OnCover()
	return
end

function LunaBattleLineTipsUI:OnReveal()
	return
end

function LunaBattleLineTipsUI:OnRefocus(userData)
	return
end

function LunaBattleLineTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LunaBattleLineTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LunaBattleLineTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LunaBattleLineTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LunaBattleLineTipsUI:OnDestroy()
	return
end

function LunaBattleLineTipsUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function LunaBattleLineTipsUI:OnClickFullScreenCloseBtn()
	UIModule.CloseSelf(self)
end

return LunaBattleLineTipsUI
