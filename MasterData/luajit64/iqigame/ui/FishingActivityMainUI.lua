-- chunkname: @IQIGame\\UI\\FishingActivityMainUI.lua

local FishingActivityMainUI = {
	LastShowPlayer = 0,
	BoatEntityId = 0,
	StartFishing = false,
	LastShowBoat = 0,
	CanThrow = false,
	PlayerEntityId = 0,
	Success = false
}

FishingActivityMainUI = Base:Extend("FishingActivityMainUI", "IQIGame.Onigao.UI.FishingActivityMainUI", FishingActivityMainUI)

local FishingActivityMainSkillView = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivityMain.FishingActivityMainSkillView")
local FishingActivityMainEndView = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivityMain.FishingActivityMainEndView")
local FishingActivityMainFishView = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivityMain.FishingActivityMainFishView")

require("IQIGame.UIExternalApi.FishingActivityMainUIApi")

function FishingActivityMainUI:OnInit()
	UGUIUtil.SetTextInChildren(self.BtnClose, FishingActivityMainUIApi:GetString("PanelTitle"))

	function self.DelegateOnClickBtnThrow()
		self:OnClickBtnThrow()
	end

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateThrowBite(fishPOD)
		self:OnThrowBite(fishPOD)
	end

	function self.DelegateFishEnd(success, fishPOD)
		self:OnFishEnd(success, fishPOD)
	end

	function self.DelegateOnShowEntitySuccess(sender, args)
		self:OnShowEntitySuccess(sender, args)
	end

	function self.DelegateUpdateEvent()
		self:OnUpdateEvent()
	end

	function self.DelegateThrowEnd()
		self:OnThrowEnd()
	end

	function self.DelegateFishOutEnd()
		self:OnFishOutEnd()
	end

	function self.DelegatePlaySkillAction(isPlay, skillActionData)
		self:OnPlaySkillAction(isPlay, skillActionData)
	end

	function self.DelegateFishResultEnd()
		self:OnFishResultEnd()
	end

	self.FishingSkillView = FishingActivityMainSkillView.New(self.SkillView)
	self.FishingEndView = FishingActivityMainEndView.New(self.FishingEnd)

	function self.FishingEndView.OnCloseCallBack()
		self:OnCloseEndView()
	end

	self.FishingFishView = FishingActivityMainFishView.New(self.FishingNode)

	function self.FishingFishView.OnFishingSkillActionCallBack()
		self:OnFishingSkill()
	end

	local cfgControlData = CfgFishActiveControlTable[FishingActivityModule.globalCid]

	self.MoneyCellBuilder = MoneyCellsBuilder.New(self.CurrencyCom)

	self.MoneyCellBuilder:RefreshView({
		cfgControlData.MoneyId,
		cfgControlData.ScoreId
	})

	self.EnergyCell = EnergyCell.New(self.EnergyCom)
end

function FishingActivityMainUI:GetPreloadAssetPaths()
	return nil
end

function FishingActivityMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FishingActivityMainUI:IsManualShowOnOpen(userData)
	return false
end

function FishingActivityMainUI:GetBGM(userData)
	return nil
end

function FishingActivityMainUI:OnOpen(userData)
	self.LastShowBoat = 0
	self.LastShowPlayer = 0

	self:ShowBoatEntity()
	self:ShowPlayerEntity()
	self:UpdateView()
end

function FishingActivityMainUI:OnClose(userData)
	self:StopFishing()
	self:HideBoatEntity()
	self:HidePlayerEntity()
	self:CleanSkillActionTimer()
	self.FishingEndView:Close()
	self.FishingSkillView:Close()
	self.FishingFishView:Close()
end

function FishingActivityMainUI:OnAddListeners()
	self.BtnThrow:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnThrow)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	EventDispatcher.AddEventListener(EventID.FishingActivityThrowBiteEvent, self.DelegateThrowBite)
	EventDispatcher.AddEventListener(EventID.FishingActivityEndEvent, self.DelegateFishEnd)
	EventDispatcher.AddEventListener(EventID.FishingActivityUpdateEvent, self.DelegateUpdateEvent)
	EventDispatcher.AddEventListener(EventID.FishingActivityPlaySkillActionEvent, self.DelegatePlaySkillAction)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowEntitySuccess)
end

function FishingActivityMainUI:OnRemoveListeners()
	self.BtnThrow:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnThrow)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	EventDispatcher.RemoveEventListener(EventID.FishingActivityThrowBiteEvent, self.DelegateThrowBite)
	EventDispatcher.RemoveEventListener(EventID.FishingActivityEndEvent, self.DelegateFishEnd)
	EventDispatcher.RemoveEventListener(EventID.FishingActivityUpdateEvent, self.DelegateUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.FishingActivityPlaySkillActionEvent, self.DelegatePlaySkillAction)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowEntitySuccess)
end

function FishingActivityMainUI:OnPause()
	return
end

function FishingActivityMainUI:OnResume()
	return
end

function FishingActivityMainUI:OnCover()
	return
end

function FishingActivityMainUI:OnReveal()
	return
end

function FishingActivityMainUI:OnRefocus(userData)
	return
end

function FishingActivityMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.FishingEndView:OnUpdate(elapseSeconds, realElapseSeconds)
	self.FishingSkillView:OnUpdate(elapseSeconds, realElapseSeconds)
	self.FishingFishView:OnUpdate(elapseSeconds, realElapseSeconds)
end

function FishingActivityMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FishingActivityMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FishingActivityMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FishingActivityMainUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.FishingEndView:Dispose()
	self.FishingSkillView:Dispose()
	self.MoneyCellBuilder:Dispose()

	self.MoneyCellBuilder = nil

	self.EnergyCell:Dispose()
end

function FishingActivityMainUI:UpdateView()
	self:SetDefaultFishingState()

	local cfgControlData = CfgFishActiveControlTable[FishingActivityModule.globalCid]
	local needID = cfgControlData.Cost[1]
	local needNum = cfgControlData.Cost[2]
	local haveNum = WarehouseModule.GetItemNumByCfgID(needID)

	self.CanThrow = needNum <= haveNum

	UGUIUtil.SetText(self.TextThrowSpend, FishingActivityMainUIApi:GetString("TextThrowSpend", CfgItemTable[needID].Name, needNum))
end

function FishingActivityMainUI:ShowPlayerEntity()
	if self.LastShowPlayer == FishingActivityModule.GetPlayerCfgLevelData().PlayerEntityId then
		self:PlayAnimation("idle", true)

		return
	end

	self:HidePlayerEntity()

	self.PlayerEntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.PlayerEntityId, FishingActivityModule.GetPlayerCfgLevelData().PlayerEntityId, 0, self.PlayerNode.transform, Vector3.zero)

	self.LastShowPlayer = FishingActivityModule.GetPlayerCfgLevelData().PlayerEntityId
end

function FishingActivityMainUI:HidePlayerEntity()
	if self.PlayerEntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.PlayerEntityId)

		self.PlayerEntityId = 0
	end
end

function FishingActivityMainUI:ShowBoatEntity()
	if self.LastShowBoat == FishingActivityModule.GetPlayerCfgLevelData().BoatEntityId then
		return
	end

	self:HideBoatEntity()

	self.BoatEntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.BoatEntityId, FishingActivityModule.GetPlayerCfgLevelData().BoatEntityId, 0, self.BoatNode.transform, Vector3.zero)

	self.LastShowBoat = FishingActivityModule.GetPlayerCfgLevelData().BoatEntityId
end

function FishingActivityMainUI:HideBoatEntity()
	if self.BoatEntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.BoatEntityId)

		self.BoatEntityId = 0
	end
end

function FishingActivityMainUI:OnShowEntitySuccess(sender, args)
	if self.BoatEntityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = Vector3(-1, 1, 1)
	elseif self.PlayerEntityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = Vector3(-1, 1, 1)
		self.SkeletonAnimationState = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic)).AnimationState

		if self.SkeletonAnimationState then
			self:PlayAnimation("idle", true)
		end
	end
end

function FishingActivityMainUI:PlayThrow()
	if self.SkeletonAnimationState then
		self:PlayAnimation("throw", false)

		self.SkeletonAnimationState.Complete = self.SkeletonAnimationState.Complete + self.DelegateThrowEnd

		GameEntry.Sound:PlaySound(11106, Constant.SoundGroup.UI)
	end

	self.ThrowNode:SetActive(false)
end

function FishingActivityMainUI:OnThrowEnd()
	self.SkeletonAnimationState.Complete = self.SkeletonAnimationState.Complete - self.DelegateThrowEnd

	self:PlayAnimation("fishout", false)

	self.SkeletonAnimationState.Complete = self.SkeletonAnimationState.Complete + self.DelegateFishOutEnd

	GameEntry.Sound:PlaySound(11105, Constant.SoundGroup.UI)
end

function FishingActivityMainUI:OnFishOutEnd()
	FishingActivityModule.Fishing()

	self.SkeletonAnimationState.Complete = self.SkeletonAnimationState.Complete - self.DelegateFishOutEnd

	self:PlayAnimation("fight1", true)
end

function FishingActivityMainUI:OnFishResultEnd()
	self.SkeletonAnimationState.Complete = self.SkeletonAnimationState.Complete - self.DelegateFishResultEnd

	if self.Success then
		local timer = Timer.New(function()
			self.FishingFishView:Close()
			self.FishingEndView:Open()
			self.FishingEndView:SetData(self.Success, self.FishPOD)

			self.StartFishing = false
		end, 0.5)

		timer:Start()
	else
		self:SetDefaultFishingState()
	end
end

function FishingActivityMainUI:PlaySkillActionAnimation()
	self:CleanSkillActionTimer()
	self:PlayAnimation("fight2", true)

	self.PlaySkillActionTimer = Timer.New(function()
		self:PlayAnimation("fight1", true)
	end, 1)

	self.PlaySkillActionTimer:Start()
end

function FishingActivityMainUI:PlayAnimation(actionName, top)
	if self.SkeletonAnimationState then
		self.SkeletonAnimationState:SetEmptyAnimation(0, 0)
		self.SkeletonAnimationState:SetAnimation(0, actionName, top)
	end
end

function FishingActivityMainUI:OnPlaySkillAction(isPlay, skillActionData)
	if not isPlay then
		if skillActionData then
			self:PlaySkillActionAnimation()
			self:PlayEffect(skillActionData:GetCfgData().EffectID)
		else
			self:PlayEffect(9001971)
		end
	end
end

function FishingActivityMainUI:CleanSkillActionTimer()
	if self.PlaySkillActionTimer then
		self.PlaySkillActionTimer:Stop()

		self.PlaySkillActionTimer = nil
	end
end

function FishingActivityMainUI:OnUpdateEvent()
	self:ShowBoatEntity()
	self:ShowPlayerEntity()
end

function FishingActivityMainUI:SetDefaultFishingState()
	self.StartFishing = false
	self.Success = false
	self.FishPOD = nil

	self.FishingEndView:Close()
	self.FishingSkillView:Close()
	self.FishingFishView:Close()
	self.ThrowNode:SetActive(true)
	self:PlayAnimation("idle", true)
	self:RemoveAnimationEvent()
end

function FishingActivityMainUI:OnThrowBite(fishPOD)
	self.FishData = fishPOD

	self.FishingFishView:Open()
	self.FishingFishView:SetData(fishPOD)
end

function FishingActivityMainUI:OnClickBtnThrow()
	if self.StartFishing then
		return
	end

	if not self.CanThrow then
		NoticeModule.ShowNoticeNoCallback(21041013)
		self:OnCloseEndView()

		return
	end

	self.StartFishing = true

	self:PlayThrow()
end

function FishingActivityMainUI:OnFishingSkill()
	self.FishingSkillView:Open()
end

function FishingActivityMainUI:OnCloseEndView()
	self:SetDefaultFishingState()
end

function FishingActivityMainUI:OnFishEnd(success, fishPOD)
	self.Success = success
	self.FishPOD = fishPOD

	self:CleanSkillActionTimer()

	if success then
		self:PlayAnimation("success", false)
		GameEntry.Sound:PlaySound(11102, Constant.SoundGroup.UI)
	else
		self:PlayAnimation("fail", false)
		self:PlayEffect(9001972)
		GameEntry.Sound:PlaySound(11101, Constant.SoundGroup.UI)
	end

	self.SkeletonAnimationState.Complete = self.SkeletonAnimationState.Complete + self.DelegateFishResultEnd
end

function FishingActivityMainUI:StopFishing()
	self:SetDefaultFishingState()
	self:RemoveAnimationEvent()
end

function FishingActivityMainUI:RemoveAnimationEvent()
	if self.SkeletonAnimationState then
		self.SkeletonAnimationState.Complete = self.SkeletonAnimationState.Complete - self.DelegateThrowEnd
		self.SkeletonAnimationState.Complete = self.SkeletonAnimationState.Complete - self.DelegateFishOutEnd
		self.SkeletonAnimationState.Complete = self.SkeletonAnimationState.Complete - self.DelegateFishResultEnd
	end
end

function FishingActivityMainUI:PlayEffect(effectID)
	GameEntry.Effect:PlayUIMountPointEffect(effectID, 50000, 0, self.EffectNode, self.UIController:GetComponent("Canvas").sortingOrder + 10)
end

function FishingActivityMainUI:OnBtnClose()
	if self.StartFishing then
		self:StopFishing()
	end

	UIModule.CloseSelf(self)
end

return FishingActivityMainUI
