-- chunkname: @IQIGame\\UI\\VirtualPhotoNoticeUI.lua

require("IQIGame.UIExternalApi.VirtualPhotoNoticeUIApi")

local VirtualPhotoNoticeUI = {}

VirtualPhotoNoticeUI = Base:Extend("VirtualPhotoNoticeUI", "IQIGame.Onigao.UI.VirtualPhotoNoticeUI", VirtualPhotoNoticeUI)

function VirtualPhotoNoticeUI:OnInit()
	function self.DelegateOnClickNotShowBtn()
		self:OnClickNotShowBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	UGUIUtil.SetTextInChildren(self.ConfirmBtn, VirtualPhotoNoticeUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetTextInChildren(self.NotShowBtn, VirtualPhotoNoticeUIApi:GetString("NotShowBtnText"))
	UGUIUtil.SetText(self.TextTitle, VirtualPhotoNoticeUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.GestureTipText1, VirtualPhotoNoticeUIApi:GetString("GestureTipText1"))
	UGUIUtil.SetText(self.GestureTipText2, VirtualPhotoNoticeUIApi:GetString("GestureTipText2"))
	UGUIUtil.SetText(self.GestureTipText3, VirtualPhotoNoticeUIApi:GetString("GestureTipText3"))
	UGUIUtil.SetText(self.GestureTipText4, VirtualPhotoNoticeUIApi:GetString("GestureTipText4"))
end

function VirtualPhotoNoticeUI:GetPreloadAssetPaths()
	return nil
end

function VirtualPhotoNoticeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function VirtualPhotoNoticeUI:IsManualShowOnOpen(userData)
	return false
end

function VirtualPhotoNoticeUI:GetBGM(userData)
	return nil
end

function VirtualPhotoNoticeUI:OnOpen(userData)
	return
end

function VirtualPhotoNoticeUI:OnClose(userData)
	return
end

function VirtualPhotoNoticeUI:OnAddListeners()
	self.NotShowBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickNotShowBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function VirtualPhotoNoticeUI:OnRemoveListeners()
	self.NotShowBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickNotShowBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function VirtualPhotoNoticeUI:OnPause()
	return
end

function VirtualPhotoNoticeUI:OnResume()
	return
end

function VirtualPhotoNoticeUI:OnCover()
	return
end

function VirtualPhotoNoticeUI:OnReveal()
	return
end

function VirtualPhotoNoticeUI:OnRefocus(userData)
	return
end

function VirtualPhotoNoticeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function VirtualPhotoNoticeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function VirtualPhotoNoticeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function VirtualPhotoNoticeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function VirtualPhotoNoticeUI:OnDestroy()
	return
end

function VirtualPhotoNoticeUI:OnClickNotShowBtn()
	UIModule.CloseSelf(self)
	PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.VirtualPhotoNoticeDisabled, 1)
end

function VirtualPhotoNoticeUI:OnClickConfirmBtn()
	UIModule.CloseSelf(self)
end

function VirtualPhotoNoticeUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return VirtualPhotoNoticeUI
