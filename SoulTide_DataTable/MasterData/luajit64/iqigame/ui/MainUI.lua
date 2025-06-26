-- chunkname: @IQIGame\\UI\\MainUI.lua

local MainUI = {
	cloudAnimStartTime = 0,
	haveOathBg = false,
	activeInHierarchy = true,
	ChangePageEffectPlayId = 0,
	showBGType = 1,
	isActivation = false,
	showUI = true,
	lastGetGuidRedTime = 0,
	haveSpineBg = false,
	spineBGPathTab = {}
}

MainUI = Base:Extend("MainUI", "IQIGame.Onigao.UI.MainUI", MainUI)

local MainScrollActiveView = require("IQIGame.UI.Main.MainScrollActiveView")
local MainTownView = require("IQIGame.UI.Main.MainTownView")
local PurchaseTipView = require("IQIGame.UI.Main.PurchaseTipView")
local ChatBar = require("IQIGame.UI.Chat.ChatBar")
local SoulSpineCell = require("IQIGame.UI.Common.SoulSpineCell")
local MainBtnChangeView = require("IQIGame.UI.Main.MainBtnChangeView")
local MainOathAvBGView = require("IQIGame.UI.Main.MainOathAvBGView")
local StorageBoxView = require("IQIGame.UI.Main.StorageBoxView")
local MainUIWhisperDLController = require("IQIGame.UI.Main.MainUIWhisperDLController")
local Live2DHarmoniousMask = require("IQIGame.UI.Common.Live2DHarmoniousMask")

require("IQIGame.UIExternalApi.GrowthFundUIApi")

function MainUI:OnInit()
	self.l2dBuilder = self.goLive2D:GetComponent("L2DBuilderMainCity")
	self.live2DHarmoniousMask = Live2DHarmoniousMask.New(self.goLive2D)
	self.scrollActiveView = MainScrollActiveView.__New(self.Active)
	self.mainTownView = MainTownView.__New(self.TownPanel, self)
	self.purchaseTipView = PurchaseTipView.New(self.PurchaseTipView)
	self.chatBar = ChatBar.New(self.goChatBar)
	self.cvFrame = CvUIFrame.New(self.goCvFrame.transform:GetChild(0).gameObject, Constant.UIControllerName.MainUI)
	self.spineCell = SoulSpineCell.New(self.goSpineCell)
	self.mainBtnChangeView = MainBtnChangeView.New(self.BtnChange, self)
	self.mainOathAvBGView = MainOathAvBGView.New(self.OathAvBg)
	self.storageBoxView = StorageBoxView.New(self.StorageView, self)

	self:InitDelegates()
	self:InitBtns()

	self.moneyCell = MoneyCellsBuilder.New(self.CurrencyContainer)
	self.energyCell = EnergyCell.New(self.EnergyCom.transform:GetChild(0).gameObject)

	UGUIUtil.SetText(self.TextTown, MainUIApi:GetString("TextTown"))
	UGUIUtil.SetText(self.TextMainCity, MainUIApi:GetString("TextMainCity"))
	UGUIUtil.SetText(self.TextMazeTitle, MainUIApi:GetString("TextMazeTitle"))

	self.WhisperDLController = MainUIWhisperDLController.New(self.DownloadWhisperResBtn)
end

function MainUI:InitSpineBG()
	self.spineBGPathTab = {}

	for i, v in pairsCfg(CfgRandomSecretaryTable) do
		if v.SecretaryType == Constant.GirlOnDutyShowType.ShowType_Spine then
			local cfgDress = CfgDressTable[v.Dress]
			local path = UIGlobalApi.GetElementPrefab(CfgSoulResTable[cfgDress.SoulResID].BgPrefabs)

			self.spineBGPathTab[cfgDress.SoulResID] = path
		end
	end
end

function MainUI:InitDelegates()
	function self.dgtOnShowMainL2D(soulCid)
		self:OnShowL2D(soulCid)
	end

	function self.delegateSettingChangeEvent()
		self:OnSettingChange()
	end

	function self.delegatePlayerInfoChanged()
		self:OnPlayerInfoChange()
	end

	function self.dgtOnDressWearSuccess(dressCid)
		self:OnDressWearSuccess(dressCid)
	end

	function self.dgtOnNewMailCountChange()
		self:OnNewMailCountChange()
	end

	function self.DelegateOnUpdateTask(cid)
		self:OnUpdateTask(cid)
	end

	function self.delegateUpdateDailySupply()
		self:UpdateDailySupply()
	end

	function self.delegateUpdateTurnEvent()
		self:OnUpdateTurnEvent()
	end

	function self.DelegateOnUnlockNotify()
		self:OnClickUnlockNotify()
	end

	function self.DelegateOnRefreshMainUIUnlockBtn()
		self:OnRefreshMainUIUnlockBtn()
	end

	function self.DelegateOnUpdateItem()
		self:OnUpdateItem()
	end

	function self.DelegateOnSoulDataChange()
		self:OnSoulDataChange()
	end

	function self.DelegateOnLotteryResult(baseShowItems, showItems, lotteryShowCid, lotteryCid)
		self:OnLotteryResult(baseShowItems, showItems, lotteryShowCid, lotteryCid)
	end

	function self.DelegateOnServerRedPoint(type, server)
		self:OnRedPoint(type, server)
	end

	function self.DelegateOnFinishedAchievement()
		self:OnFinishedAchievement()
	end

	function self.delegateOnUnlockEffectEnd(functionTypeId)
		self:OnEffectEnd(functionTypeId)
	end

	function self.onResumeL2dDelegate()
		self:OnResumeL2D()
	end

	function self.delegateOnShowLevel2D(top)
		self:OnShowLevel2D(top)
	end

	function self.delegateTaskCommitResponse(cids, awards)
		self:OnTaskCommitResponse(cids, awards)
	end

	function self.delegateBattlePassUpdate()
		self:OnBattlePassUpdate()
	end

	function self.delegateOnL2DLoadSuccess()
		self:OnL2DLoadSuccess()
	end

	function self.delegateOperationsEvent()
		self:OnOperationsEvent()
	end

	function self.delegateToggleChange(isOn)
		self:OnToggleChange(isOn)
	end

	function self.delegateChangeTownView(isTown)
		self.toggleTown.isOn = isTown
	end

	function self.delegateUpdateGetReward(data)
		self:OnGetReward(data)
	end

	function self.delegateUpdateMall()
		self:OnUpdateMall()
	end

	function self.delegateUpdateWoldBossRedPoint()
		self:OnUpdateWoldBossRedPoint()
	end

	function self.delegateUpdateMagicWaxMuseumRedPoint()
		self:OnUpdateMagicWaxMuseumRedPoint()
	end

	function self.delegateUpdateDoubleFightRedPoint()
		self:OnUpdateDoubleFightRedPoint()
	end

	function self.delegateUpdateLuckyTurnRedPoint()
		self:OnUpdateLuckyTurnRedPoint()
	end

	function self.DelegateOnUpdateDailyDupEvent()
		self:OnUpdateDailyDupEvent()
	end

	function self.delegateBtnHide()
		self:OnBtnHide()
	end

	function self.delegateBtnShow()
		self:OnBtnShow()
	end

	function self.DelegateOnClickSpeTestBtn()
		self:OnClickSpeTestBtn()
	end

	function self.DelegateUpdateRefundsGiftPackEvent()
		self:OnUpdateRebatePackage()
	end

	function self.DelegateUpdateGirlOnDutyEvent(soulCid)
		self:OnUpdateGirlOnDutyEvent(soulCid)
	end

	function self.DelegateUpdateGuildRedPoint()
		self:OnUpdateGuildRedPoint()
	end

	function self.DelegateOnDLResComplete(tag, isRepair, isAllComplete)
		self:OnDLResComplete(tag, isRepair, isAllComplete)
	end

	function self.DelegateNotifyStartSellTime()
		self:OnNotifyStartSellTime()
	end

	function self.DelegateL2DPause()
		self:PauseL2D()
	end

	function self.DelegateOnUpdateMaze()
		self:UpDateMaxMazeChapter()
	end
end

function MainUI:InitBtns()
	local btnNames = {
		"SoulInfoBtn",
		"BagBtn",
		"ShopBtn",
		"TaskBtn",
		"EquipBtn",
		"SettingBtn",
		"ActiveTaskBtn",
		"LibraryBtn",
		"WorldMazeBtn",
		"WishBtn",
		"HomeBtn",
		"MailBtn",
		"GirlBtn",
		"FormationBtn",
		"FirstRechargeBtn",
		"PassBtn",
		"ExpBonusBtn",
		"LunaBtLineBtn",
		"StorageBoxBtn",
		"GrowthFundBtn",
		"RebatePackageBtn",
		"GuildBtn",
		"CelebrationGiftBoxBtn"
	}

	self.handlers = {}
	self.RedPoints = {}

	for k, v in ipairs(btnNames) do
		local func = self["OnClick" .. v]

		self.handlers[v] = function(...)
			func(self, ...)
		end

		local redPointTrans = self[v].transform:Find("Image_RedPoint")

		if redPointTrans ~= nil then
			self.RedPoints[v] = redPointTrans.gameObject

			self.RedPoints[v]:SetActive(false)
		end

		for i = 0, self[v].transform.childCount - 1 do
			local child = self[v].transform:GetChild(i)

			if string.find(child.name, "Text_1") then
				child:GetComponent("Text").text = MainUIApi:GetString(v .. "Text", 1)
			end

			if string.find(child.name, "Text_2") then
				child:GetComponent("Text").text = MainUIApi:GetString(v .. "Text", 2)

				break
			end
		end
	end

	self.toggleTown = self.ToggleTown:GetComponent("Toggle")
end

function MainUI:GetPreloadAssetPaths()
	return nil
end

function MainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MainUI:OnOpen(userData)
	UIModule.BugFixL2dUIList[self.name] = self

	self:InitSpineBG()

	self.activeInHierarchy = true

	local uiEdgeCoverComponent = UnityEngine.GameObject.Find("UIEdgeCover"):GetComponent("UIEdgeCoverComponent")

	if uiEdgeCoverComponent.basedOnWidth then
		local orthographicSize = MainUIApi:GetString("MainCityOrthographicSize")
		local uiAspect = uiEdgeCoverComponent.limitedCanvasSize.x / uiEdgeCoverComponent.limitedCanvasSize.y

		UnityEngine.Camera.main.orthographicSize = orthographicSize * uiAspect / UnityEngine.Camera.main.aspect
	end

	self:RefreshL2D()
	self:RefreshUnlockBtn()
	self:OnUpdatePlayerLevel()
	self.moneyCell:RefreshView({
		Constant.ItemID.MONEY,
		Constant.ItemID.TREASURE,
		Constant.ItemID.ID_PAYPOINT_SHOW
	})
	self:LoadHeadIcon()
	self:LoadHeadFrame()
	self:LoadTitle()
	self:OnPlayerInfoChange()
	self:OnUpdateSoulRedPoint()
	self:OnUpdateMallRedPoint()
	self:OnUpdateEquipRedPoint()
	self:OnUpdateActivityRedPoint()
	self:OnUpdateFirstRechargeRedPoint()
	self:OnUpdateTask()
	self:OnUpdateBagRedPoint()
	self:OnUpdateLibraryRedPoint()
	self:OnUpdatePoint()
	self:OnUpdateRebatePackageRedPoint()
	self:OnBattlePassUpdate()
	NoticeModule.CheckNeedShowQueueTip()
	self.chatBar:Refresh()
	self:OnUpdateLotteryRedPoint()
	self:CheckMaze()
	self:OnUpdateDailyDupEvent()
	self:RefreshSoulPortraitOrBg()
	ActiveModule.GetLvReachRewardList()
	self.storageBoxView:Refresh()
	self.SpeTestBtn.transform.parent.gameObject:SetActive(GmListModule.IsSpeTestFunctionEnabled())

	if PlayerModule.PlayerInfo.guildId ~= 0 then
		GuildModule.RefreshRedPoint()
	else
		self:OnUpdateGuildRedPoint(false)
	end
end

function MainUI:OnClose(userData)
	UIModule.BugFixL2dUIList[self.name] = nil

	if self.changeTimer then
		self.changeTimer:Stop()
	end

	self.changeTimer = nil
	self.cloudAnimStartTime = Time.time

	if self.MoveL2DTween ~= nil then
		self.MoveL2DTween:Stop(TweenStopBehavior.DoNotModify)

		self.MoveL2DTween = nil
	end

	self.scrollActiveView:Close()
	self.mainTownView:Close()
	self.cvFrame:Dispose()
	self.purchaseTipView:Close()
	self.chatBar:OnHide()
	self.spineCell:Close()
	self:StopChangePageEffect()
	self:StopL2DDelay()
	self.mainBtnChangeView:Close()
	self.mainOathAvBGView:Close()
	self.storageBoxView:Close()

	self.showBGType = 0
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
	self.mainTownView:OnUpdate(elapseSeconds, realElapseSeconds)
	self.storageBoxView:OnUpdate(elapseSeconds, realElapseSeconds)

	if self.spineCell ~= nil then
		self.spineCell:OnUpdate()
	end

	if self.startDelayTime then
		self.delayDuration = self.delayDuration + elapseSeconds

		if self.delayDuration >= 5 then
			self:StopL2DDelay()
		end
	end

	if self.UIController:GetComponent("Canvas").enabled then
		if self.activeInHierarchy == false then
			self.activeInHierarchy = true

			EventDispatcher.Dispatch(EventID.RestoreMainCityCV)
		end
	elseif self.activeInHierarchy then
		self.activeInHierarchy = false

		EventDispatcher.Dispatch(EventID.StopMainCityCV)
	end

	local now = PlayerModule.GetServerTime()

	if now - self.lastGetGuidRedTime > 60 then
		self.lastGetGuidRedTime = now

		if PlayerModule.PlayerInfo.guildId ~= 0 then
			GuildModule.RefreshRedPoint()
		else
			self:OnUpdateGuildRedPoint(false)
		end
	end
end

function MainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MainUI:OnLoadSucceed(assetName, asset, duration, userData)
	local type = userData.type

	if type == "loadTitle" then
		for i = 0, self.TitlePos.transform.childCount - 1 do
			local obj = self.TitlePos.transform:GetChild(i).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		local goTitle = UnityEngine.Object.Instantiate(asset)

		goTitle.transform:SetParent(self.TitlePos.transform, false)
	elseif type == "loadHeadFrame" then
		for i = 0, self.HeadFrame.transform.childCount - 1 do
			local obj = self.HeadFrame.transform:GetChild(i).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		local goFrame = UnityEngine.Object.Instantiate(asset)

		goFrame.transform:SetParent(self.HeadFrame.transform, false)
		setIsRayCastTarget(goFrame, false, true)
		UIUtil.InitSortedComponents(self.HeadFrame:GetComponentInParent(typeof(UnityEngine.Canvas)), goFrame)
	elseif type == "loadSpineBG" then
		self:LoadSpineBG(asset)
	end
end

function MainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MainUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.moneyCell:Dispose()

	self.moneyCell = nil

	self.energyCell:Dispose()

	self.energyCell = nil

	self.scrollActiveView:Dispose()

	self.scrollActiveView = nil

	self.cvFrame:OnDestroy()
	self.mainTownView:Dispose()

	self.mainTownView = nil

	self.purchaseTipView:Dispose()

	self.purchaseTipView = nil

	self.chatBar:OnDestroy()
	self.spineCell:OnDestroy()
	self.mainBtnChangeView:Dispose()
	self.mainOathAvBGView:Dispose()
	self.storageBoxView:Dispose()
	self.WhisperDLController:Dispose()
	self.live2DHarmoniousMask:Dispose()
end

function MainUI:OnAddListeners()
	for k, v in pairs(self.handlers) do
		local button = self[k]:GetComponent("Button")

		if button == nil then
			logError("Can not find button named : " .. k)
		end

		button.onClick:AddListener(v)
	end

	self.WhisperDLController:AddListeners()
	self.toggleTown.onValueChanged:AddListener(self.delegateToggleChange)
	self.BtnHide:GetComponent("Button").onClick:AddListener(self.delegateBtnHide)
	self.BtnShow:GetComponent("Button").onClick:AddListener(self.delegateBtnShow)
	self.SpeTestBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSpeTestBtn)
	EventDispatcher.AddEventListener(EventID.SoulSelected, self.dgtOnShowMainL2D)
	EventDispatcher.AddEventListener(EventID.DressWearSuccess, self.dgtOnDressWearSuccess)
	EventDispatcher.AddEventListener(EventID.NewMailCountChangeEvent, self.dgtOnNewMailCountChange)
	EventDispatcher.AddEventListener(EventID.PlayerSettingChangeEvent, self.delegateSettingChangeEvent)
	EventDispatcher.AddEventListener(EventID.PlayerInfoChanged, self.delegatePlayerInfoChanged)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnUpdateTask)
	EventDispatcher.AddEventListener(EventID.UpdateDailySupply, self.delegateUpdateDailySupply)
	EventDispatcher.AddEventListener(EventID.TurnResultEvent, self.delegateUpdateTurnEvent)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.DelegateOnUnlockNotify)
	EventDispatcher.AddEventListener(EventID.RefreshMainUIUnlockBtn, self.DelegateOnRefreshMainUIUnlockBtn)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
	EventDispatcher.AddEventListener(EventID.SoulDataChange, self.DelegateOnSoulDataChange)
	EventDispatcher.AddEventListener(EventID.LotteryResult, self.DelegateOnLotteryResult)
	EventDispatcher.AddEventListener(EventID.RedServerNotice, self.DelegateOnServerRedPoint)
	EventDispatcher.AddEventListener(EventID.FinishedAchievement, self.DelegateOnFinishedAchievement)
	EventDispatcher.AddEventListener(EventID.UnlockFunEffectEnd, self.delegateOnUnlockEffectEnd)
	EventDispatcher.AddEventListener(EventID.GuideIsShowLevel2D, self.delegateOnShowLevel2D)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.delegateTaskCommitResponse)
	EventDispatcher.AddEventListener(EventID.L2DResume, self.onResumeL2dDelegate)
	EventDispatcher.AddEventListener(EventID.ChangeTownViewEvent, self.delegateChangeTownView)
	EventDispatcher.AddEventListener(EventID.BattlePassUpdate, self.delegateBattlePassUpdate)
	EventDispatcher.AddEventListener(EventID.UpdateLibraryNewsEvent, self.delegateUpdateGetReward)
	EventDispatcher.AddEventListener(EventID.UpdateMall, self.delegateUpdateMall)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateOperationsEvent)
	EventDispatcher.AddEventListener(EventID.UpdateWoldBossRedPoint, self.delegateUpdateWoldBossRedPoint)
	EventDispatcher.AddEventListener(EventID.UpdateMagicWaxMuseumRedPoint, self.delegateUpdateMagicWaxMuseumRedPoint)
	EventDispatcher.AddEventListener(EventID.UpdateDoubleFightRedPoint, self.delegateUpdateDoubleFightRedPoint)
	EventDispatcher.AddEventListener(EventID.UpdateLuckyTurnRedPoint, self.delegateUpdateLuckyTurnRedPoint)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateOnUpdateDailyDupEvent)
	EventDispatcher.AddEventListener(EventID.UpdateRefundsGiftPackEvent, self.DelegateUpdateRefundsGiftPackEvent)
	EventDispatcher.AddEventListener(EventID.UpdateGirlOnDutyEvent, self.DelegateUpdateGirlOnDutyEvent)
	EventDispatcher.AddEventListener(EventID.GuildUpdateMainCityRedPointEvent, self.DelegateUpdateGuildRedPoint)
	EventDispatcher.AddEventListener(EventID.DownloadResByTagComplete, self.DelegateOnDLResComplete)
	EventDispatcher.AddEventListener(EventID.NotifyStartSellTime, self.DelegateNotifyStartSellTime)
	EventDispatcher.AddEventListener(EventID.L2DPause, self.DelegateL2DPause)
	EventDispatcher.AddEventListener(EventID.UpdateMaze, self.DelegateOnUpdateMaze)
	GameEntry.LuaEvent:Subscribe(LoadL2DSuccessEventArgs.EventId, self.delegateOnL2DLoadSuccess)
end

function MainUI:OnRemoveListeners()
	for k, v in pairs(self.handlers) do
		self[k]:GetComponent("Button").onClick:RemoveListener(v)
	end

	self.WhisperDLController:RemoveListeners()
	self.toggleTown.onValueChanged:RemoveListener(self.delegateToggleChange)
	self.BtnHide:GetComponent("Button").onClick:RemoveListener(self.delegateBtnHide)
	self.BtnShow:GetComponent("Button").onClick:RemoveListener(self.delegateBtnShow)
	self.SpeTestBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSpeTestBtn)
	EventDispatcher.RemoveEventListener(EventID.SoulSelected, self.dgtOnShowMainL2D)
	EventDispatcher.RemoveEventListener(EventID.DressWearSuccess, self.dgtOnDressWearSuccess)
	EventDispatcher.RemoveEventListener(EventID.NewMailCountChangeEvent, self.dgtOnNewMailCountChange)
	EventDispatcher.RemoveEventListener(EventID.PlayerSettingChangeEvent, self.delegateSettingChangeEvent)
	EventDispatcher.RemoveEventListener(EventID.PlayerInfoChanged, self.delegatePlayerInfoChanged)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnUpdateTask)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailySupply, self.delegateUpdateDailySupply)
	EventDispatcher.RemoveEventListener(EventID.TurnResultEvent, self.delegateUpdateTurnEvent)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.DelegateOnUnlockNotify)
	EventDispatcher.RemoveEventListener(EventID.RefreshMainUIUnlockBtn, self.DelegateOnRefreshMainUIUnlockBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.SoulDataChange, self.DelegateOnSoulDataChange)
	EventDispatcher.RemoveEventListener(EventID.LotteryResult, self.DelegateOnLotteryResult)
	EventDispatcher.RemoveEventListener(EventID.RedServerNotice, self.DelegateOnServerRedPoint)
	EventDispatcher.RemoveEventListener(EventID.FinishedAchievement, self.DelegateOnFinishedAchievement)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunEffectEnd, self.delegateOnUnlockEffectEnd)
	EventDispatcher.RemoveEventListener(EventID.GuideIsShowLevel2D, self.delegateOnShowLevel2D)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.delegateTaskCommitResponse)
	EventDispatcher.RemoveEventListener(EventID.L2DResume, self.onResumeL2dDelegate)
	EventDispatcher.RemoveEventListener(EventID.ChangeTownViewEvent, self.delegateChangeTownView)
	EventDispatcher.RemoveEventListener(EventID.BattlePassUpdate, self.delegateBattlePassUpdate)
	EventDispatcher.RemoveEventListener(EventID.UpdateLibraryNewsEvent, self.delegateUpdateGetReward)
	EventDispatcher.RemoveEventListener(EventID.UpdateMall, self.delegateUpdateMall)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateOperationsEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateWoldBossRedPoint, self.delegateUpdateWoldBossRedPoint)
	EventDispatcher.RemoveEventListener(EventID.UpdateMagicWaxMuseumRedPoint, self.delegateUpdateMagicWaxMuseumRedPoint)
	EventDispatcher.RemoveEventListener(EventID.UpdateDoubleFightRedPoint, self.delegateUpdateDoubleFightRedPoint)
	EventDispatcher.RemoveEventListener(EventID.UpdateLuckyTurnRedPoint, self.delegateUpdateLuckyTurnRedPoint)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateOnUpdateDailyDupEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateRefundsGiftPackEvent, self.DelegateUpdateRefundsGiftPackEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateGirlOnDutyEvent, self.DelegateUpdateGirlOnDutyEvent)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateMainCityRedPointEvent, self.DelegateUpdateGuildRedPoint)
	EventDispatcher.RemoveEventListener(EventID.DownloadResByTagComplete, self.DelegateOnDLResComplete)
	EventDispatcher.RemoveEventListener(EventID.NotifyStartSellTime, self.DelegateNotifyStartSellTime)
	EventDispatcher.RemoveEventListener(EventID.L2DPause, self.DelegateL2DPause)
	EventDispatcher.RemoveEventListener(EventID.UpdateMaze, self.DelegateOnUpdateMaze)
	GameEntry.LuaEvent:Unsubscribe(LoadL2DSuccessEventArgs.EventId, self.delegateOnL2DLoadSuccess)
end

function MainUI:RefreshSoulPortraitOrBg()
	local prefabSpineBG = PlayerPrefsUtil.GetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.MainCity_Spine_BG)

	self.showBGType = prefabSpineBG == 0 and 1 or prefabSpineBG

	if SoulModule.curSoulData:GetCfgSoulRes2D().UISpineId > 0 then
		self.haveSpineBg = true
	else
		self.haveSpineBg = false
	end

	log("检测有没有spine背景 " .. tostring(self.haveSpineBg))

	self.haveOathBg = false
	self.isActivation = SoulModule.curSoulData.oathActivation

	if self.isActivation then
		local cfgSoulMarry = GirlModule.GetSoulOathData(SoulModule.curSoulData.soulCid)

		if cfgSoulMarry then
			self.haveOathBg = cfgSoulMarry.IsNewWhisper
		end
	end

	if self.toggleTown.isOn ~= TownModule.inTown then
		self.toggleTown.isOn = TownModule.inTown
	else
		self:ChangeSceneUI()
	end

	if self.showBGType == 2 and self.haveSpineBg then
		self:StartL2DDelay()
	else
		self.startDelayTime = false
	end
end

function MainUI:OnL2DLoadSuccess()
	GameEntry.Timer:AddDelayCall(1, function()
		self:CheckL2dNotify()
	end)
end

function MainUI:OnSettingChange()
	self.NameText:GetComponent("Text").text = MainUIApi:GetString("NameText", PlayerModule.PlayerInfo.baseInfo.pName)

	self:LoadHeadIcon()
	self:LoadHeadFrame()
	self:LoadTitle()
end

function MainUI:LoadTitle()
	for i = 0, self.TitlePos.transform.childCount - 1 do
		local obj = self.TitlePos.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	local title = PlayerModule.PlayerInfo.baseInfo.title

	if title ~= nil and title > 0 then
		local playerTitleData = SettingModule.GetPlayerTitleData(title)

		if playerTitleData then
			local path = UIGlobalApi.GetPrefabRoot(playerTitleData.cfgInfo.Prefab)

			AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil, {
				type = "loadTitle"
			})
		end
	end
end

function MainUI:LoadHeadFrame()
	local playerHeadFrameData = SettingModule.GetPlayHeadFrameData(PlayerModule.PlayerInfo.baseInfo.avatarFrame)

	if playerHeadFrameData then
		local path = UIGlobalApi.GetPrefabRoot(playerHeadFrameData.cfgInfo.Prefab)

		AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil, {
			type = "loadHeadFrame"
		})
	end
end

function MainUI:LoadHeadIcon()
	local playerHeadData = SettingModule.GetPlayHeadData(PlayerModule.PlayerInfo.baseInfo.headIcon)
	local iconPath = UIGlobalApi.IconPath .. playerHeadData.cfgInfo.Url

	AssetUtil.LoadImage(self, iconPath, self.SettingBtn:GetComponent("Image"))
end

function MainUI:OnBattlePassUpdate()
	self.PassBtn:SetActive(PassCheckModule.CheckPassIsOpen())
	self:ShowRedPoint("PassBtn", PassCheckModule.CheckExistRewardCanGet())
end

function MainUI:OnFinishedAchievement()
	NoticeModule.CheckNeedShowQueueTip()
end

function MainUI:OnShowL2D(soulCid)
	self:RefreshL2D()
end

function MainUI:OnDressWearSuccess(dressCid)
	self:RefreshL2D()
end

function MainUI:OnNewMailCountChange()
	local isNewMail = MailModule.newMailCount > 0

	self:ShowRedPoint("MailBtn", isNewMail)
end

function MainUI:RefreshL2D()
	local soulData = SoulModule.curSoulData

	if soulData ~= nil then
		local guideCfg = GuideModule.PredictGuide(Constant.GuideTriggerType.SceneTrigger, SceneID.MainCity)

		if guideCfg ~= nil then
			self.l2dBuilder.defaultHide = guideCfg.HideL2D
		else
			self.l2dBuilder.defaultHide = false
		end

		self.l2dBuilder.onShowCvUI = self.cvFrame.dgtOnShowCVUI
		self.l2dBuilder.onHideCvUI = self.cvFrame.dgtOnHideCVUI

		local cfgSoulResRow = soulData:GetCfgSoulRes2D()

		SoulModule.BuildL2D(self.l2dBuilder, soulData, soulData:GetCfgDress2D())
		self:SetL2DModelProperty(cfgSoulResRow)
		self.cvFrame:RefreshView(Vector3.New(cfgSoulResRow.GirlDialoguePosition[1], cfgSoulResRow.GirlDialoguePosition[2], cfgSoulResRow.GirlDialoguePosition[3]))
	end

	self.goLive2D.transform.anchoredPosition3D = Vector3.zero
end

function MainUI:StartL2DDelay()
	self.startDelayTime = true
	self.delayDuration = 0

	GameEntry.Sound:SetGroupVolume(Constant.SoundGroup.LIVE2D, 0)
end

function MainUI:StopL2DDelay()
	self.startDelayTime = false

	GameEntry.Sound:SetGroupVolume(Constant.SoundGroup.LIVE2D, SettingModule.currentCvVolume)
end

function MainUI:PauseL2D()
	self.l2dBuilder:PauseL2D()
	GameEntry.Sound:SetGroupVolume(Constant.SoundGroup.LIVE2D, 0)
end

function MainUI:ResumeL2D()
	self.l2dBuilder:ResumeL2D()
	GameEntry.Sound:SetGroupVolume(Constant.SoundGroup.LIVE2D, SettingModule.currentCvVolume)
end

function MainUI:SetL2DModelProperty(cfgSoulResRow)
	self.l2dBuilder:SetModelPositionInImage(cfgSoulResRow.Live2DModelPosition[1], cfgSoulResRow.Live2DModelPosition[2], cfgSoulResRow.Live2DModelPosition[3])
end

function MainUI:RefreshExpBonusBtnVisible()
	local result = PlayerModule.PlayerInfo.baseInfo.pLv < CfgDiscreteDataTable[6520062].Data[1]

	self.ExpBonusBtn:SetActive(result)
end

function MainUI:RefreshCelebrationGiftBtnVisible()
	local result = CelebrationGiftModule.IsOpen()

	self.CelebrationGiftBoxBtn:SetActive(result)
end

function MainUI:OnClickBagBtn()
	UIModule.Open(Constant.UIControllerName.WarehouseUI, Constant.UILayer.UI)
end

function MainUI:OnClickSoulInfoBtn()
	UIModule.Open(Constant.UIControllerName.SoulListUI, Constant.UILayer.UI)
end

function MainUI:OnClickEquipBtn()
	UIModule.Open(Constant.UIControllerName.EquipListUI, Constant.UILayer.UI, nil, true)
end

function MainUI:OnClickShopBtn()
	UIModule.Open(Constant.UIControllerName.MallUI, Constant.UILayer.UI, {
		Constant.Mall_EntranceType.MainCity
	})
end

function MainUI:OnClickPassBtn()
	UIModule.Open(Constant.UIControllerName.PassCheckUI, Constant.UILayer.UI)
end

function MainUI:OnClickGrowthFundBtn()
	local noSameRecordBefore = UIRecorder.RecordOperation(self.GrowthFundBtn, true)

	if noSameRecordBefore then
		self:UpdateGrowthFundRedPoint()
	end

	UIModule.Open(Constant.UIControllerName.GrowthFundUI, Constant.UILayer.UI)
end

function MainUI:OnClickTaskBtn()
	UIModule.Open(Constant.UIControllerName.MissionUI, Constant.UILayer.UI)
end

function MainUI:OnClickExpBonusBtn()
	UIModule.Open(Constant.UIControllerName.ExpBonusUI, Constant.UILayer.UI)
end

function MainUI:OnClickActiveTaskBtn()
	UIModule.Open(Constant.UIControllerName.ActivityUI, Constant.UILayer.UI)
end

function MainUI:OnClickWishBtn()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.LOTTERY)

	if result == false then
		NoticeModule.ShowNoticeByType(1, UnlockFunctionModule.LockTitle(Constant.UnlockType.LOTTERY))

		return
	end

	UIModule.Open(Constant.UIControllerName.LotteryUI, Constant.UILayer.UI)
end

function MainUI.OnClickHomeBtn()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.HOME)

	if result == false then
		NoticeModule.ShowNoticeByType(1, UnlockFunctionModule.LockTitle(Constant.UnlockType.HOME))

		return
	end

	HomeLandLuaModule.EnterHome()
end

function MainUI:OnClickWorldMazeBtn()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.MAZE)

	if result == false then
		NoticeModule.ShowNoticeByType(1, UnlockFunctionModule.LockTitle(Constant.UnlockType.MAZE))

		return
	end

	UIModule.Open(Constant.UIControllerName.ExploreHallUI, Constant.UILayer.UI)
end

function MainUI:OnClickFormationBtn()
	local isUnlock = UnlockFunctionModule.IsUnlock(Constant.UnlockType.FORMATION)

	if not isUnlock then
		NoticeModule.ShowNoticeByType(1, UnlockFunctionModule.LockTitle(Constant.UnlockType.FORMATION))

		return
	end

	if not UnlockFunctionModule.CanUserOperate(Constant.UnlockType.FORMATION) then
		return
	end

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI)
end

function MainUI:OnClickGirlBtn()
	net_girl.getGirls()
end

function MainUI:OnClickGuildBtn()
	GuildModule.OpenGuild()
end

function MainUI:OnClickStorageBoxBtn()
	self.storageBoxView:Open()
end

function MainUI:OnClickLibraryBtn()
	TownLibraryModule.OpenLibrary(function()
		UIModule.Open(Constant.UIControllerName.LibraryUI, Constant.UILayer.UI)
	end)
end

function MainUI:OnClickRebatePackageBtn()
	UIModule.Open(Constant.UIControllerName.RefundsGiftPackUI, Constant.UILayer.UI)
end

function MainUI:OnClickCelebrationGiftBoxBtn()
	UIModule.Open(Constant.UIControllerName.CelebrationGiftUI, Constant.UILayer.UI)
end

function MainUI:OnClickMailBtn()
	UIModule.Open(Constant.UIControllerName.MailUI, Constant.UILayer.UI)
end

function MainUI:OnClickFirstRechargeBtn()
	self:PauseL2D()
	UIModule.Open(Constant.UIControllerName.ActivityCreditUI, Constant.UILayer.UI)
end

function MainUI:OnClickSettingBtn()
	UIModule.Open(Constant.UIControllerName.SettingUI, Constant.UILayer.UI)
end

function MainUI:OnResumeL2D()
	self:ResumeL2D()
end

function MainUI:OnUpdateRebatePackage()
	local result = RefundsGiftPackModule.IsOpenRebatePackage()

	self.RebatePackageBtn:SetActive(result)

	if result then
		self:OnUpdateRebatePackageRedPoint()
	end
end

function MainUI:RefreshUnlockBtn()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.MALL) and not NoticeModule.IsInQueue(Constant.UnlockType.MALL)

	self.ShopBtn:SetActive(result)

	local mallActive = result

	result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.MAIN_TASK) and not NoticeModule.IsInQueue(Constant.UnlockType.MAIN_TASK)

	self.TaskBtn:SetActive(result)

	result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.SOUL) and not NoticeModule.IsInQueue(Constant.UnlockType.SOUL)

	self.SoulInfoBtn:SetActive(result)

	result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.SOUL_PAINTING) and not NoticeModule.IsInQueue(Constant.UnlockType.SOUL_PAINTING)

	self.EquipBtn:SetActive(result)

	result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.GIRLS)

	self.GirlBtn:SetActive(result)

	result = ActiveModule.GetFirstRechargeTaskData().TaskStatus ~= TaskModule.TaskStatus.FINISH_TASK

	self.FirstRechargeBtn:SetActive(result)

	result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.TOWN)

	self.ToggleTown:SetActive(result)

	result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.MAZE)

	self.WorldMazeBtn:SetActive(result)

	result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.LOTTERY) and not NoticeModule.IsInQueue(Constant.UnlockType.LOTTERY)

	self.WishBtn:SetActive(result)

	result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.HOME)

	self.HomeBtn:SetActive(result)

	result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.FORMATION) and not NoticeModule.IsInQueue(Constant.UnlockType.FORMATION)

	self.FormationBtn:SetActive(result)

	result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.WAREHOUSE)

	self.BagBtn:SetActive(result)

	result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.NAVIGATION)

	if result then
		self.scrollActiveView:Open()
	else
		self.scrollActiveView:Close()
	end

	result = PassCheckModule.CheckPassIsOpen()

	self.PassBtn:SetActive(result)

	result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.LIBRARY)

	self.LibraryBtn:SetActive(result)

	result = RefundsGiftPackModule.IsOpenRebatePackage()

	self.RebatePackageBtn:SetActive(result)

	result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.GUILD)

	self.GuildBtn:SetActive(result)
	self:RefreshExpBonusBtnVisible()
	self:RefreshCelebrationGiftBtnVisible()
	self:UpdateMainFunPos()

	local leftBuyCount = MallModule.GetResidueBuyTimes(GrowthFundUIApi:GetString("GrowthFundMallCid"))
	local isActive = leftBuyCount == 0
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.GROWTH_FUND_TASK)

	self.GrowthFundBtn:SetActive(mallActive and (not isActive or #processing ~= 0))
end

function MainUI:UpdateMainFunPos()
	local startPos = Vector2.New(-50, -5)

	for i = 1, #Constant.MainFunShowRank do
		local funType = Constant.MainFunShowRank[i]
		local isOpen = UnlockFunctionModule.IsUnlock(funType) and not NoticeModule.IsInQueue(funType)

		if isOpen then
			if funType == Constant.UnlockType.MALL then
				self.ShopBtn.transform.anchoredPosition = startPos + Vector2.New(0, 0)
				startPos = startPos - Vector2.New(self.ShopBtn.transform.sizeDelta.x)
			elseif funType == Constant.UnlockType.GUILD then
				self.GuildBtn.transform.anchoredPosition = startPos
				startPos = startPos - Vector2.New(self.GuildBtn.transform.sizeDelta.x)
			elseif funType == Constant.UnlockType.FORMATION then
				self.FormationBtn.transform.anchoredPosition = startPos
				startPos = startPos - Vector2.New(self.FormationBtn.transform.sizeDelta.x)
			elseif funType == Constant.UnlockType.MAIN_TASK then
				self.TaskBtn.transform.anchoredPosition = startPos
				startPos = startPos - Vector2.New(self.TaskBtn.transform.sizeDelta.x)
			elseif funType == Constant.UnlockType.SOUL_PAINTING then
				self.EquipBtn.transform.anchoredPosition = startPos
				startPos = startPos - Vector2.New(self.EquipBtn.transform.sizeDelta.x)
			elseif funType == Constant.UnlockType.WAREHOUSE then
				self.BagBtn.transform.anchoredPosition = startPos
				startPos = startPos - Vector2.New(self.BagBtn.transform.sizeDelta.x)
			elseif funType == Constant.UnlockType.LIBRARY then
				self.LibraryBtn.transform.anchoredPosition = startPos
				startPos = startPos - Vector2.New(self.LibraryBtn.transform.sizeDelta.x)
			elseif funType == Constant.UnlockType.SOUL then
				self.SoulInfoBtn.transform.anchoredPosition = startPos
				startPos = startPos - Vector2.New(self.SoulInfoBtn.transform.sizeDelta.x)
			end
		end
	end
end

function MainUI:OnEffectEnd(functionTypeId)
	if functionTypeId == Constant.UnlockType.NAVIGATION then
		self.scrollActiveView:Open()
	end
end

function MainUI:ShowRedPoint(btnName, visible)
	local redPoint = self.RedPoints[btnName]

	if redPoint ~= nil then
		redPoint:SetActive(visible)
	end
end

function MainUI:OnUpdatePoint()
	self:OnRedPoint(Constant.RedType.TYPE_TOWN)

	local isHomeRed = RedModule.IsServerRed(Constant.RedType.TYPE_HOME)

	self:ShowRedPoint("HomeBtn", isHomeRed)

	local isGirlRed = false

	self:ShowRedPoint("GirlBtn", isGirlRed)
	self:OnNewMailCountChange()
end

function MainUI:OnPlayerInfoChange()
	local playerLevelCfg = CfgPlayerLevelTable[PlayerModule.PlayerInfo.baseInfo.pLv]

	if playerLevelCfg.Experience == 0 then
		self.ImgProcess:GetComponent("Image").fillAmount = 0.78
	else
		self.ImgProcess:GetComponent("Image").fillAmount = PlayerModule.PlayerInfo.baseInfo.exp / playerLevelCfg.Experience * 0.78
	end

	local value = CfgDiscreteDataTable[6520060].Data[1]

	self.LevelText:GetComponent("Text").text = MainUIApi:GetString("LevelText", PlayerModule.PlayerInfo.baseInfo.exp, playerLevelCfg.Experience, PlayerModule.PlayerInfo.baseInfo.pLv, value)

	self:OnUpdatePlayerLevel()
	self:OnUpdateLotteryRedPoint()
	self:OnUpdateBagRedPoint()
	self:RefreshExpBonusBtnVisible()
	self:RefreshCelebrationGiftBtnVisible()
end

function MainUI:OnNotifyStartSellTime()
	self:RefreshCelebrationGiftBtnVisible()
end

function MainUI:OnUpdatePlayerLevel()
	local value = CfgDiscreteDataTable[6520060].Data[1]

	self.TextLv:GetComponent("Text").text = MainUIApi:GetString("TextLv", PlayerModule.PlayerInfo.baseInfo.pLv, value)
	self.NameText:GetComponent("Text").text = MainUIApi:GetString("NameText", PlayerModule.PlayerInfo.baseInfo.pName)
end

function MainUI:OnUpdateTask(cid)
	self:ShowRedPoint("TaskBtn", MissionModule.CheckRedPointOnNormalTask() or MissionModule.CheckRedPointOnActive() or MissionModule.CheckRedPointOnWeekActive())
	self:ShowRedPoint("WorldMazeBtn", PlayerModule.HasMazeChapterCanClaimExploreReward() or ChallengeWorldBossModule.CheckRedPoint())
	self:OnUpdateActivityRedPoint()
	self:UpdateGrowthFundRedPoint()
	self:OnUpdateMallRedPoint()

	local result = ActiveModule.GetFirstRechargeTaskData().TaskStatus ~= TaskModule.TaskStatus.FINISH_TASK

	self.FirstRechargeBtn:SetActive(result)
	self:OnUpdateFirstRechargeRedPoint()
end

function MainUI:OnUpdateFirstRechargeRedPoint()
	self:ShowRedPoint("FirstRechargeBtn", ActiveModule.CheckRedPointOnFirstRecharge())
end

function MainUI:OnUpdateMallRedPoint()
	self:ShowRedPoint("ShopBtn", MallModule.CheckExistRedPointOnMall())
end

function MainUI:OnUpdateRebatePackageRedPoint()
	self:ShowRedPoint("RebatePackageBtn", RefundsGiftPackModule.CheckRebatePackageRedPoint())
end

function MainUI:OnUpdateSoulRedPoint()
	self:ShowRedPoint("SoulInfoBtn", SoulModule.CheckMainSoulRedPoint())
end

function MainUI:OnUpdateEquipRedPoint()
	self:ShowRedPoint("EquipBtn", EquipModule.CheckEquipCanComposeRedPoint())
end

function MainUI:OnUpdateActivityRedPoint()
	self:ShowRedPoint("ActiveTaskBtn", PlayerModule.HasFreeDailySupply() or ActivityTurnModule.CheckAllTurnRedPoint() or ActiveOperationEventModule.CheckOperationRedPoint() or ActiveLuckyTurnTableModule.CheckLuckyTurnTableRedPoint() or ActiveGachaModule.ShowRedPoint())
end

function MainUI:UpdateDailySupply()
	self:OnUpdateActivityRedPoint()
end

function MainUI:OnUpdateGuildRedPoint()
	local top = GuildModule.status

	self:ShowRedPoint("GuildBtn", top)
	self.mainTownView:RefreshGuildRed(top)
end

function MainUI:OnUpdateTurnEvent()
	self:OnUpdateActivityRedPoint()
end

function MainUI:OnClickUnlockNotify()
	self:OnUpdateActivityRedPoint()
	self.mainTownView:UnlockNotify()
end

function MainUI:OnRefreshMainUIUnlockBtn()
	self:RefreshUnlockBtn()
end

function MainUI:OnUpdateLotteryRedPoint()
	local canDraw = false

	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.LOTTERY) then
		for id, cfgLotteryShowData in pairsCfg(CfgLotteryShowTable) do
			if cfgLotteryShowData.LotteryType == Constant.LotteryType.Lottery_Soul then
				for i = 1, #cfgLotteryShowData.Pool do
					local poolCid = cfgLotteryShowData.Pool[i]
					local cfgLotteryData = CfgLotteryTable[poolCid]

					if cfgLotteryData.FreeType ~= 0 then
						local leftTimeSec

						if cfgLotteryShowData.BeginTime ~= "" then
							local beginTimeSec = cfgDateTimeToTimeStamp(cfgLotteryShowData.BeginTime, PlayerModule.TimeZone)

							leftTimeSec = beginTimeSec + cfgLotteryShowData.EndTime - PlayerModule.GetServerTime()
						end

						if leftTimeSec == nil or leftTimeSec > 0 then
							local leftFreeTime, haveFreeFunc = LotteryModule.CanFreeDraw(cfgLotteryData)

							if leftFreeTime == 0 then
								canDraw = true

								break
							end
						end
					end
				end
			end
		end
	end

	self:ShowRedPoint("WishBtn", canDraw)
end

function MainUI:UpdateGrowthFundRedPoint()
	local hasClicked = UIRecorder.HasRecord(self.GrowthFundBtn)
	local leftBuyCount = MallModule.GetResidueBuyTimes(GrowthFundUIApi:GetString("GrowthFundMallCid"))
	local isActive = leftBuyCount == 0
	local hasReward = false

	if isActive then
		local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.GROWTH_FUND_TASK)

		for i = 1, #processing do
			local taskData = processing[i]

			if taskData.finNum >= taskData.tgtNum then
				hasReward = true

				break
			end
		end
	end

	self:ShowRedPoint("GrowthFundBtn", not hasClicked or hasReward)
end

function MainUI:OnUpdateItem()
	self:OnUpdateLotteryRedPoint()
	self:OnUpdateSoulRedPoint()
	self:OnUpdateEquipRedPoint()
	self:OnUpdateBagRedPoint()
	self:OnUpdateActivityRedPoint()
end

function MainUI:OnSoulDataChange()
	self:OnUpdateSoulRedPoint()
end

function MainUI:OnLotteryResult(baseShowItems, showItems, lotteryShowCid, lotteryCid)
	self:OnUpdateLotteryRedPoint()
end

function MainUI:OnRedPoint(type, show)
	if type == Constant.RedType.TYPE_HOME then
		self:ShowRedPoint("HomeBtn", show)
	elseif type == Constant.RedType.TYPE_TOWN then
		local isTownRed = RedModule.IsServerRed(Constant.RedType.TYPE_TOWN) or MemoryNewModule.IsNewLockSoulStory() or TownModule.IsHaveFunctionPlot()

		self.TownRed:SetActive(isTownRed)
	elseif type == Constant.RedType.TYPE_GIRL then
		self:ShowRedPoint("GirlBtn", false)
	end
end

function MainUI:OnShowLevel2D(top)
	self.goLive2D:SetActive(top)
	self.goCvFrame:SetActive(top)
end

function MainUI:CheckMaze()
	local unfinishedNormalMazeCid = PlayerModule.GetUnfinishedMazeCid(Constant.Maze.ChapterTypeNormal)
	local unfinishedEndlessMazeCid = PlayerModule.GetUnfinishedMazeCid(Constant.Maze.ChapterTypeEndless)

	self.WorldMazeNotice:SetActive(unfinishedNormalMazeCid ~= nil or unfinishedEndlessMazeCid ~= nil)
end

function MainUI:OnUpdateBagRedPoint()
	local showRedPoint = WarehouseModule.NeedShowRedPoint()

	self:ShowRedPoint("BagBtn", showRedPoint)
end

function MainUI:OnTaskCommitResponse(cids, awards)
	self:OnUpdateLibraryRedPoint()
end

function MainUI:OnGetReward()
	self:OnUpdateLibraryRedPoint()
end

function MainUI:OnUpdateMall()
	self:OnUpdateMallRedPoint()
end

function MainUI:OnUpdateLibraryRedPoint()
	local red1 = TownLibraryModule.GetRedPoint(Constant.LibraryTaskType.TaskTypeStory)
	local red2 = TownLibraryModule.GetRedPoint(Constant.LibraryTaskType.TaskTypeMaze)
	local red3 = TownLibraryModule.GetRedPoint(Constant.LibraryTaskType.TaskTypeEquipment)
	local red4 = TownLibraryModule.GetRedPoint(Constant.LibraryTaskType.TaskTypeNews)
	local showRed = red1 or red2 or red3 or red4

	self:ShowRedPoint("LibraryBtn", showRed)
end

function MainUI:UpDateMaxMazeChapter()
	local cfgChapterData, cfgMazeInstanceData, unfinishedMazeCid = PlayerModule.GetNormalMazeExploreProgressData()

	UGUIUtil.SetText(self.CurrentMazeName, ExploreHallUIApi:GetString("MazeNameText", cfgChapterData.Alias, cfgChapterData.Name, cfgChapterData.Order, cfgMazeInstanceData.Order, cfgMazeInstanceData.Name))
end

function MainUI:OnToggleChange(isOn)
	TownModule.inTown = isOn

	self:ChangeSceneUI()
end

function MainUI:ChangeSceneUI()
	self:UpDateMaxMazeChapter()

	local tab = CfgGlobalTable[1056].Parameter
	local posTab = string.split(tab, "|")

	if TownModule.inTown then
		local timer = Timer.New(function()
			UnityEngine.Camera.main.transform.position = Vector3.New(posTab[1], posTab[2], posTab[3])

			self.MainCityPanel:SetActive(false)
			self.PointSpine:SetActive(false)
			self.mainTownView:Open()
			self.scrollActiveView:Close()
			self:SetScaleLive2D(false)
			self:PlayAnimation("MainUI_2")
			self.purchaseTipView:Close()
			self.spineCell:Close()
			self.mainBtnChangeView:Close()
			self.mainOathAvBGView:Close()
		end, 0.24)

		timer:Start()
		self:PlayAnimation("New_MainUI_In 0")
		self:ShowOrHideUI()
	else
		local timer = Timer.New(function()
			self.mainTownView:Close()

			UnityEngine.Camera.main.transform.position = Vector3.New(posTab[1], posTab[2], posTab[3])

			self.MainCityPanel:SetActive(true)
			self.DisableClick:SetActive(true)
			self:PlayAnimation("New_MainUI_In")

			local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.NAVIGATION)

			if result then
				self.scrollActiveView:Open()
			else
				self.scrollActiveView:Close()
			end

			self.purchaseTipView:Open()
			self:ChangeFashionBG()
			self.mainBtnChangeView:Open(self.showBGType, self.haveSpineBg, self.haveOathBg)
			self:ShowOrHideUI()
		end, 0.2)

		timer:Start()
		self:PlayAnimation("MainUI_2 0")
	end

	GameEntry.LuaEvent:Fire(nil, MainCityMoveEventArgs():Fill(TownModule.inTown))
end

function MainUI:PlayAnimation(name)
	local animator = self.UIController.gameObject:GetComponentInChildren(typeof(UnityEngine.Animator))

	animator:Play(name, 0, 0)
end

function MainUI:SetScaleLive2D(top)
	if top then
		self:ResumeL2D()

		self.goLive2D.transform.localScale = Vector3.New(1, 1, 1)
		self.goCvFrame.transform.localScale = Vector3.New(1, 1, 1)
	else
		self:PauseL2D()

		self.goLive2D.transform.localScale = Vector3.New(0, 0, 0)
		self.goCvFrame.transform.localScale = Vector3.New(0, 0, 0)
	end
end

function MainUI:ChangeBG(type, haveSpineBg, haveOathBg)
	self.toggleTown.interactable = false
	self.haveSpineBg = haveSpineBg
	self.haveOathBg = haveOathBg

	self.DisableClick:SetActive(true)

	if self.changeTimer then
		self.changeTimer:Stop()

		self.changeTimer = nil
	end

	self.showBGType = type

	PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.MainCity_Spine_BG, self.showBGType)

	local effectID = 0

	if type == 2 then
		effectID = SoulModule.curSoulData:GetCfgSoulRes2D().OpenSpineUIEffect
	else
		effectID = SoulModule.curSoulData:GetCfgSoulRes2D().CloseSpineUIEffect
	end

	if effectID == 0 then
		effectID = 9008002
	end

	self:StopChangePageEffect()

	self.ChangePageEffectPlayId = GameEntry.Effect:PlayUIMountPointEffect(effectID, 50000, 0, self.SpineEffectPoint, self.UIController:GetComponent("Canvas").sortingOrder + 10)
	self.changeTimer = Timer.New(function()
		self.mainOathAvBGView:Close()
		self.spineCell:Close()
		self:ChangeFashionBG()
		WeatherBGMModule.ChangeBgmSpine(type)

		self.toggleTown.interactable = true
	end, 1)

	self.changeTimer:Start()
	SDKLoginModule.LogChangeShowGirl(type, SoulModule.curSoulData.soulCid, SoulModule.curSoulData.dressCid2D, SoulModule.curSoulData.dressCid3D)
end

function MainUI:StopChangePageEffect()
	if self.ChangePageEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.ChangePageEffectPlayId)

		self.ChangePageEffectPlayId = 0
	end
end

function MainUI:LoadSpineBG(asset)
	for i = 0, self.PointSpine.transform.childCount - 1 do
		local obj = self.PointSpine.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	local spineBgObj = UnityEngine.GameObject.Instantiate(asset)

	spineBgObj.transform:SetParent(self.PointSpine.transform, false)

	local sortComponents = spineBgObj:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder))
	local canvas = self.UIController:GetComponent("Canvas")

	for i = 0, sortComponents.Length - 1 do
		sortComponents[i].UIRootCanvas = canvas
	end

	self.goSpineCell.transform:SetParent(spineBgObj.transform:Find("Point_Root"), false)

	local CVPoint = spineBgObj.transform:Find("Point_Root/Cv_Point")

	if CVPoint then
		self.spineCell.goCvFrame.transform.position = CVPoint.transform.position
	end

	local SpineScale = spineBgObj.transform:Find("Point_Root/Spine_Scale")

	if SpineScale then
		self.spineCell.goSpineRoot.transform.localScale = SpineScale.transform.localScale
	end
end

function MainUI:ChangeFashionBG()
	SoulModule.ChangeToCandidate()
	self.WhisperDLController:SetData(SoulModule.curSoulData.soulCid, 0)

	if GameEntry.Base.DevMode then
		log("当前人偶 " .. SoulModule.curSoulData.soulCid .. " 当前穿的时装 dressCid2D = " .. SoulModule.curSoulData.dressCid2D .. " 当前穿的时装 dressCid3D = " .. SoulModule.curSoulData.dressCid3D)
		log("当前显示模式 " .. self.showBGType .. " 是否有Spine背景 " .. tostring(self.haveSpineBg) .. " 是否有誓约资源 " .. tostring(self.haveOathBg))
	end

	if self.showBGType == 2 and self.haveSpineBg then
		self:ChangeFashionBGSpine()
	elseif self.showBGType == 3 and self.haveOathBg then
		ResourceUpdateChecker.CheckResourcesByTag(SoulModule.GetWhisperResTag(SoulModule.curSoulData.soulCid), function(pTag, updateCount, updateTotalLength)
			if self.UIController == nil then
				return
			end

			if self.showBGType ~= 3 then
				return
			end

			if pTag ~= SoulModule.GetWhisperResTag(SoulModule.curSoulData.soulCid) then
				return
			end

			if updateTotalLength > 0 then
				self:ChangeFashionBGL2D()
			else
				self:ChangeFashionBGOath()
			end

			self.WhisperDLController:SetData(SoulModule.curSoulData.soulCid, updateTotalLength)
		end)
	else
		self:ChangeFashionBGL2D()
	end
end

function MainUI:ChangeFashionBGL2D()
	AssetUtil.LoadImage(self, MainUIApi:GetString("ImgWishBtn", false, false), self.ImgWishBtn:GetComponent("Image"))
	AssetUtil.LoadImage(self, MainUIApi:GetString("ImgHomeBtn", false, false), self.ImgHomeBtn:GetComponent("Image"))
	AssetUtil.LoadImage(self, MainUIApi:GetString("ImgGirlBtn", false, false), self.ImgGirlBtn:GetComponent("Image"))
	AssetUtil.LoadImage(self, MainUIApi:GetString("ImgWorldMazeBtn", false, false), self.ImgWorldMazeBtn:GetComponent("Image"))
	self.PointSpine:SetActive(false)
	self.spineCell:Close()
	self:SetBtnPosition(false, false)
	self:SetScaleLive2D(true)
	self.mainOathAvBGView:Close()
	self.DisableClick:SetActive(false)
	self.storageBoxView:Close()
end

function MainUI:ChangeFashionBGSpine()
	AssetUtil.LoadImage(self, MainUIApi:GetString("ImgWishBtn", true, false), self.ImgWishBtn:GetComponent("Image"))
	AssetUtil.LoadImage(self, MainUIApi:GetString("ImgHomeBtn", true, false), self.ImgHomeBtn:GetComponent("Image"))
	AssetUtil.LoadImage(self, MainUIApi:GetString("ImgGirlBtn", true, false), self.ImgGirlBtn:GetComponent("Image"))
	AssetUtil.LoadImage(self, MainUIApi:GetString("ImgWorldMazeBtn", true, false), self.ImgWorldMazeBtn:GetComponent("Image"))
	self.goSpineCell.transform:SetParent(self.PointSpine.transform.parent, false)
	self.PointSpine:SetActive(true)

	local path = self.spineBGPathTab[SoulModule.curSoulData:GetCfgDress2D().SoulResID]

	AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil, {
		type = "loadSpineBG"
	})
	self.spineCell:Show(SoulModule.curSoulData.soulCid, true)
	self:SetBtnPosition(true, false)
	self:SetScaleLive2D(false)
	self.mainOathAvBGView:Close()
	self.DisableClick:SetActive(false)
	self.storageBoxView:Close()
end

function MainUI:ChangeFashionBGOath()
	if GirlModule.soulOathPOD then
		self.isActivation = GirlModule.soulOathPOD.activation
	end

	AssetUtil.LoadImage(self, MainUIApi:GetString("ImgWishBtn", false, self.isActivation), self.ImgWishBtn:GetComponent("Image"))
	AssetUtil.LoadImage(self, MainUIApi:GetString("ImgHomeBtn", false, self.isActivation), self.ImgHomeBtn:GetComponent("Image"))
	AssetUtil.LoadImage(self, MainUIApi:GetString("ImgGirlBtn", false, self.isActivation), self.ImgGirlBtn:GetComponent("Image"))
	AssetUtil.LoadImage(self, MainUIApi:GetString("ImgWorldMazeBtn", false, self.isActivation), self.ImgWorldMazeBtn:GetComponent("Image"))
	self.PointSpine:SetActive(false)
	self.spineCell:Close()
	self:SetBtnPosition(false, true)
	self:SetScaleLive2D(false)
	self.mainOathAvBGView:Open()
	self.DisableClick:SetActive(false)
	self.storageBoxView:Close()
end

function MainUI:OnDLResComplete(tag, isRepair, isAllComplete)
	if isAllComplete and not isRepair then
		self.WhisperDLController:RefreshDownloadingState()

		if (tag == Constant.ResourceTag.Whisper or tag == SoulModule.GetWhisperResTag(SoulModule.curSoulData.soulCid)) and self.showBGType == 3 and self.haveOathBg then
			self:ChangeFashionBGOath()
			self.WhisperDLController:SetData(SoulModule.curSoulData.soulCid, 0)
		end
	end
end

function MainUI:SetBtnPosition(showSpineBG, showMarry)
	self.WorldMazeBtn.transform.anchoredPosition = MainUIApi:GetString("WorldMazeBtn", showSpineBG, showMarry, SoulModule.curSoulData.soulCid)
	self.WishBtn.transform.anchoredPosition = MainUIApi:GetString("WishBtn", showSpineBG, showMarry, SoulModule.curSoulData.soulCid)
	self.HomeBtn.transform.anchoredPosition = MainUIApi:GetString("HomeBtn", showSpineBG, showMarry, SoulModule.curSoulData.soulCid)
	self.WorldMazeNotice.transform.anchoredPosition = MainUIApi:GetString("WorldMazeNotice", showSpineBG, showMarry, SoulModule.curSoulData.soulCid)
	self.GirlBtn.transform.anchoredPosition = MainUIApi:GetString("GirlBtn", showSpineBG, showMarry, SoulModule.curSoulData.soulCid)

	self.WorldMazeEffect:SetActive(not showMarry)
	self.WishBtnLine:SetActive(not showMarry)
	self.HomeBtnLine:SetActive(not showMarry)
	self.GirlBtnLine:SetActive(not showMarry)
end

function MainUI:CheckL2dNotify()
	if MailModule.newMailCount == nil or MailModule.newMailCount > 0 then
		GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.NewMail))
	elseif ChatModule.privateChatCount > 0 then
		GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.PrivateChat))
	elseif TownModule.IsHaveFunctionPlot() then
		GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.TownPlot))
	end
end

function MainUI:OnUpdateWoldBossRedPoint()
	self:ShowRedPoint("WorldMazeBtn", PlayerModule.HasMazeChapterCanClaimExploreReward() or ChallengeWorldBossModule.CheckRedPoint())
end

function MainUI:OnUpdateMagicWaxMuseumRedPoint()
	self:OnUpdateActivityRedPoint()
end

function MainUI:OnUpdateDoubleFightRedPoint()
	self:OnUpdateActivityRedPoint()
end

function MainUI:OnUpdateLuckyTurnRedPoint()
	self:OnUpdateActivityRedPoint()
end

function MainUI:OnClickLunaBtLineBtn()
	UIModule.Open(Constant.UIControllerName.LunaBattleLineEntryUI, Constant.UILayer.UI)
end

function MainUI:OnUpdateDailyDupEvent()
	self.LunaBtLineBtn:SetActive(LunaBattleLineModule.IsShow())
end

function MainUI:OnOperationsEvent()
	self:OnUpdateActivityRedPoint()
end

function MainUI:OnBtnHide()
	self.showUI = false

	self:ShowOrHideUI()
end

function MainUI:OnBtnShow()
	self.showUI = true

	self:ShowOrHideUI()
end

function MainUI:ShowOrHideUI()
	self.MainCityPanel:SetActive(self.showUI)
	self.ToggleTown:SetActive(self.showUI and UnlockFunctionModule.IsUnlock(Constant.UnlockType.TOWN))
	self.BtnShow:SetActive(not self.showUI and not TownModule.inTown)
	self.BtnHide:SetActive(self.showUI and not TownModule.inTown)
end

function MainUI:OnClickSpeTestBtn()
	return
end

function MainUI:OnUpdateGirlOnDutyEvent(soulCid)
	if SoulModule.curSoulData and SoulModule.curSoulData.soulCid == soulCid then
		-- block empty
	end
end

return MainUI
