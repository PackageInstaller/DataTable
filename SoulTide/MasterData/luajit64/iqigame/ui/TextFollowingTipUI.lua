-- chunkname: @IQIGame\\UI\\TextFollowingTipUI.lua

local TextFollowingTipUI = {}

TextFollowingTipUI = Base:Extend("TextFollowingTipUI", "IQIGame.Onigao.UI.TextFollowingTipUI", TextFollowingTipUI)

function TextFollowingTipUI:OnInit()
	function self.delegateBtnClose()
		self:OnBtnClose()
	end
end

function TextFollowingTipUI:GetPreloadAssetPaths()
	return nil
end

function TextFollowingTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function TextFollowingTipUI:IsManualShowOnOpen(userData)
	return false
end

function TextFollowingTipUI:GetBGM(userData)
	return nil
end

function TextFollowingTipUI:OnOpen(userData)
	self.titleStr = userData.title
	self.contentStr = userData.content
	self.refTrans = userData.refTrans
	self.limitStr = userData.limit

	local refAlign = userData.refAlign or UGUISide.BottomLeft
	local tipAlign = userData.tipAlign or UGUISide.TopLeft

	self:UpDateView()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.Content.transform)
	UIUtil.AdjustUIInScreen(self.UIController:GetComponent("Canvas"), self.refTrans, self.Content.transform, nil, refAlign, tipAlign)
end

function TextFollowingTipUI:OnClose(userData)
	return
end

function TextFollowingTipUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function TextFollowingTipUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function TextFollowingTipUI:OnPause()
	return
end

function TextFollowingTipUI:OnResume()
	return
end

function TextFollowingTipUI:OnCover()
	return
end

function TextFollowingTipUI:OnReveal()
	return
end

function TextFollowingTipUI:OnRefocus(userData)
	return
end

function TextFollowingTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function TextFollowingTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function TextFollowingTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function TextFollowingTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function TextFollowingTipUI:OnDestroy()
	return
end

function TextFollowingTipUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function TextFollowingTipUI:UpDateView()
	self.TextTitle:SetActive(self.titleStr ~= nil)
	self.ImgLine:SetActive(self.titleStr ~= nil)

	if self.titleStr ~= nil then
		UGUIUtil.SetText(self.TextTitle, self.titleStr)
	end

	UGUIUtil.SetText(self.TextInfo, self.contentStr)
	self.LimitNode:SetActive(self.limitStr ~= nil)

	if self.limitStr ~= nil then
		UGUIUtil.SetText(self.TextLimit, self.limitStr)
	end
end

return TextFollowingTipUI
