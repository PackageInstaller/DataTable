-- chunkname: @IQIGame\\UI\\TaskSystem\\TaskSystemUI_mainTaskPanel_GoalItem.lua

local m = {}
local dataName_state = "state"
local stateName_over = "over"
local stateName_notOver = "notOver"

function m.New(go, mainView)
	local o = Clone(m)

	o:Initialize(go, mainView)

	return o
end

function m:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function m:InitComponent()
	return
end

function m:InitDelegate()
	return
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function m:Refresh(Data, isParentTaskFinished)
	self.data = Data

	local cfgTask = CfgUtil.GetTaskCfgWithID(self.data.cid)

	if isParentTaskFinished then
		LuaUtility.SetText(self.textDetail, string.format("(%s/%s) %s", self.data.needSchedule, self.data.needSchedule, cfgTask.Desc))
		LuaUtility.SetStateController(self.gameObject, dataName_state, stateName_over)

		return
	end

	if self.data.virtual and UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_GM_TOOL) and not TaskSystemModule.GetFinishedTaskWithID(self.data.cid) then
		LuaUtility.SetText(self.textDetail, string.format("(%s/%s) %s <color=#e04a37>(这个任务没有接取!!!!)</color>", self.data.schedule, self.data.needSchedule, cfgTask.Desc))
	else
		LuaUtility.SetText(self.textDetail, string.format("(%s/%s) %s", self.data.schedule, self.data.needSchedule, cfgTask.Desc))
	end

	if TaskSystemModule.CheckTaskIsFinished(self.data) then
		LuaUtility.SetStateController(self.gameObject, dataName_state, stateName_over)
	else
		LuaUtility.SetStateController(self.gameObject, dataName_state, stateName_notOver)
	end
end

function m:OnDestroy()
	self:RemoveListener()
end

return m
