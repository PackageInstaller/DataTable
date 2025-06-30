-- chunkname: @IQIGame\\UI\\ExploreHall\\FishingActivity\\FishingActivityMission\\FishingActivityMissionItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.TaskUIData = data

	UGUIUtil.SetText(self.TitleText, CfgMainQuestTable[self.TaskUIData.cid].Name)
	UGUIUtil.SetText(self.NameText, CfgMainQuestTable[self.TaskUIData.cid].Description)
	UGUIUtil.SetText(self.StateText, FishingActivityMissionUIApi:GetString("StateText", self.TaskUIData.TaskStatus))

	local num = CfgMainQuestTable[self.TaskUIData.cid].Reward[2]

	UGUIUtil.SetText(self.ProgressText, FishingActivityMissionUIApi:GetString("ProgressText", num))
	self.Complete:SetActive(self.TaskUIData.TaskStatus == 3)
	self.NoComplete:SetActive(self.TaskUIData.TaskStatus ~= 3)
	UGUIUtil.SetText(self.CompleteTitleText, CfgMainQuestTable[self.TaskUIData.cid].Name)
	UGUIUtil.SetText(self.CompleteNameText, CfgMainQuestTable[self.TaskUIData.cid].Description)
	UGUIUtil.SetText(self.CompleteStateText, FishingActivityMissionUIApi:GetString("StateText", self.TaskUIData.TaskStatus))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
