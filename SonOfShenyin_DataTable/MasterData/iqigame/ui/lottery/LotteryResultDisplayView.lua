-- chunkname: @IQIGame\\UI\\Lottery\\LotteryResultDisplayView.lua

local LotteryResultDisplayItemCell = require("IQIGame/UI/Lottery/LotteryResultDisplayItemCell")
local ItemDisplayCell = {}

function ItemDisplayCell.New(view)
	local obj = Clone(ItemDisplayCell)

	obj:__Init(view)

	return obj
end

function ItemDisplayCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.Arrow1Root.gameObject:SetActive(false)
	self.Arrow2Root.gameObject:SetActive(false)

	self.rewardItem = LotteryResultDisplayItemCell.New(self.RewardItemRoot)
end

function ItemDisplayCell:Show(drawResultData)
	self.gameObject:SetActive(true)
	self.rewardItem:Show(drawResultData)

	local itemCfg = CfgItemTable[drawResultData.srcId]
	local active = itemCfg.Quality >= 5

	self.Arrow1Root.gameObject:SetActive(active)
	self.Arrow2Root.gameObject:SetActive(active)
end

function ItemDisplayCell:Hide()
	self.gameObject:SetActive(false)
end

function ItemDisplayCell:Dispose()
	self.rewardItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local LotteryResultDisplayView = {
	startShow = false,
	curShowItemIndex = 0,
	isCloseBtnEnable = true,
	isPreview = false,
	showEnd = false,
	cardJackpotID = 0,
	tenDisplayItemCells = {}
}

function LotteryResultDisplayView.New(view)
	local obj = Clone(LotteryResultDisplayView)

	obj:__Init(view)

	return obj
end

function LotteryResultDisplayView:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)
	ForTransformChild(self.TenResultRoot.transform, function(_trans, _index)
		local itemCell = ItemDisplayCell.New(_trans.gameObject)

		table.insert(self.tenDisplayItemCells, itemCell)
	end)

	self.onceDisplayItemCell = ItemDisplayCell.New(self.OnceResultRoot)

	self:__InitDelegate()
	self:__AddListeners()
end

function LotteryResultDisplayView:__InitDelegate()
	function self.delegateOnCloseBtnClick()
		if not self:__CheckItemShowComplete() then
			return
		end

		if not self.isCloseBtnEnable then
			return
		end

		EventDispatcher.Dispatch(EventID.LotteryDrawResultShowComplete, {
			actionType = 0,
			cardJackpotID = self.cardJackpotID,
			drawResultPOD = self.drawResultPOD
		})
	end

	function self.delegateOnRecordResultBtnClick()
		if not self:__CheckItemShowComplete() then
			return
		end

		EventDispatcher.Dispatch(EventID.LotteryDrawResultShowComplete, {
			actionType = 1,
			cardJackpotID = self.cardJackpotID,
			drawResultPOD = self.drawResultPOD
		})
	end

	function self.delegateOnAgainBtnBtnClick()
		if not self:__CheckItemShowComplete() then
			return
		end

		EventDispatcher.Dispatch(EventID.LotteryDrawResultShowComplete, {
			actionType = 2,
			cardJackpotID = self.cardJackpotID,
			drawResultPOD = self.drawResultPOD
		})
	end

	function self.delegateOnConfirmBtnBtnClick()
		if not self:__CheckItemShowComplete() then
			return
		end

		local _actionType = 3

		if self.isPreview then
			_actionType = 0
		end

		EventDispatcher.Dispatch(EventID.LotteryDrawResultShowComplete, {
			actionType = _actionType,
			cardJackpotID = self.cardJackpotID,
			drawResultPOD = self.drawResultPOD
		})
	end
end

function LotteryResultDisplayView:__AddListeners()
	self.closeBtn:GetComponent("Button").onClick:AddListener(self.delegateOnCloseBtnClick)
	self.recordResultBtn:GetComponent("Button").onClick:AddListener(self.delegateOnRecordResultBtnClick)
	self.againBtn:GetComponent("Button").onClick:AddListener(self.delegateOnAgainBtnBtnClick)
	self.confirmBtn:GetComponent("Button").onClick:AddListener(self.delegateOnConfirmBtnBtnClick)
end

function LotteryResultDisplayView:__RemoveListeners()
	self.closeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnCloseBtnClick)
	self.recordResultBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnRecordResultBtnClick)
	self.againBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnAgainBtnBtnClick)
	self.confirmBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnConfirmBtnBtnClick)
end

function LotteryResultDisplayView:Show(cardJackpotID, drawResultPOD, noAnim)
	self.startShow = true
	self.showEnd = false
	self.isPreview = false
	self.isCloseBtnEnable = true
	self.cardJackpotID = cardJackpotID
	self.drawResultPOD = drawResultPOD
	self.drawResults = {}
	self.drawResults = self.drawResultPOD.drawResults

	self.onceDisplayItemCell:Hide()
	self.TenResultRoot.gameObject:SetActive(false)
	self.view.gameObject:SetActive(true)

	self.curShowItemIndex = 1

	if noAnim then
		self.TenResultRoot.gameObject:SetActive(true)
		self:__CheckItemShowComplete()
	elseif #self.drawResults > 1 then
		self:__ShowDelay()
	else
		self:__ShowOnce()
	end

	self.isNoviceCard = CfgCardJackpotTable[cardJackpotID].RookieCard == true

	LuaCodeInterface.SetGameObjectShow(self.noviceParent, self.isNoviceCard)

	if self.isNoviceCard then
		local poolData = LotteryModule.GetPoolDataByType(self.cardJackpotID)
		local confirmTime = tonumber(poolData.confirmTime)

		if confirmTime > 0 then
			self.recordResultBtn.gameObject:SetActive(false)
			self.againBtn.gameObject:SetActive(false)

			self.isPreview = true
			self.isCloseBtnEnable = true
		else
			self.isCloseBtnEnable = false

			if table.elementEquals(poolData.currentItems, poolData.historyItems) then
				self.recordResultBtn.gameObject:SetActive(false)
			else
				self.recordResultBtn.gameObject:SetActive(true)
			end
		end
	end
end

function LotteryResultDisplayView:__ShowOnce()
	self.TenResultRoot.gameObject:SetActive(false)
	self.onceDisplayItemCell:Show(self.drawResults[1])

	self.showEnd = true
end

function LotteryResultDisplayView:__ShowDelay()
	self.onceDisplayItemCell:Hide()
	self.TenResultRoot.gameObject:SetActive(true)
	ForArray(self.tenDisplayItemCells, function(_, _cell)
		_cell:Hide()
	end)

	self.curShowItemIndex = 1

	self:__OnDelayShowItemTimerHandler()

	self.delayShowItemTimer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Lottery, function()
		self:__OnDelayShowItemTimerHandler()
	end, LotteryUIApi:GetLotteryResultDisplayDurationTime(), -1, true)

	self.delayShowItemTimer:Start()
end

function LotteryResultDisplayView:__OnDelayShowItemTimerHandler()
	local cell = self.tenDisplayItemCells[self.curShowItemIndex]
	local drawResultData = self.drawResults[self.curShowItemIndex]

	cell:Show(drawResultData)

	self.curShowItemIndex = self.curShowItemIndex + 1

	if self.curShowItemIndex > #self.drawResults then
		self:__OnDelayShowItemComplete()
	end
end

function LotteryResultDisplayView:__OnDelayShowItemComplete()
	if self.delayShowItemTimer ~= nil then
		self.delayShowItemTimer:Stop()

		self.delayShowItemTimer = nil
	end

	self.showEnd = true
end

function LotteryResultDisplayView:__CheckItemShowComplete()
	if self.showEnd then
		return true
	end

	self:__OnDelayShowItemComplete()

	for _ = self.curShowItemIndex, #self.drawResults do
		self:__OnDelayShowItemTimerHandler()
	end

	return false
end

function LotteryResultDisplayView:Hide()
	self.view.gameObject:SetActive(false)
end

function LotteryResultDisplayView:Dispose()
	self:__RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

return LotteryResultDisplayView
