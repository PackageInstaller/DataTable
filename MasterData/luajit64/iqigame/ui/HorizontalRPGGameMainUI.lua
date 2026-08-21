-- chunkname: @IQIGame\\UI\\HorizontalRPGGameMainUI.lua

local HorizontalRPGGameMainUI = {
	changeSceneEffectId = 0,
	boxCount = 0
}

HorizontalRPGGameMainUI = Base:Extend("HorizontalRPGGameMainUI", "IQIGame.Onigao.UI.HorizontalRPGGameMainUI", HorizontalRPGGameMainUI)

local HorizontalRPGGuideView = require("IQIGame.UI.ExploreHall.HorizontalRPG.HorizontalRPGGameMain.HorizontalRPGGuideView")
local HorizontalRPGTicketCell = require("IQIGame.UI.ExploreHall.HorizontalRPG.HorizontalRPGTicketCell")

function HorizontalRPGGameMainUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateOnClickBtnBag()
		self:OnClickBtnBag()
	end

	function self.DelegateOnHorizontalRPGLockInput(top)
		self:OnHorizontalRPGLockInput(top)
	end

	function self.DelegateRPGPlayerDataChange()
		self:OnRPGPlayerDataChange()
	end

	function self.DelegateChangeSceneEffect(isPlaySound)
		self:OnChangeSceneEffect(isPlaySound)
	end

	function self.DelegateOnEndEffectPlayEnd(sender, args)
		self:OnEffectEnd(sender, args)
	end

	function self.DelegateBoxPicking()
		self:OnBoxPicking()
	end

	function self.DelegateOnClickBtnGuide()
		self:OnBtnGuide()
	end

	self.BtnAttack:GetComponent("LongButton").OnPointerDownAction = function(go)
		self:OnClickBtnAttack(go)
	end
	self.BtnJump:GetComponent("LongButton").OnPointerDownAction = function(go)
		self:OnClickBtnJump(go)
	end
	self.BtnSliding:GetComponent("LongButton").OnPointerDownAction = function(go)
		self:OnBtnSliding(go)
	end
	self.BtnItem:GetComponent("LongButton").OnPointerDownAction = function(go)
		self:OnBtnItem(go)
	end
	self.joystickComp = self.Joystick:GetComponent("FingersJoystickScript")

	function self.joystickComp.JoystickExecuted(script, value)
		self:OnJoystickExecuted(script, value)
	end

	self.rpgGuideView = HorizontalRPGGuideView.New(self.TaskView)
	self.moneyCell = HorizontalRPGTicketCell.New(self.TicketMould)

	local cfgHorizontalRPGControlData = CfgHorizontalRPGControlTable[HorizontalRPGModule.globalCid]

	self.moneyCell:Refresh(cfgHorizontalRPGControlData.MoneyId)
end

function HorizontalRPGGameMainUI:GetPreloadAssetPaths()
	return nil
end

function HorizontalRPGGameMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HorizontalRPGGameMainUI:IsManualShowOnOpen(userData)
	return false
end

function HorizontalRPGGameMainUI:GetBGM(userData)
	return nil
end

function HorizontalRPGGameMainUI:OnOpen(userData)
	self:UpdateView()
end

function HorizontalRPGGameMainUI:OnClose(userData)
	self:CloseEffect()
end

function HorizontalRPGGameMainUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnBag:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBag)
	self.BtnGuide:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnGuide)
	EventDispatcher.AddEventListener(EventID.HorizontalRPGLockInputEvent, self.DelegateOnHorizontalRPGLockInput)
	EventDispatcher.AddEventListener(EventID.HorizontalRPGPlayerDataChange, self.DelegateRPGPlayerDataChange)
	EventDispatcher.AddEventListener(EventID.HorizontalRPGChangeSceneEffect, self.DelegateChangeSceneEffect)
	EventDispatcher.AddEventListener(EventID.HorizontalRPGBoxPickingEvent, self.DelegateBoxPicking)
	GameEntry.LuaEvent:Subscribe(EffectPlayEndEventArgs.EventId, self.DelegateOnEndEffectPlayEnd)
end

function HorizontalRPGGameMainUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnBag:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBag)
	self.BtnGuide:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnGuide)
	EventDispatcher.RemoveEventListener(EventID.HorizontalRPGLockInputEvent, self.DelegateOnHorizontalRPGLockInput)
	EventDispatcher.RemoveEventListener(EventID.HorizontalRPGPlayerDataChange, self.DelegateRPGPlayerDataChange)
	EventDispatcher.RemoveEventListener(EventID.HorizontalRPGChangeSceneEffect, self.DelegateChangeSceneEffect)
	EventDispatcher.RemoveEventListener(EventID.HorizontalRPGBoxPickingEvent, self.DelegateBoxPicking)
	GameEntry.LuaEvent:Unsubscribe(EffectPlayEndEventArgs.EventId, self.DelegateOnEndEffectPlayEnd)
end

function HorizontalRPGGameMainUI:OnPause()
	return
end

function HorizontalRPGGameMainUI:OnResume()
	return
end

function HorizontalRPGGameMainUI:OnCover()
	return
end

function HorizontalRPGGameMainUI:OnReveal()
	return
end

function HorizontalRPGGameMainUI:OnRefocus(userData)
	return
end

function HorizontalRPGGameMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self:ChangeBtnState()
end

function HorizontalRPGGameMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HorizontalRPGGameMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HorizontalRPGGameMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HorizontalRPGGameMainUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.rpgGuideView:Dispose()

	self.rpgGuideView = nil

	self.moneyCell:Dispose()
end

function HorizontalRPGGameMainUI:UpdateView()
	self.BtnAttack:SetActive(HorizontalRPGModule.horizontalRPGPlayerData:GetCfgData().IsAttack)
	self.BtnJump:SetActive(HorizontalRPGModule.horizontalRPGPlayerData:GetCfgData().IsJump)
	UGUIUtil.SetText(self.TextLv, HorizontalRPGModule.horizontalRPGPlayerData.maxLv)

	for i = 1, 5 do
		self.MaxStarts.transform:GetChild(i - 1).gameObject:SetActive(i <= HorizontalRPGModule.horizontalRPGPlayerData.maxLv)
		self.Starts.transform:GetChild(i - 1).gameObject:SetActive(i <= HorizontalRPGModule.horizontalRPGPlayerData:GetLv())
	end

	UGUIUtil.SetTextInChildren(self.BtnClose, HorizontalRPGModule.currentHorizontalRPGMapData:GetCfgData().Name)
	self.rpgGuideView:UpdateView()
	self:RefreshBoxNum()
	self:RefreshSlidingBtn()
end

function HorizontalRPGGameMainUI:RefreshSlidingBtn()
	local isOpen = HorizontalRPGModule.horizontalRPGScene.HorizontalGamePaler.isSliding

	self.OpenSliding:SetActive(isOpen)
	self.CloseSliding:SetActive(not isOpen)
end

function HorizontalRPGGameMainUI:RefreshBoxNum()
	self.boxCount = #HorizontalRPGModule.pickedUpBox

	UGUIUtil.SetTextInChildren(self.BtnItem, self.boxCount)
	self.BtnItem:SetActive(self.boxCount > 0)
end

function HorizontalRPGGameMainUI:ChangeBtnState()
	if HorizontalRPGModule.horizontalRPGScene and HorizontalRPGModule.horizontalRPGScene.HorizontalGamePaler then
		local isGlide = HorizontalRPGModule.horizontalRPGPlayerData:GetCfgData().IsGlide

		self.BtnSliding:SetActive(isGlide)
	end
end

function HorizontalRPGGameMainUI:OnHorizontalRPGLockInput(top)
	self.OuterNode:SetActive(not top)

	if top then
		self.joystickComp:ResetJoyStickToCenter()
	end
end

function HorizontalRPGGameMainUI:OnRPGPlayerDataChange()
	self:UpdateView()
end

function HorizontalRPGGameMainUI:OnJoystickExecuted(script, value)
	EventDispatcher.Dispatch(EventID.JoystickMove, value)
end

function HorizontalRPGGameMainUI:PlayEffect()
	self.changeSceneEffectId = GameEntry.Effect:PlayUIMountPointEffect(9000921, Constant.MountPoint.PointRoot, 0, self.Root, self.UIController:GetComponent(typeof(UnityEngine.Canvas)).sortingOrder + 1)
end

function HorizontalRPGGameMainUI:CloseEffect()
	if self.changeSceneEffectId ~= 0 then
		GameEntry.Effect:StopEffect(self.changeSceneEffectId)

		self.changeSceneEffectId = 0
	end
end

function HorizontalRPGGameMainUI:OnBoxPicking()
	self:RefreshBoxNum()
end

function HorizontalRPGGameMainUI:OnChangeSceneEffect(isPlaySound)
	if isPlaySound then
		GameEntry.Sound:PlaySound(HorizontalRPGConstant.Sound.ChangeScene, Constant.SoundGroup.UI)

		if GameEntry.Base.DevMode then
			log("播放切屏音效 " .. HorizontalRPGConstant.Sound.ChangeScene)
		end
	end

	self:PlayEffect()
	EventDispatcher.Dispatch(EventID.HorizontalRPGLockInputEvent, true)
end

function HorizontalRPGGameMainUI:OnEffectEnd(sender, args)
	if self.changeSceneEffectId == args.EffectPlayID then
		self:CloseEffect()
	end

	EventDispatcher.Dispatch(EventID.HorizontalRPGLockInputEvent, false)
end

function HorizontalRPGGameMainUI:OnClickBtnClose()
	NoticeModule.ShowNotice(21045123, function()
		HorizontalRPGModule.ExitHorizontalRPGScene()
	end, nil)
end

function HorizontalRPGGameMainUI:OnClickBtnBag()
	UIModule.Open(Constant.UIControllerName.HorizontalRPGMazeBagUI, Constant.UILayer.UI)
end

function HorizontalRPGGameMainUI:OnBtnSliding()
	HorizontalRPGModule.horizontalRPGScene.HorizontalGamePaler:Sliding()
	self:RefreshSlidingBtn()
end

function HorizontalRPGGameMainUI:OnClickBtnAttack()
	HorizontalRPGModule.horizontalRPGScene.HorizontalGamePaler:Fire()
end

function HorizontalRPGGameMainUI:OnClickBtnJump()
	HorizontalRPGModule.horizontalRPGScene.HorizontalGamePaler:Jump(true)
end

function HorizontalRPGGameMainUI:OnBtnGuide()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 12000)
end

function HorizontalRPGGameMainUI:OnBtnItem()
	if self.boxCount <= 0 then
		return
	end

	local result = HorizontalRPGModule.horizontalRPGScene.HorizontalGamePaler:CheckPlayerCanPutBox()

	if not result then
		NoticeModule.ShowNotice(21045121)

		return
	end

	HorizontalRPGModule.PlaceTheBox()
end

return HorizontalRPGGameMainUI
