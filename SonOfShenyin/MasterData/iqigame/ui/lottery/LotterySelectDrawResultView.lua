-- chunkname: @IQIGame\\UI\\Lottery\\LotterySelectDrawResultView.lua

local UIViewObjectPool = require("IQIGame/UI/Common/UIViewObjectPool")
local LotteryResultDisplayItemCell = require("IQIGame/UI/Lottery/LotteryResultDisplayItemCell")
local ResultItemsView = {
	index = 0
}

function ResultItemsView.New(view, selectCallback)
	local obj = Clone(ResultItemsView)

	obj:__Init(view, index, selectCallback)

	return obj
end

function ResultItemsView:__Init(view, index, selectCallback)
	self.view = view
	self.index = index
	self.selectCallback = selectCallback

	LuaCodeInterface.BindOutlet(self.view, self)
	self.resultItemPrefab.gameObject:SetActive(false)

	self.itemCellPool = UIViewObjectPool.New(self.resultItemPrefab, self.ResultGrid.transform, function(_view)
		return LotteryResultDisplayItemCell.New(_view)
	end)

	self:__InitDelegate()
	self:__AddListeners()
end

function ResultItemsView:__InitDelegate()
	function self.__delegateOnViewClick()
		self.selectCallback()
	end
end

function ResultItemsView:__AddListeners()
	self.SelectBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnViewClick)
end

function ResultItemsView:__RemoveListeners()
	self.SelectBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnViewClick)
end

function ResultItemsView:Show(drawResults)
	self.view.gameObject:SetActive(true)
	self:SetSelectState(false)

	self.HasData = table.len(drawResults) > 0

	self.itemCellPool:ForItems(function(_item)
		_item:Hide()
	end)
	ForPairs(drawResults, function(_, _drawResultData)
		local itemCell = self.itemCellPool:GetFree(function(_item)
			return _item:IsFree()
		end)

		itemCell:Show(_drawResultData)
	end)
end

function ResultItemsView:SetSelectState(state)
	LuaUtility.SetGameObjectShow(self.SelectImg, state)
	self:SetBGState(state)
end

function ResultItemsView:SetBGState(state)
	LuaUtility.SetGameObjectShow(self.bg1, state)
	LuaUtility.SetGameObjectShow(self.bg2, not state)
	self:SetTitleTextState(state)
end

function ResultItemsView:SetTitleTextState(state)
	return
end

function ResultItemsView:SetSelectBtnState(state)
	LuaUtility.SetGameObjectShow(self.SelectBtn, state)
end

function ResultItemsView:Hide()
	self.view.gameObject:SetActive(false)
end

function ResultItemsView:Dispose()
	self.itemCellPool:ForItems(function(_item)
		_item:Dispose()
	end)
	self:__RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local LotterySelectDrawResultView = {
	curOpType = 0,
	selectDrawResultEnum = 0,
	cardJackpotID = 0
}

LotterySelectDrawResultView.DrawResultEnum = {
	History = 1,
	Current = 2
}

function LotterySelectDrawResultView.New(view)
	local obj = Clone(LotterySelectDrawResultView)

	obj:__Init(view)

	return obj
end

function LotterySelectDrawResultView:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)
	self:__InitDelegate()

	self.resultParentTable = {}
	self.resultParentTable[self.DrawResultEnum.History] = ResultItemsView.New(self.HistoryResultParent, function()
		self:__OnResultItemsViewSelected(self.DrawResultEnum.History)
	end)
	self.resultParentTable[self.DrawResultEnum.Current] = ResultItemsView.New(self.CurrentResultParent, function()
		self:__OnResultItemsViewSelected(self.DrawResultEnum.Current)
	end)

	self:__AddListeners()
end

function LotterySelectDrawResultView:__InitDelegate()
	function self.DelegateOnClickCancelBtn()
		self:Hide()
	end

	function self.DelegateOnClickConfirmBtn()
		local function confirmCallback()
			local currentDraw = self.selectDrawResultEnum == self.DrawResultEnum.Current

			LotteryModule.ConfrimDraw(self.cardJackpotID, currentDraw)
			self:Hide()

			local poolData = LotteryModule.GetPoolDataByType(self.cardJackpotID)

			poolData.confirmTime = PlayerModule.GetServerTimeByMs()

			local _drawResultPOD = {}

			if currentDraw then
				_drawResultPOD.drawResults = poolData.currentItems
			else
				_drawResultPOD.drawResults = poolData.historyItems
			end

			EventDispatcher.Dispatch(EventID.LotteryDrawResultShowComplete, {
				actionType = 4,
				cardJackpotID = self.cardJackpotID,
				drawResultPOD = _drawResultPOD
			})
		end

		NoticeModule.ShowNotice(21044003, confirmCallback)
	end

	function self.DelegateOnClickConfirmRecordBtn()
		LotteryModule.RecordDraw(self.cardJackpotID)
		self:Hide()
	end
end

function LotterySelectDrawResultView:__AddListeners()
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCancelBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.ConfrimRecordBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmRecordBtn)
end

function LotterySelectDrawResultView:__RemoveListeners()
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCancelBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.ConfrimRecordBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmRecordBtn)
end

function LotterySelectDrawResultView:Show(cardJackpotID, opType)
	self.view.gameObject:SetActive(true)

	self.cardJackpotID = cardJackpotID
	self.curOpType = opType

	LuaUtility.SetGameObjectShow(self.ConfrimRecordBtn, opType == 1)
	LuaUtility.SetGameObjectShow(self.ConfrimBtn, opType == 2)
	LuaUtility.SetGameObjectShow(self.replaceImg, opType == 1)
	UGUIUtil.SetText(self.TitleText, LotteryUIApi:GetDrwaResultTitle(opType))

	local poolData = LotteryModule.GetPoolDataByType(cardJackpotID)

	self.resultParentTable[self.DrawResultEnum.History]:Show(poolData.historyItems)
	self.resultParentTable[self.DrawResultEnum.Current]:Show(poolData.currentItems)
	self.resultParentTable[self.DrawResultEnum.History]:SetSelectBtnState(opType == 2)
	self.resultParentTable[self.DrawResultEnum.Current]:SetSelectBtnState(opType == 2)

	if opType == 1 then
		self.resultParentTable[self.DrawResultEnum.History]:SetBGState(true)
		self.resultParentTable[self.DrawResultEnum.Current]:SetBGState(true)
	elseif opType == 2 then
		self.selectDrawResultEnum = self.DrawResultEnum.History

		self.resultParentTable[self.DrawResultEnum.History]:SetSelectState(false)
		self.resultParentTable[self.DrawResultEnum.History]:SetSelectState(false)

		self.ConfirmBtn:GetComponent("Button").interactable = false
	end
end

function LotterySelectDrawResultView:__OnResultItemsViewSelected(enumIndex)
	self.ConfirmBtn:GetComponent("Button").interactable = true
	self.selectDrawResultEnum = enumIndex

	ForPairs(self.resultParentTable, function(_enumIndex, _resultParentView)
		_resultParentView:SetSelectState(_enumIndex == enumIndex)
	end)
end

function LotterySelectDrawResultView:Hide()
	self.view.gameObject:SetActive(false)
end

function LotterySelectDrawResultView:Dispose()
	ForPairs(self.resultParentTable, function(_enumIndex, _resultParentView)
		_resultParentView:Dispose()
	end)
	self:__RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

return LotterySelectDrawResultView
