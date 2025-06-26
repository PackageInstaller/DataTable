-- chunkname: @IQIGame\\UI\\DualTeamExplore\\DualTeamExploreMissionItemState.lua

local m = {
	State = 0,
	RewardCells = {}
}

function m.New(view, state, rewardCellPool, onClickCallback)
	local obj = Clone(m)

	obj:Init(view, state, rewardCellPool, onClickCallback)

	return obj
end

function m:Init(view, state, rewardCellPool, onClickCallback)
	self.View = view
	self.State = state
	self.RewardCellPool = rewardCellPool
	self.OnClickCallback = onClickCallback

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickFunctionBtn()
		self:OnClickFunctionBtn()
	end

	self.BtnCDTimer = Timer.New(function()
		local functionBtnCom = self.FunctionBtn:GetComponent("Button")

		functionBtnCom.interactable = true
	end, 1)

	self:AddListeners()
end

function m:AddListeners()
	if self.FunctionBtn ~= nil then
		local functionBtnCom = self.FunctionBtn:GetComponent("Button")

		if functionBtnCom ~= nil then
			functionBtnCom.onClick:AddListener(self.DelegateOnClickFunctionBtn)
		end
	end
end

function m:RemoveListeners()
	if self.FunctionBtn ~= nil then
		local functionBtnCom = self.FunctionBtn:GetComponent("Button")

		if functionBtnCom ~= nil then
			functionBtnCom.onClick:RemoveListener(self.DelegateOnClickFunctionBtn)
		end
	end
end

function m:SetData(taskUIData, currentState)
	self.View:SetActive(self.State == currentState)

	if self.State ~= currentState then
		return
	end

	local cfgMainQuestData = CfgMainQuestTable[taskUIData.cid]

	UGUIUtil.SetText(self.TargetDescText, DualTeamExploreMissionUIApi:GetString("StateView_TargetDescText_L3", cfgMainQuestData.Description, taskUIData.CurrentNum, taskUIData.TargetNum))
	UGUIUtil.SetText(self.ProgressText, DualTeamExploreMissionUIApi:GetString("StateView_ProgressText_L3", taskUIData.CurrentNum, taskUIData.TargetNum))

	self.ProgressBar:GetComponent("Image").fillAmount = taskUIData.CurrentNum / taskUIData.TargetNum

	self.FlagIcon:SetActive(cfgMainQuestData.Flag ~= "")

	if cfgMainQuestData.Flag ~= "" then
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgMainQuestData.Flag), self.FlagIcon:GetComponent("Image"))
	end

	self:ClearRewardCells()

	for i = 1, #cfgMainQuestData.Reward, 2 do
		local itemCid = cfgMainQuestData.Reward[i]
		local itemNum = cfgMainQuestData.Reward[i + 1]
		local cell = self.RewardCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.RewardGrid.transform, false)
		cell:SetData(itemCid, itemNum)
		table.insert(self.RewardCells, cell)
	end
end

function m:ClearRewardCells()
	for i = 1, #self.RewardCells do
		local cell = self.RewardCells[i]

		cell.View:SetActive(false)
		cell.View.transform:SetParent(self.View.transform, false)
		self.RewardCellPool:Release(cell)
	end

	self.RewardCells = {}
end

function m:OnClickFunctionBtn()
	if self.OnClickCallback ~= nil then
		self.OnClickCallback(self.State)
	end

	local functionBtnCom = self.FunctionBtn:GetComponent("Button")

	functionBtnCom.interactable = false

	self.BtnCDTimer:Stop()
	self.BtnCDTimer:Start()
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self.BtnCDTimer:Stop()
	self:ClearRewardCells()
	self:RemoveListeners()

	self.RewardCellPool = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
