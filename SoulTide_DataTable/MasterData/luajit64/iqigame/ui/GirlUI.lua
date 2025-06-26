-- chunkname: @IQIGame\\UI\\GirlUI.lua

local GirlUI = Base:Extend("GirlUI", "IQIGame.Onigao.UI.GirlUI", {
	signFavorUp = false,
	isOpenAlter = false,
	isOpen = false,
	isSelectFirst = false,
	SoundPackageId = 0,
	itemSelectImgDic = {},
	effectInstanceIDEndPosMap = {},
	goIDEffectIDMap = {}
})
local FondleView = require("IQIGame.UI.Girl.FondleView")
local BtnFunctionView = require("IQIGame.UI.Girl.BtnFunctionView")
local SoulChooseView = require("IQIGame.UI.Girl.SoulChooseView")
local DressView = require("IQIGame.UI.Girl.dress.DressView")
local WhisperView = require("IQIGame.UI.Girl.Whisper.WhisperView")
local BackGroundView = require("IQIGame.UI.Girl.BackGround.BackGroundView")
local isShowGift = false
local selectItemData, selectCellObj, lastSoulFavorLv, lastSoulLoveStage, lastSoulID, lastSoulExp

function GirlUI:OnInit()
	self:Init()
end

function GirlUI:OnOpen(userData)
	UIModule.BugFixL2dUIList[self.name] = self

	if JumpModule.girlJumpData ~= nil then
		self.soulData = JumpModule.girlJumpData
		JumpModule.girlJumpData = nil
	elseif userData ~= nil then
		self.soulData = userData
	else
		self.soulData = SoulModule.curSoulData
	end

	self.signFavorUp = false
	MemoryModule.currentSoulID = self.soulData.soulCid
	MemoryNewModule.currentSoulID = self.soulData.soulCid

	if self.EffectItem then
		self.EffectItem:SetActive(false)
	end

	self.LoveUp:SetActive(false)
	self.fondleView:Open()
	self:ShowDefaultView()
	self:UpdateView(false)
	self:CheckBtnRule()
	self:CheckBtnBackGround()
	self.live2DView:Refresh(self.soulData)
	self.soulChooseView:UpdateView(self.soulData)
	self:OnSelectSoul(self.soulData.soulCid)

	self.isOpenAlter = false

	self:LoadGirlBG(GirlBackGroundModule.currentUseBG)
end

function GirlUI:GetPreloadAssetPaths()
	self.slotUIPath = AssetPath.Get(GlobalKey.UIPrefabPath, "Common/CommonSlotUI")

	local pathList = {
		self.slotUIPath
	}

	return pathList
end

function GirlUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GirlUI:OnClose(userData)
	UIModule.BugFixL2dUIList[self.name] = nil
	self.isOpen = false
	selectItemData = nil
	selectCellObj = nil
	isShowGift = false

	self.fondleView:Close()
	self.live2DView:Dispose()
	self.dressView:OnHide()
	self.whisperView:Close()
	self.backGroundView:Close()
	net_girl.exitGirls()

	if self.SoundPackageId and self.SoundPackageId ~= 0 then
		SoundPackagePlayer.Remove(self.SoundPackageId)
	end

	self.SoundPackageId = 0
	self.showBGPath = nil
end

function GirlUI:OnPause()
	return
end

function GirlUI:OnResume()
	return
end

function GirlUI:OnCover()
	return
end

function GirlUI:OnReveal()
	return
end

function GirlUI:OnRefocus(userData)
	return
end

function GirlUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GirlUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GirlUI:OnLoadSucceed(assetName, asset, duration, userData)
	if userData.type == "LoadBG" then
		self.showBGPath = assetName

		for i = 0, self.BGRoot.transform.childCount - 1 do
			local obj = self.BGRoot.transform:GetChild(i).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		local bgObj = UnityEngine.Object.Instantiate(asset)

		bgObj.transform:SetParent(self.BGRoot.transform, false)

		local sortComponents = bgObj:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder))
		local canvas = self.UIController:GetComponent("Canvas")

		for i = 0, sortComponents.Length - 1 do
			sortComponents[i].UIRootCanvas = canvas
		end
	end
end

function GirlUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GirlUI:OnDestroy()
	self.live2DView:OnDestroy()
	self.btnFunctionView:Dispose()
	self.fondleView:Dispose()
	self.soulChooseView:OnDestroy()
	self.dressView:OnDestroy()
	self.whisperView:Dispose()
	self.backGroundView:Dispose()
	AssetUtil.UnloadAsset(self)
end

function GirlUI:Init()
	UGUIUtil.SetText(self.TextTitleName, GirlUIApi:GetString("TextTitleName"))

	self.dressView = DressView.New(self.goDressView)
	self.whisperView = WhisperView.New(self.RectWhisper, self)
	self.backGroundView = BackGroundView.New(self.RectBackGround)
	self.commonSlotPrefab = self.UIController:GetPreloadedAsset(self.slotUIPath)
	self.EffectItem = UnityEngine.Object.Instantiate(self.borderPrefab)

	self.EffectItem.transform:SetParent(self.UIController.gameObject.transform, false)
	self.EffectItem:SetActive(false)

	self.checkToggle = self.Check:GetComponent("Toggle")
	self.btnBack = self.BtnBack:GetComponent("Button")
	self.btnGifts = self.BtnGifts:GetComponent("Button")
	self.btnPresent = self.BtnPresent:GetComponent("Button")
	self.btnOath = self.BtnOath:GetComponent("Button")
	self.btnDress = self.BtnWardrobe:GetComponent("Button")

	function self.DelegateOnFinishedAchievement()
		self:OnFinishedAchievement()
	end

	function self.DelegateOnCloseMemoryUI()
		self:OnCloseMemoryUI()
	end

	function self.DelegateOnCloseMemoryNewUI()
		self:OnCloseMemoryNewUI()
	end

	function self.delegateOnChangeToggle(isOn)
		self:OnChangeToggle(isOn)
	end

	function self.delegateGift()
		self:OnGift()
	end

	self.btnClosetTxt:GetComponent("Text").text = GirlUIApi:GetString("ClosetTxt")
	self.TextGiftTitle:GetComponent("Text").text = GirlUIApi:GetString("GiftTxt", 1)
	self.btnPresetTxt:GetComponent("Text").text = GirlUIApi:GetString("PresetTxt")
	self.labGiftCatTxt:GetComponent("Text").text = GirlUIApi:GetString("GiftCatTxt")

	UGUIUtil.SetText(self.TextBtnCloseGift, GirlUIApi:GetString("TextBtnCloseGift"))

	self.labFavorTitleTxt:GetComponent("Text").text = GirlUIApi:GetString("labFavorTitleTxt")
	self.labCheckSoul:GetComponent("Text").text = GirlUIApi:GetString("labFateTitleTxt")

	UGUIUtil.SetText(self.TextBtnGift, GirlUIApi:GetString("TextBtnGift"))
	UGUIUtil.SetText(self.TextBtnSoulLibrary, GirlUIApi:GetString("TextBtnSoulLibrary"))

	self.btnCloseGift = self.BtnCloseGift:GetComponent("Button")
	self.fondleView = FondleView.__New(self.Fondle, self)
	self.rectFunctionTween = self.RectFunction:GetComponent("TweenPosition")
	self.soulChooseView = SoulChooseView.__New(self.ChooseSoulPanel)
	self.btnFunctionView = BtnFunctionView.__New(self.RectFunction, self)
	self.live2DView = GirlL2DView.New(self.goLive2D)

	function self.delegateSubPanelTween()
		self:OnResetSubPanelTween()
	end

	function self.delegateSubCancelPanelTween()
		self:OnResetSubCancelPanelTween()
	end

	function self.delegateOpenFunctionPanelTween()
		self:OnOpenFunctionPanelTween()
	end

	function self.delegateBtnBack()
		self:OnClickBtnBack()
	end

	function self.delegateBtnGifts()
		self:OnClickBtnGifts()
	end

	function self.delegateSoulDataChange(soulID)
		self:OnSoulDataChange(soulID)
	end

	function self.delegateBtnPresent()
		self:OnClickBtnPresent()
	end

	function self.delegateBtnCloseGift()
		self:OnClickBtnCloseGift()
	end

	function self.delegateBtnCloseDress()
		self:OnClickBtnCloseDress()
	end

	function self.delegateBtnCloseSoulPower()
		self:OnClickBtnCloseSoulPower()
	end

	function self.delegateBtnOath()
		self:OnClickBtnOath()
	end

	function self.delegateResetTween()
		self:OnResetTween()
	end

	function self.onClickBtnDressDelegate()
		self:OnClickBtnDress()
	end

	function self.delegateBtnWhisper()
		self:OnClickBtnWhisper()
	end

	function self.delegateBtnCloseWhisper()
		self:OnClickBtnCloseWhisper()
	end

	function self.delegateBtnCloseBackGround()
		self:OnClickBtnCloseBackGround()
	end

	function self.delegateUpdateItem(cell)
		self:UpdateItemCell(cell)
	end

	function self.delegateSelectedItem(cell)
		self:SelectedItemCell(cell)
	end

	function self.delegateGiftSuccess(giftCid, spAddition, addFavor)
		self:OnGiftSuccess(giftCid, spAddition, addFavor)
	end

	function self.delegateFuncJump(cid)
		self:OnFuncJump(cid)
	end

	function self.delegateUpdateGirUIRedPoint()
		self:UpdateRedPoint()
	end

	function self.delegateSoulOathSuccess(soulCid)
		self:OnSoulOathSuccess(soulCid)
	end

	function self.delegateOnShowLevel2D(top)
		self:OnShowLevel2D(top)
	end

	function self.delegateSelectSoul(soulCid)
		self:OnSelectSoul(soulCid)
	end

	function self.delegateBtnGuide()
		self:OnBtnGuide()
	end

	function self.delegateOnStartFlyEffect(sender, arg)
		self:OnStartFlyEffect(sender, arg)
	end

	function self.delegateEffectFlyComplete(go)
		self:EffectFlyComplete(go)
	end

	function self.delegateFavorIncreaseTxtTween()
		self:OnFinishTxtFavorTween()
	end

	function self.delegateBtnSoulLibrary()
		self:OnBtnSoulLibrary()
	end

	function self.delegateUpdatePeriodOfTime()
		self:UpdatePeriodOfTime()
	end

	function self.delegateBtnRule()
		self:OnBtnRule()
	end

	function self.delegateOnUnlockNotify()
		self:OnUnlockFunction()
	end

	function self.delegateBtnBackGround()
		self:OnBtnBackGround()
	end

	function self.delegateUpdateGirlBGEvent(cid)
		self:OnUpdateGirlBG(cid)
	end

	function self.delegateUpdateRandomSecretaryState()
		self:OnRandomSecretaryState()
	end

	function self.delegateBtnInteraction()
		self:OnBtnInteraction()
	end

	function self.onResumeL2dDelegate()
		self:OnResumeL2D()
	end

	function self.onPauseL2DDelegate()
		self:Pause()
	end

	local tempSubTween = self.RectGift:GetComponent("TweenPosition")

	self.RectGift.transform.position = tempSubTween.to

	local to = tempSubTween.to

	tempSubTween.to = tempSubTween.from
	tempSubTween.from = to
	self.gridSlotComponent = self.GridSlot:GetComponent("ScrollAreaList")
	self.gridSlotComponent.onRenderCell = self.delegateUpdateItem
	self.gridSlotComponent.onSelectedCell = self.delegateSelectedItem
end

function GirlUI:UpdateRedPoint()
	self.btnFunctionView:OnUpdateFunctionViewRed(self.soulData.soulCid)
	EventDispatcher.Dispatch(EventID.RedGirlChooseCell, self.soulData.soulCid)
end

function GirlUI:OnAddListeners()
	self.btnBack.onClick:AddListener(self.delegateBtnBack)
	self.btnGifts.onClick:AddListener(self.delegateBtnGifts)
	self.btnPresent.onClick:AddListener(self.delegateBtnPresent)
	self.btnCloseGift.onClick:AddListener(self.delegateBtnCloseGift)
	self.btnOath.onClick:AddListener(self.delegateBtnOath)
	self.BtnGuide:GetComponent("Button").onClick:AddListener(self.delegateBtnGuide)
	self.BtnSoulLibrary:GetComponent("Button").onClick:AddListener(self.delegateBtnSoulLibrary)
	self.btnDress.onClick:AddListener(self.onClickBtnDressDelegate)
	self.BtnCloseDress:GetComponent("Button").onClick:AddListener(self.delegateBtnCloseDress)
	self.BtnCloseGiftSmall:GetComponent("Button").onClick:AddListener(self.delegateBtnCloseGift)
	self.BtnWhisper:GetComponent("Button").onClick:AddListener(self.delegateBtnWhisper)
	self.BtnCloseWhisper:GetComponent("Button").onClick:AddListener(self.delegateBtnCloseWhisper)
	self.BtnRule:GetComponent("Button").onClick:AddListener(self.delegateBtnRule)
	self.BtnBackGround:GetComponent("Button").onClick:AddListener(self.delegateBtnBackGround)
	self.BtnCloseBackGround:GetComponent("Button").onClick:AddListener(self.delegateBtnCloseBackGround)
	self.BtnInteraction:GetComponent("Button").onClick:AddListener(self.delegateBtnInteraction)
	EventDispatcher.AddEventListener(EventID.FinishedAchievement, self.DelegateOnFinishedAchievement)
	EventDispatcher.AddEventListener(EventID.SoulDataChange, self.delegateSoulDataChange)
	EventDispatcher.AddEventListener(EventID.GiftGivingSuccess, self.delegateGiftSuccess)
	GameEntry.LuaEvent:Subscribe(EffectShowEventArgs.EventId, self.delegateOnStartFlyEffect)
	EventDispatcher.AddEventListener(EventID.MemoryUICloseEvent, self.DelegateOnCloseMemoryUI)
	EventDispatcher.AddEventListener(EventID.MemoryNewUICloseEvent, self.DelegateOnCloseMemoryNewUI)
	EventDispatcher.AddEventListener(EventID.FuncJump, self.delegateFuncJump)
	EventDispatcher.AddEventListener(EventID.UpdateGirUIRedPoint, self.delegateUpdateGirUIRedPoint)
	self.checkToggle.onValueChanged:AddListener(self.delegateOnChangeToggle)
	EventDispatcher.AddEventListener(EventID.SoulCompleteOathSuccess, self.delegateSoulOathSuccess)
	EventDispatcher.AddEventListener(EventID.GuideIsShowLevel2D, self.delegateOnShowLevel2D)
	EventDispatcher.AddEventListener(EventID.SoulChanged, self.delegateSelectSoul)
	EventDispatcher.AddEventListener(EventID.UpdatePeriodOfTime, self.delegateUpdatePeriodOfTime)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.delegateOnUnlockNotify)
	EventDispatcher.AddEventListener(EventID.UpdateGirlBackgroundEvent, self.delegateUpdateGirlBGEvent)
	EventDispatcher.AddEventListener(EventID.UpdateRandomSecretaryState, self.delegateUpdateRandomSecretaryState)
	EventDispatcher.AddEventListener(EventID.L2DResume, self.onResumeL2dDelegate)
	EventDispatcher.AddEventListener(EventID.L2DPause, self.onPauseL2DDelegate)
end

function GirlUI:OnRemoveListeners()
	self.btnBack.onClick:RemoveListener(self.delegateBtnBack)
	self.btnGifts.onClick:RemoveListener(self.delegateBtnGifts)
	self.btnPresent.onClick:RemoveListener(self.delegateBtnPresent)
	self.btnCloseGift.onClick:RemoveListener(self.delegateBtnCloseGift)
	self.btnOath.onClick:RemoveListener(self.delegateBtnOath)
	self.BtnGuide:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGuide)
	self.BtnSoulLibrary:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSoulLibrary)
	self.btnDress.onClick:RemoveListener(self.onClickBtnDressDelegate)
	self.BtnCloseDress:GetComponent("Button").onClick:RemoveListener(self.delegateBtnCloseDress)
	self.BtnCloseGiftSmall:GetComponent("Button").onClick:RemoveListener(self.delegateBtnCloseGift)
	self.BtnWhisper:GetComponent("Button").onClick:RemoveListener(self.delegateBtnWhisper)
	self.BtnCloseWhisper:GetComponent("Button").onClick:RemoveListener(self.delegateBtnCloseWhisper)
	self.BtnRule:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRule)
	self.BtnBackGround:GetComponent("Button").onClick:RemoveListener(self.delegateBtnBackGround)
	self.BtnCloseBackGround:GetComponent("Button").onClick:RemoveListener(self.delegateBtnCloseBackGround)
	self.BtnInteraction:GetComponent("Button").onClick:RemoveListener(self.delegateBtnInteraction)
	EventDispatcher.RemoveEventListener(EventID.FinishedAchievement, self.DelegateOnFinishedAchievement)
	EventDispatcher.RemoveEventListener(EventID.SoulDataChange, self.delegateSoulDataChange)
	EventDispatcher.RemoveEventListener(EventID.GiftGivingSuccess, self.delegateGiftSuccess)
	GameEntry.LuaEvent:Unsubscribe(EffectShowEventArgs.EventId, self.delegateOnStartFlyEffect)
	EventDispatcher.RemoveEventListener(EventID.FuncJump, self.delegateFuncJump)
	EventDispatcher.RemoveEventListener(EventID.MemoryUICloseEvent, self.DelegateOnCloseMemoryUI)
	EventDispatcher.RemoveEventListener(EventID.MemoryNewUICloseEvent, self.DelegateOnCloseMemoryNewUI)
	EventDispatcher.RemoveEventListener(EventID.UpdateGirUIRedPoint, self.delegateUpdateGirUIRedPoint)
	self.checkToggle.onValueChanged:RemoveListener(self.delegateOnChangeToggle)
	EventDispatcher.RemoveEventListener(EventID.SoulCompleteOathSuccess, self.delegateSoulOathSuccess)
	EventDispatcher.RemoveEventListener(EventID.GuideIsShowLevel2D, self.delegateOnShowLevel2D)
	EventDispatcher.RemoveEventListener(EventID.SoulChanged, self.delegateSelectSoul)
	EventDispatcher.RemoveEventListener(EventID.UpdatePeriodOfTime, self.delegateUpdatePeriodOfTime)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.delegateOnUnlockNotify)
	EventDispatcher.RemoveEventListener(EventID.UpdateGirlBackgroundEvent, self.delegateUpdateGirlBGEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateRandomSecretaryState, self.delegateUpdateRandomSecretaryState)
	EventDispatcher.RemoveEventListener(EventID.L2DResume, self.onResumeL2dDelegate)
	EventDispatcher.RemoveEventListener(EventID.L2DPause, self.onPauseL2DDelegate)
end

function GirlUI:OnChangeToggle(isOn)
	if isOn then
		local soulCid = self.soulData.soulCid

		SoulModule.SetCurSoulData(soulCid)
		EventDispatcher.Dispatch(EventID.SoulSelected, soulCid)
		SoulModule.ReqSoulChanged(soulCid)

		self.checkToggle.enabled = false
	end
end

function GirlUI:OnSoulDataChange(soulID)
	if soulID ~= MemoryModule.currentSoulID then
		return
	end

	self.soulData = SoulModule.GetSoulData(soulID)

	if not GiftModule.isDelayShow then
		self:UpdateView(false)
	end

	if self.whisperView.isOpen then
		GirlModule.RequestSoulOath(soulID, function(pSoulID, soulOathPOD)
			local whisperList, openWhisperList = GirlModule.GetSoulWhisperListData(pSoulID)

			if GirlModule.soulOathPOD.activation and #whisperList > 0 then
				self.whisperView:UpdateView(pSoulID)
			else
				self:OnClickBtnCloseWhisper()
			end
		end)
	end

	self.btnFunctionView:OnUpdateFunctionViewRed()
end

function GirlUI:EqualOrderProgress()
	local percent = 0
	local maxOrder = 0

	for i, v in pairsCfg(CfgSoulFavorTable) do
		if v.SoulID == self.soulData.soulCid and maxOrder < v.FavorDegree then
			maxOrder = v.FavorDegree
		end
	end

	percent = self.soulData.favorLv / maxOrder

	return percent
end

function GirlUI:UpdateView(isShow)
	self:UpdateRedPoint()

	local favorLv = self.soulData.favorLv
	local favorExp = self.soulData:GetSoulFavor(favorLv)
	local cfgSoulFavorRender = self.soulData:GetCfgSoulFavor()

	if self.soulData ~= nil then
		self.checkToggle.isOn = self.soulData.soulCid == SoulModule.curSoulData.soulCid
		self.checkToggle.enabled = not self.checkToggle.isOn
		self.TextFavorLv:GetComponent("Text").text = cfgSoulFavorRender.LoveStage
		self.TextFavorLv1:GetComponent("Text").text = tostring(self.soulData.favorLv)
		self.ImageFavorPer:GetComponent("Image").fillAmount = self.soulData:UpgradePercent()

		local favorExpLeft, favorExpRight = self.soulData:UpgradeFavor()

		self.TextFavor:GetComponent("Text").text = GirlUIApi:GetString("TextFavor", favorExpLeft, favorExpRight)

		local num = GiftModule.remainderGiveGiftNum

		if num < 0 then
			num = 0
		end

		self.TextPresentCount:GetComponent("Text").text = GirlUIApi:GetString("labSendGiftTxt", num)

		local openMaxLv = CfgDiscreteDataTable[6520064].Data[1]

		if lastSoulID ~= nil and self.soulData.soulCid == lastSoulID and lastSoulExp ~= nil then
			local curUpExp = 0

			if favorLv == lastSoulFavorLv then
				curUpExp = self.soulData.favor - lastSoulExp

				if favorLv == openMaxLv and favorExpRight < self.soulData.favor then
					curUpExp = curUpExp - favorExpRight
				end
			else
				self.signFavorUp = true

				for lv = lastSoulFavorLv, favorLv do
					local maxExpLv = self.soulData:GetSoulFavor(lv)

					if lv == lastSoulFavorLv then
						curUpExp = curUpExp + (maxExpLv - lastSoulExp)
					elseif lv == favorLv then
						curUpExp = curUpExp + self.soulData.favor
					else
						curUpExp = curUpExp + maxExpLv
					end
				end
			end

			if curUpExp > 0 and isShow then
				self:StartFavorUpTxtEffect(curUpExp)
			end
		end
	end

	self.fondleView:Update(lastSoulID, lastSoulFavorLv, lastSoulLoveStage, self.soulData, isShow)

	lastSoulFavorLv = favorLv
	lastSoulLoveStage = cfgSoulFavorRender.LoveStage

	if favorExp > self.soulData.favor then
		lastSoulExp = self.soulData.favor
	else
		lastSoulExp = self.soulData.favor - favorExp
	end

	self.btnFunctionView:UpdateView(self.soulData)

	if self.RectGift.activeInHierarchy then
		if lastSoulID ~= nil and self.soulData.soulCid ~= lastSoulID then
			self.isSelectFirst = true

			self:ShowGiftList()
		end

		self:ShowSelectGift()
	end

	lastSoulID = self.soulData.soulCid

	self:SetOathState()
	self:RefreshRandomSecretaryState()
end

function GirlUI:OnSoulOathSuccess(soulCid)
	if soulCid == self.soulData.soulCid then
		self:SetOathState()
	end
end

function GirlUI:SetOathState()
	local cfgSoulMarryData = GirlModule.GetSoulOathData(self.soulData.soulCid)
	local openLv = cfgSoulMarryData == nil and 0 or cfgSoulMarryData.MarryFavorLv

	self.BtnOath:SetActive(openLv <= self.soulData.favorLv)

	local girlPod = GirlModule.GetSoulGirlData(self.soulData.soulCid)

	self.BtnWhisper:SetActive(false)
	self.BtnOathRedImg:SetActive(false)
	self.OathImg:SetActive(false)

	if girlPod then
		self.BtnWhisper:SetActive(girlPod.activation)
		self.OathImg:SetActive(girlPod.activation)

		local path = GirlUIApi:GetString("BtnOathIconPath", girlPod.activation)

		AssetUtil.LoadImage(self, path, self.BtnOathIcon:GetComponent("Image"))

		if girlPod.activation then
			self.TextFavorLv:GetComponent("Text").text = GirlUIApi:GetString("TextFavorLv")
		end
	end
end

function GirlUI:OnClickBtnBack()
	SceneManager.ChangeScene(SceneID.MainCity)
end

function GirlUI:ShowGiftList()
	self.tabItems = {}
	self.itemSelectImgDic = {}

	for k, v in pairs(GiftModule.giftsDic) do
		local itemID = v.cfgGiftInfo.ItemId
		local haveNum = WarehouseModule.GetItemNumByCfgID(itemID)
		local isSpecificSoul = #v.cfgGiftInfo.SpecificSoul > 0
		local isSoulSelf = table.indexOf(v.cfgGiftInfo.SpecificSoul, self.soulData.soulCid) ~= -1

		if haveNum > 0 then
			if isSpecificSoul then
				if isSoulSelf then
					self.tabItems[#self.tabItems + 1] = v
				end
			else
				self.tabItems[#self.tabItems + 1] = v
			end
		end
	end

	table.sort(self.tabItems, function(a, b)
		local type1 = GiftModule.GetSoulGiftType(a.cfgGiftInfo.Id, self.soulData.soulCid)
		local type2 = GiftModule.GetSoulGiftType(b.cfgGiftInfo.Id, self.soulData.soulCid)
		local cfgData1 = CfgItemTable[a.cfgGiftInfo.ItemId]
		local cfgData2 = CfgItemTable[b.cfgGiftInfo.ItemId]

		if type1 == type2 then
			if cfgData1.Quality == cfgData2.Quality then
				return cfgData1.Id < cfgData2.Id
			end

			return cfgData1.Quality > cfgData2.Quality
		else
			return type2 < type1
		end
	end)

	local tabItemLen = #self.tabItems

	if tabItemLen <= 0 then
		self.GiftHaveNode:SetActive(false)
		self.GiftNoneNode:SetActive(true)
	else
		self.GiftHaveNode:SetActive(true)
		self.GiftNoneNode:SetActive(false)
	end

	if self.lastItemLen == nil or self.lastItemLen ~= tabItemLen or self.isSelectFirst then
		self.gridSlotComponent:Refresh(tabItemLen)
	else
		self.gridSlotComponent:RenderCells()
	end

	self.lastItemLen = tabItemLen
end

function GirlUI:UpdateItemCell(cell)
	local giftData = self.tabItems[cell.index + 1]

	if giftData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local itemGo = cell.gameObject
	local componentList = {}

	LuaCodeInterface.BindOutlet(itemGo, componentList)

	local selectImg = componentList.ImageChoose:GetComponent("Image").gameObject

	selectImg:SetActive(false)

	local itemObj
	local parentTransform = componentList.SlotParent.transform

	for i = 0, parentTransform.childCount - 1 do
		itemObj = parentTransform:GetChild(0).gameObject
	end

	if itemObj == nil then
		itemObj = UnityEngine.Object.Instantiate(self.commonSlotPrefab)
	end

	itemObj.transform:SetParent(parentTransform, false)
	itemObj:SetActive(true)

	local itemCell = ItemCell.PackageOrReuseView(self, itemObj, false)
	local giftData = self.tabItems[cell.index + 1]
	local itemData = CfgItemTable[giftData.cfgGiftInfo.ItemId]

	itemCell:SetItem(itemData)

	itemGo.name = cell.index + 1

	local num = WarehouseModule.GetItemNumByCfgID(giftData.cfgGiftInfo.ItemId)

	itemCell:SetNum(num)

	self.itemSelectImgDic[giftData.Id] = selectImg

	if selectItemData ~= nil and selectItemData.Id == giftData.Id then
		selectImg:SetActive(true)
	else
		selectImg:SetActive(false)
	end

	local isSpecificSoul = table.indexOf(giftData.cfgGiftInfo.SpecificSoul, self.soulData.soulCid) ~= -1

	componentList.Tag:SetActive(isSpecificSoul)
	UGUIUtil.SetText(componentList.TagTxt, GirlUIApi:GetString("TagTxt"))

	local type = GiftModule.GetSoulGiftType(giftData.cfgGiftInfo.Id, self.soulData.soulCid)

	componentList.TagImg1:SetActive(false)
	componentList.TagImg2:SetActive(false)
	componentList.TagImg3:SetActive(false)

	if type == Constant.SoulGiftType.Sick then
		componentList.TagImg1:SetActive(true)
	elseif type == Constant.SoulGiftType.Normal then
		componentList.TagImg2:SetActive(true)
	elseif type == Constant.SoulGiftType.Favor then
		componentList.TagImg3:SetActive(true)
	end

	local btn = itemCell.ViewGo:GetComponent("Button")

	if btn ~= nil then
		btn.interactable = false
	end

	if (selectCellObj == nil or self.isSelectFirst == true) and cell.index == 0 then
		self:SelectedItemCell(cell)
	end

	LuaCodeInterface.ClearOutlet(itemGo, componentList)
end

function GirlUI:SelectedItemCell(cell)
	selectCellObj = cell.gameObject
	selectItemData = self.tabItems[cell.index + 1]

	self:ShowSelectGift()
end

function GirlUI:ShowSelectGift()
	for k, v in pairs(self.itemSelectImgDic) do
		v:SetActive(false)
	end

	if selectItemData ~= nil then
		if self.itemSelectImgDic[selectItemData.Id] then
			self.itemSelectImgDic[selectItemData.Id]:SetActive(true)
		end

		local metaItem = CfgItemTable[selectItemData.cfgGiftInfo.ItemId]

		self.GiftSeleteNameTxt:GetComponent("Text").text = metaItem.Name

		local type = GiftModule.GetSoulGiftType(selectItemData.Id, self.soulData.soulCid)

		UGUIUtil.SetText(self.GiftType, GirlUIApi:GetString("GiftType", type))

		local giftFavorTypeValue = GiftModule.GetItemFavorType(selectItemData, self.soulData.soulCid)
		local d = CfgDiscreteDataTable[6506001].Data[giftFavorTypeValue]

		if d then
			local favorValue

			favorValue = d / 100 * selectItemData.cfgGiftInfo.Favor
			self.GiftSeleteFavorTxt:GetComponent("Text").text = "+" .. favorValue
		end
	end
end

function GirlUI:CloseFunction()
	self.rectFunctionTween:SetOnFinished(self.delegateResetTween)
	self.rectFunctionTween:PlayForward()
end

function GirlUI:OnResetTween()
	self.rectFunctionTween:RemoveOnFinished(self.delegateResetTween)
	self.rectSubPanelTween:SetOnFinished(self.delegateSubPanelTween)
	self.rectSubPanelTween:PlayForward()
end

function GirlUI:OnResetSubPanelTween()
	self.rectSubPanelTween:RemoveOnFinished(self.delegateSubPanelTween)
end

function GirlUI:SubPanelShrink()
	self.rectSubPanelTween:SetOnFinished(self.delegateSubCancelPanelTween)
	self.rectSubPanelTween:PlayReverse()
end

function GirlUI:OnResetSubCancelPanelTween()
	self.rectSubPanelTween:RemoveOnFinished(self.delegateSubCancelPanelTween)
	self.rectSubPanelTween.gameObject:SetActive(false)
	self.rectFunctionTween:SetOnFinished(self.delegateOpenFunctionPanelTween)
	self.rectFunctionTween:PlayReverse()
end

function GirlUI:OnOpenFunctionPanelTween()
	self.rectFunctionTween:RemoveOnFinished(self.delegateOpenFunctionPanelTween)
	self:DefaultCloseBtn()
end

function GirlUI:OnClickBtnGifts()
	self.rectSubPanelTween = self.RectGift:GetComponent("TweenPosition")

	self:CloseFunction()
	self.RectGift:SetActive(true)
	self:ShowGiftList()
	self:DefaultCloseBtn()
	self.BtnCloseGift:SetActive(true)
	self.Button:SetActive(false)
end

function GirlUI:OnClickBtnWhisper()
	local whisperList, openWhisperList = GirlModule.GetSoulWhisperListData(self.soulData.soulCid)

	if #whisperList == 0 then
		NoticeModule.ShowNotice(21043006)

		return
	end

	self.rectSubPanelTween = self.RectWhisper:GetComponent("TweenPosition")

	self:CloseFunction()
	self.whisperView:Open()
	self.whisperView:UpdateView(self.soulData.soulCid)
	self:DefaultCloseBtn()
	self.BtnCloseWhisper:SetActive(true)
	self.Button:SetActive(false)

	local cfgSoulMarryData = GirlModule.GetSoulOathData(self.soulData.soulCid)

	if cfgSoulMarryData ~= nil and cfgSoulMarryData.OpenUICVAction > 0 then
		GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.GirlAction, cfgSoulMarryData.OpenUICVAction))
	end
end

function GirlUI:OnClickBtnDress()
	self.rectSubPanelTween = self.goDressView:GetComponent("TweenPosition")

	self:CloseFunction()
	self.dressView:Open(self.soulData.soulCid)
	self:DefaultCloseBtn()
	self.BtnCloseDress:SetActive(true)
	self.Button:SetActive(false)
end

function GirlUI:OnClickBtnPresent()
	if GiftModule.remainderGiveGiftNum <= 0 then
		NoticeModule.ShowNotice(21043000)

		return
	end

	if selectItemData == nil then
		NoticeModule.ShowNotice(21043001)

		return
	end

	if #selectItemData.cfgGiftInfo.SpecificSoul > 0 and table.indexOf(selectItemData.cfgGiftInfo.SpecificSoul, self.soulData.soulCid) == -1 then
		local soulID = selectItemData.cfgGiftInfo.SpecificSoul[1]

		NoticeModule.ShowNoticeByType(1, GirlUIApi:GetString("TextSpecificSoul", CfgItemTable[selectItemData.cfgGiftInfo.ItemId].Name, CfgSoulTable[soulID].Name))

		local actionId = GiftModule.GetAction(selectItemData.Id, self.soulData.soulCid, true)

		if actionId > 0 then
			GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.Gift, actionId))
		end

		return
	end

	local type = GiftModule.GetSoulGiftType(selectItemData.Id, self.soulData.soulCid)

	if type == Constant.SoulGiftType.Sick then
		local actionId = GiftModule.GetAction(selectItemData.Id, self.soulData.soulCid, false)

		if actionId > 0 then
			GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.Gift, actionId))
		end

		return
	end

	if self.soulData.favorLv == self.soulData.favorMaxLv then
		NoticeModule.ShowNotice(21048004, self.delegateGift, nil, self)
	else
		self:OnGift()
	end
end

function GirlUI:OnGift()
	GiftModule.giveGift(self.soulData.soulCid, selectItemData.Id)
end

function GirlUI:OnClickBtnCloseGift()
	self.RectFunction.gameObject:SetActive(true)
	self:SubPanelShrink()
end

function GirlUI:OnClickBtnCloseDress()
	self.dressView:Close()
	self.RectFunction.gameObject:SetActive(true)
	self:SubPanelShrink()
end

function GirlUI:OnClickBtnCloseWhisper()
	self.whisperView:Close()
	self.RectFunction.gameObject:SetActive(true)
	self:SubPanelShrink()
end

function GirlUI:OnClickBtnCloseBackGround()
	self.backGroundView:Close()
	self.RectFunction.gameObject:SetActive(true)
	self:SubPanelShrink()
end

function GirlUI:OnClickBtnOath()
	GirlModule.RequestSoulOath(self.soulData.soulCid, function(soulCid, soulOathPOD)
		UIModule.Open(Constant.UIControllerName.SoulMarryConfirmUI, Constant.UILayer.UI, soulCid)
	end)
end

function GirlUI:OnBtnInteraction()
	UIModule.Open(Constant.UIControllerName.SoulInteractionUI, Constant.UILayer.UI, self.soulData.soulCid)
end

function GirlUI:ShowDefaultView()
	self.RectGift.gameObject:SetActive(false)
	self.dressView:SetActive(false)
	self.RectFunction.gameObject:SetActive(true)
	self.RectWhisper:SetActive(false)

	local tweenPos = self.RectFunction:GetComponent("TweenPosition")

	self.RectFunction.transform.anchoredPosition3D = tweenPos.from
	tweenPos = self.RectGift:GetComponent("TweenPosition")
	self.RectGift.transform.anchoredPosition3D = tweenPos.from
	tweenPos = self.goDressView:GetComponent("TweenPosition")
	self.goDressView.transform.anchoredPosition3D = tweenPos.from
	tweenPos = self.RectWhisper:GetComponent("TweenPosition")
	self.RectWhisper.transform.anchoredPosition3D = tweenPos.from
	tweenPos = self.RectBackGround:GetComponent("TweenPosition")
	self.RectBackGround.transform.anchoredPosition3D = tweenPos.from

	self:DefaultCloseBtn()
end

function GirlUI:ShowGiftView()
	self.RectGift.gameObject:SetActive(true)
	self.btnGifts.gameObject:SetActive(false)
	self.RectFunction.gameObject:SetActive(false)
	self:ShowGiftList()
	self:DefaultCloseBtn()
	self.BtnCloseGift:SetActive(true)
	self.Button:SetActive(false)
end

function GirlUI:OnGiftSuccess(giftCid, spAddition, addFavor)
	local itemID = CfgGiftTable[giftCid].ItemId

	if WarehouseModule.GetItemNumByCfgID(itemID) == 0 then
		self.isSelectFirst = true
	else
		self.isSelectFirst = false
	end

	if selectCellObj ~= nil then
		if self.EffectItem == nil then
			self.EffectItem = UnityEngine.Object.Instantiate(self.borderPrefab)

			self.EffectItem.transform:SetParent(self.UIController.gameObject.transform, false)
		end

		self.EffectItem:SetActive(false)

		self.EffectItem.transform.position = selectCellObj.transform:Find("Slot"):GetChild(0).position

		self.EffectItem:SetActive(true)

		local startPos = self.EffectItem.transform.position
		local endPos = self.EffectEndPos.transform.position

		self:FlyPropEffect(9000007, startPos, endPos)

		local timer = Timer.New(function()
			self:UpdateView(true)
			self:ShowGiftList()

			local isLoveUIStyleUp = false
			local cfgDataOld = SoulModule.GetCfgSoulFavor(self.soulData.soulCid, GiftModule.lastFavorLv)
			local cfgDataNow = SoulModule.GetCfgSoulFavor(self.soulData.soulCid, self.soulData.favorLv)

			if cfgDataNow.LoveUIStyle > cfgDataOld.LoveUIStyle then
				isLoveUIStyleUp = true
			end

			if not isLoveUIStyleUp then
				local actionId = GiftModule.GetAction(giftCid, self.soulData.soulCid, true)

				if actionId > 0 then
					GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.Gift, actionId))
				end
			end

			self.signFavorUp = false

			local maxLv = self.soulData.favorMaxLv
			local lv = self.soulData.favorLv

			if maxLv <= lv then
				local favorExpLeft, favorExpRight = self.soulData:UpgradeFavor()

				if favorExpLeft == favorExpRight then
					NoticeModule.ShowNoticeNoCallback(21043005)
				end
			end
		end, 1)

		timer:Start()
	end
end

function GirlUI:FlyPropEffect(effectID, startPos, targetPos)
	local canvas = self.View:GetComponent("Canvas")
	local effectInstanceID = GameEntry.Effect:PlayUIEffect(effectID, startPos, canvas.sortingOrder + 1)

	self.effectInstanceIDEndPosMap[effectInstanceID] = targetPos
end

function GirlUI:OnStartFlyEffect(sender, arg)
	local targetPos = self.effectInstanceIDEndPosMap[arg.EffectPlayID]

	if targetPos == nil then
		return
	end

	local uiEffect = GameEntry.Effect:GetEffectByPlayID(arg.EffectPlayID)
	local go = uiEffect.EntityGO

	self.goIDEffectIDMap[go:GetInstanceID()] = arg.EffectPlayID

	LuaCodeInterface.FlyOneGoTo(go, targetPos, 1, self.delegateEffectFlyComplete)
end

function GirlUI:StartFavorUpTxtEffect(upExp)
	self.LoveUp:SetActive(true)

	local LoveAlphaAnima = self.LoveUp:GetComponent("TweenAlpha")

	LoveAlphaAnima:ResetToBeginning()

	LoveAlphaAnima.enabled = true

	LoveAlphaAnima:SetOnFinished(self.delegateFavorIncreaseTxtTween)

	self.LoveUpTxt:GetComponent("Text").text = GirlUIApi:GetString("LoveUpTxt", upExp)
end

function GirlUI:EffectFlyComplete(gameObject)
	local effectID = self.goIDEffectIDMap[gameObject:GetInstanceID()]

	GameEntry.Effect:StopEffect(effectID)

	self.goIDEffectIDMap[gameObject:GetInstanceID()] = nil
	self.effectInstanceIDEndPosMap[effectID] = nil
end

function GirlUI:OnFinishTxtFavorTween()
	local loveAnima = self.LoveUp:GetComponent(typeof(UITweener))

	loveAnima:RemoveOnFinished(self.delegateFavorIncreaseTxtTween)

	loveAnima.enabled = false

	self.LoveUp:SetActive(false)
end

function GirlUI:OnCloseMemoryUI()
	self:UpdateRedPoint()
end

function GirlUI:OnCloseMemoryNewUI()
	self:UpdateRedPoint()
end

function GirlUI:OnFuncJump(cid)
	local cfgData = CfgFunctionTable[cid]

	if cfgData.FunctionType ~= Constant.Function.openGirlUI then
		return
	end

	local tabIndex = cfgData.Params[1]

	if tabIndex == 1 then
		self.btnFunctionView:OnBtnDating()
	elseif tabIndex == 2 then
		self:OnClickBtnGifts()
	elseif tabIndex == 3 then
		self.btnFunctionView:OnBtnNewMemory()
	elseif tabIndex == 4 then
		self.btnFunctionView:OnBtnMemory()
	end
end

function GirlUI:OnFinishedAchievement()
	NoticeModule.CheckNeedShowQueueTip()
end

function GirlUI:OnSelectSoul(soulCid)
	MemoryModule.currentSoulID = soulCid
	MemoryNewModule.currentSoulID = soulCid

	self:OnSoulDataChange(soulCid)
end

function GirlUI:DefaultCloseBtn()
	self.Button:SetActive(true)
	self.BtnCloseGift:SetActive(false)
	self.BtnCloseDress:SetActive(false)
	self.BtnCloseWhisper:SetActive(false)
	self.BtnCloseBackGround:SetActive(false)
end

function GirlUI:OnShowLevel2D(top)
	self.goLive2D:SetActive(top)
end

function GirlUI:OnBtnSoulLibrary()
	TownLibraryModule.OpenLibrary(function()
		self.live2DView:Pause()

		local townLibrarySoulData = TownLibraryModule.GetSoulDataBySoulCid(self.soulData.soulCid)

		UIModule.Open(Constant.UIControllerName.LibrarySoulInfoUI, Constant.UILayer.UI, {
			townLibrarySoulData,
			false
		})
	end)
end

function GirlUI:OnBtnGuide()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 3000)
end

function GirlUI:UpdatePeriodOfTime()
	self:LoadGirlBG(GirlBackGroundModule.currentUseBG)
end

function GirlUI:OnUpdateGirlBG(cid)
	self:LoadGirlBG(cid)
end

function GirlUI:OnRandomSecretaryState()
	self:RefreshRandomSecretaryState()
end

function GirlUI:LoadGirlBG(cid)
	local path, bgm, environmentalSound = GirlBackGroundModule.GetBackGroundPath(cid)

	if self.showBGPath == path then
		return
	end

	local package, envSoundCidList

	if environmentalSound ~= 0 then
		envSoundCidList = {
			environmentalSound
		}
	end

	if bgm then
		package = SoundPackageData.New(bgm, envSoundCidList)
	end

	if self.SoundPackageId and self.SoundPackageId ~= 0 then
		SoundPackagePlayer.Replace(self.SoundPackageId, package)
	else
		self.SoundPackageId = SoundPackagePlayer.Add(package)
	end

	AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, self.OnLoadFailed, {
		type = "LoadBG"
	})
end

function GirlUI:CheckBtnRule()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.GIRL_ON_DUTY)

	self.BtnRule:SetActive(result)
end

function GirlUI:OnBtnRule()
	UIModule.Open(Constant.UIControllerName.RandomSecretaryUI, Constant.UILayer.UI)
end

function GirlUI:OnUnlockFunction()
	self:CheckBtnRule()
	self:CheckBtnBackGround()
end

function GirlUI:CheckBtnBackGround()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.GIRL_BACKGROUND)

	self.BtnBackGround:SetActive(result)
end

function GirlUI:OnBtnBackGround()
	self.rectSubPanelTween = self.RectBackGround:GetComponent("TweenPosition")

	self:CloseFunction()
	self.backGroundView:Open()
	self.backGroundView:UpdateView()
	self:DefaultCloseBtn()
	self.BtnCloseBackGround:SetActive(true)
	self.Button:SetActive(false)
end

function GirlUI:RefreshRandomSecretaryState()
	local isOpen, dataList = RandomSecretaryModule.GetRandomDressUpRotateList()

	self.RandomSecretaryOpen:SetActive(isOpen)
	self.RandomSecretaryOff:SetActive(not isOpen)
end

function GirlUI:Pause()
	self.live2DView:Pause()
end

function GirlUI:OnResumeL2D()
	self.live2DView:OnResumeL2D()
end

return GirlUI
