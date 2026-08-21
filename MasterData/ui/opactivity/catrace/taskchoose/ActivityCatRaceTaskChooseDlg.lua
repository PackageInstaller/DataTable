-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\CatRace\\TaskChoose\\ActivityCatRaceTaskChooseDlg.lua

local ResOpActivityCatRaceMisc = require("ClientData/ResOpActivityCatRaceMisc")
local ResOpActivityCatRaceTask = require("ClientData/ResOpActivityCatRaceTask")
local ActivityCatRaceTaskChooseCell = require("UI/OpActivity/CatRace/TaskChoose/ActivityCatRaceTaskChooseCell")
local strClassName = "ActivityCatRaceTaskChooseDlg"
local ActivityCatRaceTaskChooseDlg = Class(strClassName, UIControls.Window)

function ActivityCatRaceTaskChooseDlg:ctor()
	self.taskCellMountPath = "BgPanel/TaskChoosePanel/TaskList/Content"
	self.taskCellPrefabPath = "System/Activity/ActivityCatRace/BtnCatRaceTask"

	self:initUI()
end

function ActivityCatRaceTaskChooseDlg:initUI()
	self.taskChoosePanel = UIControls.Panel(self, "BgPanel/TaskChoosePanel")
	self.myTaskPreviewPanel = "BgPanel/TaskAwardPanel/TaskFinish"
	self.taskPublishAwardPreview = "BgPanel/TaskAwardPanel/TaskReleaseAward/AwardPanel"
	self.taskFinishAwardPreview = "BgPanel/TaskAwardPanel/TaskFinishAward/AwardPanel"
	self.closeBtn = UIControls.Button(self, "BgPanel/BgFrame/DecPanel/Dec03")

	self.closeBtn:addEventClick(self._onBtnClose)

	self.denyBtn = UIControls.Button(self, "BgPanel/BtnDeny")

	self.denyBtn:addEventClick(self._onBtnClose)

	self.confirmBtn = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.confirmBtn:addEventClick(self._onBtnConfirm)

	self.friendTaskAwardGridPath = "BgPanel/TaskAwardPanel/TaskFinishAward/AwardPanel"
	self.optionalTaskAwardGridPath = "BgPanel/TaskAwardPanel/TaskReleaseAward/AwardPanel"
end

function ActivityCatRaceTaskChooseDlg:setData(data)
	self.mainActID = data.mainActID
	self.mainOpID = CurAvatar:getActivityObj(self.mainActID).opId
	self.mainActData = CurAvatar:getActivityObj(self.mainActID).actData
	self.miscResData = ResOpActivityCatRaceMisc[self.mainActID]
	self.taskResData = ResOpActivityCatRaceTask[self.mainActID]
	self.selectedTaskID, self.selectedTaskType = self.mainActData:getOptionalTask()
	self.friendTaskAwardID = self.miscResData.friend_task_award
	self.optionalTaskAwardID = self.miscResData.send_task_award
	self.actID = self.miscResData.optional_task_achieve_id
	self.actObj = CurAvatar:getActivityObj(self.actID)
	self.actData = self.actObj.actData
	self.opID = self.actObj.opID
	self.achieveCellDatas = self.actData.clientData

	if self.taskCellList then
		for _, cell in pairs(self.taskCellList) do
			cell:destroy()
		end
	end

	self.taskCellList = {}

	local taskSelectCallback = Slot(self.onTaskSelectCallback, self)

	for _, taskDetail in ipairs(self.taskResData) do
		local achieveType = taskDetail.achieve_type
		local achieveData = self.actData:getAchieveOneData(achieveType, 1)
		local achieveCell = ActivityCatRaceTaskChooseCell(self, self.taskCellMountPath, self.taskCellPrefabPath)

		achieveCell:setData(achieveData, taskDetail, taskSelectCallback)
		table.insert(self.taskCellList, achieveCell)
	end

	self:refreshData()

	self.taskFinishAwardID = ResOpActivityCatRaceMisc[self.mainActID].send_task_award
	self.taskPublishAwardID = ResOpActivityCatRaceMisc[self.mainActID].friend_task_award

	self:previewFriendTaskAward()
	self:previewOptionalTaskAward()

	if self.selectedTaskID then
		self.curSelctedId = self.selectedTaskID
	else
		self.curSelctedId = 1
	end

	for _, cell in pairs(self.taskCellList) do
		if cell.taskDetail.task_id == self.curSelctedId then
			cell:setState(true)
		else
			cell:setState(false)
		end
	end
end

function ActivityCatRaceTaskChooseDlg:refreshData()
	for _, cell in ipairs(self.taskCellList) do
		cell:refreshData()
	end
end

function ActivityCatRaceTaskChooseDlg:onTaskSelectCallback(sender, taskDetail)
	self.curSelctedId = taskDetail.task_id

	for _, cell in pairs(self.taskCellList) do
		if cell.taskDetail.task_id == self.curSelctedId then
			cell:setState(true)
		else
			cell:setState(false)
		end
	end
end

function ActivityCatRaceTaskChooseDlg:_onBtnConfirm(sender)
	if self.curSelctedId then
		if self.curSelctedId ~= self.selectedTaskID then
			CurAvatar:activityRPC(Functor(RPC.opActCatRaceSelectTask, self.mainOpID, self.curSelctedId), self.mainOpID)

			self.mainActData.lastOptionalTaskGetRecord = ClientUtils.getServerTime()
		end

		self:setVisible(false)
	else
		MsgManager.notice(Lang.get(53096))
	end
end

function ActivityCatRaceTaskChooseDlg:_onBtnClose()
	self:setVisible(false)
end

function ActivityCatRaceTaskChooseDlg:previewFriendTaskAward()
	if self.friendTaskAwardGrids then
		for _, cell in pairs(self.friendTaskAwardGrids) do
			cell:destroy()
		end
	end

	self.friendTaskAwardGrids = {}

	ClientUtils.CreateBonusGrid(self, self.friendTaskAwardGrids, self.friendTaskAwardGridPath, self.friendTaskAwardID, true, nil, true)
end

function ActivityCatRaceTaskChooseDlg:previewOptionalTaskAward()
	if self.OptionalTaskAwardGrids then
		for _, cell in pairs(self.OptionalTaskAwardGrids) do
			cell:destroy()
		end
	end

	self.OptionalTaskAwardGrids = {}

	ClientUtils.CreateBonusGrid(self, self.OptionalTaskAwardGrids, self.optionalTaskAwardGridPath, self.optionalTaskAwardID, true, nil, true)
end

return ActivityCatRaceTaskChooseDlg
