-- chunkname: @IQIGame\\UI\\ActivityStage\\ActivityStageUI_stagePanel_targetDescribeItem.lua

local ActivityStageUI_stagePanel_targetDescribeItem = {}

function ActivityStageUI_stagePanel_targetDescribeItem.New(go, mainView)
	local o = Clone(ActivityStageUI_stagePanel_targetDescribeItem)

	o:Initialize(go, mainView)

	return o
end

function ActivityStageUI_stagePanel_targetDescribeItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function ActivityStageUI_stagePanel_targetDescribeItem:InitComponent()
	return
end

function ActivityStageUI_stagePanel_targetDescribeItem:InitDelegate()
	return
end

function ActivityStageUI_stagePanel_targetDescribeItem:AddListener()
	return
end

function ActivityStageUI_stagePanel_targetDescribeItem:RemoveListener()
	return
end

function ActivityStageUI_stagePanel_targetDescribeItem:OnDestroy()
	return
end

function ActivityStageUI_stagePanel_targetDescribeItem:Refresh(Data, activityStageId)
	self.data = Data

	LuaUtility.SetText(self.textName_frameLock, self.data.Name)
	LuaUtility.SetText(self.textName_frame, self.data.Name)
	LuaUtility.SetGameObjectShow(self.FrameLock, not self.mainView:GetTargetIsComplete(activityStageId, self.data.Id))
end

return ActivityStageUI_stagePanel_targetDescribeItem
