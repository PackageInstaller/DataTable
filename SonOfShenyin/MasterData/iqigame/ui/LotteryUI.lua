-- chunkname: @IQIGame\\UI\\LotteryUI.lua

local UIViewObjectPool = require("IQIGame/UI/Common/UIViewObjectPool")
local RoleCardPoolView = require("IQIGame/UI/Lottery/LotteryCardPoolView/RoleCardPoolView")
local SkillCardPoolView = require("IQIGame/UI/Lottery/LotteryCardPoolView/SkillCardPoolView")
local LotteryDrawResultView = require("IQIGame/UI/Lottery/LotteryDrawResultView")
local LotterySelectDrawResultView = require("IQIGame/UI/Lottery/LotterySelectDrawResultView")
local LotteryTemplateController = require("IQIGame/UI/Lottery/Template/LotteryTemplateController")
local LotteryAppointedControl = require("IQIGame/UI/Lottery/Template/LotteryAppointedControl")
local CardPoolTabItem = {
	cardJackpotID = 0
}

function CardPoolTabItem.New(view, onSelectFunc)
	local obj = Clone(CardPoolTabItem)

	obj:__Init(view, onSelectFunc)

	return obj
end

function CardPoolTabItem:__Init(view, onSelectFunc)
	self.view = view
	self.onSelectFunc = onSelectFunc

	LuaCodeInterface.BindOutlet(self.view, self)

	function self.delegateOnItemClick()
		self:OnItemClick()
	end

	self.view:GetComponent("Button").onClick:AddListener(self.delegateOnItemClick)
end

function CardPoolTabItem:Show(cardJackpotID)
	self.__isGroupTab = false
	self.cardJackpotID = cardJackpotID
	self.view.gameObject.name = "Table_" .. tostring(cardJackpotID)

	local cardJackpotData = CfgCardJackpotTable[cardJackpotID]
	local showTag = cardJackpotData.CardLabel == 1

	self.onTagItem.gameObject:SetActive(showTag)
	self.offTagItem.gameObject:SetActive(showTag)

	self.text1:GetComponent("Text").text = cardJackpotData.Name
	self.text2:GetComponent("Text").text = cardJackpotData.Name

	self:ChangeSelect(false)
	self.view.gameObject:SetActive(true)
	self:RefreshFreeRedDot()
end

function CardPoolTabItem:ShowByGroupCid(groupCid)
	self.__isGroupTab = true
	self.cardJackpotID = groupCid
	self.view.gameObject.name = "Table_" .. tostring(groupCid)

	local cardGroupData = CfgCardGroupTable[groupCid]
	local showTag = cardGroupData.CardLabel == 1

	self.onTagItem.gameObject:SetActive(showTag)
	self.offTagItem.gameObject:SetActive(showTag)

	self.text1:GetComponent("Text").text = cardGroupData.Name
	self.text2:GetComponent("Text").text = cardGroupData.Name

	self:ChangeSelect(false)
	self.view.gameObject:SetActive(true)
	self:RefreshFreeRedDot()
end

function CardPoolTabItem:Hide()
	self.cardJackpotID = 0

	self.view.gameObject:SetActive(false)
end

function CardPoolTabItem:Dispose()
	self.view:GetComponent("Button").onClick:RemoveListener(self.delegateOnItemClick)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

function CardPoolTabItem:OnItemClick()
	self.onSelectFunc(self.cardJackpotID, self.__isGroupTab)
end

function CardPoolTabItem:RefreshFreeRedDot()
	if self.__isGroupTab then
		self.redDotGo.gameObject:SetActive(false)

		return
	end

	if self.cardJackpotID == 0 then
		self.redDotGo.gameObject:SetActive(false)

		return
	end

	local freeCnt = LotteryModule.GetCardFreeCount(self.cardJackpotID)
	local active = freeCnt > 0

	self.redDotGo.gameObject:SetActive(active)
end

function CardPoolTabItem:ChangeSelect(isSelect)
	self.on.gameObject:SetActive(isSelect)
	self.off.gameObject:SetActive(not isSelect)
end

local LotteryUI = {
	rookieCardCloseTimer = 0,
	showRookieCardCloseText = false,
	cardJackpotID = 0,
	cardPoolViewTable = {}
}

LotteryUI = Base:Extend("LotteryUI", "IQIGame.Onigao.UI.LotteryUI", LotteryUI)

function LotteryUI:OnInit()
	self:__OnInit()
end

function LotteryUI:GetPreloadAssetPaths()
	return nil
end

function LotteryUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LotteryUI:IsManualShowOnOpen(userData)
	return false
end

function LotteryUI:GetBGM(userData)
	return LotteryModule.GetLotteryBGM()
end

function LotteryUI:OnOpen(userData)
	local selectCardJackpotID = -99

	if userData ~= nil and userData.cardJackpotID ~= nil then
		selectCardJackpotID = userData.cardJackpotID
	end

	self:__OnShow(selectCardJackpotID)
end

function LotteryUI:OnClose(userData)
	if self.refreshTimer then
		self.refreshTimer:Stop()

		self.refreshTimer = nil
	end
end

function LotteryUI:OnAddListeners()
	self.rewardListBtn:GetComponent("Button").onClick:AddListener(self.delegateOnRewardListBtnClick)
	self.recordListBtn:GetComponent("Button").onClick:AddListener(self.delegateOnRecordListBtnClick)
	self.tokenExchangeBtn:GetComponent("Button").onClick:AddListener(self.delegateOnTokenExchangeBtnClick)
	self.onceBtn:GetComponent("Button").onClick:AddListener(self.delegateOnOnceButtonClick)
	self.tenBtn:GetComponent("Button").onClick:AddListener(self.delegateOnTenButtonClick)
	self.showResultBtn:GetComponent("Button").onClick:AddListener(self.delegateOnShowResultButtonClick)
	self.buttonFreeOnce:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonFreeOnce)
	self.buttonFreeTen:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonFreeTen)
	self.buttonShopFree:GetComponent("Button").onClick:AddListener(self.delegateOnClickShopFreeBtn)
	EventDispatcher.AddEventListener(EventID.LotteryResultEvent, self.delegateOnDrawResult)
	EventDispatcher.AddEventListener(EventID.LotteryDrawResultShowComplete, self.delegateOnLotteryDrawResultShowComplete)
	EventDispatcher.AddEventListener(EventID.LotteryNotifyUpdate, self.delegateLotteryUpdate)
	EventDispatcher.AddEventListener(EventID.LotteryAddOrRemove, self.delegateLotteryAddOrRemove)
	EventDispatcher.AddEventListener(EventID.BuyItemResult, self.delegateBuyItemResult)
	EventDispatcher.AddEventListener(EventID.LotteryMainBuyDrawing, self.buyDrawingDelegate)
	EventDispatcher.AddEventListener(EventID.SwitchLotteryBGM, self.delegateOnSwitchBGM)
	EventDispatcher.AddEventListener(EventID.LotteryNotifyDrawPoolUpdate, self.delegateOnLotteryNotifyDrawPoolUpdate)
	EventUtil.AddEventListener(self, EventID.SetLotteryAppointedViewActive, self.__OnSetLotteryAppointedViewActive)
	UIEventUtil.AddClickEventListener_Button(self, "HeroIntroduceUIBtn", self.__OnHeroIntroduceUIBtnClick)
end

function LotteryUI:OnRemoveListeners()
	self.rewardListBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnRewardListBtnClick)
	self.recordListBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnRecordListBtnClick)
	self.tokenExchangeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnTokenExchangeBtnClick)
	self.onceBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnOnceButtonClick)
	self.tenBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnTenButtonClick)
	self.showResultBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnShowResultButtonClick)
	self.buttonFreeOnce:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonFreeOnce)
	self.buttonFreeTen:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonFreeTen)
	self.buttonShopFree:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickShopFreeBtn)
	EventDispatcher.RemoveEventListener(EventID.LotteryResultEvent, self.delegateOnDrawResult)
	EventDispatcher.RemoveEventListener(EventID.LotteryDrawResultShowComplete, self.delegateOnLotteryDrawResultShowComplete)
	EventDispatcher.RemoveEventListener(EventID.LotteryNotifyUpdate, self.delegateLotteryUpdate)
	EventDispatcher.RemoveEventListener(EventID.LotteryAddOrRemove, self.delegateLotteryAddOrRemove)
	EventDispatcher.RemoveEventListener(EventID.BuyItemResult, self.delegateBuyItemResult)
	EventDispatcher.RemoveEventListener(EventID.LotteryMainBuyDrawing, self.buyDrawingDelegate)
	EventDispatcher.RemoveEventListener(EventID.SwitchLotteryBGM, self.delegateOnSwitchBGM)
	EventDispatcher.RemoveEventListener(EventID.LotteryNotifyDrawPoolUpdate, self.delegateOnLotteryNotifyDrawPoolUpdate)
	EventUtil.ClearEventListener(self)
	UIEventUtil.ClearEventListener(self)
end

function LotteryUI:OnPause()
	return
end

function LotteryUI:OnResume()
	return
end

function LotteryUI:OnCover()
	return
end

function LotteryUI:OnReveal()
	return
end

function LotteryUI:OnRefocus(userData)
	return
end

function LotteryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LotteryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LotteryUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LotteryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LotteryUI:OnDestroy()
	if self.refreshTimer then
		self.refreshTimer:Stop()

		self.refreshTimer = nil
	end

	for _, _poolView in pairs(self.cardPoolViewTable) do
		_poolView:Dispose()
	end

	self.cardPoolTabPool:Dispose(function(_item)
		_item:Dispose()
	end)
	self.moneyCell:Dispose()
	self.commonReturnBtn:Dispose()
	self.drawResultView:Dispose()
end

function LotteryUI:__OnInit()
	self:__InitDelegateFunc()
	self.toggleItemTemplate.gameObject:SetActive(false)

	self.cardPoolTabPool = UIViewObjectPool.New(self.toggleItemTemplate, nil, function(_view)
		return CardPoolTabItem.New(_view, function(_cardJackpotID, _isGroupCid)
			self:__OnTableItemSelected(_cardJackpotID, _isGroupCid)
		end)
	end)
	self.moneyCell = CurrencyCell.New(self.moneyPanel)
	self.commonReturnBtn = CommonReturnBtn.New(self.commonReturnBtn, self)
	self.drawResultView = LotteryDrawResultView.New(self.drawResultView)
	self.selectDrawResultView = LotterySelectDrawResultView.New(self.selectDrawResultPanel)
	self.appointedControl = LotteryAppointedControl.New(self.AppointedRoot)
end

function LotteryUI:__InitCardPoolViews()
	self.cardPoolViewTable = {}

	for i = 0, self.cardMouldRoot.transform.childCount - 1 do
		local poolView = self.cardMouldRoot.transform:GetChild(i).gameObject

		if poolView.name == LotteryUIApi:GetHeroPoolUINodeName() then
			self.cardPoolViewTable[poolView.name] = RoleCardPoolView.New(poolView)
		elseif poolView.name == LotteryUIApi:GetDIYPoolUINodeName() then
			self.cardPoolViewTable[poolView.name] = SkillCardPoolView.New(poolView)
		end
	end
end

function LotteryUI:__InitDelegateFunc()
	function self.delegateOnRewardListBtnClick()
		self:__OnRewardListBtnClick()
	end

	function self.delegateOnRecordListBtnClick()
		self:__OnRecordListBtnClick()
	end

	function self.delegateOnTokenExchangeBtnClick()
		self:__OnTokenExchangeBtnClick()
	end

	function self.delegateOnOnceButtonClick()
		self:__OnOnceButtonClick()
	end

	function self.delegateOnTenButtonClick()
		self:__OnTenButtonClick()
	end

	function self.delegateOnShowResultButtonClick()
		self:__OnShowResultButtonClick()
	end

	function self.delegateOnDrawResult(drawResultPOD)
		self:__OnDrawResult(drawResultPOD)
	end

	function self.delegateOnLotteryDrawResultShowComplete(args)
		self:__OnLotteryDrawResultShowComplete(args)
	end

	function self.delegateLotteryUpdate()
		self:__OnRefreshStateShow()
	end

	function self.delegateLotteryAddOrRemove()
		self:__RefreshCardPoolShow(self:__GetCardJackpotID())
	end

	function self.delegateBuyItemResult()
		return
	end

	function self.buyDrawingDelegate()
		if not LotteryModule.isExchangedDrawing then
			return
		end

		if LotteryModule.waitDrawWithByItem == nil then
			return
		end

		LotteryModule.RequestDraw(LotteryModule.waitDrawWithByItem.cardJackpotID, LotteryModule.waitDrawWithByItem.count)
	end

	function self.delegateOnSwitchBGM(bgmCid)
		self:__OnSwitchBGM(bgmCid)
	end

	function self.delegateOnClickButtonFreeOnce()
		self:OnClickButtonFreeOnce()
	end

	function self.delegateOnClickButtonFreeTen()
		self:OnClickButtonFreeTen()
	end

	function self.delegateOnLotteryNotifyDrawPoolUpdate()
		self:__OnRefreshFreeRedDot()
	end

	function self.delegateOnClickShopFreeBtn()
		self:__OnClickShopFreeBtn()
	end
end

function LotteryUI:__OnSwitchBGM(bgmCid)
	self.UIController:ChangeBGM(bgmCid)
end

function LotteryUI:OnClickButtonFreeOnce()
	LotteryModule.SendDraw(self:__GetCardJackpotID(), 1)
end

function LotteryUI:OnClickButtonFreeTen()
	LotteryModule.SendDraw(self:__GetCardJackpotID(), 10)
end

function LotteryUI:__OnRewardListBtnClick()
	UIModule.Open(Constant.UIControllerName.LotteryTipsUI, Constant.UILayer.UI, {
		cardJackpotID = self:__GetCardJackpotID()
	})
end

function LotteryUI:__OnRecordListBtnClick()
	UIModule.Open(Constant.UIControllerName.LotteryRecordsUI, Constant.UILayer.UI, self:__GetCardJackpotID())
end

function LotteryUI:__OnTokenExchangeBtnClick()
	local jumpCid = LotteryUIApi:GetShopButtonJumpCid()

	if jumpCid == 0 then
		return
	end

	JumpModule.Jump(jumpCid)
end

function LotteryUI:__OnOnceButtonClick()
	local cardJackpotID = self:__GetCardJackpotID(true)

	if cardJackpotID <= 0 then
		NoticeModule.ShowNotice(90002)

		return
	end

	LotteryModule.RequestDraw(cardJackpotID, 1)
end

function LotteryUI:__OnTenButtonClick()
	local cardJackpotID = self:__GetCardJackpotID(true)

	if cardJackpotID <= 0 then
		NoticeModule.ShowNotice(90002)

		return
	end

	LotteryModule.RequestDraw(cardJackpotID, 10)
end

function LotteryUI:__OnShowResultButtonClick()
	local poolData = LotteryModule.GetPoolDataByType(self:__GetCardJackpotID())

	self.drawResultView:ShowHistoryDrawResult(self:__GetCardJackpotID(), {
		drawResults = poolData.historyItems
	})
end

function LotteryUI:__OnClickShopFreeBtn()
	JumpModule.Jump(LotteryUIApi:GetShopFreeButtonJumpCid())
end

function LotteryUI:__OnDrawResult(drawResultPOD)
	self.drawResultView:Show(self:__GetCardJackpotID(), drawResultPOD)
end

function LotteryUI:__OnShow(selectCardJackpotID)
	self.drawResultView:Hide()
	self.selectDrawResultView:Hide()
	self:__RefreshCardPoolShow(selectCardJackpotID)
end

function LotteryUI:__RefreshCardPoolShow(selectCardJackpotID)
	self.cardPoolTabPool:ForItems(function(_item)
		_item:Hide()
	end)

	self.__ResortRookieCard = false

	local isCardJackpotOpen = false
	local tempCardJackpotID = -99
	local rookieCardCid = 0
	local openPool = LotteryModule.GetIsOpenPool()
	local __showNormalPool = {}
	local __showGroupPool = {}

	ForPairs(openPool, function(_, _drawPOD)
		local cardCfg = CfgUtil.GetCardJackpotWithID(_drawPOD.id)

		if not cardCfg.RookieCard then
			local endTime = TryToNumber(_drawPOD.endTime, 0)

			if endTime > 0 then
				local span = endTime - tonumber(PlayerModule.GetServerTimeByMs())

				if span <= 0 then
					return
				end
			end
		end

		if cardCfg.CardGroupID ~= 0 then
			if __showGroupPool[cardCfg.CardGroupID] == nil then
				__showGroupPool[cardCfg.CardGroupID] = {}
			end

			table.insert(__showGroupPool[cardCfg.CardGroupID], _drawPOD.id)

			if selectCardJackpotID == _drawPOD.id then
				selectCardJackpotID = cardCfg.CardGroupID
			end
		else
			table.insert(__showNormalPool, _drawPOD)
		end
	end)
	ForPairs(__showNormalPool, function(_, _drawPOD)
		local cardCfg = CfgUtil.GetCardJackpotWithID(_drawPOD.id)

		if cardCfg.RookieCard then
			local confirmTime = tonumber(_drawPOD.confirmTime)

			if confirmTime == nil then
				confirmTime = 0
			end

			if confirmTime > 0 then
				local difference = (PlayerModule.GetServerTimeByMs() - confirmTime) / 1000

				if difference >= LotteryUIApi:GetRookieCardPoolCloseTimeS() then
					return
				end

				rookieCardCid = _drawPOD.id

				return
			end

			self.__ResortRookieCard = true
		end

		local tabItem = self.cardPoolTabPool:GetFree(function(_item)
			return not _item.view.gameObject.activeSelf
		end)

		tabItem:Show(_drawPOD.id)

		if tempCardJackpotID == -99 then
			tempCardJackpotID = _drawPOD.id
		end

		if not isCardJackpotOpen then
			isCardJackpotOpen = selectCardJackpotID == _drawPOD.id
		end
	end)
	ForPairs(__showGroupPool, function(_groupCid, _drawList)
		local tabItem = self.cardPoolTabPool:GetFree(function(_item)
			return not _item.view.gameObject.activeSelf
		end)

		tabItem:ShowByGroupCid(_groupCid)

		if tempCardJackpotID == -99 then
			tempCardJackpotID = _groupCid
		end

		if not isCardJackpotOpen then
			isCardJackpotOpen = selectCardJackpotID == _groupCid
		end
	end)

	if rookieCardCid ~= 0 then
		local tabItem = self.cardPoolTabPool:GetFree(function(_item)
			return not _item.view.gameObject.activeSelf
		end)

		tabItem:Show(rookieCardCid)

		if tempCardJackpotID == -99 then
			tempCardJackpotID = rookieCardCid
		end

		isCardJackpotOpen = isCardJackpotOpen or selectCardJackpotID == rookieCardCid
	end

	if not isCardJackpotOpen then
		selectCardJackpotID = tempCardJackpotID
	end

	if selectCardJackpotID == -99 then
		logError("卡池数据为nil,请检查...")
		UIModule.Close(Constant.UIControllerName.LotteryUI)

		return
	end

	self:__OnChangeSelectCardJackpot_New(selectCardJackpotID)
end

function LotteryUI:__OnRefreshFreeRedDot()
	self.cardPoolTabPool:ForItems(function(_item)
		_item:RefreshFreeRedDot()
	end)

	local view = self.cardPoolViewTable[self.cardJackpotID]

	if view == nil then
		return
	end

	view:RefreshMustGuaranteeText()
end

function LotteryUI:__OnTableItemSelected(cardJackpotID, _isGroupCid)
	if self.cardJackpotID == cardJackpotID then
		return
	end

	self:__OnChangeSelectCardJackpot_New(cardJackpotID, _isGroupCid)
end

function LotteryUI:__OnChangeSelectCardJackpot_New(cardJackpotID, isGroupCid)
	if self.cardPoolViewTable[cardJackpotID] == nil then
		self:__LoadCardJackpotView(cardJackpotID, isGroupCid, function(_cardJackpotID, _prefab, _isGroupCid)
			self.cardPoolViewTable[_cardJackpotID] = LotteryTemplateController.New(_cardJackpotID, _prefab, _isGroupCid)

			self:__RefreshShow(cardJackpotID, _isGroupCid)
		end)
	else
		self:__RefreshShow(cardJackpotID, isGroupCid)
	end
end

function LotteryUI:__LoadCardJackpotView(cardJackpotID, isGroupCid, callback)
	local showPrefabPath = ""

	if isGroupCid then
		local cardShowGroupData = CfgCardGroupTable[cardJackpotID]

		showPrefabPath = cardShowGroupData.ShowPrefab
	else
		local cardJackpotData = CfgCardJackpotTable[cardJackpotID]

		showPrefabPath = cardJackpotData.ShowPrefab
	end

	if LuaUtility.StrIsNullOrEmpty(showPrefabPath) then
		logError("抽卡界面卡池未正确配置预制体路径", cardJackpotID)

		return
	end

	AssetUtil.LoadAsset(self, showPrefabPath, function(_, _assetUrl, _asset, _duration, _userData)
		local obj = GameObject.Instantiate(_asset)

		obj.transform:SetParent(self.cardMouldRoot.transform, false)

		obj.transform.localPosition = Vector3.zero
		obj.transform.localScale = Vector3.one

		if callback ~= nil then
			callback(cardJackpotID, obj, isGroupCid)
		end
	end, function(_assetName, _status, _errorMessage, _userData)
		logError("抽卡界面加载卡池预制体失败 {0} -> {1}", cardJackpotID, showPrefabPath)
	end)
end

function LotteryUI:__RefreshShow(cardJackpotID, isGroupCid)
	self.isGroupCid = isGroupCid
	self.cardJackpotID = cardJackpotID

	self:__OnSetLotteryAppointedViewActive(false)
	self.cardPoolTabPool:ForItems(function(_item)
		if not _item.view.gameObject.activeSelf then
			return
		end

		_item:ChangeSelect(_item.cardJackpotID == cardJackpotID)
	end)
	ForPairs(self.cardPoolViewTable, function(_cardJackpotID, _view)
		if _cardJackpotID == cardJackpotID then
			_view:Show()
		else
			_view:Hide()
		end
	end)
	self:__OnRefreshStateShow()
	self:__RefreshTime()

	if self.refreshTimer then
		self.refreshTimer:Stop()

		self.refreshTimer = nil
	end

	self.refreshTimer = Timer.New(function()
		self:__RefreshTime()
	end, 1, -1)

	self.refreshTimer:Start()
end

function LotteryUI:__OnRefreshStateShow()
	if self.isGroupCid then
		self:__OnRefreshGroupShowStateShow()

		return
	end

	local cardJackpotData = CfgCardJackpotTable[self:__GetCardJackpotID()]

	self.moneyCell:RefreshItem(cardJackpotData.TopMoneyID)

	local costItemCid = cardJackpotData.OneTime[1]
	local costItemCfg = CfgItemTable[costItemCid]
	local costImgPath = UIGlobalApi.GetIconPath(costItemCfg.BigIcon)

	AssetUtil.LoadImage(self, costImgPath, self.onceCostImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, costImgPath, self.tenCostImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, costImgPath, self.showResultCostImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, costImgPath, self.freeOneCostImage:GetComponent("Image"))
	AssetUtil.LoadImage(self, costImgPath, self.freeTenCostImage:GetComponent("Image"))

	local _canOne, _canTen = LotteryModule.GetCardPoolDrawType(self:__GetCardJackpotID())

	self.onceBtn.gameObject:SetActive(_canOne)
	self.tenBtn.gameObject:SetActive(_canTen)

	if not cardJackpotData.RookieCard then
		self:HideRookieCardCloseText()
		self.showResultBtn.gameObject:SetActive(false)
		self.tipsRoot.gameObject:SetActive(true)
		self.recordListBtn.gameObject:SetActive(true)
		self.tokenExchangeBtn.gameObject:SetActive(true)
		self.buttonShopFree.gameObject:SetActive(true)
		LuaUtility.SetGameObjectShow(self.buttonFreeOnce, false)
		LuaUtility.SetGameObjectShow(self.buttonFreeTen, false)
		LuaUtility.SetGameObjectShow(self.freetipstext, false)

		local drawFreeCount = LotteryModule.GetCardFreeCount(self.cardJackpotID)

		LuaUtility.SetGameObjectShow(self.buttonFreeOnce, drawFreeCount > 0 and drawFreeCount < 10)
		LuaUtility.SetGameObjectShow(self.buttonFreeTen, drawFreeCount >= 10)
		LuaUtility.SetGameObjectShow(self.onceBtn, not (drawFreeCount > 0))
		LuaUtility.SetGameObjectShow(self.tenBtn, not (drawFreeCount > 0))
		LuaUtility.SetGameObjectShow(self.freetipstext, drawFreeCount > 0)
		LuaUtility.SetText(self.textFreeCount, drawFreeCount)

		return
	end

	local poolData = LotteryModule.GetPoolDataByType(self:__GetCardJackpotID())

	LuaUtility.SetGameObjectShow(self.buttonFreeOnce, false)
	LuaUtility.SetGameObjectShow(self.buttonFreeTen, false)
	LuaUtility.SetGameObjectShow(self.freetipstext, false)
	self.recordListBtn.gameObject:SetActive(false)
	self.tokenExchangeBtn.gameObject:SetActive(false)
	self.buttonShopFree.gameObject:SetActive(false)
	self.tipsRoot.gameObject:SetActive(false)

	if #poolData.currentItems == 0 and #poolData.historyItems == 0 then
		self.showResultBtn.gameObject:SetActive(false)

		return
	end

	self.onceBtn.gameObject:SetActive(false)
	self.tenBtn.gameObject:SetActive(false)
	self.showResultBtn.gameObject:SetActive(true)

	local confirmTime = tonumber(poolData.confirmTime)

	if confirmTime > 0 then
		self:ShowRookieCardCloseText(confirmTime)
	else
		self:HideRookieCardCloseText()
	end
end

function LotteryUI:__OnRefreshGroupShowStateShow()
	local cardGroupCfg = CfgCardGroupTable[self.cardJackpotID]
	local cardJackpotID = cardGroupCfg.CardJackpotID[1]
	local cardJackpotData = CfgCardJackpotTable[cardJackpotID]

	self.moneyCell:RefreshItem(cardJackpotData.TopMoneyID)

	local costItemCid = cardJackpotData.OneTime[1]
	local costItemCfg = CfgItemTable[costItemCid]
	local costImgPath = UIGlobalApi.GetIconPath(costItemCfg.BigIcon)

	AssetUtil.LoadImage(self, costImgPath, self.onceCostImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, costImgPath, self.tenCostImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, costImgPath, self.showResultCostImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, costImgPath, self.freeOneCostImage:GetComponent("Image"))
	AssetUtil.LoadImage(self, costImgPath, self.freeTenCostImage:GetComponent("Image"))

	local _canOne, _canTen = LotteryModule.GetCardPoolDrawType(cardJackpotID)

	self.onceBtn.gameObject:SetActive(_canOne)
	self.tenBtn.gameObject:SetActive(_canTen)
	self:HideRookieCardCloseText()
	self.showResultBtn.gameObject:SetActive(false)
	self.tipsRoot.gameObject:SetActive(true)
	self.recordListBtn.gameObject:SetActive(true)
	self.tokenExchangeBtn.gameObject:SetActive(true)
	self.buttonShopFree.gameObject:SetActive(true)
	LuaUtility.SetGameObjectShow(self.buttonFreeOnce, false)
	LuaUtility.SetGameObjectShow(self.buttonFreeTen, false)
	LuaUtility.SetGameObjectShow(self.freetipstext, false)
	LuaUtility.SetGameObjectShow(self.buttonFreeOnce, false)
	LuaUtility.SetGameObjectShow(self.buttonFreeTen, false)
	LuaUtility.SetGameObjectShow(self.freetipstext, false)
end

function LotteryUI:__OnChangeSelectCardJackpot(cardJackpotID, playAnim)
	self.cardJackpotID = cardJackpotID

	self.cardPoolTabPool:ForItems(function(_item)
		if not _item.view.gameObject.activeSelf then
			return
		end

		_item:ChangeSelect(_item.cardJackpotID == cardJackpotID)
	end)
	self:__RefreshSelectPoolShow(playAnim)
	self:__RefreshTime()

	if self.refreshTimer then
		self.refreshTimer:Stop()

		self.refreshTimer = nil
	end

	self.refreshTimer = Timer.New(function()
		self:__RefreshTime()
	end, 1, -1)

	self.refreshTimer:Start()
end

function LotteryUI:__RefreshSelectPoolShow(playAnim)
	self.canCheck = not playAnim and true or false

	local cardJackpotData = CfgCardJackpotTable[self.cardJackpotID]
	local showView, hideView

	local function __viewLogic(_viewName, _view)
		local active = cardJackpotData.ShowPrefab == _viewName

		if not playAnim then
			if active then
				_view:Show(self.cardJackpotID, false, nil)
			else
				_view:Hide(false, nil)
			end
		else
			if active then
				showView = _view
			end

			if _view.view.gameObject.activeSelf then
				hideView = _view
			end
		end
	end

	ForPairs(self.cardPoolViewTable, __viewLogic)

	if playAnim then
		local function __showEnd()
			self.canCheck = true
		end

		local function __delayPlayShow()
			self.firstDelayTime = nil

			showView:Show(self.cardJackpotID, true, __showEnd)
		end

		if hideView == nil then
			self.firstDelayTime = Timer.New(__delayPlayShow, LotteryUIApi:GetFirstShowViewDelayTime())

			self.firstDelayTime:Start()
		else
			hideView:Hide(true, function()
				showView:Show(self.cardJackpotID, true, __showEnd)
			end)
		end
	end

	self.moneyCell:RefreshItem(cardJackpotData.TopMoneyID)

	local costItemCid = cardJackpotData.OneTime[1]
	local costItemCfg = CfgItemTable[costItemCid]
	local costImgPath = UIGlobalApi.GetIconPath(costItemCfg.BigIcon)

	AssetUtil.LoadImage(self, costImgPath, self.onceCostImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, costImgPath, self.tenCostImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, costImgPath, self.showResultCostImg:GetComponent("Image"))

	local _canOne, _canTen = LotteryModule.GetCardPoolDrawType(self.cardJackpotID)

	self.onceBtn.gameObject:SetActive(_canOne)
	self.tenBtn.gameObject:SetActive(_canTen)

	local poolData = LotteryModule.GetPoolDataByType(self.cardJackpotID)

	if not cardJackpotData.RookieCard then
		self.showResultBtn.gameObject:SetActive(false)
		self.tipsRoot.gameObject:SetActive(true)
		self.recordListBtn.gameObject:SetActive(true)
		self.tokenExchangeBtn.gameObject:SetActive(true)
		self.buttonShopFree.gameObject:SetActive(true)
		LuaUtility.SetGameObjectShow(self.buttonFreeOnce, false)
		LuaUtility.SetGameObjectShow(self.buttonFreeTen, false)
		LuaUtility.SetGameObjectShow(self.freetipstext, false)

		if poolData.activityId ~= 0 and poolData.isFree then
			local cfgActivity = CfgUtil.GetCfgActivityDataWithID(poolData.activityId)

			if cfgActivity then
				local drawFreeCount = cfgActivity.ExtraParam[3] - poolData.dayFreeTime

				LuaUtility.SetGameObjectShow(self.buttonFreeOnce, drawFreeCount > 0 and drawFreeCount < 10)
				LuaUtility.SetGameObjectShow(self.buttonFreeTen, drawFreeCount > 10)
				LuaUtility.SetGameObjectShow(self.onceBtn, not (drawFreeCount > 0))
				LuaUtility.SetGameObjectShow(self.tenBtn, not (drawFreeCount > 0))
				LuaUtility.SetGameObjectShow(self.freetipstext, drawFreeCount > 0)
				LuaUtility.SetText(self.textFreeCount, drawFreeCount)
			end
		end

		return
	end

	LuaUtility.SetGameObjectShow(self.buttonFreeOnce, false)
	LuaUtility.SetGameObjectShow(self.buttonFreeTen, false)
	LuaUtility.SetGameObjectShow(self.freetipstext, false)
	self.recordListBtn.gameObject:SetActive(false)
	self.tokenExchangeBtn.gameObject:SetActive(false)
	self.buttonShopFree.gameObject:SetActive(false)
	self.tipsRoot.gameObject:SetActive(false)

	if #poolData.currentItems == 0 and #poolData.historyItems == 0 then
		self.showResultBtn.gameObject:SetActive(false)

		return
	end

	self.onceBtn.gameObject:SetActive(false)
	self.tenBtn.gameObject:SetActive(false)
	self.showResultBtn.gameObject:SetActive(true)
end

function LotteryUI:__RefreshTime()
	local cardJackpotID = self:__GetCardJackpotID()
	local currentPool = LotteryModule.DrawPodList[cardJackpotID]

	if currentPool.endTime and tonumber(currentPool.endTime) > 0 then
		LuaUtility.SetGameObjectShow(self.timeParent, true)

		local span = tonumber(currentPool.endTime) - tonumber(PlayerModule.GetServerTimeByMs())
		local time = span / 1000

		LuaUtility.SetText(self.timeText, DateStandardFormation(time))
	else
		LuaUtility.SetGameObjectShow(self.timeParent, false)
	end

	if self.showRookieCardCloseText then
		self:__UpdateRookieCardCloseText()
	end
end

function LotteryUI:__GetCardJackpotID(groupRecordCid)
	if not self.isGroupCid then
		return self.cardJackpotID
	end

	local cardGroupCfg = CfgCardGroupTable[self.cardJackpotID]

	if not groupRecordCid then
		return cardGroupCfg.CardJackpotID[1]
	end

	return LotteryModule.GetShowGroupRecordData(self.cardJackpotID)
end

function LotteryUI:__OnLotteryDrawResultShowComplete(args)
	local cardCfg = CfgUtil.GetCardJackpotWithID(args.cardJackpotID)

	if self.__ResortRookieCard and cardCfg.RookieCard and args.actionType == 0 then
		self:__RefreshCardPoolShow(args.cardJackpotID)

		return
	end

	self:__OnRefreshStateShow()

	if args.actionType == 0 then
		self.drawResultView:Hide()

		return
	end

	if args.actionType == 1 then
		self.selectDrawResultView:Show(args.cardJackpotID, 1)
	elseif args.actionType == 2 then
		self.drawResultView:Hide()
		LotteryModule.RequestDraw(args.cardJackpotID, #args.drawResultPOD.drawResults)
	elseif args.actionType == 3 then
		self.drawResultView:Hide()
		self.selectDrawResultView:Show(args.cardJackpotID, 2)
	elseif args.actionType == 4 then
		self.drawResultView:ShowHistoryDrawResult(args.cardJackpotID, args.drawResultPOD)
	end
end

function LotteryUI:HideRookieCardCloseText()
	self.showRookieCardCloseText = false

	self.rookieCardCloseText.gameObject:SetActive(false)
end

function LotteryUI:ShowRookieCardCloseText(confirmTime)
	self.showRookieCardCloseText = true
	self.rookieCardCloseTimer = confirmTime

	self.rookieCardCloseText.gameObject:SetActive(true)
end

function LotteryUI:__UpdateRookieCardCloseText()
	local difference = (PlayerModule.GetServerTimeByMs() - self.rookieCardCloseTimer) / 1000
	local lastTime = LotteryUIApi:GetRookieCardPoolCloseTimeS() - difference

	if lastTime <= 0 then
		self:HideRookieCardCloseText()
		self:__OnShow(self:__GetCardJackpotID())

		return
	end

	local timeStr = DateTimeFormat(lastTime, "hh:mm:ss")

	LuaUtility.SetText(self.rookieCardCloseText, LotteryUIApi:GetRookieCardPoolCloseText(timeStr))
end

function LotteryUI:__OnSetLotteryAppointedViewActive(active, showGroupCid, heroCid)
	if not active then
		self.appointedControl:Hide()

		return
	end

	self.appointedControl:Show(showGroupCid, heroCid)
end

function LotteryUI:__OnHeroIntroduceUIBtnClick()
	UIModule.Open(Constant.UIControllerName.HeroIntroduceUI, Constant.UILayer.UI)
end

return LotteryUI
