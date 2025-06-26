-- chunkname: @IQIGame\\UI\\CommunicationUI.lua

local CommunicationUI = Base:Extend("CommunicationUI", "IQIGame.Onigao.UI.CommunicationUI", {})

function CommunicationUI:OnInit()
	self.Animation:SetActive(false)
end

function CommunicationUI:GetPreloadAssetPaths()
	return nil
end

function CommunicationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CommunicationUI:OnOpen(userData)
	if NetCommController.CommunicationCount == 0 then
		UIModule.Close(Constant.UIControllerName.CommunicationUI)

		return
	end

	self.ShowAnimationTimer = Timer.New(function()
		self.ShowAnimationTimer = nil

		self.Animation:SetActive(true)
	end, 1)

	self.ShowAnimationTimer:Start()
end

function CommunicationUI:OnClose(userData)
	if self.ShowAnimationTimer ~= nil then
		self.ShowAnimationTimer:Stop()

		self.ShowAnimationTimer = nil
	end

	self.Animation:SetActive(false)
end

function CommunicationUI:OnAddListeners()
	return
end

function CommunicationUI:OnRemoveListeners()
	return
end

function CommunicationUI:OnPause()
	return
end

function CommunicationUI:OnResume()
	return
end

function CommunicationUI:OnCover()
	return
end

function CommunicationUI:OnReveal()
	return
end

function CommunicationUI:OnRefocus(userData)
	return
end

function CommunicationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CommunicationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CommunicationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CommunicationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CommunicationUI:OnDestroy()
	return
end

return CommunicationUI
