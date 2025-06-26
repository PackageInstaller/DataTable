-- chunkname: @IQIGame\\UI\\CommunicationUI.lua

local CommunicationUI = Base:Extend("CommunicationUI", "IQIGame.Onigao.UI.CommunicationUI", {})

function CommunicationUI:OnInit()
	UGUIUtil.SetText(self.ContentText, NoticeUIApi:GetTipsText())
end

function CommunicationUI:GetPreloadAssetPaths()
	return nil
end

function CommunicationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CommunicationUI:OnOpen(userData)
	local isHideContent = false

	if userData ~= nil and userData.isHideContent ~= nil then
		isHideContent = userData.isHideContent
	end

	LuaUtility.SetGameObjectShow(self.ContentText, not isHideContent)
	LuaUtility.SetGameObjectShow(self.EffectPoint, false)

	if NetCommController.CommunicationCount == 0 then
		if UIModule.HasUI(Constant.UIControllerName.CommunicationUI) then
			UIModule.Close(Constant.UIControllerName.CommunicationUI)
		end

		return
	end

	self.ShowAnimationTimer = Timer.New(function()
		self.ShowAnimationTimer = nil

		self.EffectPoint:SetActive(true)
	end, 1)

	self.ShowAnimationTimer:Start()
end

function CommunicationUI:OnClose(userData)
	if self.ShowAnimationTimer ~= nil then
		self.ShowAnimationTimer:Stop()

		self.ShowAnimationTimer = nil
	end

	self.EffectPoint:SetActive(false)
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
