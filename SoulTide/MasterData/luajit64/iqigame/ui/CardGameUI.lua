-- chunkname: @IQIGame\\UI\\CardGameUI.lua

local CardGameUI = {
	LastTurn = 0,
	GapElapsedTime = -1,
	ShuffleElapsedTime = -1,
	CanSelectCard = false,
	InMaze = false,
	Positions = {},
	CardCells = {}
}

CardGameUI = Base:Extend("CardGameUI", "IQIGame.Onigao.UI.CardGameUI", CardGameUI)

local CardGameCardController = require("IQIGame.UI.CardGame.CardGameCardController")

function CardGameUI:OnInit()
	function self.DelegateOnClickStartBtn()
		self:OnClickStartBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	for i = 1, self.PositionGrid.transform.childCount do
		local cardGo = UnityEngine.Object.Instantiate(self.CardPrefab)

		cardGo.transform:SetParent(self.CardGrid.transform, false)

		self.CardCells[i] = CardGameCardController.New(cardGo, i, self.UIController, function(index)
			self:OnClickCard(index)
		end)
	end

	UGUIUtil.SetTextInChildren(self.StartBtn, CardGameUIApi:GetString("StartButtonText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, CardGameUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetTextInChildren(self.CloseBtn, CardGameUIApi:GetString("CloseBtnText"))
	UGUIUtil.SetTextInChildren(self.DisableConfirmBtn, CardGameUIApi:GetString("DisableConfirmBtnText"))
end

function CardGameUI:GetPreloadAssetPaths()
	return nil
end

function CardGameUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CardGameUI:IsManualShowOnOpen(userData)
	return false
end

function CardGameUI:GetBGM(userData)
	return nil
end

function CardGameUI:OnOpen(userData)
	self:UpdateView(userData.cardCid, userData.inMaze)
end

function CardGameUI:OnClose(userData)
	if self.CoverOrRevealTimer ~= nil then
		self.CoverOrRevealTimer:Stop()

		self.CoverOrRevealTimer = nil
	end
end

function CardGameUI:OnAddListeners()
	self.StartBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickStartBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function CardGameUI:OnRemoveListeners()
	self.StartBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickStartBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function CardGameUI:OnPause()
	return
end

function CardGameUI:OnResume()
	return
end

function CardGameUI:OnCover()
	return
end

function CardGameUI:OnReveal()
	return
end

function CardGameUI:OnRefocus(userData)
	return
end

function CardGameUI:OnUpdate(scaledElapseSeconds, unscaledElapseSeconds)
	local elapsedTime = scaledElapseSeconds

	if self.ShuffleElapsedTime ~= -1 and self.GapElapsedTime == -1 then
		self.ShuffleElapsedTime = self.ShuffleElapsedTime + elapsedTime

		local turn = math.floor(self.ShuffleElapsedTime / self.CfgCardGameData.ShuffleDuration)
		local elapsedTimeThisTurn = self.ShuffleElapsedTime % self.CfgCardGameData.ShuffleDuration

		if turn ~= self.LastTurn then
			self:UpdateTurn(self.LastTurn, self.CfgCardGameData.ShuffleDuration)

			self.LastTurn = turn
			self.GapElapsedTime = 0

			GameEntry.Sound:PlaySound(10513, Constant.SoundGroup.UI)
		end

		if self.ShuffleElapsedTime >= self.CfgCardGameData.ShuffleDuration * self.CfgCardGameData.ShuffleTimes then
			self.ShuffleElapsedTime = -1
			self.LastTurn = 0
			self.GapElapsedTime = -1

			self:ShuffleComplete()

			return
		end

		if self.GapElapsedTime ~= -1 then
			return
		end

		self:UpdateTurn(turn, elapsedTimeThisTurn)
	end

	if self.GapElapsedTime ~= -1 then
		self.GapElapsedTime = self.GapElapsedTime + elapsedTime

		if self.GapElapsedTime >= self.CfgCardGameData.SwitchInterval then
			self.GapElapsedTime = -1
		end
	end
end

function CardGameUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CardGameUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CardGameUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CardGameUI:OnDestroy()
	for i = 1, #self.CardCells do
		local cell = self.CardCells[i]

		cell:Dispose()
	end
end

function CardGameUI:UpdateView(cardCid, inMaze)
	self.CfgCardGameData = CfgCardGameTable[cardCid]
	self.InMaze = inMaze

	self.StartBtn:SetActive(false)

	local timer = FrameTimer.New(function()
		self.StartBtn:SetActive(true)
		self:Reset()

		for i = 1, #self.CardCells do
			local cell = self.CardCells[i]

			cell:SetData(self.CfgCardGameData.CardIcon[i], self.CfgCardGameData.CardDescribe[i], self.CfgCardGameData.CardStyle[i])
		end
	end, 1)

	timer:Start()
end

function CardGameUI:Reset()
	for i = 1, self.PositionGrid.transform.childCount do
		local childTrans = self.PositionGrid.transform:Find("Position" .. i)

		self.Positions[i] = childTrans.position
	end

	self.CanSelectCard = false

	for i = 1, #self.CardCells do
		local cell = self.CardCells[i]

		cell.View.transform.position = self.Positions[i]

		cell:Reveal(true)
		cell:SetSelect(false)
	end

	self.SelectedCard = nil

	self.StartBtn:SetActive(true)
	self.ConfirmView:SetActive(false)
	self.CloseBtn:SetActive(false)
end

function CardGameUI:UpdateTurn(turn, elapsedTimeThisTurn)
	local index1 = self.ShuffleCardShowIndexes[turn * 2 + 1]
	local index2 = self.ShuffleCardShowIndexes[turn * 2 + 2]
	local originalIndex1 = self.ShuffleCardOriginalIndexes[turn * 2 + 1]
	local originalIndex2 = self.ShuffleCardOriginalIndexes[turn * 2 + 2]
	local card1 = self.CardCells[originalIndex1]

	card1:MoveTo(self.Positions[index1], self.Positions[index2], elapsedTimeThisTurn / self.CfgCardGameData.ShuffleDuration, 1)

	local card2 = self.CardCells[originalIndex2]

	card2:MoveTo(self.Positions[index2], self.Positions[index1], elapsedTimeThisTurn / self.CfgCardGameData.ShuffleDuration, -1)
end

function CardGameUI:OnClickStartBtn()
	self.StartBtn:SetActive(false)

	local animationLength

	for i = 1, #self.CardCells do
		local cell = self.CardCells[i]

		cell:Cover()

		if animationLength == nil then
			animationLength = cell.RevealAnimationLength
		end
	end

	self.CoverOrRevealTimer = Timer.New(function()
		self.CoverOrRevealTimer = nil

		self:Shuffle()
	end, animationLength + 0.3)

	self.CoverOrRevealTimer:Start()
end

function CardGameUI:Shuffle()
	self.ShuffleElapsedTime = 0
	self.ShuffleCardShowIndexes = {}
	self.ShuffleCardOriginalIndexes = {}

	local originalCardIndexAfterShuffle = {}

	for i = 1, #self.CardCells do
		originalCardIndexAfterShuffle[i] = i
	end

	for i = 1, self.CfgCardGameData.ShuffleTimes do
		local cardIndexes = {}

		for j = 1, #self.CardCells do
			cardIndexes[j] = j
		end

		local index = math.random(1, #cardIndexes)
		local shuffleCardIndex1 = cardIndexes[index]

		table.remove(cardIndexes, index)

		index = math.random(1, #cardIndexes)

		local shuffleCardIndex2 = cardIndexes[index]
		local index1 = shuffleCardIndex1 < shuffleCardIndex2 and shuffleCardIndex1 or shuffleCardIndex2
		local index2 = shuffleCardIndex1 < shuffleCardIndex2 and shuffleCardIndex2 or shuffleCardIndex1

		table.insert(self.ShuffleCardShowIndexes, index1)
		table.insert(self.ShuffleCardShowIndexes, index2)
		table.insert(self.ShuffleCardOriginalIndexes, originalCardIndexAfterShuffle[index1])
		table.insert(self.ShuffleCardOriginalIndexes, originalCardIndexAfterShuffle[index2])

		local tempOriginalIndex = originalCardIndexAfterShuffle[shuffleCardIndex1]

		originalCardIndexAfterShuffle[shuffleCardIndex1] = originalCardIndexAfterShuffle[shuffleCardIndex2]
		originalCardIndexAfterShuffle[shuffleCardIndex2] = tempOriginalIndex
	end
end

function CardGameUI:ShuffleComplete()
	self.ConfirmView:SetActive(true)
	self.ConfirmBtn:SetActive(false)
	self.DisableConfirmBtn:SetActive(true)
	UGUIUtil.SetText(self.SelectNoticeText, CardGameUIApi:GetString("SelectNoticeText", 0, 1))

	self.CanSelectCard = true
end

function CardGameUI:OnClickConfirmBtn()
	self.SelectedCard:Reveal()

	local animationLength = self.SelectedCard.RevealAnimationLength

	self.CoverOrRevealTimer = Timer.New(function()
		for i = 1, #self.CardCells do
			local cell = self.CardCells[i]

			if cell ~= self.SelectedCard then
				cell:Reveal()
			end
		end

		self.CoverOrRevealTimer = Timer.New(function()
			self.CoverOrRevealTimer = nil

			self.CloseBtn:SetActive(true)
		end, animationLength)

		self.CoverOrRevealTimer:Start()
	end, animationLength * 0.8)

	self.CoverOrRevealTimer:Start()
	self.ConfirmView:SetActive(false)

	self.CanSelectCard = false

	GameEntry.Sound:PlaySound(10512, Constant.SoundGroup.UI)
end

function CardGameUI:OnClickCard(index)
	if not self.CanSelectCard then
		return
	end

	local toSelectedCard = self.CardCells[index]

	if self.SelectedCard == toSelectedCard then
		return
	end

	if self.SelectedCard ~= nil then
		self.SelectedCard:SetSelect(false)
	end

	self.SelectedCard = toSelectedCard

	self.SelectedCard:SetSelect(true)
	self.ConfirmBtn:SetActive(true)
	self.DisableConfirmBtn:SetActive(false)
	UGUIUtil.SetText(self.SelectNoticeText, CardGameUIApi:GetString("SelectNoticeText", 1, 1))
end

function CardGameUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
	CardGameModule.SendChooseCard(self.SelectedCard.Index, self.InMaze)
end

return CardGameUI
