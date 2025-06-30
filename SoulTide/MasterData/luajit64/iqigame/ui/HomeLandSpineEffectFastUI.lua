-- chunkname: @IQIGame\\UI\\HomeLandSpineEffectFastUI.lua

local HomeLandSpineEffectFastUI = Base:Extend("HomeLandSpineEffectFastUI", "IQIGame.Onigao.UI.HomeLandSpineEffectFastUI", {})

function HomeLandSpineEffectFastUI:OnInit()
	function self.delegateSpineStartEnd()
		self:OnSpineStartEnd()
	end

	function self.delegateSpineEnd()
		self:OnSpineEnd()
	end

	function self.delegateRoomCreatedArgs(sender, args)
		self:OnRoomCreateArgs(sender, args)
	end
end

function HomeLandSpineEffectFastUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandSpineEffectFastUI:GetOpenPreloadAssetPaths(userData)
	self.spineEffectPath = UIGlobalApi.GetUIModelPath("UI_ChangeRoomDecorate")

	return {
		self.spineEffectPath
	}
end

function HomeLandSpineEffectFastUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandSpineEffectFastUI:GetBGM(userData)
	return nil
end

function HomeLandSpineEffectFastUI:OnOpen(userData)
	self.isLoopEnd = false
	self.roomID = userData[1]
	self.decorateTab = userData[2]

	self:OpenSpineEffect()

	self.isTimerEnd = false
	self.isRoomCreate = false
	self.timer = Timer.New(function()
		self.isTimerEnd = true

		self:CheckEnterRoom()
	end, 4)

	self.timer:Start()
end

function HomeLandSpineEffectFastUI:OnClose(userData)
	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "CloseHomeLandSpineEffectFastUI")
	EventDispatcher.Dispatch(EventID.HomeLandUpdateRoomGuideEvent)
end

function HomeLandSpineEffectFastUI:OnAddListeners()
	GameEntry.LuaEvent:Subscribe(HomelandRoomCreatedEventArgs.EventId, self.delegateRoomCreatedArgs)
end

function HomeLandSpineEffectFastUI:OnRemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(HomelandRoomCreatedEventArgs.EventId, self.delegateRoomCreatedArgs)
end

function HomeLandSpineEffectFastUI:OnPause()
	return
end

function HomeLandSpineEffectFastUI:OnResume()
	return
end

function HomeLandSpineEffectFastUI:OnCover()
	return
end

function HomeLandSpineEffectFastUI:OnReveal()
	return
end

function HomeLandSpineEffectFastUI:OnRefocus(userData)
	return
end

function HomeLandSpineEffectFastUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandSpineEffectFastUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	local canvas = self.UIController.gameObject:GetComponent("Canvas")
	local Renders = self.spineEffect:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for i = 0, Renders.Length - 1 do
		Renders[i].sortingOrder = canvas.sortingOrder + 1
	end
end

function HomeLandSpineEffectFastUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandSpineEffectFastUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandSpineEffectFastUI:OnDestroy()
	return
end

function HomeLandSpineEffectFastUI:OpenSpineEffect()
	local Prefab = self.UIController:GetPreloadedAsset(self.spineEffectPath)

	for i = 0, self.Point.transform.childCount - 1 do
		local obj = self.Point.transform:GetChild(0).gameObject

		UnityEngine.GameObject.DestroyImmediate(obj)
	end

	self.spineEffect = UnityEngine.GameObject.Instantiate(Prefab)

	self.spineEffect.transform:SetParent(self.Point.transform, false)

	local canvas = self.UIController.gameObject:GetComponent("Canvas")
	local Renders = self.spineEffect:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for i = 0, Renders.Length - 1 do
		Renders[i].sortingOrder = canvas.sortingOrder + 1
	end

	self.skeletonAnimation = self.spineEffect:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))
	self.skeletonAnimation.AnimationName = nil

	self.skeletonAnimation.state:SetEmptyAnimation(0, 0)
	self.skeletonAnimation.state:SetAnimation(0, "Start", false)

	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete + self.delegateSpineStartEnd
end

function HomeLandSpineEffectFastUI:OnSpineStartEnd()
	HomeLandLuaModule.QuicklyPut(self.roomID, self.decorateTab)

	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete - self.delegateSpineStartEnd
	self.skeletonAnimation.AnimationName = nil

	self.skeletonAnimation.state:SetEmptyAnimation(0, 0)
	self.skeletonAnimation.state:SetAnimation(0, "Play_loop", true)
end

function HomeLandSpineEffectFastUI:PlaySpineEnd()
	self.skeletonAnimation.AnimationName = nil

	self.skeletonAnimation.state:SetEmptyAnimation(0, 0)
	self.skeletonAnimation.state:SetAnimation(0, "End", false)

	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete + self.delegateSpineEnd
end

function HomeLandSpineEffectFastUI:OnSpineEnd()
	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete - self.delegateSpineEnd

	UIModule.Close(Constant.UIControllerName.HomeLandSpineEffectFastUI)
end

function HomeLandSpineEffectFastUI:CheckEnterRoom()
	if self.isRoomCreate and self.isTimerEnd then
		self:PlaySpineEnd()
	end
end

function HomeLandSpineEffectFastUI:OnRoomCreateArgs(sender, args)
	if args.RoomID == self.roomID then
		self.isRoomCreate = true

		self:CheckEnterRoom()
	end
end

return HomeLandSpineEffectFastUI
