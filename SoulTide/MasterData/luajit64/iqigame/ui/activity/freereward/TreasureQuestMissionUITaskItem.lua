-- chunkname: @IQIGame\\UI\\Activity\\FreeReward\\TreasureQuestMissionUITaskItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(taskUIData)
	local cfgMainQuestData = CfgMainQuestTable[taskUIData.cid]

	UGUIUtil.SetText(self.TargetProgressText, TreasureQuestMissionUIApi:GetString("Item_TargetProgressText", cfgMainQuestData.Name, taskUIData.CurrentNum, taskUIData.TargetNum))

	local itemCid = cfgMainQuestData.Reward[1]
	local itemNum = cfgMainQuestData.Reward[2]
	local cfgItemData = CfgItemTable[itemCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.RewardIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.RewardNumText, TreasureQuestMissionUIApi:GetString("Item_RewardNumText", itemNum))
	UGUIUtil.SetText(self.StateText, TreasureQuestMissionUIApi:GetString("Item_StateText", taskUIData.TaskStatus))
	self.StateImage:SetActive(taskUIData.TaskStatus == TaskModule.TaskStatus.FINISH_TASK)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
