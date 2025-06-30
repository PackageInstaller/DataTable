-- chunkname: @IQIGame\\UI\\RestaurantGameCardUI.lua

local RestaurantGameCardUI = {
	lockClick = false,
	isTimeOut = false,
	cardGameItemCells = {},
	cards = {}
}

RestaurantGameCardUI = Base:Extend("RestaurantGameCardUI", "IQIGame.Onigao.UI.RestaurantGameCardUI", RestaurantGameCardUI)

require("IQIGame.UIExternalApi.RestaurantGameCardUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local CardGameItemCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.CardGame.CardGameItemCell")

function RestaurantGameCardUI:OnInit()
	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	function self.DelegateBtnSelectLevel()
		self:OnBtnSelectLevel()
	end

	function self.DelegateUpdateCardGame()
		self:OnUpdateCardGame()
	end

	function self.DelegateUpdateCardGameRank()
		self:RefreshCardGameRank()
	end

	function self.DelegateBtnRank()
		self:OnBtnRank()
	end

	function self.DelegateBtnReset()
		self:OnBtnReset()
	end

	self.CardMould:SetActive(false)

	self.cardGameItemCellPool = UIObjectPool.New(30, function()
		local cardCell = CardGameItemCell.New(UnityEngine.Object.Instantiate(self.CardMould))

		function cardCell.clickCallBack(cell)
			self:OnClickCard(cell)
		end

		return cardCell
	end, function(cell)
		cell:Dispose()
	end)
	self.timer = Timer.New(function()
		self:ShowCD()
	end, 1, -1)
end

function RestaurantGameCardUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantGameCardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantGameCardUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantGameCardUI:GetBGM(userData)
	return nil
end

function RestaurantGameCardUI:OnOpen(userData)
	self.lockClick = false
	self.isTimeOut = false

	ROCardGameModule.GetCardGameRanking()
	self:UpdateView()
end

function RestaurantGameCardUI:OnClose(userData)
	if self.timer then
		self.timer:Stop()
	end
end

function RestaurantGameCardUI:OnAddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.BtnSelectLevel:GetComponent("Button").onClick:AddListener(self.DelegateBtnSelectLevel)
	self.BtnRank:GetComponent("Button").onClick:AddListener(self.DelegateBtnRank)
	self.BtnReset:GetComponent("Button").onClick:AddListener(self.DelegateBtnReset)
	EventDispatcher.AddEventListener(EventID.ROUpdateCardGameEvent, self.DelegateUpdateCardGame)
	EventDispatcher.AddEventListener(EventID.ROUpdateCardGameRankEvent, self.DelegateUpdateCardGameRank)
end

function RestaurantGameCardUI:OnRemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.BtnSelectLevel:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSelectLevel)
	self.BtnRank:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRank)
	self.BtnReset:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnReset)
	EventDispatcher.RemoveEventListener(EventID.ROUpdateCardGameEvent, self.DelegateUpdateCardGame)
	EventDispatcher.RemoveEventListener(EventID.ROUpdateCardGameRankEvent, self.DelegateUpdateCardGameRank)
end

function RestaurantGameCardUI:OnPause()
	return
end

function RestaurantGameCardUI:OnResume()
	return
end

function RestaurantGameCardUI:OnCover()
	return
end

function RestaurantGameCardUI:OnReveal()
	return
end

function RestaurantGameCardUI:OnRefocus(userData)
	return
end

function RestaurantGameCardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantGameCardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantGameCardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantGameCardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantGameCardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	for i, v in pairs(self.cardGameItemCells) do
		self.cardGameItemCellPool:Release(v)
	end

	self.cardGameItemCells = {}

	self.cardGameItemCellPool:Dispose()
end

function RestaurantGameCardUI:OnBtnSelectLevel()
	UIModule.Open(Constant.UIControllerName.RestaurantGameSelectLevelUI, Constant.UILayer.UI)
end

function RestaurantGameCardUI:OnBtnClose()
	UIModule.CloseSelf(self)
end

function RestaurantGameCardUI:OnUpdateCardGame()
	self:UpdateView()
end

function RestaurantGameCardUI:RefreshCardGameRank()
	local rank = ROCardGameModule.myRanking or 0

	UGUIUtil.SetText(self.TextRankIndex, RestaurantGameCardUIApi:GetString("TextRankIndex", rank))
	self.RankTag:SetActive(rank > ROCardGameModule.cardGameRankMaxNum)
end

function RestaurantGameCardUI:UpdateView()
	self:RefreshBtnState()
	self:RefreshCardGameRank()
	UGUIUtil.SetText(self.TextLevel, ROCardGameModule.roCardGameData:GetCfgData().Level)
	UGUIUtil.SetText(self.TextLevelSteps, ROCardGameModule.roCardGameData.stepCounts)
	UGUIUtil.SetText(self.TextTotalSteps, ROCardGameModule.GetPassTotalSteps())

	self.cards = ROCardGameModule.roCardGameData.cards

	for i, v in pairs(self.cardGameItemCells) do
		self.cardGameItemCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.cardGameItemCells = {}

	for i = 1, #self.cards do
		local data = self.cards[i]
		local render = self.cardGameItemCellPool:Obtain()

		render.View:SetActive(true)
		render.View.transform:SetParent(self.Content.transform, false)
		render:SetData(data)
		table.insert(self.cardGameItemCells, render)
	end

	if ROCardGameModule.roCardGameData.startTime > 0 then
		local passTime = PlayerModule.GetServerTime() - ROCardGameModule.roCardGameData.startTime
		local cd = ROCardGameModule.roCardGameData:GetCfgData().Countdown - passTime

		self.timer:Stop()

		if cd > 0 then
			self.timer:Start()
		end

		self:ShowCD()
	else
		UGUIUtil.SetText(self.TextTime, ROCardGameModule.roCardGameData:GetCfgData().Countdown)

		self.ImgTime:GetComponent("Image").fillAmount = 1
	end
end

function RestaurantGameCardUI:ShowCD()
	local passTime = PlayerModule.GetServerTime() - ROCardGameModule.roCardGameData.startTime
	local cd = math.floor(ROCardGameModule.roCardGameData:GetCfgData().Countdown - passTime)

	if cd >= 0 then
		self.isTimeOut = false

		UGUIUtil.SetText(self.TextTime, cd)
	else
		self.isTimeOut = true

		self.timer:Stop()
		self:CheckResult()
	end

	self.ImgTime:GetComponent("Image").fillAmount = cd / ROCardGameModule.roCardGameData:GetCfgData().Countdown
end

function RestaurantGameCardUI:OnClickCard(cell)
	if ROCardGameModule.roCardGameData.startTime == 0 then
		return
	end

	if self.isTimeOut then
		return
	end

	if self.lockClick then
		return
	end

	cell.cardData.isOpen = true

	cell:UpdateView()

	ROCardGameModule.roCardGameData.stepCounts = ROCardGameModule.roCardGameData.stepCounts + 1

	UGUIUtil.SetText(self.TextLevelSteps, ROCardGameModule.roCardGameData.stepCounts)

	if self.openFirstCard == nil then
		self.openFirstCard = cell
	elseif self.openSecondCard == nil then
		self.openSecondCard = cell
	end

	if self.openFirstCard and self.openSecondCard then
		if self.openFirstCard.cardData.cid == self.openSecondCard.cardData.cid then
			self.openFirstCard:PlayEffect(true)
			self.openSecondCard:PlayEffect(true)

			ROCardGameModule.roCardGameData.rightCount = ROCardGameModule.roCardGameData.rightCount + 2

			self:CheckResult()

			self.openFirstCard = nil
			self.openSecondCard = nil
		else
			self.openFirstCard:PlayEffect(false)
			self.openSecondCard:PlayEffect(false)

			self.lockClick = true

			local time = Timer.New(function()
				self.openFirstCard.cardData.isOpen = false
				self.openSecondCard.cardData.isOpen = false

				self.openFirstCard:UpdateView()
				self.openSecondCard:UpdateView()

				self.openFirstCard = nil
				self.openSecondCard = nil
				self.lockClick = false
			end, 1)

			time:Start()
		end
	end
end

function RestaurantGameCardUI:RefreshBtnState()
	self.BtnReset:SetActive(ROCardGameModule.roCardGameData.startTime > 0)
	self.ConfirmBtn:SetActive(ROCardGameModule.roCardGameData.startTime == 0)
end

function RestaurantGameCardUI:CheckResult()
	if self.isTimeOut then
		UIModule.Open(Constant.UIControllerName.RestaurantGameResultUI, Constant.UILayer.UI, {
			Success = false
		})
	elseif ROCardGameModule.roCardGameData.rightCount == #ROCardGameModule.roCardGameData.cards then
		self.timer:Stop()

		local passTime = math.floor(PlayerModule.GetServerTime() - ROCardGameModule.roCardGameData.startTime)

		UIModule.Open(Constant.UIControllerName.RestaurantGameResultUI, Constant.UILayer.UI, {
			Success = true
		})
		ROCardGameModule.MemoryFlop(passTime)
	end

	self:RefreshBtnState()
end

function RestaurantGameCardUI:OnBtnReset()
	if self.timer then
		self.timer:Stop()
	end

	ROCardGameModule.CreateNewLevel()
	self:UpdateView()
end

function RestaurantGameCardUI:OnClickConfirmBtn()
	ROCardGameModule.roCardGameData.startTime = PlayerModule.GetServerTime()

	self:UpdateView()
end

function RestaurantGameCardUI:OnBtnRank()
	UIModule.Open(Constant.UIControllerName.RestaurantGameCardRankUI, Constant.UILayer.UI)
end

return RestaurantGameCardUI
