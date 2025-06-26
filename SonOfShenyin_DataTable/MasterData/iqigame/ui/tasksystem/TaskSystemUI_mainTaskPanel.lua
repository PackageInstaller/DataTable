-- chunkname: @IQIGame\\UI\\TaskSystem\\TaskSystemUI_mainTaskPanel.lua

local TaskSystemUI_mainTaskPanel = {}
local taskTabItemClass = require("IQIGame/UI/TaskSystem/TaskSystemUI_mainTaskPanel_TaskItem")
local goalItemClass = require("IQIGame/UI/TaskSystem/TaskSystemUI_mainTaskPanel_GoalItem")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local dataName_timeTip = "timeTip"
local stateName_day = "day"
local stateName_night = "night"

function TaskSystemUI_mainTaskPanel.New(go, mainView)
	local o = Clone(TaskSystemUI_mainTaskPanel)

	o:Initialize(go, mainView)

	return o
end

function TaskSystemUI_mainTaskPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.taskTabDataArray = {}
	self.taskTabItemList = {}
	self.sortPreviewAwardDataList = {}
	self.previewAwardCellList = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function TaskSystemUI_mainTaskPanel:InitComponent()
	self.taskTabScroll = self.taskTabScroll:GetComponent("OptimizedScrollRect")

	self.taskTabScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateTaskTabScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.goalItemPool = UIViewObjectPool.New(self.goalItem, self.goalContent.transform, function(_view)
		return goalItemClass.New(_view, self)
	end)
	self.awardScrollAreaList = self.awardScrollAreaList:GetComponent("ScrollAreaList")

	function self.awardScrollAreaList.onRenderCell(gridCell)
		self:OnRenderGridCell(gridCell)
	end
end

function TaskSystemUI_mainTaskPanel:InitDelegate()
	function self.delegateOnClickButtonGo()
		self:OnClickButtonGo()
	end

	function self.delegateOnClickButtonGetReward()
		self:OnClickButtonGetReward()
	end

	function self.delegateOnClickButtonRevert()
		self:OnClickButtonRevert()
	end

	function self.delegateOnClickButtonTrackStart()
		self:OnClickButtonTrackStart()
	end

	function self.delegateOnClickButtonTrackStop()
		self:OnClickButtonTrackStop()
	end
end

function TaskSystemUI_mainTaskPanel:AddListener()
	self.buttonGo:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonGo)
	self.buttonGetReward:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonGetReward)
	self.buttonRevert:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonRevert)
	self.buttonTrackStart:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonTrackStart)
	self.buttonTrackStop:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonTrackStop)
	EventUtil.AddEventListener(self, EventID.TrackTaskResultEvent)
end

function TaskSystemUI_mainTaskPanel:RemoveListener()
	self.buttonGo:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonGo)
	self.buttonGetReward:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonGetReward)
	self.buttonRevert:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonRevert)
	self.buttonTrackStart:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonTrackStart)
	self.buttonTrackStop:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonTrackStop)
	EventUtil.ClearEventListener(self)
end

function TaskSystemUI_mainTaskPanel:__OnTrackTaskResultEventHandler()
	self:RefreshDetail()
end

function TaskSystemUI_mainTaskPanel:OnClickButtonTrackStop()
	TaskSystemModule.TrackTask(0)
end

function TaskSystemUI_mainTaskPanel:OnClickButtonTrackStart()
	if not self.currentSelectItem then
		return
	end

	TaskSystemModule.TrackTask(self.currentSelectItem.data.cid)
end

function TaskSystemUI_mainTaskPanel:OnClickButtonRevert()
	if IQIGame.Onigao.Game.Device.isMobile then
		return
	end

	if not self.currentSelectItem then
		return
	end

	local taskData = self.currentSelectItem.data
	local cfgTask = CfgUtil.GetTaskCfgWithID(taskData.cid)

	if not cfgTask.IsRepaired then
		return
	end

	TaskSystemModule.RepairTask(self.currentSelectItem.data.cid)
end

function TaskSystemUI_mainTaskPanel:OnClickButtonGetReward()
	if not self.currentSelectItem then
		return
	end

	TaskSystemModule.SubmitTask({
		self.currentSelectItem.data.cid
	})
end

function TaskSystemUI_mainTaskPanel:OnClickButtonGo()
	if not self.currentSelectItem then
		return
	end

	local taskData = self.currentSelectItem.data
	local lvTaskArray = TaskSystemModule.GetSortForTypeDataList(Constant.MainTaskType.RPGMain, {
		taskData.cid,
		Constant.RPGTaskType.LvChildTask
	}, TaskSystemModule.sortType.Id, true, true)

	for i = 1, #lvTaskArray do
		if not TaskSystemModule.CheckTaskIsFinished(lvTaskArray[i]) then
			NoticeModule.ShowNotice(11030)

			return
		end
	end

	local childTask = WorldMapModule.GetCurrentChildTaskByParentTaskId(self.currentSelectItem.data.cid, self.taskType)

	if childTask then
		local cfgTask = CfgUtil.GetTaskCfgWithID(childTask.cid)

		if cfgTask.TimeType == Constant.RPGTaskTimeType.Night and WorldMapModule.GetTimeState() == Constant.WorldMapTimeState.Day then
			NoticeModule.ShowNotice(12022)

			return
		elseif cfgTask.TimeType == Constant.RPGTaskTimeType.Day and WorldMapModule.GetTimeState() == Constant.WorldMapTimeState.Night then
			NoticeModule.ShowNotice(12021)

			return
		end
	end

	local actionData = WorldMapModule.GetActionByTaskId(self.currentSelectItem.data.cid)

	if actionData then
		local componentData = WorldMapModule.GetComponentDataWithId(actionData.compCid)

		if not componentData then
			logError(string.format("【RPG】角色传送没有找到行为 id = %s,所属组件id = %s的组件数据", actionData.cid, actionData.compCid))

			return
		end

		local transPos = componentData:GetCfg().TransmitPoint
		local pos

		if transPos[1] and transPos[2] and transPos[3] then
			pos = Vector3.New(transPos[1], transPos[2], transPos[3])
		else
			pos = Vector3.New(componentData.pos.x + 3, componentData.pos.y, componentData.pos.z)
		end

		WorldMapModule.EnterRoom(actionData:GetRoomId(), true, pos and WorldMapModule.PackingEnterRoomData(pos) or nil)
	elseif self.currentSelectItem.data.type == Constant.MainTaskType.RPGMain then
		local roomId = WorldMapModule.GetRoomIDWithTag(Constant.RPGTagType.MainTag)

		if roomId then
			WorldMapModule.EnterRoom(roomId, true)
		end
	elseif self.currentSelectItem.data.type == Constant.MainTaskType.RPGBranch then
		local roomId = WorldMapModule.GetRoomIDWithTag(Constant.RPGTagType.BranchTag)

		if roomId then
			WorldMapModule.EnterRoom(roomId, true)
		end
	end

	UIModule.CloseAllUIFrom({
		Constant.UIControllerName.MainUI
	})
	EventDispatcher.Dispatch(EventID.OpenMobilePhoneEvent, false)
end

function TaskSystemUI_mainTaskPanel:OnRenderGridCell(gridCellData)
	local data = self.sortPreviewAwardDataList[gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.previewAwardCellList[insID]

	if cell == nil then
		cell = ExtendItemCellOne.New(gridCellData.gameObject)
		self.previewAwardCellList[insID] = cell
	end

	cell:SetAwardData(data.ItemData, data.ActionParam[2])

	gridCellData.gameObject.name = "Item" .. gridCellData.index + 1
end

function TaskSystemUI_mainTaskPanel:UpdateTaskTabScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.taskTabDataArray[index + 1]

	if not self.taskTabItemList[instanceID] then
		self.taskTabItemList[instanceID] = taskTabItemClass.New(viewGameObject, self)
	end

	self.taskTabItemList[instanceID]:Refresh(data, self.taskType)
end

function TaskSystemUI_mainTaskPanel:Show(taskType)
	LuaUtility.SetGameObjectShow(self.gameObject, true)

	self.taskType = taskType and taskType or Constant.MainTaskType.RPGBranch

	self:OnOpen()
end

function TaskSystemUI_mainTaskPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
	self:OnClose()
end

function TaskSystemUI_mainTaskPanel:OnClose()
	self.currentSelectItem = nil
	self.currentSelectId = nil
end

function TaskSystemUI_mainTaskPanel:OnOpen()
	self:Refresh()

	local viewsHolder = self.taskTabScroll:GetItemViewsHolder(0)

	if viewsHolder then
		local item = self.taskTabItemList[viewsHolder.instanceID]

		item:OnClickButtonClick()
	end
end

function TaskSystemUI_mainTaskPanel:Refresh()
	self.taskTabDataArray = TaskSystemModule.GetSortForTypeDataList(self.taskType, Constant.ExtendTaskType.RPGMain_Main, TaskSystemModule.sortType.Status_ID, true, true)

	local len = #self.taskTabDataArray

	self.taskTabScroll:RefreshByItemCount(len)
	LuaUtility.SetGameObjectShow(self.TaskEmpty, len == 0)
end

function TaskSystemUI_mainTaskPanel:OnTaskSelected(item)
	if self.currentSelectItem then
		self.currentSelectItem:UnSelected()

		self.currentSelectItem = nil
		self.currentSelectId = nil
	end

	self.currentSelectItem = item

	self.currentSelectItem:Selected()

	self.currentSelectId = self.currentSelectItem.data.cid

	self:RefreshDetail()
end

function TaskSystemUI_mainTaskPanel:RefreshDetail()
	if not self.currentSelectItem then
		return
	end

	local taskData = self.currentSelectItem.data
	local cfgTask = CfgUtil.GetTaskCfgWithID(taskData.cid)

	LuaUtility.SetText(self.textName, cfgTask.Name)
	LuaUtility.SetText(self.textDetail, cfgTask.Desc)
	self.goalItemPool:ForItems(function(item)
		item:Hide()
	end)

	local taskArray = TaskSystemModule.GetSortForTypeDataList(self.taskType, {
		taskData.cid
	}, TaskSystemModule.sortType.Id, true, false)
	local len = #taskArray

	for i = 1, len do
		local goalItem = self.goalItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		goalItem:Show()
		goalItem:Refresh(taskArray[i], TaskSystemModule.CheckTaskIsFinished(taskData))
	end

	LuaUtility.SetGameObjectShow(self.timeTipRoot, false)

	if cfgTask.TimeType == Constant.RPGTaskTimeType.Night then
		if WorldMapModule.GetTimeState() == Constant.WorldMapTimeState.Day then
			LuaUtility.SetGameObjectShow(self.timeTipRoot, true)
			LuaUtility.SetText(self.textTimeTip, cfgTask.TimeInfo)
			LuaUtility.SetStateController(self.gameObject, dataName_timeTip, stateName_night)
		end
	elseif cfgTask.TimeType == Constant.RPGTaskTimeType.Day and WorldMapModule.GetTimeState() == Constant.WorldMapTimeState.Night then
		LuaUtility.SetGameObjectShow(self.timeTipRoot, true)
		LuaUtility.SetText(self.textTimeTip, cfgTask.TimeInfo)
		LuaUtility.SetStateController(self.gameObject, dataName_timeTip, stateName_day)
	end

	local actionParam = UIUtil.GetConfigArr(cfgTask.ActionParam)
	local actionParamLength = #actionParam

	self.sortPreviewAwardDataList = {}

	for i = 1, actionParamLength do
		local item = CfgUtil.GetItemCfgDataWithID(actionParam[i][1])

		if item.IsHide ~= Constant.ItemHideType.All then
			local awardData = {
				ActionParam = actionParam[i],
				ItemData = ItemData.CreateByCIDAndNumber(actionParam[i][1], actionParam[i][2])
			}

			table.insert(self.sortPreviewAwardDataList, awardData)
		end
	end

	table.sort(self.sortPreviewAwardDataList, function(a, b)
		local acfg = a.ItemData:GetCfg()
		local bcfg = b.ItemData:GetCfg()

		if acfg.Quality ~= bcfg.Quality then
			return acfg.Quality > bcfg.Quality
		end

		return acfg.Id < bcfg.Id
	end)
	self.awardScrollAreaList:Refresh(#self.sortPreviewAwardDataList)

	self.awardScrollAreaList.enableDrag = #self.sortPreviewAwardDataList >= 3 and true or false

	LuaUtility.SetGameObjectShow(self.buttonGo, taskData.status == Constant.TaskStatus.doing)
	LuaUtility.SetGameObjectShow(self.buttonGetReward, taskData.status == Constant.TaskStatus.hasDone)

	if IQIGame.Onigao.Game.Device.isMobile then
		LuaUtility.SetGameObjectShow(self.buttonRevert, false)
	else
		LuaUtility.SetGameObjectShow(self.buttonRevert, cfgTask.IsRepaired)
	end

	LuaUtility.SetGameObjectShow(self.buttonTrackStart, taskData.cid ~= PlayerModule.GetTrackTaskCid())
	LuaUtility.SetGameObjectShow(self.buttonTrackStop, taskData.cid == PlayerModule.GetTrackTaskCid() and taskData.type ~= Constant.MainTaskType.RPGMain)
	LuaUtility.SetGameObjectShow(self.TagTrack, taskData.cid == PlayerModule.GetTrackTaskCid())
end

function TaskSystemUI_mainTaskPanel:OnDestroy()
	for _, v in pairs(self.taskTabItemList) do
		v:OnDestroy()
	end

	self.taskTabItemList = {}
	self.taskTabScroll = nil

	self.goalItemPool:Dispose(function(item)
		item:OnDestroy()
	end)

	for _, v in pairs(self.previewAwardCellList) do
		v:Dispose()
	end

	self.awardScrollAreaList = nil

	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return TaskSystemUI_mainTaskPanel
