-- chunkname: @IQIGame\\UI\\HomeLandUpgradeEffectUI.lua

local HomeLandUpgradeEffectUI = Base:Extend("HomeLandUpgradeEffectUI", "IQIGame.Onigao.UI.HomeLandUpgradeEffectUI", {})

function HomeLandUpgradeEffectUI:OnInit()
	function self.delegateSpineStartEnd()
		self:OnSpineStartEnd()
	end

	function self.delegateSpineEnd()
		self:OnSpineEnd()
	end
end

function HomeLandUpgradeEffectUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandUpgradeEffectUI:GetOpenPreloadAssetPaths(userData)
	self.spineEffectPath = UIGlobalApi.GetUIModelPath("UI_ChangeRoomDecorate")

	return {
		self.spineEffectPath
	}
end

function HomeLandUpgradeEffectUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandUpgradeEffectUI:GetBGM(userData)
	return nil
end

function HomeLandUpgradeEffectUI:OnOpen(userData)
	self.cfgBuildingID = userData

	self:OpenSpineEffect()

	self.timer = Timer.New(function()
		self:PlaySpineEnd()
	end, 2)
end

function HomeLandUpgradeEffectUI:OnClose(userData)
	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil
end

function HomeLandUpgradeEffectUI:OnAddListeners()
	return
end

function HomeLandUpgradeEffectUI:OnRemoveListeners()
	return
end

function HomeLandUpgradeEffectUI:OnPause()
	return
end

function HomeLandUpgradeEffectUI:OnResume()
	return
end

function HomeLandUpgradeEffectUI:OnCover()
	return
end

function HomeLandUpgradeEffectUI:OnReveal()
	return
end

function HomeLandUpgradeEffectUI:OnRefocus(userData)
	return
end

function HomeLandUpgradeEffectUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandUpgradeEffectUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	local canvas = self.UIController.gameObject:GetComponent("Canvas")

	self.spineEffect:GetComponentInChildren(typeof(UnityEngine.Renderer)).sortingOrder = canvas.sortingOrder + 1
end

function HomeLandUpgradeEffectUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandUpgradeEffectUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandUpgradeEffectUI:OnDestroy()
	return
end

function HomeLandUpgradeEffectUI:OpenSpineEffect()
	local Prefab = self.UIController:GetPreloadedAsset(self.spineEffectPath)

	for i = 0, self.Point.transform.childCount - 1 do
		local obj = self.Point.transform:GetChild(0).gameObject

		UnityEngine.GameObject.DestroyImmediate(obj)
	end

	self.spineEffect = UnityEngine.GameObject.Instantiate(Prefab)

	self.spineEffect.transform:SetParent(self.Point.transform, false)

	local canvas = self.UIController.gameObject:GetComponent("Canvas")

	self.spineEffect:GetComponentInChildren(typeof(UnityEngine.Renderer)).sortingOrder = canvas.sortingOrder + 1
	self.skeletonAnimation = self.spineEffect:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))
	self.skeletonAnimation.AnimationName = nil

	self.skeletonAnimation.state:SetEmptyAnimation(0, 0)
	self.skeletonAnimation.state:SetAnimation(0, "Start", false)

	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete + self.delegateSpineStartEnd
end

function HomeLandUpgradeEffectUI:OnSpineStartEnd()
	HomeLandLuaModule.UpdateBuildingLv(self.cfgBuildingID)

	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete - self.delegateSpineStartEnd
	self.skeletonAnimation.AnimationName = nil

	self.skeletonAnimation.state:SetEmptyAnimation(0, 0)
	self.skeletonAnimation.state:SetAnimation(0, "Play_loop", true)
	self.timer:Start()
end

function HomeLandUpgradeEffectUI:PlaySpineEnd()
	self.skeletonAnimation.AnimationName = nil

	self.skeletonAnimation.state:SetEmptyAnimation(0, 0)
	self.skeletonAnimation.state:SetAnimation(0, "End", false)

	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete + self.delegateSpineEnd
end

function HomeLandUpgradeEffectUI:OnSpineEnd()
	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete - self.delegateSpineEnd

	UIModule.Close(Constant.UIControllerName.HomeLandUpgradeEffectUI)
end

return HomeLandUpgradeEffectUI
