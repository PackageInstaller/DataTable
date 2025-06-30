-- chunkname: @IQIGame\\UI\\DreamlandPerfectFinishUI.lua

local DreamlandPerfectFinishUI = {}

DreamlandPerfectFinishUI = Base:Extend("DreamlandPerfectFinishUI", "IQIGame.Onigao.UI.DreamlandPerfectFinishUI", DreamlandPerfectFinishUI)

require("IQIGame.UIExternalApi.DreamlandPerfectFinishUIApi")

function DreamlandPerfectFinishUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	local titleText1, titleText2 = DreamlandPerfectFinishUIApi:GetString("TitleText")

	UGUIUtil.SetText(self.TitleText1, titleText1)
	UGUIUtil.SetText(self.TitleText2, titleText2)
end

function DreamlandPerfectFinishUI:GetPreloadAssetPaths()
	return nil
end

function DreamlandPerfectFinishUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DreamlandPerfectFinishUI:IsManualShowOnOpen(userData)
	return false
end

function DreamlandPerfectFinishUI:GetBGM(userData)
	return nil
end

function DreamlandPerfectFinishUI:OnOpen(userData)
	GameEntry.Sound:PlaySound(10527, Constant.SoundGroup.UI)
end

function DreamlandPerfectFinishUI:OnClose(userData)
	return
end

function DreamlandPerfectFinishUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function DreamlandPerfectFinishUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function DreamlandPerfectFinishUI:OnPause()
	return
end

function DreamlandPerfectFinishUI:OnResume()
	return
end

function DreamlandPerfectFinishUI:OnCover()
	return
end

function DreamlandPerfectFinishUI:OnReveal()
	return
end

function DreamlandPerfectFinishUI:OnRefocus(userData)
	return
end

function DreamlandPerfectFinishUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DreamlandPerfectFinishUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DreamlandPerfectFinishUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DreamlandPerfectFinishUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DreamlandPerfectFinishUI:OnDestroy()
	return
end

function DreamlandPerfectFinishUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return DreamlandPerfectFinishUI
