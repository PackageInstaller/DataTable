-- chunkname: @IQIGame\\UI\\PersonalitySystemPanel.lua

local PersonalitySystemPanel = {}

PersonalitySystemPanel = Base:Extend("PersonalitySystemPanel", "IQIGame.Onigao.UI.PersonalitySystemPanel", PersonalitySystemPanel)

local PersonalitySystemView = require("IQIGame.UI.RoleDevelopment.PersonalitySystemView")

function PersonalitySystemPanel:OnInit()
	LuaCodeInterface.BindOutlet(self.View, self)

	self.PersonalitySystemView = PersonalitySystemView.New(self.MyPanel)
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	self:OnDelegation()
end

function PersonalitySystemPanel:OnDelegation()
	return
end

function PersonalitySystemPanel:GetPreloadAssetPaths()
	return nil
end

function PersonalitySystemPanel:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PersonalitySystemPanel:IsManualShowOnOpen(userData)
	return false
end

function PersonalitySystemPanel:GetBGM(userData)
	return nil
end

function PersonalitySystemPanel:OnOpen(userData)
	self.commonReturnBtn:SetHomeBtnState(SceneTransferModule.GetCanBackHome())
	self.PersonalitySystemView:SetData()
end

function PersonalitySystemPanel:OnClose(userData)
	return
end

function PersonalitySystemPanel:OnAddListeners()
	return
end

function PersonalitySystemPanel:OnRemoveListeners()
	return
end

function PersonalitySystemPanel:OnPause()
	return
end

function PersonalitySystemPanel:OnResume()
	return
end

function PersonalitySystemPanel:OnCover()
	return
end

function PersonalitySystemPanel:OnReveal()
	return
end

function PersonalitySystemPanel:OnRefocus(userData)
	return
end

function PersonalitySystemPanel:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PersonalitySystemPanel:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PersonalitySystemPanel:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PersonalitySystemPanel:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PersonalitySystemPanel:OnDestroy()
	self.PersonalitySystemView:OnDestroy()
	self.commonReturnBtn:Dispose()
end

return PersonalitySystemPanel
