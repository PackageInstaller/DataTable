-- chunkname: @IQIGame\\UI\\Main\\MainUI_RPGInfoPanel.lua

local MainUI_RPGInfoPanel = {}
local dataName_time = "time"
local dataName_switchTime = "switchTime"
local stateName_day = "day"
local stateName_night = "night"
local stateName_switchTime_day = "day"
local stateName_switchTime_night = "night"

function MainUI_RPGInfoPanel.New(go, mainView)
	local o = Clone(MainUI_RPGInfoPanel)

	o:Initialize(go, mainView)

	return o
end

function MainUI_RPGInfoPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function MainUI_RPGInfoPanel:InitComponent()
	LuaUtility.SetGameObjectShow(self.storyInfo, false)
end

function MainUI_RPGInfoPanel:InitDelegate()
	function self.delegateOnClickButtonMap()
		self:OnClickButtonMap()
	end

	function self.onTaskNotify()
		self:Refresh()
	end

	function self.delegateOnClickButtonTask()
		self:OnClickButtonTask()
	end

	function self.setStoryInfoEvent(textId, progress)
		self:SetStoryInfo(textId, progress)
	end

	function self.onEnterRoomEvent()
		self:Refresh()
	end

	function self.delegateOnClickButtonSwitchTime()
		self:OnClickButtonSwitchTime()
	end
end

function MainUI_RPGInfoPanel:AddListener()
	self.buttonMap:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonMap)
	self.buttonTask:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonTask)
	self.buttonSwitchTime:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonSwitchTime)
	EventDispatcher.AddEventListener(EventID.TaskNotifyTask, self.onTaskNotify)
	EventDispatcher.AddEventListener(EventID.TaskNotifyFinish, self.onTaskNotify)
	EventDispatcher.AddEventListener(EventID.TaskNotifyRemove, self.onTaskNotify)
	EventDispatcher.AddEventListener(EventID.MainUI_RPGInfoPanel_SetStoryInfoEvent, self.setStoryInfoEvent)
	EventDispatcher.AddEventListener(EventID.WorldMapRoom_EnterRoomResultEvent, self.onEnterRoomEvent)
	EventUtil.AddEventListener(self, EventID.MainUI_RPGInfoPanel_SetStoryInfoShowEvent)
	EventUtil.AddEventListener(self, EventID.WorldMapRPG_NotifyTimeChangeEvent)
	EventUtil.AddEventListener(self, EventID.TrackTaskResultEvent)
	UIEventUtil.AddClickEventListener_Button(self, "btnGoto", self.__OnBtnGotoClick)
end

function MainUI_RPGInfoPanel:RemoveListener()
	self.buttonMap:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonMap)
	self.buttonTask:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonTask)
	self.buttonSwitchTime:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonSwitchTime)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyTask, self.onTaskNotify)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyFinish, self.onTaskNotify)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyRemove, self.onTaskNotify)
	EventDispatcher.RemoveEventListener(EventID.MainUI_RPGInfoPanel_SetStoryInfoEvent, self.setStoryInfoEvent)
	EventDispatcher.RemoveEventListener(EventID.WorldMapRoom_EnterRoomResultEvent, self.onEnterRoomEvent)
	EventUtil.ClearEventListener(self)
	UIEventUtil.ClearEventListener(self)
end

function MainUI_RPGInfoPanel:__OnTrackTaskResultEventHandler()
	self:RefreshMainTask()
	LuaUtility.SetGameObjectShow(self.fx_taskRefresh, false)
	LuaUtility.SetGameObjectShow(self.fx_taskRefresh, true)
end

function MainUI_RPGInfoPanel:__OnWorldMapRPG_NotifyTimeChangeEventHandler()
	self:RefreshTime()
	HomeModule.RefreshRoomByTime()
end

function MainUI_RPGInfoPanel:__OnMainUI_RPGInfoPanel_SetStoryInfoShowEventHandler(show)
	LuaUtility.SetGameObjectShow(self.storyInfo, show)
end

function MainUI_RPGInfoPanel:OnClickButtonSwitchTime()
	if WorldMapModule.GetTimeState() == Constant.WorldMapTimeState.Day then
		WorldMapModule.ChangeMapTimeSpan(Constant.WorldMapTimeState.Night)
	else
		WorldMapModule.ChangeMapTimeSpan(Constant.WorldMapTimeState.Day)
	end
end

function MainUI_RPGInfoPanel:OnClickButtonTask()
	if UnlockFunctionModule.OnClickInterceptor(Constant.UnlockType.FUNC_TASK) then
		return
	end

	if StoryModule.IsStoring and StoryModule.storyState == Constant.StoryState.Interact then
		return
	end

	UIModule.Open(Constant.UIControllerName.TaskSystemUI, Constant.UILayer.UI)
end

function MainUI_RPGInfoPanel:__OnBtnGotoClick()
	local trackTaskCid = PlayerModule.GetTrackTaskCid()

	if trackTaskCid == 0 then
		return
	end

	TaskSystemModule.OnTaskJump(trackTaskCid)
end

function MainUI_RPGInfoPanel:OnClickButtonMap()
	if UnlockFunctionModule.OnClickInterceptor(Constant.UnlockType.FUNC_WorldMap) then
		return
	end

	if StoryModule.IsStoring and StoryModule.storyState == Constant.StoryState.Interact then
		return
	end

	local userData = {}

	userData.ToggleType = Constant.WorldAreaUIToggleType.Trunk

	UIModule.Open(Constant.UIControllerName.WorldAreaUI, Constant.UILayer.UI, userData)
end

function MainUI_RPGInfoPanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function MainUI_RPGInfoPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function MainUI_RPGInfoPanel:Refresh()
	self:RefreshMainTask()

	local funcList = {}

	funcList[Constant.UnlockType.FUNC_WorldMap] = self.buttonMap
	funcList[Constant.UnlockType.FUNC_SmallPhone] = self.SmallPhone
	funcList[Constant.UnlockType.FUNC_TASK] = self.buttonTask

	UnlockFunctionModule.FuncSwitchHandler(funcList)

	if self.mainView.isStoryState then
		LuaUtility.SetGameObjectShow(self.Rate, true)
		LuaUtility.SetGameObjectShow(self.buttonSwitchTime, false)
	end

	self:RefreshTime()

	local currentRoom = WorldMapModule.GetCurrentHomeData()

	if not currentRoom then
		return
	end

	local path = currentRoom:GetCfg().MiniMapRes

	if not LuaUtility.StrIsNullOrEmpty(path) then
		LuaUtility.LoadImage(self, path, self.imageMap:GetComponent("Image"))
	end

	LuaUtility.SetText(self.textRoomName, currentRoom:GetCfg().Name)

	if not self.mainView.isStoryState then
		LuaUtility.SetGameObjectShow(self.buttonSwitchTime, currentRoom:GetCfg().IsChangeTime)
	end
end

function MainUI_RPGInfoPanel:SetStoryInfo(textId, progress)
	if textId and textId ~= 0 then
		local targetText = CfgUtil.GetCfgStoryTextDataWithID(textId)

		LuaUtility.SetText(self.textStoryInfo, targetText)
	end

	if progress then
		LuaUtility.SetText(self.textNum, progress .. "%")
	end
end

function MainUI_RPGInfoPanel:RefreshMainTask()
	LuaUtility.SetGameObjectShow(self.Rate, false)

	local trackTaskCid = PlayerModule.GetTrackTaskCid()

	if trackTaskCid == 0 then
		self:SetNullTaskShow()
	else
		local cfgParentTask = CfgUtil.GetTaskCfgWithID(trackTaskCid)
		local ChildTaskData = WorldMapModule.GetCurrentChildTaskByParentTaskId(cfgParentTask.Id, cfgParentTask.Type)
		local cfgChildTask = CfgUtil.GetTaskCfgWithID(ChildTaskData.cid)

		LuaUtility.SetText(self.textTaskName, cfgParentTask.Name)
		LuaUtility.SetText(self.textTaskDesc, cfgChildTask.Name)
	end
end

function MainUI_RPGInfoPanel:SetNullTaskShow()
	LuaUtility.SetText(self.textTaskName, CfgUtil.GetCfgTipsTextWithID(1300067))
	LuaUtility.SetText(self.textTaskDesc, CfgUtil.GetCfgTipsTextWithID(1300068))
end

function MainUI_RPGInfoPanel:RefreshTime()
	if WorldMapModule.GetTimeState() == Constant.WorldMapTimeState.Day then
		LuaUtility.SetStateController(self.gameObject, dataName_time, stateName_day)
		LuaUtility.SetStateController(self.gameObject, dataName_switchTime, stateName_switchTime_day)
	else
		LuaUtility.SetStateController(self.gameObject, dataName_time, stateName_night)
		LuaUtility.SetStateController(self.gameObject, dataName_switchTime, stateName_switchTime_night)
	end
end

function MainUI_RPGInfoPanel:OnDestroy()
	self:RemoveListener()
end

return MainUI_RPGInfoPanel
