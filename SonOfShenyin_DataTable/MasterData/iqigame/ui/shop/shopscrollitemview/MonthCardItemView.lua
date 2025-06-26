-- chunkname: @IQIGame\\UI\\Shop\\ShopScrollItemView\\MonthCardItemView.lua

local RewardItem = {}

function RewardItem.New(view)
	local obj = Clone(RewardItem)

	obj:__Init(view)

	return obj
end

function RewardItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function RewardItem:Show(itemCid, itemCnt, getType)
	self.gameObject:SetActive(true)

	local itemCfg = CfgItemTable[itemCid]
	local iconPath = UIGlobalApi.GetIconPath(itemCfg.Icon)

	AssetUtil.LoadImage(self, iconPath, self.ItemIcon:GetComponent("Image"))

	self.CountText:GetComponent("Text").text = itemCnt
	self.RewardTypeText:GetComponent("Text").text = CommonTipsApi:GetMonthCardRewardTypeText(getType)
end

function RewardItem:Hide()
	self.gameObject:SetActive(false)
end

function RewardItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local m = {}

function m.New(view, mainView)
	local obj = Clone(m)

	obj:Init(view, mainView)

	return obj
end

function m:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.rewardItems = {}

	ForTransformChild(self.RewardRoot.transform, function(_trans, _index)
		local rewardItem = RewardItem.New(_trans.gameObject)

		table.insert(self.rewardItems, rewardItem)
	end)

	function self.buttonMonthCardBuyDelegate()
		self:OnButtonMonthCardBuyClick()
	end

	function self.buttonHelpDelegate()
		self:OnButtonHelpClick()
	end

	function self.buyMonthCardResultEvent()
		self:OnBuyMonthCardResultEvent()
	end

	self.buttonMonthCardBuy = self.buttonMonthCardBuy:GetComponent("Button")
	self.buttonHelp = self.buttonHelp:GetComponent("Button")

	self.GetRewardBtn.gameObject:SetActive(false)
	self.RewardedTag.gameObject:SetActive(false)
	self:AddListeners()
end

function m:AddListeners()
	self.buttonMonthCardBuy.onClick:AddListener(self.buttonMonthCardBuyDelegate)
	self.buttonHelp.onClick:AddListener(self.buttonHelpDelegate)
	EventDispatcher.AddEventListener(EventID.SignInNotify, self.buyMonthCardResultEvent)
	UIEventUtil.AddClickEventListener_Button(self, "GetRewardBtn", self.__OnGetRewardBtnClick)
	EventUtil.AddEventListener(self, EventID.OnReceiveMonthCardAwardResult, self.__OnReceiveMonthCardAwardResult)
end

function m:RemoveListeners()
	self.buttonMonthCardBuy.onClick:RemoveListener(self.buttonMonthCardBuyDelegate)
	self.buttonHelp.onClick:RemoveListener(self.buttonHelpDelegate)
	EventDispatcher.RemoveEventListener(EventID.SignInNotify, self.buyMonthCardResultEvent)
	UIEventUtil.ClearEventListener(self)
	EventUtil.ClearEventListener(self)
end

function m:SetData(Data)
	self.Data = Data

	if self.Data.isNewMonthCard then
		self:__RefreshNewCardShow()
	else
		self:__RefreshNormalCardShow()
	end
end

function m:__RefreshNormalCardShow()
	local monthCardData = self.Data

	self:__RefreshRewardItems(self.Data.buyReward.Data, self.Data.dayReward.Data)
	LuaUtility.SetGameObjectShow(self.ObjMonthCard, true)

	local path = "Assets/05_Images/UI/ActivityPart/Shop/NewUI/ShopUI/title_monthCard.png"

	AssetUtil.LoadImage(self, path, self.NameBg:GetComponent("Image"))
	self:__RefreshDescText(UIGlobalApi:GetNormalMonthCardTipsText())
	self:RefreshMonthTime()

	local buyPrice = monthCardData.commodityData.Price[1][2] / 100

	UGUIUtil.SetText(self.textMonthPrice, buyPrice)

	if MonthCardModule.GetMonthResidualDays() > 0 then
		self.GetRewardBtn.gameObject:SetActive(not MonthCardModule.monthPrzieState)
		self.RewardedTag.gameObject:SetActive(MonthCardModule.monthPrzieState)
	end
end

function m:__RefreshNewCardShow()
	self.GetRewardBtn.gameObject:SetActive(false)
	self.RewardedTag.gameObject:SetActive(false)

	local monthCardData = self.Data.monthCardData
	local commodityData = self.Data.commodityData

	self:__RefreshRewardItems(monthCardData.Reward, monthCardData.DailyReward)

	local path = UIGlobalApi.GetImagePath(monthCardData.Picture)

	AssetUtil.LoadImage(self, path, self.NameBg:GetComponent("Image"))
	self:__RefreshDescText(monthCardData.Tips)

	local buyPrice = commodityData.Price[1][2] / 100

	UGUIUtil.SetText(self.textMonthPrice, buyPrice)
	self:__RefreshNewCardDynamicsData(monthCardData, commodityData)
end

function m:__RefreshNewCardDynamicsData(monthCardData, commodityData)
	local day = MonthCardModule.GetNewCardEndDay(monthCardData.Id)

	UGUIUtil.SetText(self.textTime, day)

	local maxBuyNum = monthCardData.Limit / monthCardData.Time
	local buyNum = math.ceil(day / monthCardData.Time)
	local canBuy = buyNum < maxBuyNum

	LuaUtility.SetGameObjectShow(self.buyBtnParent, canBuy)
	LuaUtility.SetGameObjectShow(self.buyLimitParent, not canBuy)
end

function m:__RefreshRewardItems(buyRewards, dayRewards)
	local itemCellIndex = 1

	ForArrayCustomStep(buyRewards, function(_index, _)
		local itemCid = buyRewards[_index]
		local itemCnt = buyRewards[_index + 1]
		local rewardItemCell = self.rewardItems[itemCellIndex]

		if rewardItemCell == nil then
			return true
		end

		itemCellIndex = itemCellIndex + 1

		rewardItemCell:Show(itemCid, itemCnt, 1)
	end, 2)
	ForArrayCustomStep(dayRewards, function(_index, _)
		local itemCid = dayRewards[_index]
		local itemCnt = dayRewards[_index + 1]
		local rewardItemCell = self.rewardItems[itemCellIndex]

		if rewardItemCell == nil then
			return true
		end

		itemCellIndex = itemCellIndex + 1

		rewardItemCell:Show(itemCid, itemCnt, 2)
	end, 2)
	ForArrayByCount(itemCellIndex, #self.rewardItems, 1, function(_index)
		self.rewardItems[_index]:Hide()
	end)
end

function m:__RefreshDescText(tipsArray)
	local tipsText = ""

	ForArray(tipsArray, function(_index, tips)
		if _index ~= 1 then
			tipsText = tipsText .. "\r\n"
		end

		tipsText = tipsText .. tips
	end)

	self.DescText:GetComponent("Text").text = tipsText
end

function m:OnButtonMonthCardBuyClick()
	if self.Data.isNewMonthCard then
		MonthCardModule.BuyNewMonthCard(self.Data)
	else
		SignInModule.BuyMonthCard()
	end
end

function m:OnBuyMonthCardResultEvent()
	self:RefreshMonthTime()
end

function m:RefreshMonthTime()
	local surplusDay = MonthCardModule.GetMonthResidualDays()

	UGUIUtil.SetText(self.textTime, surplusDay)

	local discreteData = CfgDiscreteDataTable[Constant.DiscreteData.BuyMonthCardNeedDayNum].Data[1]

	LuaUtility.SetGameObjectShow(self.buyBtnParent, surplusDay < discreteData)
	LuaUtility.SetGameObjectShow(self.buyLimitParent, discreteData <= surplusDay)
end

function m:OnButtonHelpClick()
	self.mainView.ActionDescPanel:Show(true)
	self.mainView.ActionDescPanel:Refresh(Constant.MonthCardCfgID.HelpTipsID)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m:__OnGetRewardBtnClick()
	if MonthCardModule.monthPrzieState then
		return
	end

	MonthCardModule.GetMonthCardAward()
end

function m:__OnReceiveMonthCardAwardResult()
	self:__RefreshNormalCardShow()
end

return m
