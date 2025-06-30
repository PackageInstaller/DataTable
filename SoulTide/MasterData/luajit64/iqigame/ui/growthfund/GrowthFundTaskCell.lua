-- chunkname: @IQIGame\\UI\\GrowthFund\\GrowthFundTaskCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetTextInChildren(self.ProcessingView, GrowthFundUIApi:GetCell_ProcessingViewText())
	UGUIUtil.SetTextInChildren(self.RewardView, GrowthFundUIApi:GetCell_RewardViewText())
	UGUIUtil.SetTextInChildren(self.FinishView, GrowthFundUIApi:GetCell_FinishViewText())
end

function m:SetData(taskData)
	local state = 1

	if taskData.TaskStatus == TaskModule.TaskStatus.FINISH_TASK then
		state = 3
	elseif taskData.CurrentNum >= taskData.TargetNum then
		state = 2
	end

	self.ProcessingView:SetActive(state == 1)
	self.RewardView:SetActive(state == 2)
	self.FinishView:SetActive(state == 3)

	local cfgMainQuestData = CfgMainQuestTable[taskData.cid]
	local cfgTargetData = CfgTargetTable[cfgMainQuestData.TargetId]

	UGUIUtil.SetText(self.LevelText, tostring(cfgTargetData.TargetNum))

	local rewardTreasureNum = 0

	for i = 1, #cfgMainQuestData.Reward, 2 do
		local itemCid = cfgMainQuestData.Reward[i]
		local itemNum = cfgMainQuestData.Reward[i + 1]

		if itemCid == Constant.ItemID.TREASURE then
			rewardTreasureNum = rewardTreasureNum + itemNum
		end
	end

	UGUIUtil.SetText(self.RewardNumText, tostring(rewardTreasureNum))
end

function m:Reset()
	return
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
