-- chunkname: @IQIGame\\UI\\Lottery\\LotteryRewardShow.lua

local m = {}
local LotteryRewardShowItemCell = require("IQIGame.UI.Lottery.LotteryRewardShowItemCell")

function m.New(view, mainView)
	local obj = Clone(m)

	obj:Init(view, mainView)

	return obj
end

function m:Init(view, mainView)
	self.View = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateCloseBtn()
		if self.isAnimation then
			return
		end

		self:Hide()
	end

	function self.DelegateOnClickRecordResultBtn()
		self:OnClickRecordResultBtn()
	end

	function self.DelegateOnClickAgainBtn()
		self:OnClickAgainBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateRecordDrawResultEvent()
		self:RecordDrawResultEvent()
	end

	function self.DelegateConfrimDrawResultEvent()
		self:ConfrimDrawResultEvent()
	end

	self.rewardObjList = {}

	self:AddListeners()
end

function m:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtn)
	self.RecordResultBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRecordResultBtn)
	self.AgainBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAgainBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	EventDispatcher.AddEventListener(EventID.LotteryRecordDrawResultEvent, self.DelegateRecordDrawResultEvent)
	EventDispatcher.AddEventListener(EventID.LotteryConfrimDrawResultEvent, self.DelegateConfrimDrawResultEvent)
end

function m:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtn)
	self.RecordResultBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRecordResultBtn)
	self.AgainBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAgainBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	EventDispatcher.RemoveEventListener(EventID.LotteryRecordDrawResultEvent, self.DelegateRecordDrawResultEvent)
	EventDispatcher.RemoveEventListener(EventID.LotteryConfrimDrawResultEvent, self.DelegateConfrimDrawResultEvent)
end

function m:SetData(resultList)
	self.poolData = LotteryModule.GetPoolDataByType(LotteryModule.curSelectPoolType)

	self:SetRecordBtnState(not self:CurrentAndHistoryIsIdentical())
	self:SetAgineDrawBtnState()

	self.isNoviceCard = CfgCardJackpotTable[LotteryModule.curSelectPoolType].RookieCard == true

	LuaUtility.SetGameObjectShow(self.NoviceParent, self.isNoviceCard)

	for i = 1, #self.rewardObjList do
		self.rewardObjList[i]:Hide()
	end

	self.resultList = resultList

	self:RefreshItemCell()
end

function m:RefreshItemCell()
	local item

	coroutine.start(function()
		self.isAnimation = true

		for i = 1, #self.resultList do
			coroutine.wait(CfgUtil.publicParametersData.lotteryResultNextTime)

			item = self:CreatItem(i)

			item:SetData(self.resultList[i])
		end

		coroutine.wait(0.5)

		self.isAnimation = false
	end)
end

function m:CreatItem(index)
	local obj_s = self.rewardObjList[index]
	local obj

	if not obj_s then
		if index <= 5 then
			obj = UnityEngine.Object.Instantiate(self.RewardShowItem, self.ItemGrid.transform)
		else
			obj = UnityEngine.Object.Instantiate(self.RewardShowItem, self.secondItemGrid.transform)
		end

		obj_s = LotteryRewardShowItemCell.New(obj, self)
		self.rewardObjList[index] = obj_s
	end

	obj_s:Show()

	return obj_s
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
	LuaUtility.PlayDoTweenWithGameObject(self.rewardBackground)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()

	for i = 1, #self.rewardObjList do
		self.rewardObjList[i]:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m:OnClickRecordResultBtn()
	self.mainView:OpenSelectResultPanel(1)
end

function m:OnClickAgainBtn()
	self:Hide()
	LotteryModule.SendDraw(LotteryModule.curSelectPoolType, 10)
end

function m:OnClickConfirmBtn()
	self.mainView:OpenSelectResultPanel(2)
end

function m:RecordDrawResultEvent()
	self:SetRecordBtnState(false)
	self.mainView.LotterySelectDrawResultView:Hide()
end

function m:SetRecordBtnState(state)
	LuaUtility.SetGameObjectShow(self.RecordResultBtn, state)
end

function m:SetAgineDrawBtnState()
	local cardJackpotCfg = CfgCardJackpotTable[LotteryModule.curSelectPoolType]

	if cardJackpotCfg.FullTimes <= 0 then
		LuaUtility.SetGameObjectShow(self.AgainBtn, true)
	elseif self.poolData.drawTime >= cardJackpotCfg.FullTimes then
		LuaUtility.SetGameObjectShow(self.AgainBtn, false)
	else
		LuaUtility.SetGameObjectShow(self.AgainBtn, true)
	end
end

function m:CurrentAndHistoryIsIdentical()
	return table.elementEquals(self.poolData.currentItems, self.poolData.historyItems)
end

function m:ConfrimDrawResultEvent()
	self:Hide()
	self.mainView.LotterySelectDrawResultView:Hide()
end

return m
