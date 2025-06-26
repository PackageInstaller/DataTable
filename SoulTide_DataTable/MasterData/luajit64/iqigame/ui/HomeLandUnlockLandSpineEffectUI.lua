-- chunkname: @IQIGame\\UI\\HomeLandUnlockLandSpineEffectUI.lua

local HomeLandUnlockLandSpineEffectUI = {}

HomeLandUnlockLandSpineEffectUI = Base:Extend("HomeLandUnlockLandSpineEffectUI", "IQIGame.Onigao.UI.HomeLandUnlockLandSpineEffectUI", HomeLandUnlockLandSpineEffectUI)

function HomeLandUnlockLandSpineEffectUI:OnInit()
	function self.delegateSpineStartEnd()
		self:OnSpineStartEnd()
	end

	function self.delegateSpineEnd()
		self:OnSpineEnd()
	end
end

function HomeLandUnlockLandSpineEffectUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandUnlockLandSpineEffectUI:GetOpenPreloadAssetPaths(userData)
	self.spineEffectPath = UIGlobalApi.GetUIModelPath("UI_ChangeRoomDecorate")

	return {
		self.spineEffectPath
	}
end

function HomeLandUnlockLandSpineEffectUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandUnlockLandSpineEffectUI:GetBGM(userData)
	return nil
end

function HomeLandUnlockLandSpineEffectUI:OnOpen(userData)
	self:OpenSpineEffect()

	self.timer = Timer.New(function()
		self:PlaySpineEnd()
	end, 3)

	self.timer:Start()
end

function HomeLandUnlockLandSpineEffectUI:OnClose(userData)
	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil
end

function HomeLandUnlockLandSpineEffectUI:OnAddListeners()
	return
end

function HomeLandUnlockLandSpineEffectUI:OnRemoveListeners()
	return
end

function HomeLandUnlockLandSpineEffectUI:OnPause()
	return
end

function HomeLandUnlockLandSpineEffectUI:OnResume()
	return
end

function HomeLandUnlockLandSpineEffectUI:OnCover()
	return
end

function HomeLandUnlockLandSpineEffectUI:OnReveal()
	return
end

function HomeLandUnlockLandSpineEffectUI:OnRefocus(userData)
	return
end

function HomeLandUnlockLandSpineEffectUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandUnlockLandSpineEffectUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	local canvas = self.UIController.gameObject:GetComponent("Canvas")

	self.spineEffect:GetComponentInChildren(typeof(UnityEngine.Renderer)).sortingOrder = canvas.sortingOrder + 1
end

function HomeLandUnlockLandSpineEffectUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandUnlockLandSpineEffectUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandUnlockLandSpineEffectUI:OnDestroy()
	return
end

function HomeLandUnlockLandSpineEffectUI:OpenSpineEffect()
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

function HomeLandUnlockLandSpineEffectUI:OnSpineStartEnd()
	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete - self.delegateSpineStartEnd
	self.skeletonAnimation.AnimationName = nil

	self.skeletonAnimation.state:SetEmptyAnimation(0, 0)
	self.skeletonAnimation.state:SetAnimation(0, "Play_loop", true)
	EventDispatcher.Dispatch(EventID.UpdateHomeLandUnlockLandEvent)
end

function HomeLandUnlockLandSpineEffectUI:PlaySpineEnd()
	self.skeletonAnimation.AnimationName = nil

	self.skeletonAnimation.state:SetEmptyAnimation(0, 0)
	self.skeletonAnimation.state:SetAnimation(0, "End", false)

	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete + self.delegateSpineEnd
end

function HomeLandUnlockLandSpineEffectUI:OnSpineEnd()
	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete - self.delegateSpineEnd

	UIModule.CloseSelf(self)
end

return HomeLandUnlockLandSpineEffectUI
