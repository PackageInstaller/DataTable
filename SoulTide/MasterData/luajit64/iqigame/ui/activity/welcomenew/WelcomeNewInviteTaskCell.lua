-- chunkname: @IQIGame\\UI\\Activity\\WelcomeNew\\WelcomeNewInviteTaskCell.lua

local m = {
	showRewardTab = {},
	rewardCellPool = {}
}
local WelcomeNewInviteTaskRewardCell = require("IQIGame.UI.Activity.WelcomeNew.WelcomeNewInviteTaskRewardCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.BtnGetRewardLabel1, WelcomeActivityInviterUIApi:GetString("BtnGetRewardLabel", 1))

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.delegateBtnGetReward1()
		self:OnBtnGetReward1()
	end

	function self.delegateBtnGetReward2()
		self:OnBtnGetReward2()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnGetReward1:GetComponent("Button").onClick:AddListener(self.delegateBtnGetReward1)
	self.BtnGetReward2:GetComponent("Button").onClick:AddListener(self.delegateBtnGetReward2)
end

function m:RemoveListener()
	self.BtnGetReward1:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGetReward1)
	self.BtnGetReward2:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGetReward2)
end

function m:SetData(operateEventID, data)
	self.operateEventID = operateEventID
	self.cfgWelcomeTaskData = data
	self.showRewardTab = {}

	if self.cfgWelcomeTaskData then
		for i = 1, #self.cfgWelcomeTaskData.Reward, 2 do
			local tab = {}

			tab.ID = self.cfgWelcomeTaskData.Reward[i]
			tab.Num = self.cfgWelcomeTaskData.Reward[i + 1]

			table.insert(self.showRewardTab, tab)
		end

		local completeNum, taskState = ActiveWelcomeNewModule.GetTaskSate(self.cfgWelcomeTaskData.Id)

		if completeNum > self.cfgWelcomeTaskData.NeedNum then
			completeNum = self.cfgWelcomeTaskData.NeedNum
		end

		local str = WelcomeActivityInviterUIApi:GetString("TextNeedLv", self.cfgWelcomeTaskData.Condition, completeNum, self.cfgWelcomeTaskData.NeedNum)

		UGUIUtil.SetText(self.TextNeedLv, str)
		UGUIUtil.SetText(self.BtnGetRewardLabel2, WelcomeActivityInviterUIApi:GetString("BtnGetRewardLabel", taskState))
		self.scrollList:Refresh(#self.showRewardTab)

		local canGetReward = taskState == 1

		self.Bg1:SetActive(canGetReward)
		self.Bg2:SetActive(not canGetReward)
		self.BtnGetReward1:SetActive(canGetReward)
		self.BtnGetReward2:SetActive(not canGetReward)
	end
end

function m:OnRenderGridCell(cell)
	local data = self.showRewardTab[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.rewardCellPool[instanceID]

	if renderCell == nil then
		renderCell = WelcomeNewInviteTaskRewardCell.New(cell.gameObject)
		self.rewardCellPool[instanceID] = renderCell
	end

	renderCell:SetData(data)
end

function m:OnBtnGetReward1()
	if self.operateEventID then
		ActiveWelcomeNewModule.ConfirmTask(self.operateEventID, self.cfgWelcomeTaskData.Id)
	end
end

function m:OnBtnGetReward2()
	return
end

function m:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.rewardCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
