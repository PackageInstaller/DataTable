-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportNewYearTaskView.lua

module("logic.extensions.passport.view.PassportNewYearTaskView", package.seeall)

local PassportNewYearTaskView = class("PassportNewYearTaskView", ViewComponent)

function PassportNewYearTaskView:buildUI()
	PassportNewYearTaskView.super.buildUI(self)

	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("cell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getGo("btnClose")
	self._btnsSwitch = {}

	for i = 1, 2 do
		local btn = {}

		btn.go = self:getGo("btn_" .. i)
		btn.select = goutil.findChild(btn.go, "select")
		self._btnsSwitch[i] = btn
	end

	self._campPowerGo = self:getGo("txtCampPower")
	self._txtCampPower = self:getTxt("txtCampPower/txt")
	self._itemCampPower = self:getGo("txtCampPower/item/icon")
	self._bg = self:getGo("viewBgGo")
	self._con = self:getGo("con")
	self._tipsGo = self:getGo("tips")
	self._txtTime = self:getTxt("time/txt")
	self._btnHelp = self:getGo("btnHelp")
end

function PassportNewYearTaskView:bindEvents()
	PassportNewYearTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnsSwitch[1].go, GameUtil.handler(self._onClickSwitch, self, 1))
	GameUtil.addClickHandler(self._btnsSwitch[2].go, GameUtil.handler(self._onClickSwitch, self, 2))
	GameUtil.addClickHandler(self._btnHelp, self._onClickHelp, self)
end

function PassportNewYearTaskView:unbindEvents()
	PassportNewYearTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnsSwitch[1].go)
	GameUtil.rmClickHandler(self._btnsSwitch[2].go)
	GameUtil.rmClickHandler(self._btnHelp)
end

function PassportNewYearTaskView:onEnter()
	PassportNewYearTaskView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._switchId = 1

	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	MaterialMgr.setIcon(self._itemCampPower, MatType.ACTIVITY_ITEM, self._activityId)
	self:dealLoadBGRes()
	self:_sendInfoReq()

	local startTime, endTime = ActivityDefineController:getStartTimeAndEndTime(GameEnum.ActivityType.PASSPORT_NEWYEAR, self._activityId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	GameUtil.SetActive(self._campPowerGo, false)
	GameUtil.SetActive(self._tipsGo, false)

	self._txtTime.text = langPara("活动时间：%s.%s 5:00 -%s.%s 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

function PassportNewYearTaskView:onExit()
	PassportNewYearTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._updateMatNum, self)
	self._tableView:dispose()
	MaterialMgr.resetAll(self._itemCampPower)
	uGuiUtil.clearImage(self._bg)

	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function PassportNewYearTaskView:_sendInfoReq()
	EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._activityId)
end

function PassportNewYearTaskView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function PassportNewYearTaskView:_onUpdateData()
	self:_onUpdateTaskData()
end

function PassportNewYearTaskView:_onUpdateUI()
	self:_updateTaskScrollerList()

	for k, v in ipairs(self._btnsSwitch) do
		goutil.setActive(v.select, k == self._switchId)
	end
end

function PassportNewYearTaskView:_onUpdateTaskData()
	self._taskDataQueue = {}

	local queue = EventTaskSummaryConfig.instance:getTaskQueue(self._activityId)

	for pageId, taskList in ipairs(queue) do
		local list = {}

		for idx, data in ipairs(taskList) do
			local tab = {}

			tab.data = data
			tab.state = EventTaskSummaryController.instance:calcTaskState(self._activityId, data.taskId)

			table.insert(list, tab)
		end

		table.sort(list, function(a, b)
			if a.state == b.state then
				if a.data.taskId < b.data.taskId then
					return true
				end

				return false
			end

			return a.state < b.state
		end)

		self._taskDataQueue[pageId] = list
	end

	table.sort(self._taskDataQueue, function(listA, listB)
		local a = listA[1]
		local b = listB[1]

		if a.state == b.state then
			if a.data.taskId < b.data.taskId then
				return true
			end

			return false
		end

		return a.state < b.state
	end)
end

function PassportNewYearTaskView:_updateTaskScrollerList()
	local list = {}
	local fitterList = {}

	for _, taskDataList in ipairs(self._taskDataQueue) do
		if taskDataList[1].state == 3 then
			table.insert(list, taskDataList[#taskDataList])
		else
			table.insert(list, taskDataList[1])
		end
	end

	for _, v in ipairs(list) do
		if self._switchId == 1 and v.data.periodType == "daily" then
			table.insert(fitterList, v)
		elseif self._switchId == 2 and v.data.periodType ~= "daily" then
			table.insert(fitterList, v)
		end
	end

	self._tableView:reloadData(fitterList)
end

function PassportNewYearTaskView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.btnGet = goutil.findChild(cell.go, "btnGet")
	cell.btnGoTo = goutil.findChild(cell.go, "btnGoTo")
	cell.goFinish = goutil.findChild(cell.go, "finishGo")
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "descTxt")
	cell.txtName = goutil.findChildTextComponent(cell.go, "nameTxt")
	cell.txtProger = goutil.findChildTextComponent(cell.go, "progerTxt")
	cell.item = goutil.findChild(cell.go, "item")

	MaterialMgr.resetAll(cell.item)
	GameUtil.rmClickHandler(cell.btnGet)
	GameUtil.rmClickHandler(cell.btnGoTo)

	return cell
end

function PassportNewYearTaskView:_updateCell(view, goCell, temData)
	local data = temData.data
	local cell = self:_clearCell(goCell)

	MaterialMgr.setCellListByCfg(data.prize, cell.item)

	cell.txtDesc.text = data.desc
	cell.txtName.text = data.title

	local curProgress = EventTaskSummaryModel.instance:getTaskCurProgress(data.taskId)
	local maxProgress = data.maxProgress

	cell.txtProger.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

	GameUtil.SetActive(cell.btnGet, temData.state == 1)
	GameUtil.SetActive(cell.btnGoTo, temData.state == 2)
	GameUtil.SetActive(cell.goFinish, temData.state == 3)
	GameUtil.SetActive(cell.txtProger.gameObject, temData.state ~= 3)
	GameUtil.addClickHandler(cell.btnGoTo, GameUtil.handler(self._onClickBtnGo, self, data))
	GameUtil.addClickHandler(cell.btnGet, GameUtil.handler(self._onClickBtnRecieve, self, data.taskId))
end

function PassportNewYearTaskView:_onClickBtnGo(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	GotoMgr.gotoByString(data.jumpTo)
end

function PassportNewYearTaskView:_onClickBtnRecieve(taskId)
	EventTaskSummaryController.instance:onSendEventTaskSummaryGainTaskPrizeReq(self._activityId, taskId)
end

function PassportNewYearTaskView:_onClickSwitch(id)
	if self._switchId ~= id then
		self._switchId = id

		self:_onUpdate()
	end
end

function PassportNewYearTaskView:dealLoadBGRes()
	local resDataList = {
		[-1] = {
			bgRes = "bg_zytxz_05",
			skinId = 15012,
			scale = {
				-1,
				1,
				1
			},
			pos = {
				-350,
				-570
			}
		}
	}

	if not resDataList[curId] then
		local data = resDataList[-1]

		if not string.nilorempty(data.bgRes) then
			local path = GameUrl.getPassportBGUrl(data.bgRes)

			uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, path)
		end

		if data.skinId > 0 then
			GameUtil.setAnchoredPos(self._con, data.pos[1], data.pos[2])

			self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, data.skinId, self._con, data.scale)
		end
	end
end

function PassportNewYearTaskView:_onClickHelp()
	UIStateManager.instance:push(ViewName.RulesView, "ChristmasPassport_rule")
end

return PassportNewYearTaskView
