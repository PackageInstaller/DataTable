-- chunkname: @IQIGame\\UI\\Activity\\DoubleFight\\InvasionView.lua

local m = {
	challengeRecordCells = {},
	cfgFightList = {},
	challengeLevelPool = {},
	rewardBoxCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local ChallengeRecordCell = require("IQIGame.UI.Activity.DoubleFight.ChallengeRecordCell")
local ChallengeLevelCell = require("IQIGame.UI.Activity.DoubleFight.ChallengeLevelCell")
local RewardBoxCell = require("IQIGame.UI.Activity.DoubleFight.RewardBoxCell")

function m.New(view, root, operateEventID)
	local obj = Clone(m)

	obj:Init(view, root, operateEventID)

	return obj
end

function m:Init(view, root, operateEventID)
	self.View = view
	self.root = root
	self.operateEventID = operateEventID

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextBtnGetReward, ActivityUIApi:GetString("InvasionTextBtnGetReward"))
	UGUIUtil.SetText(self.TextBtnTip, ActivityUIApi:GetString("InvasionTextBtnTip"))

	function self.delegateBtnTip()
		self:OnBtnTip()
	end

	function self.delegateUpdateOperations()
		self:UpDateView()
	end

	function self.delegateBtnGetReward()
		self:OnBtnGetReward()
	end

	self.scrollLevel = self.ScrollLevel:GetComponent("ScrollAreaList")

	function self.scrollLevel.onRenderCell(cell)
		self:OnRenderGroupCell(cell)
	end

	function self.scrollLevel.onSelectedCell(cell)
		self:OnSelectGroupCell(cell)
	end

	self.goProgressCell:SetActive(false)

	self.rewardBoxCellPool = UIObjectPool.New(5, function()
		return RewardBoxCell.New(UnityEngine.Object.Instantiate(self.goProgressCell), self.root)
	end, function(cell)
		cell:Dispose()
	end)
	self.challengeRecordCells = {}

	for i = 1, 2 do
		local cell = ChallengeRecordCell.New(self["ChallengeRecord" .. i], i, self)

		self.challengeRecordCells[i] = cell
	end
end

function m.GetPreloadAssetPaths()
	return
end

function m:Update(elapseSeconds, realElapseSeconds)
	return
end

function m:AddListener()
	self.TipBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnTip)
	self.BtnGetReward:GetComponent("Button").onClick:AddListener(self.delegateBtnGetReward)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function m:RemoveListener()
	self.TipBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnTip)
	self.BtnGetReward:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGetReward)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function m:UpDateView()
	if ActiveOperationEventModule.CheckIsOpen(self.operateEventID) then
		self.eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.operateEventID)

		if self.eventPOD then
			self.cfgDoubleFightGlobal = CfgDoubleFightGlobalTable[self.eventPOD.dataCfgId]

			UGUIUtil.SetText(self.TextOpenTime, ActivityUIApi:GetString("InvasionTextOpenTime", getCustomDateTimeText(self.eventPOD.startTime, "MonthToMinuteFormat"), getCustomDateTimeText(self.eventPOD.endTime, "MonthToMinuteFormat")))

			self.cfgFightList = self.cfgDoubleFightGlobal.FightList

			self.scrollLevel:Refresh(#self.cfgFightList)
			self:ShowSelectLevel()
		end
	end
end

function m:OnRenderGroupCell(cell)
	local luaIndex = cell.index + 1
	local cfgID = self.cfgFightList[luaIndex]
	local insID = cell.gameObject:GetInstanceID()
	local levelCell = self.challengeLevelPool[insID]

	if levelCell == nil then
		levelCell = ChallengeLevelCell.New(cell.gameObject)
		self.challengeLevelPool[insID] = levelCell
	end

	local isUnlock = ActiveDoubleFightModule.CheckChallengeLevelUnlock(self.operateEventID, cfgID)

	levelCell:SetDate(self.cfgDoubleFightGlobal, luaIndex, isUnlock, self.operateEventID)

	if self.selectLevel == nil and isUnlock then
		self.selectLevel = cfgID
	end

	levelCell:SetSelect(self.selectLevel == cfgID)
end

function m:OnSelectGroupCell(cell)
	local luaIndex = cell.index + 1
	local cfgID = self.cfgFightList[luaIndex]
	local isUnlock = ActiveDoubleFightModule.CheckChallengeLevelUnlock(self.operateEventID, cfgID)

	if isUnlock then
		self.selectLevel = cfgID

		for i, v in pairs(self.challengeLevelPool) do
			if v.cfgID == self.selectLevel then
				v:SetSelect(true)
			else
				v:SetSelect(false)
			end
		end

		self:ShowSelectLevel()
	end
end

function m:ShowSelectLevel()
	self.selectDoubleFightStepPOD = ActiveDoubleFightModule.GetDoubleFightStepPOD(self.operateEventID, self.selectLevel)

	if self.selectDoubleFightStepPOD then
		for i, v in pairs(self.rewardBoxCells) do
			v.View.transform:SetParent(self.root.UIController.transform, false)
			v.View:SetActive(false)
			self.rewardBoxCellPool:Release(v)
		end

		self.rewardBoxCells = {}

		local maxScore = 0
		local cfgDoubleFightList = CfgDoubleFightListTable[self.selectLevel]

		for i = 1, #cfgDoubleFightList.ScoreList do
			local cell = self.rewardBoxCellPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.RewardBox.transform, false)
			cell:SetData(self.operateEventID, self.selectLevel, i)
			table.insert(self.rewardBoxCells, cell)

			if maxScore < cell.score then
				maxScore = cell.score
			end
		end

		local per = self.selectDoubleFightStepPOD.maxScore / maxScore

		self.goBarProgress:GetComponent("Image").fillAmount = per
	end

	for i, v in pairs(self.challengeRecordCells) do
		local doubleFightRecordPOD = self:GetDoubleFightRecordPOD(i)

		v:UpdateView(doubleFightRecordPOD, self.operateEventID, self.selectLevel)
	end
end

function m:GetDoubleFightRecordPOD(index)
	if self.selectDoubleFightStepPOD and self.selectDoubleFightStepPOD.records then
		for i, v in pairs(self.selectDoubleFightStepPOD.records) do
			if v.index == index then
				return v
			end
		end
	end

	return nil
end

function m:OnBtnTip()
	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, self.cfgDoubleFightGlobal.Desc)
end

function m:OnBtnGetReward()
	local tab = {}

	for i, v in pairs(self.rewardBoxCells) do
		if v.state == 2 then
			table.insert(tab, v.index)
		end
	end

	if #tab > 0 then
		ActiveDoubleFightModule.GetRewards(self.operateEventID, self.selectLevel, tab)
	end
end

function m:Open()
	self:AddListener()
	self.View:SetActive(true)
	self:UpDateView()
	ActiveDoubleFightModule.SaveOpenDoubleFightPrefs(self.operateEventID)
end

function m:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function m:OnHide()
	self:RemoveListener()
end

function m:OnDestroy()
	for i, v in pairs(self.challengeRecordCells) do
		v:Dispose()
	end

	for i, v in pairs(self.rewardBoxCells) do
		self.rewardBoxCellPool:Release(v)
	end

	self.rewardBoxCells = {}

	self.rewardBoxCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
