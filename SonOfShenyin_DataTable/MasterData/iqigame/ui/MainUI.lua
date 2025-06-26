-- chunkname: @IQIGame\\UI\\MainUI.lua

local MainUI = Base:Extend("MainUI", "IQIGame.Onigao.UI.MainUI", {})
local joystickUI = require("IQIGame.UI.Story.StoryJoystickView")
local HomeUIController = require("IQIGame/UI/Home/HomeUIController")
local storyPanelClass = require("IQIGame/UI/Story/StoryPanel")
local RPGInfoPanelClass = require("IQIGame/UI/Main/MainUI_RPGInfoPanel")
local HudPanelClass = require("IQIGame/UI/Main/MainUI_HudPanel")
local DialogControlClass = require("IQIGame/UI/Dialog/CommonDialogController")
local dataName_model = "model"
local dataName_buttonCollection = "buttonCollection"
local stateName_rightBottomShrink = "rightBottomShrink"
local stateName_rightBottomExpand = "rightBottomExpand"
local stateName_story = "story"
local stateName_mainUI = "mainUI"
local stateName_showImagePuzzle = "onShowImagePuzzle"
local stateName_hideImagePuzzle = "onHideImagePuzzle"
local MainPhoneUI = require("IQIGame/UI/MainPhoneUI")

function MainUI:OnInit()
	self.phoneUI = MainPhoneUI.New(self.MainPhoneUIRoot)

	self:InitMembers()
	self:InitDelegate()
	self:InitComponent()
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[Constant.ItemCid.STRENGTH].SmallIcon), self.energyImg:GetComponent("Image"))
end

function MainUI:InitMembers()
	self.isObjectExpandShow = false
end

function MainUI:InitComponent()
	self.moneyCell = CurrencyCell.New(self.MoneyTopRoot)
	self.JoystickView = joystickUI.New(self.JosyStickUI)
	self.storyPanel = storyPanelClass.New(self.StoryPanel, self)

	self.storyPanel:Hide()

	self.rpgInfoPanel = RPGInfoPanelClass.New(self.RPGInfoRoot, self)
	self.hudPanel = HudPanelClass.New(self.hudRoot, self)
	self.dialogController = DialogControlClass.New()

	self.dialogController:RegisterActionCallBack(function(actionType, actionParam)
		WorldMapModule.RPGActionTrigger(actionType, actionParam)
	end)

	self.toggleRegular = self.toggleRegular:GetComponent("Toggle")
	PlayerModule.isOpenInspector = PlayerPrefsUtil.GetString("", "OpenInspectorPrefs") == "true"

	local inspectorParent = GameObject.Find("Inspector")

	if inspectorParent then
		local inspectorObj = inspectorParent.transform:Find("InspectorCanvas")

		if inspectorObj then
			inspectorObj.gameObject:SetActive(PlayerModule.isOpenInspector)
		end
	end

	self.QuickJumpBtn:SetActive(false)
end

function MainUI:InitDelegate()
	function self.DelegateOnClickGmBtn()
		self:OnClickGMBtn()
	end

	function self.DelegateOnClickGmBtn1()
		UIModule.Open(Constant.UIControllerName.MazeUI, Constant.UILayer.UI)
	end

	function self.DelegateOnClickStartGameBtn()
		self:OnClickStartGameBtn()
	end

	function self.DelegateOnGetGameNotice(noticeData)
		return
	end

	function self.DelegateUpdateJoystickDirectTransform()
		self:UpdateJoystickDirectTransform()
	end

	function self.DelegateOnUnlockFunctionUpdateEvent()
		self:OnRefreshUnlockBtn()
	end

	function self.DelegateCheckFuncOpen()
		self:CheckSpecialPopups()
	end

	function self.DelegateOnClickHeroBtn()
		self:OnClickHeroBtn()
	end

	function self.DelegateOnClickShopBtn()
		self:OnClickShopBtn()
	end

	function self.DelegateLotteryBtn()
		self:OnClickLotteryBtn()
	end

	function self.DelegatePassBtn()
		self:OnClickPassBtn()
	end

	function self.DelegateActivityBtn()
		self:OnClickActivityBtn()
	end

	function self.DelegateNoviceGradeBtn()
		self:OnClickNoviceGradeBtn()
	end

	function self.DelegateOnAddStrengthBtn()
		self:OnAddStrengthBtn()
	end

	function self.DelegateOpenMobilePhoneEvent(state)
		self:OpenMobilePhoneEvent(state)
	end

	function self.DelegateOnClickPlayeInfoBtn()
		self:OnClickPlayeInfoBtn()
	end

	function self.DelegateOnClickPushGiftBtn()
		self:OnClickPushGiftBtn()
	end

	function self.DelegateOnClickActivityListBtn()
		self:OnClickActivityListBtn(Constant.ActivityListTeamID.Activity)
	end

	function self.DelegateOnClickWelfareListBtn()
		self:OnClickActivityListBtn(Constant.ActivityListTeamID.Welfare)
	end

	function self.DelegateOnClickFirstRechargeBtn()
		self:OnClickFirstRechargeBtn()
	end

	function self.DelegateNotifyUpdateStage()
		self:NotifyUpdateStage()
	end

	function self.DelegateOnChangeShowHcidSucced()
		self:LoadPlayerHeadImg()
	end

	function self.Delegation_Response_GetReNameResult()
		self:LoadPlayerName()
	end

	function self.DelegateOnPlayLvChange()
		self:LoadPlayerLv()
	end

	function self.DelegateRefreshPlayerInfoData()
		self:RefreshPlayerInfo()
	end

	function self.DelegateResetTalent()
		self:ResetTalent()
	end

	function self.DelegateUpdataItem()
		self:UpdateItem()
	end

	function self.DelegateOnClickRechargeRebateBtn()
		self:OnClickRechargeRebateBtn()
	end

	function self.DelegateNotifyLimitedTimePkg()
		self:OnNotifyChangeShopItems()
	end

	function self.ActivityPassUIActiveEvent(state)
		self:RefreshBtnVisable()
	end

	function self.DelegateOnTaskNotifyEvent()
		self:OnTaskNotifyEvent()
	end

	function self.DelgateOnReceiveRechargeRebateEvent()
		self:RefreshRebateBtnState()
	end

	function self.DelegateOnNotifyPlayerDataChangeEvent()
		self:OnNotifyPlayerDataChangeEvent()
	end

	function self.DelegateOnActivityUpdateEvent()
		self:OnActivityUpdateEvent()
	end

	function self.DelgateOnPushGiftUIClosedEvent()
		self:OnPushGiftUIClosedEvent()
	end

	function self.DelegateMaincitySpecialEvent(eventID, target)
		self:OpenDialogue(eventID, target)
	end

	function self.__delegateOnUpdateHomePlayerMoveSpeed(_speed)
		self:__OnUpdateHomePlayerMoveSpeed(_speed)
	end

	function self.__delegateSetMainUIScreenMaskActive(active)
		self:__OnSetMainUIScreenMaskActive(active)
	end

	function self.__delegateOnLotteryNotifyDrawPoolUpdate()
		self:__RefreshLotteryRedDot()
	end

	function self.DelegateOnClickActiveActivityListBtn()
		self:OnClickActiveActivityListBtn(Constant.ActivityListTeamID.SummerActivity)
	end

	function self.showStoryUIEvent()
		self.storyPanel:Show()
	end

	function self.hideStoryUIEvent()
		self.storyPanel:Hide()
	end

	function self.showNpcNameEvent(mountPoint, nameString, componentId)
		self.hudPanel:ShowNpcName(mountPoint, nameString, componentId)
	end

	function self.hideNpcNameEvent(mountPoint)
		self.hudPanel:HideNpcName(mountPoint)
	end

	function self.freeNpcNameEvent(mountPoint)
		self.hudPanel:FreeNpcName(mountPoint)
	end

	function self.showDialogEvent(actorId, dialogueId)
		self.dialogController:ShowDialogAction(actorId, dialogueId, Constant.CommonDialogCfgType.Main)
	end

	function self.delegateOnClickButtonStorage()
		LuaUtility.SetStateController(self.gameObject, dataName_buttonCollection, stateName_rightBottomShrink)
	end

	function self.delegateOnClickButtonList()
		LuaUtility.SetStateController(self.gameObject, dataName_buttonCollection, stateName_rightBottomExpand)
	end

	function self.delegateOnOpenPhoneBtnClick()
		if UnlockFunctionModule.OnClickInterceptor(Constant.UnlockType.FUNC_SmallPhone) then
			return
		end

		if StoryModule.IsStoring and StoryModule.storyState == Constant.StoryState.Interact then
			return
		end

		if StoryModule.IsStoring then
			StoryModule.PauseStory()
		end

		self:OpenMobilePhoneEvent(true, {
			showAppearance = true
		})
	end

	function self.toggleRegularClickDelegate(isOn)
		self:OnToggleRegularClick(isOn)
	end

	function self.delegateOnClickButtonMessage()
		self:OnClickButtonMessage()
	end
end

function MainUI:OnAddListeners()
	self.StartGameBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickStartGameBtn)
	self.GMBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGmBtn)
	self.GMBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGmBtn1)
	self.HeroBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickHeroBtn)
	self.LotteryBtn:GetComponent("Button").onClick:AddListener(self.DelegateLotteryBtn)
	self.PassactivityBtn:GetComponent("Button").onClick:AddListener(self.DelegatePassBtn)
	self.ActivityBtn:GetComponent("Button").onClick:AddListener(self.DelegateActivityBtn)
	self.PlayerInfoBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPlayeInfoBtn)
	self.GradeBtn:GetComponent("Button").onClick:AddListener(self.DelegateNoviceGradeBtn)
	self.energyItem:GetComponent("Button").onClick:AddListener(self.DelegateOnAddStrengthBtn)
	self.RechargeRebateBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRechargeRebateBtn)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShopBtn)
	self.PushGiftBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPushGiftBtn)
	self.ActivityListBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickActivityListBtn)
	self.WelfareBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickWelfareListBtn)
	self.FirstRechargeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFirstRechargeBtn)
	self.ActiveActivityBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickActiveActivityListBtn)
	self.buttonStorage:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonStorage)
	self.buttonList:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonList)
	self.OpenPhoneBtn:GetComponent("Button").onClick:AddListener(self.delegateOnOpenPhoneBtnClick)
	self.toggleRegular.onValueChanged:AddListener(self.toggleRegularClickDelegate)
	self.buttonMessage:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonMessage)
	EventDispatcher.AddEventListener(EventID.OnMainUIOpenEvent, self.DelegateCheckFuncOpen)
	EventDispatcher.AddEventListener(EventID.GetNoticeResultEvent, self.DelegateOnGetGameNotice)
	EventDispatcher.AddEventListener(EventID.JoystickDirectTransform, self.DelegateUpdateJoystickDirectTransform)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.DelegateOnUnlockFunctionUpdateEvent)
	EventDispatcher.AddEventListener(EventID.OpenMobilePhoneEvent, self.DelegateOpenMobilePhoneEvent)
	EventDispatcher.AddEventListener(EventID.ActivityPassUIActive, self.ActivityPassUIActiveEvent)
	EventDispatcher.AddEventListener(EventID.ActivityUpdateEvent, self.ActivityPassUIActiveEvent)
	EventDispatcher.AddEventListener(EventID.TaskNotifyFinish, self.ActivityPassUIActiveEvent)
	EventDispatcher.AddEventListener(EventID.OnNotifyStage, self.DelegateNotifyUpdateStage)
	EventDispatcher.AddEventListener(EventID.ChangeShowHcid, self.DelegateOnChangeShowHcidSucced)
	EventDispatcher.AddEventListener(EventID.PlayerDataChangeEvent, self.DelegateRefreshPlayerInfoData)
	EventDispatcher.AddEventListener(EventID.PlayerLvChange, self.DelegateOnPlayLvChange)
	EventDispatcher.AddEventListener(EventID.GetRePlayerNameResult, self.Delegation_Response_GetReNameResult)
	EventDispatcher.AddEventListener(EventID.ResetTalentSuccess, self.DelegateResetTalent)
	EventDispatcher.AddEventListener(EventID.ActiveTalentSuccess, self.DelegateResetTalent)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdataItem)
	EventDispatcher.AddEventListener(EventID.MainCitySpecialEvent, self.DelegateMaincitySpecialEvent)
	EventDispatcher.AddEventListener(EventID.NotifyLimitedTimePkg, self.DelegateNotifyLimitedTimePkg)
	EventDispatcher.AddEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyEvent)
	EventDispatcher.AddEventListener(EventID.ReceiveRechargeRebateEvent, self.DelgateOnReceiveRechargeRebateEvent)
	EventDispatcher.AddEventListener(EventID.NotifyPlayerDataChange, self.DelegateOnNotifyPlayerDataChangeEvent)
	EventDispatcher.AddEventListener(EventID.UpdateHomePlayerMoveSpeed, self.__delegateOnUpdateHomePlayerMoveSpeed)
	EventDispatcher.AddEventListener(EventID.SetMainUIScreenMaskActive, self.__delegateSetMainUIScreenMaskActive)
	EventDispatcher.AddEventListener(EventID.ActivityUpdateEvent, self.DelegateOnActivityUpdateEvent)
	EventDispatcher.AddEventListener(EventID.PushGiftUIClosed, self.DelgateOnPushGiftUIClosedEvent)
	EventDispatcher.AddEventListener(EventID.LotteryNotifyDrawPoolUpdate, self.__delegateOnLotteryNotifyDrawPoolUpdate)
	EventDispatcher.AddEventListener(EventID.MainUI_ShowStoryUIEvent, self.showStoryUIEvent)
	EventDispatcher.AddEventListener(EventID.MainUI_HideStoryUIEvent, self.hideStoryUIEvent)
	EventDispatcher.AddEventListener(EventID.MainUI_ShowNpcNameEvent, self.showNpcNameEvent)
	EventDispatcher.AddEventListener(EventID.MainUI_FreeNpcNameEvent, self.freeNpcNameEvent)
	EventDispatcher.AddEventListener(EventID.MainUI_HideNpcNameEvent, self.hideNpcNameEvent)
	EventDispatcher.AddEventListener(EventID.MainUI_ShowDialogEvent, self.showDialogEvent)
	EventUtil.AddEventListener(self, EventID.MainUI_SetShowImagePuzzleState)
	EventUtil.AddEventListener(self, EventID.MainUI_SetHideImagePuzzleState)
	EventUtil.AddEventListener(self, EventID.MainUI_SetRayCastEnabledEvent)
	EventUtil.AddEventListener(self, EventID.MainUI_SetJoyStickViewEnabledEvent)
	EventUtil.AddEventListener(self, EventID.NetFavorResponse_NotifyEntry)
	EventUtil.AddEventListener(self, EventID.MainUI_HideHudPanelEvent)
	EventUtil.AddEventListener(self, EventID.MainUI_ShowHudPanelEvent)
	self.phoneUI:OnAddListeners()
end

function MainUI:OnRemoveListeners()
	self.StartGameBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickStartGameBtn)
	self.GMBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGmBtn)
	self.GMBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGmBtn1)
	self.HeroBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickHeroBtn)
	self.LotteryBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateLotteryBtn)
	self.PassactivityBtn:GetComponent("Button").onClick:RemoveListener(self.DelegatePassBtn)
	self.ActivityBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateActivityBtn)
	self.PlayerInfoBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPlayeInfoBtn)
	self.GradeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateNoviceGradeBtn)
	self.energyItem:GetComponent("Button").onClick:RemoveListener(self.DelegateOnAddStrengthBtn)
	self.RechargeRebateBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRechargeRebateBtn)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShopBtn)
	self.PushGiftBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPushGiftBtn)
	self.ActivityListBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickActivityListBtn)
	self.WelfareBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickWelfareListBtn)
	self.FirstRechargeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFirstRechargeBtn)
	self.ActiveActivityBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickActiveActivityListBtn)
	self.buttonStorage:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonStorage)
	self.buttonList:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonList)
	self.OpenPhoneBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnOpenPhoneBtnClick)
	self.toggleRegular.onValueChanged:RemoveListener(self.toggleRegularClickDelegate)
	self.buttonMessage:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonMessage)
	EventDispatcher.RemoveEventListener(EventID.OnMainUIOpenEvent, self.DelegateCheckFuncOpen)
	EventDispatcher.RemoveEventListener(EventID.GetNoticeResultEvent, self.DelegateOnGetGameNotice)
	EventDispatcher.RemoveEventListener(EventID.JoystickDirectTransform, self.DelegateUpdateJoystickDirectTransform)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.DelegateOnUnlockFunctionUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.OpenMobilePhoneEvent, self.DelegateOpenMobilePhoneEvent)
	EventDispatcher.RemoveEventListener(EventID.ActivityPassUIActive, self.ActivityPassUIActiveEvent)
	EventDispatcher.RemoveEventListener(EventID.ActivityUpdateEvent, self.ActivityPassUIActiveEvent)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyFinish, self.ActivityPassUIActiveEvent)
	EventDispatcher.RemoveEventListener(EventID.OnNotifyStage, self.DelegateNotifyUpdateStage)
	EventDispatcher.RemoveEventListener(EventID.ChangeShowHcid, self.DelegateOnChangeShowHcidSucced)
	EventDispatcher.RemoveEventListener(EventID.PlayerDataChangeEvent, self.DelegateRefreshPlayerInfoData)
	EventDispatcher.RemoveEventListener(EventID.PlayerLvChange, self.DelegateOnPlayLvChange)
	EventDispatcher.RemoveEventListener(EventID.GetRePlayerNameResult, self.Delegation_Response_GetReNameResult)
	EventDispatcher.RemoveEventListener(EventID.ResetTalentSuccess, self.DelegateResetTalent)
	EventDispatcher.RemoveEventListener(EventID.ActiveTalentSuccess, self.DelegateResetTalent)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdataItem)
	EventDispatcher.RemoveEventListener(EventID.MainCitySpecialEvent, self.DelegateMaincitySpecialEvent)
	EventDispatcher.RemoveEventListener(EventID.NotifyLimitedTimePkg, self.DelegateNotifyLimitedTimePkg)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyEvent)
	EventDispatcher.RemoveEventListener(EventID.ReceiveRechargeRebateEvent, self.DelgateOnReceiveRechargeRebateEvent)
	EventDispatcher.RemoveEventListener(EventID.NotifyPlayerDataChange, self.DelegateOnNotifyPlayerDataChangeEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateHomePlayerMoveSpeed, self.__delegateOnUpdateHomePlayerMoveSpeed)
	EventDispatcher.RemoveEventListener(EventID.SetMainUIScreenMaskActive, self.__delegateSetMainUIScreenMaskActive)
	EventDispatcher.RemoveEventListener(EventID.ActivityUpdateEvent, self.DelegateOnActivityUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.PushGiftUIClosed, self.DelgateOnPushGiftUIClosedEvent)
	EventDispatcher.RemoveEventListener(EventID.LotteryNotifyDrawPoolUpdate, self.__delegateOnLotteryNotifyDrawPoolUpdate)
	EventDispatcher.RemoveEventListener(EventID.MainUI_ShowStoryUIEvent, self.showStoryUIEvent)
	EventDispatcher.RemoveEventListener(EventID.MainUI_HideStoryUIEvent, self.hideStoryUIEvent)
	EventDispatcher.RemoveEventListener(EventID.MainUI_ShowNpcNameEvent, self.showNpcNameEvent)
	EventDispatcher.RemoveEventListener(EventID.MainUI_FreeNpcNameEvent, self.freeNpcNameEvent)
	EventDispatcher.RemoveEventListener(EventID.MainUI_HideNpcNameEvent, self.hideNpcNameEvent)
	EventDispatcher.RemoveEventListener(EventID.MainUI_ShowDialogEvent, self.showDialogEvent)
	EventUtil.ClearEventListener(self)
	self.phoneUI:OnRemoveListeners()
end

function MainUI:__OnMainUI_ShowHudPanelEventHandler()
	self.hudPanel:Show()
end

function MainUI:__OnMainUI_HideHudPanelEventHandler()
	self.hudPanel:Hide()
end

function MainUI:__OnNetFavorResponse_NotifyEntryHandler()
	self:RefreshFavorMsgNew()
end

function MainUI:OnClickButtonMessage()
	UIModule.Open(Constant.UIControllerName.AffinityChatUI, Constant.UILayer.UI)
end

function MainUI:__OnMainUI_SetJoyStickViewEnabledEventHandler(enabled)
	self:SetJoyStickUIEnabled(enabled)
end

function MainUI:__OnMainUI_SetRayCastEnabledEventHandler(enabled)
	return
end

function MainUI:__OnMainUI_SetHideImagePuzzleStateHandler()
	LuaUtility.SetStateController(self.gameObject, dataName_model, stateName_hideImagePuzzle)
	LuaUtility.SetStateController(self.StoryPanel, dataName_model, stateName_hideImagePuzzle)
end

function MainUI:__OnMainUI_SetShowImagePuzzleStateHandler()
	LuaUtility.SetStateController(self.gameObject, dataName_model, stateName_showImagePuzzle)
	LuaUtility.SetStateController(self.StoryPanel, dataName_model, stateName_showImagePuzzle)
end

function MainUI:OnToggleRegularClick(isOn)
	LuaUtility.SetGameObjectShow(self.RegularCheckMark, isOn)

	if isOn then
		LuaUtility.SetLvFilterVolumeEnable(true)
		LuaUtility.DoTweenTo_Float(0, 1, LuaUtility.GetBehaviorGlobalFloatVariables(Constant.BehaviorGlobalDefine.RegularFilterDuration), function(v)
			LuaUtility.SetLvFilterVolumeControl(v)

			if v >= 1 then
				self.toggleRegular.interactable = true

				EventDispatcher.Dispatch(EventID.WorldMapRoom_RefreshAllComponentsEvent)
				BehaviorTreeUtility.TriggerRegularShowBehaviorTree()
			end
		end)
	else
		LuaUtility.DoTweenTo_Float(1, 0, LuaUtility.GetBehaviorGlobalFloatVariables(Constant.BehaviorGlobalDefine.RegularFilterDuration), function(v)
			LuaUtility.SetLvFilterVolumeControl(v)

			if v <= 0 then
				LuaUtility.SetLvFilterVolumeEnable(false)

				self.toggleRegular.interactable = true

				EventDispatcher.Dispatch(EventID.WorldMapRoom_RefreshAllComponentsEvent)
				BehaviorTreeUtility.TriggerRegularCloseBehaviorTree()
			end
		end)
		StoryUIApi:CloseLvXiangEffectSound()
	end

	self.toggleRegular.interactable = false
end

function MainUI:GetPreloadAssetPaths()
	return nil
end

function MainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MainUI:OnOpen(userData)
	self:__OnSetMainUIScreenMaskActive(false)
	self:AddRedDotEventListener()
	self.moneyCell:RefreshItem(Constant.TopMoneyType.MainUI)
	self:CheckSpecialPopups()
	self:RefreshRebateBtnState()
	self:RefreshPushGiftBtnState()
	self:SetJoyStick()
	self:OnRefreshUnlockBtn()
	self:RefreshMainLineProcess()
	self:RefreshPlayerInfo()
	self:OpenMobilePhoneEvent(false)
	self:RefreshFavorMsgNew()
	self:__RefreshLotteryRedDot()
	LuaUtility.SetStateController(self.gameObject, dataName_buttonCollection, stateName_rightBottomExpand)

	if userData and userData.loadStory then
		self.isStoryState = true

		self:ShowStoryUI()
	else
		self.isStoryState = false

		self:ShowMainUI()
	end

	self.rpgInfoPanel:Refresh()
	LuaUtility.SetGameObjectShow(self.RegularCheckMark, false)
end

function MainUI:OnClose(userData)
	self:RemoveRedDotEventListener()
	self.phoneUI:OnClose()
end

function MainUI:OnPause()
	return
end

function MainUI:OnResume()
	return
end

function MainUI:OnCover()
	return
end

function MainUI:OnReveal()
	return
end

function MainUI:OnRefocus(userData)
	return
end

function MainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if StoryModule.IsStoring and WorldMapModule.isRegularOn then
		if self.dDirRefreshTime and Time.time - self.dDirRefreshTime > Constant.DirectRefreshDuration then
			self:RefreshStoryRegularDir()

			self.dDirRefreshTime = Time.time
		else
			self:RefreshStoryRegularDir()

			self.dDirRefreshTime = Time.time
		end
	end
end

function MainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MainUI:OnDestroy()
	self.phoneUI:OnDestroy()

	if self.CountdownTimer ~= nil then
		self.CountdownTimer:Stop()

		self.CountdownTimer = nil
	end

	self.moneyCell:Dispose()
	self.JoystickView:Dispose()
	self.storyPanel:OnDestroy()
	self.hudPanel:OnDestroy()
	self.rpgInfoPanel:OnDestroy()
	self.dialogController:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function MainUI:AddRedDotEventListener()
	RedDotModule.Subscribe(Constant.E_RedDotPath.Warlock, self.HeroBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.PassActivity, self.PassactivityBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.MobilePhone_NoviceActivity_TaskTab, self.ActivityBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.MobilePhone_NoviceActivity_LevelRewardTab, self.GradeBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.Shop_FreeItem, self.ShopBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.WelfareList, self.WelfareBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.ActivityList, self.ActivityListBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.FirstRecharge, self.FirstRechargeBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Subscribe(Constant.E_RedDotPath.Home_Mail, self.smallPhone.transform:Find("RedDot").gameObject)
end

function MainUI:RemoveRedDotEventListener()
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Warlock, self.HeroBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.PassActivity, self.PassactivityBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.MobilePhone_NoviceActivity_TaskTab, self.ActivityBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.MobilePhone_NoviceActivity_LevelRewardTab, self.GradeBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Shop_FreeItem, self.ShopBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.WelfareList, self.WelfareBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.ActivityList, self.ActivityListBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.FirstRecharge, self.FirstRechargeBtn.transform:Find("RedDot").gameObject)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Home_Mail, self.smallPhone.transform:Find("RedDot").gameObject)
end

function MainUI:CheckSpecialPopups()
	return
end

function MainUI:OnClickGMBtn()
	UIModule.Open(Constant.UIControllerName.GMOrderUI2, Constant.UILayer.UI)
end

function MainUI:OnClickStartGameBtn()
	UIModule.Open(Constant.UIControllerName.PlayingMethodUI, Constant.UILayer.UI)
end

function MainUI:RefreshMainLineProcess()
	local storyStageCfg = MapModule.GetMainLineNewUnlock()

	if storyStageCfg ~= nil then
		UGUIUtil.SetText(self.MainLineProcessText, storyStageCfg.Name)
	else
		UGUIUtil.SetText(self.MainLineProcessText, "")
	end
end

function MainUI:OnRefreshUnlockBtn()
	local funcList = {}

	funcList[Constant.UnlockType.FUNC_GM_TOOL] = self.GMBtn
	funcList[Constant.UnlockType.FUNC_DRAW] = self.LotteryBtn
	funcList[Constant.UnlockType.FUNC_Daily] = self.MoneyTopRoot

	UnlockFunctionModule.FuncSwitchHandler(funcList)
	self:RefreshBtnVisable()
end

function MainUI:OnClickHeroBtn()
	UIModule.Open(Constant.UIControllerName.WarlockChoosePanel, Constant.UILayer.UI)
end

function MainUI:OnClickShopBtn()
	UIModule.Open(Constant.UIControllerName.ShopUI, Constant.UILayer.UI, {
		enterType = Constant.ShopEnterType.Normal
	})
end

function MainUI:OnClickLotteryBtn()
	UIModule.Open(Constant.UIControllerName.LotteryUI, Constant.UILayer.UI)
end

function MainUI:OnClickPassBtn()
	UIModule.Open(Constant.UIControllerName.ActivityPassUI, Constant.UILayer.UI)
end

function MainUI:OnClickActivityBtn()
	UIModule.Open(Constant.UIControllerName.NoviceTaskUI, Constant.UILayer.UI)
end

function MainUI:OnClickNoviceGradeBtn()
	UIModule.Open(Constant.UIControllerName.NoviceGradeUI, Constant.UILayer.UI)
end

function MainUI:OnClickPlayeInfoBtn()
	UIModule.Open(Constant.UIControllerName.UserInfoUI, Constant.UILayer.UI, {
		UserInfoModule.GetPlayerInfo(),
		true
	})
end

function MainUI:OnAddStrengthBtn()
	UIModule.Open(Constant.UIControllerName.BuyEnergyUI, Constant.UILayer.UI)
end

function MainUI:OpenMobilePhoneEvent(state, userData)
	if state then
		if UnlockFunctionModule.OnClickInterceptor(Constant.UnlockType.FUNC_SmallPhone) then
			return
		end

		self.phoneUI:OnOpen(userData)
	else
		self.phoneUI:OnClose()
	end
end

function MainUI:OnClickRechargeRebateBtn()
	UIModule.Open(Constant.UIControllerName.RechargeRebateUI, Constant.UILayer.UI)
end

function MainUI:OnClickPushGiftBtn()
	UIModule.Open(Constant.UIControllerName.PushShopListUI, Constant.UILayer.UI)
end

function MainUI:OnClickActivityListBtn(teamID)
	UIModule.Open(Constant.UIControllerName.ActivityListUI, Constant.UILayer.UI, {
		teamID = teamID
	})
end

function MainUI:OnClickFirstRechargeBtn()
	UIModule.Open(Constant.UIControllerName.ActivityListUI, Constant.UILayer.UI, {
		teamID = Constant.ActivityListTeamID.Welfare,
		selectViewType = Constant.ActivityListCfgType.FirstRechargeActivityType
	})
end

function MainUI:OnClickActiveActivityListBtn(teamID)
	UIModule.Open(Constant.UIControllerName.ActiveActivityListUI, Constant.UILayer.UI, {
		teamID = teamID
	})
end

function MainUI:NotifyUpdateStage()
	self:RefreshMainLineProcess()
end

function MainUI:ResetTalent()
	self:RefreshEnergy()
end

function MainUI:UpdateItem()
	self:RefreshEnergy()
end

function MainUI:OnNotifyChangeShopItems()
	self:RefreshPushGiftBtnState()
end

function MainUI:SetJoyStick()
	local player = HomeModule.GetPlayer()

	if player == nil then
		self.JoystickView:Close()

		return
	end

	if player.skinEntityGo == nil then
		return
	end

	self.JoystickView:Open()
	self.JoystickView:OnSetTargetTransform(player.skinEntityGo.transform)
	self.JoystickView:OnSetMoveSpeed(HomeLandApi.PlayerMoveSpeed)
end

function MainUI:SetJoyStickUIEnabled(enabled)
	if enabled then
		self.JoystickView:Open()
	else
		self.JoystickView:Close()
	end
end

function MainUI:UpdateJoystickDirectTransform()
	self:SetJoyStick()
end

function MainUI:__OnUpdateHomePlayerMoveSpeed(_speed)
	self.JoystickView:OnSetMoveSpeed(_speed)
end

function MainUI:RefreshBtnVisable()
	LuaUtility.SetGameObjectShow(self.LotteryBtn, UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_DRAW))
	LuaUtility.SetGameObjectShow(self.ShopBtn, UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_STORE))

	local isFinishAll = TaskSystemModule.isFinishAll(Constant.MainTaskType.Novice_7_DAY_TASK)

	LuaUtility.SetGameObjectShow(self.ActivityBtn, ActivityModule.IsOpenByTime(Constant.ActivityID.Novice_7_TASK) and not isFinishAll)

	isFinishAll = TaskSystemModule.isFinishAll(Constant.MainTaskType.Novice_7_DAY_GRADE)

	LuaUtility.SetGameObjectShow(self.GradeBtn, ActivityModule.IsOpenByTime(Constant.ActivityID.NOVICE_7_GRADE) and not isFinishAll)
	self:RefreshActivityPassBtnState()
	self:OnRefreshFirstRechargeBtnState()
	self:RefreshWelfareBtnAndActivityBtnState()
end

function MainUI:RefreshActivityPassBtnState()
	LuaUtility.SetGameObjectShow(self.PassactivityBtn, ActivityPassModule.isOpen and UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_PASS_CARD) and ConditionModule.Check(UnlockFunctionModule.GetFuncSwitchByType(Constant.UnlockType.FUNC_PASS_CARD).Condition))
end

function MainUI:RefreshPushGiftBtnState()
	local isPop, expireCommodityID = PlayerModule.GetPushGiftCommoditysIsPop()

	LuaUtility.SetGameObjectShow(self.PushGiftBtn, not isPop)

	if expireCommodityID ~= nil then
		LuaUtility.SetGameObjectShow(self.pushGiftTimeText, true)
		self:RefreshCountdown(PlayerModule.GetLimitTimeGiftDataByID(expireCommodityID))
	else
		LuaUtility.SetGameObjectShow(self.pushGiftTimeText, false)
	end

	LuaUtility.SetGameObjectShow(self.PushGiftBtn.transform:Find("RedDot").gameObject, RedDotModule.CheckRedDot_PushGift())
end

function MainUI:RefreshCountdown(endTime)
	self:UpdateSurplusTime(endTime)

	if self.CountdownTimer ~= nil then
		self.CountdownTimer:Stop()

		self.CountdownTimer = nil
	end

	if self.CountdownTimer == nil then
		self.CountdownTimer = Timer.New(function()
			self:UpdateSurplusTime(endTime)
		end, 1, -1)

		self.CountdownTimer:Start()
	end
end

function MainUI:UpdateSurplusTime(endTime)
	local surplusTime = tonumber(endTime) - math.floor(tonumber(PlayerModule.GetServerTime()))

	if surplusTime <= 0 then
		surplusTime = 0
	end

	UGUIUtil.SetText(self.pushGiftTimeText, DateTimeFormat(surplusTime, BuyEnergyUIApi:GetTimeFormat(surplusTime)))
end

function MainUI:RefreshRebateBtnState()
	LuaUtility.SetGameObjectShow(self.RechargeRebateBtn, PlayerModule.PlayerInfo.baseInfo.rebate ~= nil and tonumber(PlayerModule.PlayerInfo.baseInfo.rebate.id) ~= 0)
end

function MainUI:RefreshWelfareBtnAndActivityBtnState()
	local activityTabList = ActivityListModule.GetActivityListByTeamID(Constant.ActivityListTeamID.Activity)

	LuaUtility.SetGameObjectShow(self.ActivityListBtn, table.len(activityTabList) > 0)

	activityTabList = ActivityListModule.GetActivityListByTeamID(Constant.ActivityListTeamID.Welfare)

	LuaUtility.SetGameObjectShow(self.WelfareBtn, table.len(activityTabList) > 0)
end

function MainUI:OnRefreshFirstRechargeBtnState()
	LuaUtility.SetGameObjectShow(self.FirstRechargeBtn, not ShopModule.GetFirstRechargeTaskIsFinish())
end

function MainUI:OnTaskNotifyEvent()
	self:OnRefreshFirstRechargeBtnState()
end

function MainUI:OnNotifyPlayerDataChangeEvent()
	self:LoadPlayerHeadImg()
end

function MainUI:OnActivityUpdateEvent()
	self:RefreshWelfareBtnAndActivityBtnState()
end

function MainUI:OnPushGiftUIClosedEvent()
	self:RefreshPushGiftBtnState()
end

function MainUI:RefreshPlayerInfo()
	self:LoadPlayerHeadImg()
	self:LoadPlayerName()
	self:LoadPlayerLv()
	self:RefreshEnergy()
end

function MainUI:LoadPlayerHeadImg()
	local path = SkinModule.GetHeroCurrentSkinImgPath(PlayerModule.PlayerInfo.baseInfo.showHeroCid, Constant.SkinImageType.HeroResourcesHead)

	AssetUtil.LoadImage(self, path, self.playerHeadImg:GetComponent("Image"))
end

function MainUI:LoadPlayerName()
	UGUIUtil.SetText(self.playerNameText, PlayerModule.PlayerInfo.baseInfo.pName)
end

function MainUI:LoadPlayerLv()
	UGUIUtil.SetText(self.playerLevelText, PlayerModule.PlayerInfo.baseInfo.pLv)
	self:RefreshActivityPassBtnState()
end

function MainUI:RefreshEnergy()
	UGUIUtil.SetText(self.presentNumText, WarehouseModule.GetPlayerStrengthNum())
	UGUIUtil.SetText(self.maxNumText, PlayerModule.GetPlayerEnergy())
end

function MainUI:__OnSetMainUIScreenMaskActive(active)
	self.screenMask.gameObject:SetActive(active)
end

function MainUI:__RefreshLotteryRedDot()
	local hasFreeDraw = LotteryModule.CheckHasFreeDraw()

	self.LotteryBtn.transform:Find("RedDot").gameObject:SetActive(hasFreeDraw)
end

function MainUI:RefreshStoryRegularDir()
	local player = StoryModule.player

	if not player then
		return
	end

	local effectArray = StoryModule.GetEffectArrayByEffectId(90033)

	if not effectArray or #effectArray == 0 then
		return
	end

	local left, right
	local len = #effectArray

	for i = 1, len do
		if effectArray[i] then
			local storyNpc = StoryModule.GetCharacterByNPCID(effectArray[i].npcId)

			if storyNpc then
				local viewPortPoint = UnityEngine.Camera.main:WorldToViewportPoint(storyNpc.transform.position)
				local isInXRange = viewPortPoint.x >= 0 and viewPortPoint.x <= 1
				local playerPosX = player.transform.position.x
				local targetX = storyNpc.transform.position.x
				local isLeft = targetX < playerPosX

				if not isInXRange then
					left = isLeft
					right = not isLeft
				end
			end
		end
	end

	EventDispatcher.Dispatch(EventID.MainUI_SetHudRegularDirShowEvent, 1, left and true or false)
	EventDispatcher.Dispatch(EventID.MainUI_SetHudRegularDirShowEvent, 2, right and true or false)
end

function MainUI:RefreshFavorMsgNew()
	LuaUtility.SetGameObjectShow(self.newsImg, AffinityModule.GetAffinityHaveNew())
end

function MainUI:ShowStoryUI()
	LuaUtility.SetGameObjectShow(self.StoryRoot, true)
	self.storyPanel:Show()
	self.storyPanel:OnOpen()
	LuaUtility.SetStateController(self.gameObject, dataName_model, stateName_story)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.MoneyTopRoot, false)
end

function MainUI:ShowMainUI()
	self.storyPanel:Hide()
	LuaUtility.SetStateController(self.gameObject, dataName_model, stateName_mainUI)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.MoneyTopRoot, true)
end

function MainUI:HideStoryUI()
	self.storyPanel:Hide()
	LuaUtility.SetStateController(self.gameObject, dataName_model, stateName_mainUI)
end

return MainUI
