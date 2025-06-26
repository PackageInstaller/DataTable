-- chunkname: @IQIGame\\UI\\HomeLandSpineEffectUI.lua

local HomeLandSpineEffectUI = Base:Extend("HomeLandSpineEffectUI", "IQIGame.Onigao.UI.HomeLandSpineEffectUI", {
	playSound = 0
})

function HomeLandSpineEffectUI:OnInit()
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

function HomeLandSpineEffectUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandSpineEffectUI:GetOpenPreloadAssetPaths(userData)
	self.spineEffectPath = UIGlobalApi.GetUIModelPath("UI_ChangeRoomDecorate")

	return {
		self.spineEffectPath
	}
end

function HomeLandSpineEffectUI:OnOpen(userData)
	self.isLoopEnd = false
	self.roomData = userData

	self:OpenSpineEffect()

	self.isTimerEnd = false
	self.isRoomCreate = false
	self.timer = Timer.New(function()
		self.isTimerEnd = true

		self:CheckEnterRoom()
	end, 4)

	self.timer:Start()
end

function HomeLandSpineEffectUI:OnClose(userData)
	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "CloseHomeLandSpineEffectUI")
	EventDispatcher.Dispatch(EventID.HomeLandUpdateRoomGuideEvent)

	if self.playSound > 0 then
		GameEntry.Sound:StopSound(self.playSound)
	end
end

function HomeLandSpineEffectUI:OnAddListeners()
	GameEntry.LuaEvent:Subscribe(HomelandRoomCreatedEventArgs.EventId, self.delegateRoomCreatedArgs)
end

function HomeLandSpineEffectUI:OnRemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(HomelandRoomCreatedEventArgs.EventId, self.delegateRoomCreatedArgs)
end

function HomeLandSpineEffectUI:OnPause()
	return
end

function HomeLandSpineEffectUI:OnResume()
	return
end

function HomeLandSpineEffectUI:OnCover()
	return
end

function HomeLandSpineEffectUI:OnReveal()
	return
end

function HomeLandSpineEffectUI:OnRefocus(userData)
	return
end

function HomeLandSpineEffectUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandSpineEffectUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	local canvas = self.UIController.gameObject:GetComponent("Canvas")

	self.spineEffect:GetComponentInChildren(typeof(UnityEngine.Renderer)).sortingOrder = canvas.sortingOrder + 1
end

function HomeLandSpineEffectUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandSpineEffectUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandSpineEffectUI:OnDestroy()
	return
end

function HomeLandSpineEffectUI:OpenSpineEffect()
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

function HomeLandSpineEffectUI:OnSpineStartEnd()
	GameEntry.Sound:PlaySound(HomeLandChooseCastleApi:GetString("UnlockRoomPanelBGM"), Constant.SoundGroup.UI)
	GameEntry.LuaEvent:Fire(nil, HomelandReCreateRoomEventArgs():Fill(self.roomData.cid, self.roomData))

	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete - self.delegateSpineStartEnd
	self.skeletonAnimation.AnimationName = nil

	self.skeletonAnimation.state:SetEmptyAnimation(0, 0)
	self.skeletonAnimation.state:SetAnimation(0, "Play_loop", true)
end

function HomeLandSpineEffectUI:PlaySpineEnd()
	self.skeletonAnimation.AnimationName = nil

	self.skeletonAnimation.state:SetEmptyAnimation(0, 0)
	self.skeletonAnimation.state:SetAnimation(0, "End", false)

	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete + self.delegateSpineEnd

	EventDispatcher.Dispatch(EventID.UpdateHomeLandUnlockLandEvent)
end

function HomeLandSpineEffectUI:OnSpineEnd()
	self.skeletonAnimation.state.Complete = self.skeletonAnimation.state.Complete - self.delegateSpineEnd

	UIModule.Close(Constant.UIControllerName.HomeLandSpineEffectUI)
end

function HomeLandSpineEffectUI:CheckEnterRoom()
	if self.isRoomCreate and self.isTimerEnd then
		self:PlaySpineEnd()

		if HomeLandLuaModule.currentEnterRoomID ~= self.roomData.cid then
			GameEntry.LuaEvent:Fire(nil, HomelandEnterRoomEventArgs():Fill(self.roomData.cid))
		end

		self.roomData = nil
	end
end

function HomeLandSpineEffectUI:OnRoomCreateArgs(sender, args)
	if self.roomData and args.RoomID == self.roomData.cid then
		self.isRoomCreate = true

		self:CheckEnterRoom()
	end
end

return HomeLandSpineEffectUI
