-- chunkname: @IQIGame\\UI\\Activity\\Common\\ActivityTaskItemState.lua

local m = {
	InitState = 0,
	RewardCells = {}
}

function m.New(view, state, rewardPool, api, onClick)
	local obj = Clone(m)

	obj:Init(view, state, rewardPool, api, onClick)

	return obj
end

function m:Init(view, state, rewardPool, api, onClick)
	self.View = view
	self.InitState = state
	self.RewardPool = rewardPool
	self.Api = api
	self.OnClickCallback = onClick

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickFunctionBtn()
		self:OnClickFunctionBtn()
	end

	if api == nil then
		logError("必须传入Api")
	elseif api.langApiFuncList.TaskItemFunctionBtnText == nil or api.langApiFuncList.TaskItemProgressText == nil then
		logError("Api必须包含方法：Name:TaskItemFunctionBtnText, Param:state[1,2,3], Name:TaskItemProgressText, Param:finishNum, targetNum")
	end

	UGUIUtil.SetTextInChildren(self.FunctionBtn, api:GetString("TaskItemFunctionBtnText", state))
	self:AddListeners()
end

function m:AddListeners()
	local functionBtnCom = self.FunctionBtn:GetComponent("Button")

	if functionBtnCom ~= nil then
		functionBtnCom.onClick:AddListener(self.DelegateOnClickFunctionBtn)
	end
end

function m:RemoveListeners()
	local functionBtnCom = self.FunctionBtn:GetComponent("Button")

	if functionBtnCom ~= nil then
		functionBtnCom.onClick:RemoveListener(self.DelegateOnClickFunctionBtn)
	end
end

function m:SetData(taskUIData, taskState)
	self:BaseSetData(taskUIData, taskState)
end

function m:BaseSetData(taskUIData, taskState)
	self.View:SetActive(self.InitState == taskState)

	if self.InitState == taskState then
		local cfgMainQuestData = CfgMainQuestTable[taskUIData.cid]
		local cfgTargetData = CfgTargetTable[cfgMainQuestData.TargetId]

		UGUIUtil.SetText(self.NameText, cfgTargetData.TargetDes)
		UGUIUtil.SetText(self.ProgressText, self.Api:GetString("TaskItemProgressText", taskUIData.CurrentNum, taskUIData.TargetNum))
		self:ClearRewardCells()

		for i = 1, #cfgMainQuestData.Reward, 2 do
			local itemCid = cfgMainQuestData.Reward[i]
			local itemNum = cfgMainQuestData.Reward[i + 1]
			local rewardCell = self.RewardPool:Obtain()

			rewardCell.ViewGo.transform:SetParent(self.RewardGrid.transform, false)
			rewardCell:SetItemByCID(itemCid, itemNum)
			table.insert(self.RewardCells, rewardCell)
		end
	end
end

function m:ClearRewardCells()
	for i = 1, #self.RewardCells do
		local rewardCell = self.RewardCells[i]

		rewardCell.ViewGo:SetActive(false)
		self.RewardPool:Release(rewardCell)
	end

	self.RewardCells = {}
end

function m:OnClickFunctionBtn()
	if self.OnClickCallback ~= nil then
		self.OnClickCallback(self.InitState)
	end
end

function m:Dispose()
	self:BaseDispose()
end

function m:BaseDispose()
	self:ClearRewardCells()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
