-- chunkname: @IQIGame\\UI\\MagicWaxMuseumTipUI.lua

local MagicWaxMuseumTipUI = {}

MagicWaxMuseumTipUI = Base:Extend("MagicWaxMuseumTipUI", "IQIGame.Onigao.UI.MagicWaxMuseumTipUI", MagicWaxMuseumTipUI)

function MagicWaxMuseumTipUI:OnInit()
	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end
end

function MagicWaxMuseumTipUI:GetPreloadAssetPaths()
	return nil
end

function MagicWaxMuseumTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MagicWaxMuseumTipUI:IsManualShowOnOpen(userData)
	return false
end

function MagicWaxMuseumTipUI:GetBGM(userData)
	return nil
end

function MagicWaxMuseumTipUI:OnOpen(userData)
	local name = userData.name
	local describe = userData.describe

	self.refTrans = userData.refTrans

	UGUIUtil.SetText(self.goName, name)
	UGUIUtil.SetText(self.goDesc, describe)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.Content.transform)
	UIUtil.AdjustUIInScreen(self.UIController:GetComponent("Canvas"), self.refTrans, self.Content.transform, nil, UGUISide.Top, UGUISide.BottomLeft)
end

function MagicWaxMuseumTipUI:OnClose(userData)
	return
end

function MagicWaxMuseumTipUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.onClickBtnCloseDelegate)
end

function MagicWaxMuseumTipUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.onClickBtnCloseDelegate)
end

function MagicWaxMuseumTipUI:OnPause()
	return
end

function MagicWaxMuseumTipUI:OnResume()
	return
end

function MagicWaxMuseumTipUI:OnCover()
	return
end

function MagicWaxMuseumTipUI:OnReveal()
	return
end

function MagicWaxMuseumTipUI:OnRefocus(userData)
	return
end

function MagicWaxMuseumTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MagicWaxMuseumTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MagicWaxMuseumTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MagicWaxMuseumTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MagicWaxMuseumTipUI:OnDestroy()
	return
end

function MagicWaxMuseumTipUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.MagicWaxMuseumTipUI)
end

return MagicWaxMuseumTipUI
