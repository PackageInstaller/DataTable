-- chunkname: @IQIGame\\UI\\ActivityList\\DiceGameActivity\\DiceGameTaskUI_taskItem.lua

local DiceGameTaskUI_taskItem = {}

function DiceGameTaskUI_taskItem.New(go, mainView)
	local o = Clone(DiceGameTaskUI_taskItem)

	o:Initialize(go, mainView)

	return o
end

function DiceGameTaskUI_taskItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function DiceGameTaskUI_taskItem:InitComponent()
	return
end

function DiceGameTaskUI_taskItem:InitDelegate()
	function self.delegateOnClickGetBtn()
		self:OnClickGetBtn()
	end
end

function DiceGameTaskUI_taskItem:AddListener()
	self.GetBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickGetBtn)
end

function DiceGameTaskUI_taskItem:RemoveListener()
	self.GetBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickGetBtn)
end

function DiceGameTaskUI_taskItem:OnClickGetBtn()
	TaskSystemModule.SubmitTask({
		self.data.cid
	})
end

function DiceGameTaskUI_taskItem:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function DiceGameTaskUI_taskItem:Refresh(Data)
	self.data = Data

	local cfgTask = TaskSystemModule.GetCfgTaskDataWithID(self.data.cid)

	LuaUtility.SetGameObjectShow(self.hadGot, self.data.status == Constant.TaskStatus.hadGot)
	LuaUtility.SetGameObjectShow(self.hasDone, self.data.status == Constant.TaskStatus.hasDone)
	LuaUtility.SetGameObjectShow(self.noFinish, self.data.status == Constant.TaskStatus.doing)
	LuaUtility.SetText(self.taskDescription, cfgTask.Desc)
end

return DiceGameTaskUI_taskItem
