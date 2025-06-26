-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkTask\\AmusementParkTaskItem.lua

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
	self.taskUIData = data

	UGUIUtil.SetText(self.TitleText, CfgMainQuestTable[self.taskUIData.cid].Name)
	UGUIUtil.SetText(self.NameText, CfgMainQuestTable[self.taskUIData.cid].Description)
	UGUIUtil.SetText(self.StateText, AmusementParkMissionUIApi:GetString("StateText", self.taskUIData.TaskStatus))

	local num = CfgMainQuestTable[self.taskUIData.cid].Reward[2]

	UGUIUtil.SetText(self.ProgressText, AmusementParkMissionUIApi:GetString("ProgressText", num))
	self.Complete:SetActive(self.taskUIData.TaskStatus == 3)
	self.NoComplete:SetActive(self.taskUIData.TaskStatus ~= 3)
	UGUIUtil.SetText(self.CompleteTitleText, CfgMainQuestTable[self.taskUIData.cid].Name)
	UGUIUtil.SetText(self.CompleteNameText, CfgMainQuestTable[self.taskUIData.cid].Description)
	UGUIUtil.SetText(self.CompleteStateText, AmusementParkMissionUIApi:GetString("StateText", self.taskUIData.TaskStatus))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
