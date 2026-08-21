-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\CatRace\\Task\\ActivityCatRaceTaskDlg.lua

local ResOpActivityCatRaceMisc = require("ClientData/ResOpActivityCatRaceMisc")
local ResClientNotice = require("ClientData/ResClientNotice")
local ActivityCatRaceTaskCell = require("UI/OpActivity/CatRace/Task/ActivityCatRaceTaskCell")
local ActivityCatRaceFriendTaskCell = require("UI/OpActivity/CatRace/Task/ActivityCatRaceFriendTaskCell")
local CatRaceConfig = require("UI/OpActivity/CatRace/CatRaceConfig")
local strClassName = "ActivityCatRaceTaskDlg"
local ActivityCatRaceTaskDlg = Class(strClassName, UIControls.Window)
local MY_TASK_TAB = 1
local FRIEND_TASK_TAB = 2

function ActivityCatRaceTaskDlg:ctor()
	self.cellPrefabPath = "System/Activity/ActivityCatRace/ActivityCatRaceTaskCell"
	self.friendCellPrefabPath = "System/Activity/ActivityCatRace/ActivityCatRaceFriendTaskCell"

	self:initUI()
end

function ActivityCatRaceTaskDlg:initUI()
	self.myTaskPanel = UIControls.Panel(self, "BgPanel/MyTaskPanel")
	self.friendTaskPanel = UIControls.Panel(self, "BgPanel/FriendTaskPanel")
	self.myTaskBtn = UIControls.Button(self, "BgPanel/TabPanel/BtnMyTask")

	self.myTaskBtn:addEventClick(self.onBtnMyTask)

	self.friendTaskBtn = UIControls.Button(self, "BgPanel/TabPanel/BtnFriendTask")

	self.friendTaskBtn:addEventClick(self.onBtnFriendTask)

	self.timeTxt = UIControls.Label(self, "BgPanel/MyTaskPanel/TextTime")
	self.closeBtn = UIControls.Button(self, "BgPanel/BgFrame/DecPanel/Dec03")

	self.closeBtn:addEventClick(self._onBtnClose)

	self.cells = {}
	self.friendScroll = UIControls.ScrollViewLoopV(self, "BgPanel/FriendTaskPanel/TaskList")

	self.friendScroll:addEventCellChanged(self.onFriendTaskCellChanged)

	self.friendTaskNoneImg = UIControls.Image(self, "BgPanel/FriendTaskPanel/ImgNothing")
	self.optionalTaskAwardPanel = UIControls.Panel(self, "BgPanel/BgAward")
	self.optionalTaskAwardBtn = UIControls.Button(self, "BgPanel/BgAward/BtnConfirm")

	self.optionalTaskAwardBtn:addEventClick(self._onBtnOptionalTaskAward)

	self.optionalTaskAwardGridPath = "BgPanel/BgAward/AwardItemPanel"
	self.awardTipTxt = UIControls.Label(self, "BgPanel/BgAward/TextAward")
	self.awardGridPath = "BgPanel/BgAward/AwardItemPanel"
end

function ActivityCatRaceTaskDlg:_onBtnClose()
	self:setVisible(false)
end

function ActivityCatRaceTaskDlg:setData(data)
	self.mainActID = data.mainActID
	self.mainActData = CurAvatar:getActivityObj(self.mainActID).actData
	self.mainOpId = self.mainActData.actObject.opId
	self.resData = ResOpActivityCatRaceMisc[self.mainActID]

	self:initMyTaskPanel()
	self:initFriendTaskPanel()
	ClientTimerManager.AddSecondFormatTickUI(self.timeTxt, ClientUtils.getServerTimeNextDay() - ClientUtils.getServerTime(), false, Lang.get(48670), Slot(self.resetDaily, self))
	self.mainActData:getAllFriendCatRaceData(Slot(self.refreshFriendTaskPanelCallback, self))
	self:refreshData()
	self:onBtnMyTask()
end

function ActivityCatRaceTaskDlg:resetDaily()
	self:refreshData()
end

function ActivityCatRaceTaskDlg:refreshData()
	if self.taskCellList then
		for _, cell in pairs(self.taskCellList) do
			cell:refreshData()
		end
	end

	if self.cells then
		for _, cell in pairs(self.cells) do
			cell:refreshData()
		end
	end

	self:refreshOptionalTaskAward()
end

function ActivityCatRaceTaskDlg:refreshOptionalTaskAward()
	if self.curTabState == MY_TASK_TAB then
		local canGet, isInterDay = self.mainActData:isOptionalTaskAwardAvaliable()

		if canGet then
			self.optionalTaskAwardPanel:setVisible(true)
			self.optionalTaskAwardBtn:setVisible(true)

			if isInterDay then
				self.awardTipTxt:setText(ResClientNotice[438].notice)
			else
				self.awardTipTxt:setText(ResClientNotice[437].notice)
			end

			if self.awardGrid then
				for _, grid in pairs(self.awardGrid) do
					grid:destroy()
				end
			end

			self.awardGrid = {}

			ClientUtils.CreateBonusGrid(self, self.awardGrid, self.awardGridPath, self.mainActData.miscData.send_task_award, true, nil, true, CatRaceConfig.GRID_CONFIG)
		else
			self.optionalTaskAwardPanel:setVisible(false)
		end
	else
		self.optionalTaskAwardPanel:setVisible(true)

		local canGet = self.mainActData:getRemainFriendTaskNum() > 0

		self.optionalTaskAwardBtn:setVisible(false)

		if canGet then
			self.optionalTaskAwardPanel:setVisible(true)
			self.awardTipTxt:setText(ResClientNotice[439].notice)

			if self.awardGrid then
				for _, grid in pairs(self.awardGrid) do
					grid:destroy()
				end
			end

			self.awardGrid = {}

			ClientUtils.CreateBonusGrid(self, self.awardGrid, self.awardGridPath, self.mainActData.miscData.friend_task_award, true, nil, true, CatRaceConfig.GRID_CONFIG)
		else
			self.awardTipTxt:setText(ResClientNotice[447].notice)

			if self.awardGrid then
				for _, grid in pairs(self.awardGrid) do
					grid:destroy()
				end
			end
		end
	end
end

function ActivityCatRaceTaskDlg:_onBtnOptionalTaskAward()
	CurAvatar:activityRPC(Functor(RPC.opActCatRaceGetPublishAward, self.mainOpId), self.mainOpId)
end

function ActivityCatRaceTaskDlg:initMyTaskPanel()
	self.fixedTaskActID = self.resData.fixed_task_achieve_id
	self.optionalTaskActID = self.resData.optional_task_achieve_id
	self.friendTaskActID = self.resData.friend_task_achieve_id

	if self.taskCellList then
		for _, cell in pairs(self.taskCellList) do
			cell:destroy()
		end
	end

	self.taskCellList = {}

	local friendTabCallback = Slot(self.onBtnFriendTask, self)

	self:initTaskCell(self.fixedTaskActID, "BgPanel/MyTaskPanel/TaskList/Content", CatRaceConfig.MY_TASK_TYPE)

	local optionalTaskCell = ActivityCatRaceTaskCell(self, "BgPanel/MyTaskPanel/TaskList/Content", self.cellPrefabPath, nil, nil, nil, nil, nil, "4")
	local optionalTaskObj = CurAvatar:getActivityObj(self.optionalTaskActID)
	local optionalTaskCellData = {
		actData = optionalTaskObj.actData,
		type = CatRaceConfig.OPTIONAL_TASK_TYPE
	}

	optionalTaskCell:setData(optionalTaskCellData, self.mainActID, friendTabCallback)
	table.insert(self.taskCellList, optionalTaskCell)

	local friendTaskcell = ActivityCatRaceTaskCell(self, "BgPanel/MyTaskPanel/TaskList/Content", self.cellPrefabPath, nil, nil, nil, nil, nil, "5")
	local friendTaskObj = CurAvatar:getActivityObj(self.friendTaskActID)
	local friendTaskCellData = {
		actData = friendTaskObj.actData,
		type = CatRaceConfig.FRIEND_TASK_TYPE
	}

	friendTaskcell:setData(friendTaskCellData, self.mainActID, friendTabCallback)
	table.insert(self.taskCellList, friendTaskcell)
end

function ActivityCatRaceTaskDlg:initFriendTaskPanel()
	return
end

function ActivityCatRaceTaskDlg:refreshFriendTaskPanelCallback(friendDataList)
	local ui = UIManager.tryGetUI("activityCatRaceTaskDlg")

	if not ui then
		return
	end

	self.friendDataList = {}

	if friendDataList then
		for _, data in ipairs(friendDataList) do
			table.insert(self.friendDataList, data)
		end
	end

	for i = #self.friendDataList, 1, -1 do
		if not self.mainActData:hasPublishFriendTaskToday(friendDataList[i]) then
			table.remove(self.friendDataList, i)
		end
	end

	for i = #self.friendDataList, 1, -1 do
		if self.mainActData:checkFriendIsComp(self.friendDataList[i].uid) then
			self.friendDataList[i], self.friendDataList[1] = self.friendDataList[1], self.friendDataList[i]

			break
		end
	end

	self.friendTaskNoneImg:setVisible(#self.friendDataList <= 0)
	self.friendScroll:setTotalCount(#self.friendDataList)
end

function ActivityCatRaceTaskDlg._friendSortFunc(A, B)
	return
end

function ActivityCatRaceTaskDlg:onFriendTaskCellChanged(sender, targetCell, newIdx)
	if not self.friendDataList then
		return
	end

	local cellData = self.friendDataList[newIdx]

	if not cellData then
		return
	end

	if targetCell == nil then
		targetCell = ActivityCatRaceFriendTaskCell(sender, self.friendCellPrefabPath, newIdx, 0, 0)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	targetCell:setData(cellData, self.mainActID)

	self.cells[newIdx] = targetCell
end

function ActivityCatRaceTaskDlg:initTaskCell(actID, mountPath, cellType, friendTabCallback)
	local actObj = CurAvatar:getActivityObj(actID)

	if actObj then
		local actData = actObj.actData
		local extraName = 1

		for achieveType, typeData in pairs(actData.clientData) do
			for achieveIndex, achieveData in ipairs(typeData) do
				local cellData = {}

				cellData.actData = actData
				cellData.achieveType = achieveType
				cellData.achieveIndex = achieveIndex
				cellData.achieveData = achieveData
				cellData.type = cellType

				local cell = ActivityCatRaceTaskCell(self, mountPath, self.cellPrefabPath, nil, nil, nil, nil, nil, extraName)

				extraName = extraName + 1

				cell:setData(cellData, self.mainActID, friendTabCallback)
				table.insert(self.taskCellList, cell)
			end
		end
	end
end

function ActivityCatRaceTaskDlg:onBtnMyTask()
	self.curTabState = MY_TASK_TAB

	self.myTaskPanel:setVisible(true)
	self.friendTaskPanel:setVisible(false)
	self.myTaskBtn:setEnable(false)
	self.friendTaskBtn:setEnable(true)
	self:refreshData()
end

function ActivityCatRaceTaskDlg:onBtnFriendTask(sender, canSelFriendTask)
	self.curTabState = FRIEND_TASK_TAB

	self.myTaskPanel:setVisible(false)
	self.friendTaskPanel:setVisible(true)
	self.myTaskBtn:setEnable(true)
	self.friendTaskBtn:setEnable(false)
	self:setFriendTaskCanSel(canSelFriendTask)
	self.friendScroll:goToTop()
	self:refreshData()
end

function ActivityCatRaceTaskDlg:setFriendTaskCanSel(canSelFriendTask)
	self.canSelectFriendTask = canSelFriendTask
end

function ActivityCatRaceTaskDlg:checkCanSelectFriendTask()
	if self.mainActData:isNeedGetFriendTask() then
		return true
	end

	return self.canSelectFriendTask
end

function ActivityCatRaceTaskDlg:_onDailyTimerRefresh()
	return
end

function ActivityCatRaceTaskDlg:onClose()
	if self.dailyRefreshTimer then
		self.dailyRefreshTimer:Stop()

		self.dailyRefreshTimer = nil
	end
end

return ActivityCatRaceTaskDlg
