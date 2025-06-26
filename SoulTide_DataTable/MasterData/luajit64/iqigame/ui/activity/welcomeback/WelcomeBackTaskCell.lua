-- chunkname: @IQIGame\\UI\\Activity\\WelcomeBack\\WelcomeBackTaskCell.lua

local m = {
	totalComplete = 0,
	taskRewardTab = {},
	rewardCellPool = {}
}
local WelcomeBackTaskRewardCell = require("IQIGame.UI.Activity.WelcomeBack.WelcomeBackTaskRewardCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.Text01, WelcomeBackUIApi:GetString("Text01"))
	UGUIUtil.SetText(self.Text03, WelcomeBackUIApi:GetString("Text03"))
	UGUIUtil.SetText(self.BtnGetRewardLabel1, WelcomeBackUIApi:GetString("BtnGetRewardLabel1"))
	UGUIUtil.SetText(self.BtnGetRewardLabel2, WelcomeBackUIApi:GetString("BtnGetRewardLabel2"))
	UGUIUtil.SetText(self.BtnGetRewardLabel3, WelcomeBackUIApi:GetString("BtnGetRewardLabel3"))

	self.scrollArea = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollArea.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.delegateBtnGetReward1()
		self:OnBtnGetReward1()
	end

	function self.delegateBtnGetReward2()
		self:OnBtnGetReward2()
	end

	function self.delegateBtnGetReward3()
		self:OnBtnGetReward3()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnGetReward1:GetComponent("Button").onClick:AddListener(self.delegateBtnGetReward1)
	self.BtnGetReward2:GetComponent("Button").onClick:AddListener(self.delegateBtnGetReward2)
	self.BtnGetReward3:GetComponent("Button").onClick:AddListener(self.delegateBtnGetReward3)
end

function m:RemoveListener()
	self.BtnGetReward1:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGetReward1)
	self.BtnGetReward2:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGetReward1)
	self.BtnGetReward3:GetComponent("Button").onClick:RemoveListener(self.delegateBtnGetReward3)
end

function m:SetData(data, index, totalComplete)
	self.taskUIData = data
	self.index = index
	self.totalComplete = totalComplete
	self.cfgTaskData = CfgMainQuestTable[self.taskUIData.cid]

	if self.taskUIData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK then
		if self.taskUIData.CurrentNum >= self.taskUIData.TargetNum then
			self.state = 2
		else
			self.state = 1
		end
	else
		self.state = 3
	end

	self:UpdateView()
end

function m:UpdateView()
	self.BtnGetReward1:SetActive(self.state == 2)
	self.BtnGetReward2:SetActive(self.state == 1)
	self.BtnGetReward3:SetActive(self.state == 3)
	self.Bg1:SetActive(self.state == 3)
	self.Bg2:SetActive(self.state == 2)
	self.Bg3:SetActive(self.state == 1)
	UGUIUtil.SetText(self.Text02, WelcomeBackUIApi:GetString("Text02", self.index))

	local complete = self.totalComplete

	if self.state > 1 then
		complete = self.index
	end

	if complete > self.index then
		complete = self.index
	end

	UGUIUtil.SetText(self.TextNeedLv, WelcomeBackUIApi:GetString("TextNeedLv", self.cfgTaskData.Description, complete, self.index))

	self.taskRewardTab = {}

	for i = 1, #self.cfgTaskData.Reward, 2 do
		local tab = {}

		tab.ID = self.cfgTaskData.Reward[i]
		tab.Num = self.cfgTaskData.Reward[i + 1]

		table.insert(self.taskRewardTab, tab)
	end

	self.scrollArea:Refresh(#self.taskRewardTab)
end

function m:OnRenderGridCell(cell)
	local data = self.taskRewardTab[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.rewardCellPool[instanceID]

	if renderCell == nil then
		renderCell = WelcomeBackTaskRewardCell.New(cell.gameObject)
		self.rewardCellPool[instanceID] = renderCell
	end

	renderCell:SetData(data)
end

function m:OnBtnGetReward1()
	if not ActiveWelcomeBackModule.ActiveWelcomeBackIsOpen() then
		UIModule.Close(Constant.UIControllerName.WelcomeBackUI)

		return
	end

	ActiveWelcomeBackModule.GetReward(self.taskUIData.cid)
end

function m:OnBtnGetReward2()
	return
end

function m:OnBtnGetReward3()
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
