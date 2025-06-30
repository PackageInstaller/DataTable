-- chunkname: @IQIGame\\UI\\ActiveActivityList\\GhostActivity\\GhostGameTaskUI_taskItem.lua

local GhostGameTaskUI_taskItem = {}

function GhostGameTaskUI_taskItem.New(go, mainView)
	local o = Clone(GhostGameTaskUI_taskItem)

	o:Initialize(go, mainView)

	return o
end

function GhostGameTaskUI_taskItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function GhostGameTaskUI_taskItem:InitComponent()
	self.commonSlot = ItemCell.New(self.commonSlotUI, true)
end

function GhostGameTaskUI_taskItem:InitDelegate()
	function self.delegateOnClickGetBtn()
		self:OnClickGetBtn()
	end
end

function GhostGameTaskUI_taskItem:AddListener()
	self.GetBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickGetBtn)
end

function GhostGameTaskUI_taskItem:RemoveListener()
	self.GetBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickGetBtn)
end

function GhostGameTaskUI_taskItem:OnClickGetBtn()
	TaskSystemModule.SubmitTask({
		self.data.cid
	})
end

function GhostGameTaskUI_taskItem:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function GhostGameTaskUI_taskItem:Refresh(Data)
	self.data = Data

	local cfgTask = TaskSystemModule.GetCfgTaskDataWithID(self.data.cid)

	LuaUtility.SetGameObjectShow(self.hadGot, self.data.status == Constant.TaskStatus.hadGot)
	LuaUtility.SetGameObjectShow(self.hasDone, self.data.status == Constant.TaskStatus.hasDone)
	LuaUtility.SetGameObjectShow(self.noFinish, self.data.status == Constant.TaskStatus.doing)
	LuaUtility.SetText(self.taskDescription, cfgTask.Desc)
	self.commonSlot:SetItemByCid(cfgTask.ActionParam[1], cfgTask.ActionParam[2])
	self.commonSlot:SetNum(cfgTask.ActionParam[2])
end

return GhostGameTaskUI_taskItem
