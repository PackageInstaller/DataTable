-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\DispatchDlg.lua

local DispatchTask = require("Logic/RearHouse/DispatchTask")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local ConsumeTips = require("System/ConsumeTips")
local DispatchCell = Class("DispatchCell", UIControls.ScrollViewLoopCell)

function DispatchCell:ctor(...)
	self:initUI()
end

function DispatchCell:initUI(...)
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onBtnSensorClick)

	self.imgBg = UIControls.Image(self, "Bg")
	self.txtTime = UIControls.Label(self, "TextHoursTitle/TextHours")
	self.txtDiff = UIControls.Label(self, "TextDifficulty")
	self.txtTimeDown = UIControls.Label(self, "TextTime")
	self.panelHappening = UIControls.Panel(self, "HappeningPanel")
	self.imgPreHalf = UIControls.Image(self, "HappeningPanel/Img1")
	self.imgAfterHalf = UIControls.Image(self, "HappeningPanel/Img2")
	self.txtName = UIControls.Label(self, "TextName")
	self.imgLock = UIControls.Image(self, "TextName/IconLock")
	self.txtDiff = UIControls.Label(self, "TextDifficulty")
	self.imgDiff = UIControls.Image(self, "TextDifficulty/ImgDifficulty")
	self.imgNew = UIControls.Image(self, "IconNew")
	self.txtHeroNum = UIControls.Label(self, "TextHeroNum")
	self.awardCells = {}
	self.panelEffect = {}

	for i = 1, 2 do
		local efx = UIControls.Panel(self, "GridMaterialItemPanel/EfxGrid" .. i)

		table.insert(self.panelEffect, efx)
	end
end

function DispatchCell:setData(task)
	self.task = task

	self:refreshData()
end

function DispatchCell:refreshData(...)
	self:refreshAward()
	self.txtName:setText(self.task.name)
	self.txtTime:setText(utils.calcTimeTxt(self.task.time))
	self.txtDiff:setText(self.task.difficulty_desc)
	self:timeDown()
	self.imgLock:setVisible(self.task.isLock)
	self.imgBg:setImage(self.task.iconPath[1], self.task.iconPath[2])

	local color = RearHouseCommon.getColorByStep(self.task.star)

	self.txtDiff:setText(string.format(Lang.get(30230), self.task:getStepDesc()))
	self.imgDiff:setColorByRGBA(color.r, color.g, color.b, color.a)
	self.txtDiff:setFontColor(color)
	self.txtHeroNum:setText(self.task.require_num)

	self.isReady = RearHouseCommon.isNewTaskCanDo({
		self.task
	})

	self.imgNew:setVisible(self.isReady == true and self.task.isNew)

	local stateName = "DispatchListCellNml"

	if self.task.isDoing then
		stateName = "DispatchListCellHigh"

		self.panelHappening:setVisible(true)

		if self.task:isTimePassHalf() == true then
			self.imgPreHalf:setVisible(false)
			self.imgAfterHalf:setVisible(true)
		else
			self.imgPreHalf:setVisible(true)
			self.imgAfterHalf:setVisible(false)
		end
	else
		if self.task.isNew then
			stateName = "DispatchListCellNml"
		elseif self.task.isDone then
			stateName = "DispatchListCellDis"
		elseif self.task.isLock then
			stateName = "DispatchListCellNml"
		end

		self.panelHappening:setVisible(false)
	end

	self.imgBg:setObjGray(self.task.isDone == true)
	self:playStateAnimator(stateName)
end

function DispatchCell:refreshAward(...)
	local awardNum = #self.task.awardItems

	for i = 1, awardNum do
		local cell = self.awardCells[i]

		if cell == nil then
			cell = UIControls.getGridAwardContainer(self, "GridMaterialItemPanel")

			table.insert(self.awardCells, cell)
		end

		cell:setObj(self.task.awardItems[i])

		cell.grid.mDisableWays = true

		cell:setVisible(true)
		cell.grid:showNewHint(self.task.isDone == true)

		cell.grid.mEnableTips = true

		if cell.grid.mEventClick == nil then
			cell.grid.mEventClick = Slot(self.onAwardClick, self)
		end
	end

	for i = awardNum + 1, #self.awardCells do
		if self.awardCells[i] then
			self.awardCells[i]:setVisible(false)
		end
	end

	if self.task.isDone then
		for i = 1, awardNum do
			self.panelEffect[i]:setVisible(true)
		end

		for i = awardNum + 1, #self.panelEffect do
			if self.panelEffect[i] then
				self.panelEffect[i]:setVisible(false)
			end
		end
	else
		for i = 1, #self.panelEffect do
			if self.panelEffect[i] then
				self.panelEffect[i]:setVisible(false)
			end
		end
	end
end

function DispatchCell:checkEtraAward(...)
	local index = math.random(2)

	if index == 1 then
		UIManager.getUI("dispatchExtraAwardDlg", true):setData(self.task)
	end
end

function DispatchCell:onAwardClick(...)
	if self.task.isDone then
		for _, cell in ipairs(self.awardCells) do
			if cell:getVisible() == true and cell.grid then
				cell.grid:flyToCommonFuncEntryPanel()

				cell.grid.mEnableTips = false
			end
		end

		RPC.houseDispatchDone(self.task.data.id)
	end
end

function DispatchCell:onBtnSensorClick(...)
	if self.task.isDone then
		self:onAwardClick()

		return
	end

	UIManager.getUI("dispatchInfoDlg", true):setData(self.task, self.isReady)
end

function DispatchCell:timeDown(...)
	if self.task.isDoing then
		local timeOffset = self.task:getEndTime() - ClientUtils.getServerTime()

		if timeOffset < 0 then
			self.task:refreshState()
			self:refreshData()
		else
			self.txtTimeDown:setText(utils.calcTimeTxt(timeOffset))
		end
	end
end

local strClassName = "DispatchDlg"
local DispatchDlg = Class(strClassName, UIControls.Window)

function DispatchDlg:ctor(...)
	self:initUI()
	self:initData()
end

function DispatchDlg:onOpen(...)
	DispatchDlg.super.onOpen(self)

	if self.timeDown == nil then
		self.timeDown = Timer(Slot(self.timeDownFunc, self), 1, -1)

		self.timeDown:Start()
	end

	self:timeDownFunc()
end

function DispatchDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnRefresh = UIControls.Button(self, "BgPanel/BtnConfirm", "TextNum")

	self.btnRefresh:addEventClick(self.onBtnRefreshClick)

	self.txtTime = UIControls.Label(self, "BgPanel/TextTime")
	self.txtNum = UIControls.Label(self, "BgPanel/TextNum")
	self.imgDiff = UIControls.Image(self, "BgPanel/TextDifficulty/ImgDifficulty")
	self.txtDiff = UIControls.Label(self, "BgPanel/TextDifficulty")
	self.btnQuickDispatch = UIControls.Button(self, "BgPanel/BtnCancel")

	self.btnQuickDispatch:addEventClick(self.onBtnQuickDispatchClick)

	self.panelEmpty = UIControls.Panel(self, "BgPanel/BgNothing")
	self.scrollView = UIControls.ScrollViewLoopV(self, "BgPanel/DispatchList", 0, self.onDispatchCellChanged)
	self.taskCells = {}

	if UIControls.checkControlFunc(self, "BgPanel/BtnGet") then
		self.btnGet = UIControls.Button(self, "BgPanel/BtnGet")

		self.btnGet:addEventClick(self.onBtnGetClick)
	end
end

function DispatchDlg:initData(...)
	self:initTasks()
	self:_checkTaskEnough()
	self:initUIData()
	self:refreshList()
end

function DispatchDlg:initTasks(...)
	self.tasks = CurAvatar.dispatchTasks

	self:sortTask()
end

function DispatchDlg:initUIData(...)
	local step = RearHouseCommon.getMyMaxStep()

	self.txtDiff:setText(string.format(Lang.get(30661), step))

	local color = RearHouseCommon.getColorByStep(step)

	self.txtDiff:setFontColor(color)
	self.imgDiff:setColorByRGBA(color.r, color.g, color.b, color.a)
	self.btnQuickDispatch:setVisible(RearHouseCommon.isQuickDispatchOpen())
end

function DispatchDlg:timeDownFunc(...)
	local timeStr = utils.calcTimeTxt(ClientUtils.getServerTimeNextDay() - ClientUtils.getServerTime())

	self.txtTime:setText(string.format(Lang.get(30662), timeStr))

	if self.taskCells then
		for _, cell in pairs(self.taskCells) do
			cell:timeDown()
		end
	end
end

function DispatchDlg:onTaskClaimed(index)
	table.remove(self.tasks, index)
	self:refreshList()
end

function DispatchDlg:refreshUI(isCheckEnough)
	self:initTasks()
	self:refreshList()

	if isCheckEnough == true then
		self:_checkTaskEnough()
	end
end

function DispatchDlg:refreshList(...)
	self.scrollView:setTotalCount(#self.tasks)
	self.panelEmpty:setVisible(#self.tasks == 0)
	self.txtNum:setText(#self.tasks .. "/" .. RearHouseCommon.getDispatchMaxCount())
	self:_refreshUI()
end

function DispatchDlg:_checkTaskEnough(...)
	if ClientUtils.record.dispatchNotEnoughTip ~= nil then
		return
	end

	local leftCount = RearHouseCommon.getDispatchMaxCount() - #self.tasks
	local dailyCount = RearHouseCommon.getDispathDailyCount()

	if leftCount < dailyCount then
		local content = ClientUtils.getClientNotice(316)

		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", content)

		ClientUtils.record.dispatchNotEnoughTip = true
	end
end

function DispatchDlg:_refreshUI(...)
	local dailyCount = RearHouseCommon.getDispathDailyCount()
	local refreshCount = 0

	for _, task in ipairs(self.tasks) do
		if task.isNew then
			refreshCount = refreshCount + 1
		end
	end

	self.refreshCount = refreshCount

	self.btnRefresh:setObjGray(refreshCount == 0)

	self.cost = RearHouseCommon.getDispatchSingleCost() * self:_calcuRefreshNum(refreshCount)
	self.leftFreeTimes = (RearHouseCommon.getDispatchFreeRefreshTimes() or 0) - CurAvatar.dispatchData.use_refresh_today

	if self.leftFreeTimes > 0 then
		self.btnRefresh:setText(Lang.get(1261))
	else
		self.btnRefresh:setText(self.cost)
	end

	if self.btnGet then
		local taskIds = {}

		for i, task in pairs(self.tasks or {}) do
			if task.isDoing then
				local timeOffset = task:getEndTime() - ClientUtils.getServerTime()

				if timeOffset < 0 then
					task:refreshState()
				end
			end

			if task.isDone then
				table.insert(taskIds, task.data.id)
			end
		end

		self.btnGet:setVisible(#taskIds > 0)
	end
end

function DispatchDlg:_calcuRefreshNum(refreshCount)
	return refreshCount
end

function DispatchDlg:sortTask(...)
	if self.tasks then
		table.sort(self.tasks, self._sortFunc)
	end
end

function DispatchDlg._sortFunc(v1, v2)
	if v1.order == v2.order then
		if v1.star == v2.star then
			return v1.id > v2.id
		else
			return v1.star > v2.star
		end
	else
		return v1.order < v2.order
	end
end

function DispatchDlg:onBtnQuickDispatchClick(...)
	local data = RearHouseCommon.getQuickDispatchReqData()

	if #data > 0 then
		RPC.houseDispatchStart(data)
	else
		MsgManager.notice(Lang.get(30663))
	end
end

function DispatchDlg:onDispatchCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = DispatchCell(sender, "System/Backyard/DispatchListCell", newIdx)
	else
		self.taskCells[targetCell.mIndex] = nil
	end

	targetCell.mIndex = newIdx
	self.taskCells[newIdx] = targetCell

	targetCell:setData(self.tasks[newIdx])
end

function DispatchDlg:onBtnRefreshClick(...)
	if self.refreshCount == 0 then
		MsgManager.notice(Lang.get(30664))

		return
	end

	if self.leftFreeTimes > 0 then
		self:doRefreshClick()
	else
		ClientUtils.checkMoneyChange(Const.MONEY_ID_DIAMOND, self.cost, Slot(self.doRefreshClick, self), self)
	end
end

function DispatchDlg:doRefreshClick(...)
	if CurAvatar.isShowDispatchRefreshTip == true then
		local function yesFunc()
			local noTipToday = self.confirmui:getToggleState()

			if noTipToday == true then
				CurAvatar:refreshDispatchTipTime()
			end

			ConsumeTips.showTipsDiamond(self.cost, Const.CONSUME_DIAMOND_REFRESH_PHOTOTASK, 1, Slot(self.doRefresh, self))
		end

		local msgContent = ClientUtils.getClientNotice(255)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, yesFunc, nil, nil)

		self.confirmui = UIManager.getUI("confirmui", nil, false)

		self.confirmui:showToggle(Lang.get(30665), false)
	else
		ConsumeTips.showTipsDiamond(self.cost, Const.CONSUME_DIAMOND_REFRESH_PHOTOTASK, 1, Slot(self.doRefresh, self))
	end
end

function DispatchDlg:doRefresh()
	local freeCount = CurAvatar.dispatchData.use_refresh_today
	local leftDiamond = ClientUtils.getMoney(Const.MONEY_ID_DIAMOND)

	RPC.houseDispatchRefresh(freeCount, leftDiamond)
end

function DispatchDlg:onBtnGetClick()
	local taskIds = {}

	for i, task in pairs(self.tasks or {}) do
		if task.isDone then
			table.insert(taskIds, task.data.id)
		end
	end

	for i, taskCell in pairs(self.taskCells) do
		if taskCell.task.isDone then
			for _, cell in ipairs(taskCell.awardCells) do
				if cell:getVisible() == true and cell.grid then
					cell.grid:flyToCommonFuncEntryPanel()

					cell.grid.mEnableTips = false
				end
			end
		end
	end

	if #taskIds > 0 then
		RPC.houseDispatchAllDone(taskIds)
	end
end

function DispatchDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function DispatchDlg:destroy(...)
	DispatchDlg.super.destroy(self)

	if self.timeDown then
		self.timeDown:Stop()
	end

	self.timeDown = nil
end

return DispatchDlg
