-- chunkname: @IQIGame\\UI\\LinkTipUI.lua

local LinkTipUI = {}

LinkTipUI = Base:Extend("LinkTipUI", "IQIGame.Onigao.UI.LinkTipUI", LinkTipUI)

function LinkTipUI:OnInit()
	self:Initialize()
end

function LinkTipUI:GetPreloadAssetPaths()
	return nil
end

function LinkTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LinkTipUI:IsManualShowOnOpen(userData)
	return false
end

function LinkTipUI:GetBGM(userData)
	return nil
end

function LinkTipUI:OnOpen(userData)
	self:Refresh(userData)
end

function LinkTipUI:OnClose(userData)
	self:OnHide()
end

function LinkTipUI:OnPause()
	return
end

function LinkTipUI:OnResume()
	return
end

function LinkTipUI:OnCover()
	return
end

function LinkTipUI:OnReveal()
	return
end

function LinkTipUI:OnRefocus(userData)
	return
end

function LinkTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LinkTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LinkTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LinkTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LinkTipUI:Initialize()
	self.linkTipCell = LinkTipCell.New(self.goLinkTipCell)
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end
end

function LinkTipUI:Refresh(userData)
	local txt = userData[1]
	local refGo = userData[2]
	local refSide = userData[3]
	local followerSide = userData[4]

	self.linkTipCell:Open(txt, refGo, refSide, followerSide)
end

function LinkTipUI:OnHide()
	return
end

function LinkTipUI:OnDestroy()
	self.linkTipCell:OnDestroy()
end

function LinkTipUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
end

function LinkTipUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function LinkTipUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

return LinkTipUI
