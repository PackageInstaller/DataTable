-- chunkname: @IQIGame\\UI\\SimpleGuideUI.lua

local SimpleGuideUI = {}

SimpleGuideUI = Base:Extend("SimpleGuideUI", "IQIGame.Onigao.UI.SimpleGuideUI", SimpleGuideUI)

function SimpleGuideUI:OnInit()
	self:InitDelegate()
end

function SimpleGuideUI:InitDelegate()
	function self.delegateOnClickButtonGuide()
		self:OnClickButtonGuide()
	end
end

function SimpleGuideUI:OnAddListeners()
	self.buttonGuide:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonGuide)
end

function SimpleGuideUI:OnRemoveListeners()
	self.buttonGuide:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonGuide)
end

function SimpleGuideUI:OnClickButtonGuide()
	UIModule.CloseSelf(self)
	GuideModule.SimpleGuideTriggerEnd(self.cfgGuide.Id, self.cfgGuide.KeyID)
end

function SimpleGuideUI:OnOpen(userData)
	self.cfgGuide = userData.cfgGuide

	self:Refresh()
end

function SimpleGuideUI:OnClose(userData)
	return
end

function SimpleGuideUI:GetPreloadAssetPaths()
	return nil
end

function SimpleGuideUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SimpleGuideUI:IsManualShowOnOpen(userData)
	return false
end

function SimpleGuideUI:GetBGM(userData)
	return nil
end

function SimpleGuideUI:OnPause()
	return
end

function SimpleGuideUI:OnResume()
	return
end

function SimpleGuideUI:OnCover()
	return
end

function SimpleGuideUI:OnReveal()
	return
end

function SimpleGuideUI:OnRefocus(userData)
	return
end

function SimpleGuideUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SimpleGuideUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SimpleGuideUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SimpleGuideUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SimpleGuideUI:Refresh()
	local subId = self.cfgGuide.SubIDList[1]
	local cfgSub = GuideModule.GetSubGuide(subId)

	LuaUtility.LoadImage(self, cfgSub.ImagePath, self.imageGuide:GetComponent("Image"), function()
		LuaUtility.SetImageNativeSizeWithGameObject(self.imageGuide)
	end)
end

function SimpleGuideUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

return SimpleGuideUI
