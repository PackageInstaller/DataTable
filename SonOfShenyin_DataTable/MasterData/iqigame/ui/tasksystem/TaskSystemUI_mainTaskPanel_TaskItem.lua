-- chunkname: @IQIGame\\UI\\TaskSystem\\TaskSystemUI_mainTaskPanel_TaskItem.lua

local m = {}

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
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function m:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
	EventUtil.AddEventListener(self, EventID.TrackTaskResultEvent)
end

function m:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
	EventUtil.ClearEventListener(self)
end

function m:__OnTrackTaskResultEventHandler()
	LuaUtility.SetGameObjectShow(self.TagTrack, PlayerModule.GetTrackTaskCid() == self.data.cid)
end

function m:OnClickButtonClick()
	self.mainView:OnTaskSelected(self)
end

function m:Selected()
	LuaUtility.SetGameObjectShow(self.selected, true)
end

function m:UnSelected()
	LuaUtility.SetGameObjectShow(self.selected, false)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function m:Refresh(Data, taskType)
	self.data = Data

	local cfgTask = CfgUtil.GetTaskCfgWithID(self.data.cid)

	LuaUtility.SetText(self.textName, cfgTask.Name)
	LuaUtility.SetGameObjectShow(self.TagTrack, PlayerModule.GetTrackTaskCid() == self.data.cid)

	self.gameObject.name = self.data.cid

	if TaskSystemModule.CheckTaskIsFinished(self.data) then
		LuaUtility.SetGameObjectShow(self.stateHadDone, true)
		LuaUtility.SetGameObjectShow(self.stateDoing, false)
		LuaUtility.SetGameObjectShow(self.stateCanGet, false)
		LuaUtility.SetGameObjectShow(self.stateLocked, false)
	else
		LuaUtility.SetGameObjectShow(self.stateHadDone, false)

		local childTask = WorldMapModule.GetCurrentChildTaskByParentTaskId(self.data.cid, taskType)

		if childTask then
			LuaUtility.SetGameObjectShow(self.stateDoing, WorldMapModule.GetChildTaskType(childTask.cid) == Constant.RPGTaskType.DungeonChildTask)
			LuaUtility.SetGameObjectShow(self.stateCanGet, WorldMapModule.GetChildTaskType(childTask.cid) == Constant.RPGTaskType.DialogChildTask)
			LuaUtility.SetGameObjectShow(self.stateLocked, WorldMapModule.GetChildTaskType(childTask.cid) == Constant.RPGTaskType.LvChildTask)
		else
			LuaUtility.SetGameObjectShow(self.stateDoing, false)
			LuaUtility.SetGameObjectShow(self.stateCanGet, false)
			LuaUtility.SetGameObjectShow(self.stateLocked, false)
		end
	end

	if self.mainView.currentSelectId and self.mainView.currentSelectId == self.data.cid then
		self:Selected()
	else
		self:UnSelected()
	end
end

function m:OnDestroy()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return m
