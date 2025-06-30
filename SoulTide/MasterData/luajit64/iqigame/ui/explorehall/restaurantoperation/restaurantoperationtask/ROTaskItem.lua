-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\RestaurantOperationTask\\ROTaskItem.lua

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
	UGUIUtil.SetText(self.StateText, RestaurantOperationMissionUIApi:GetString("StateText", self.taskUIData.TaskStatus))

	local num = CfgMainQuestTable[self.taskUIData.cid].Reward[2]

	UGUIUtil.SetText(self.ProgressText, RestaurantOperationMissionUIApi:GetString("ProgressText", num))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
