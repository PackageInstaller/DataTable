-- chunkname: @IQIGame\\UI\\GameGuideInfoUI.lua

local GameGuideInfoUI = {
	index = 1,
	pageWidth = 1205
}

GameGuideInfoUI = Base:Extend("GameGuideInfoUI", "IQIGame.Onigao.UI.GameGuideInfoUI", GameGuideInfoUI)

function GameGuideInfoUI:OnInit()
	for i = 1, 6 do
		UGUIUtil.SetText(self["Text" .. i], GameGuideInfoUIApi:GetString("Text" .. i))
	end

	function self.delegateBtnRight()
		self:OnBtnRight()
	end
end

function GameGuideInfoUI:GetPreloadAssetPaths()
	return nil
end

function GameGuideInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GameGuideInfoUI:IsManualShowOnOpen(userData)
	return false
end

function GameGuideInfoUI:GetBGM(userData)
	return nil
end

function GameGuideInfoUI:OnOpen(userData)
	self.index = 0
	self.Content.transform.anchoredPosition.x = Vector2(0, 0)
end

function GameGuideInfoUI:OnClose(userData)
	return
end

function GameGuideInfoUI:OnAddListeners()
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.delegateBtnRight)
end

function GameGuideInfoUI:OnRemoveListeners()
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRight)
end

function GameGuideInfoUI:OnPause()
	return
end

function GameGuideInfoUI:OnResume()
	return
end

function GameGuideInfoUI:OnCover()
	return
end

function GameGuideInfoUI:OnReveal()
	return
end

function GameGuideInfoUI:OnRefocus(userData)
	return
end

function GameGuideInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GameGuideInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GameGuideInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GameGuideInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GameGuideInfoUI:OnDestroy()
	return
end

function GameGuideInfoUI:OnBtnRight()
	self.index = self.index + 1

	self:SetScrollContentPos()
end

function GameGuideInfoUI:SetScrollContentPos()
	local anPox = -self.index * self.pageWidth

	self.BtnRight:SetActive(false)

	local tween = TweenPosition.Begin(self.Content.transform.gameObject, 0.5, Vector2(anPox, 0))

	tween:SetOnFinished(function()
		self.BtnRight:SetActive(self.index < 4)
		UnityEngine.GameObject.DestroyImmediate(tween)
	end)
end

return GameGuideInfoUI
