-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassporttaskcommonView.lua

module("logic.extensions.passport.view.PassporttaskcommonView", package.seeall)

local PassporttaskcommonView = class("PassporttaskcommonView", ViewComponent)

function PassporttaskcommonView:ctor()
	PassporttaskcommonView.super.ctor(self)
end

function PassporttaskcommonView:unbindEvents()
	PassporttaskcommonView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnsSwitch[1].go)
	GameUtil.rmClickHandler(self._btnsSwitch[2].go)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
end

function PassporttaskcommonView:bindEvents()
	PassporttaskcommonView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnsSwitch[1].go, GameUtil.handler(self._onClickSwitch, self, 1))
	GameUtil.addClickHandler(self._btnsSwitch[2].go, GameUtil.handler(self._onClickSwitch, self, 2))
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
end

function PassporttaskcommonView:buildUI()
	PassporttaskcommonView.super.buildUI(self)

	self._topLeft = self:getGo("topLeft")
	self._btnClose = self:getBtn("topLeft/btnClose")
	self._txtTitle = self:getTxt("topLeft/txtTitle")
	self._onePage = self:getGo("title/onePage")
	self._twoPage = self:getGo("title/twoPage")
	self._btnsSwitch = {}

	for i = 1, 2 do
		local btn = {}

		btn.go = self:getGo("title/twoPage/btnTask_" .. i)
		btn.select = goutil.findChild(btn.go, "select")
		btn.dot = goutil.findChild(btn.go, "dot")
		self._btnsSwitch[i] = btn
	end

	self._bg = self:getGo("bg")
	self._bgMask = self:getGo("bgMask")
	self._con = self:getGo("con")
	self._txtTime = self:getTxt("time/txt")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._rare = self:getGo("petInfo/rare")
	self._txtName = self:getTxt("petInfo/txtName")
	self._tableView = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._Scorelist = ScrollerList.create(self._tableView, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PassporttaskcommonView:onExit()
	PassporttaskcommonView.super.onExit(self)
	self._Scorelist:dispose()
	self._Scorelist:reloadData(nil)
	uGuiUtil.clearImage(self._bg)
	uGuiUtil.clearImage(self._bgMask)
	MaterialMgr.resetAll(self._rare)

	self.loader = RoleObjectPool.instance:removeRole(self.loader)

	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
end

function PassporttaskcommonView:onEnter()
	PassporttaskcommonView.super.onEnter(self)

	local params = self:getFirstParam()
	local allParam = self:getOpenParam()
	local tabCfg = params

	if type(tabCfg) == "table" then
		self._activityId = tabCfg.activityId
		self._parameter = tabCfg.parameter
	elseif #allParam > 1 then
		self._activityId = checknumber(allParam[1])
		self._parameter = checknumber(allParam[2])
	else
		FloatWordMgr.instance:show("传参有误！")
		self:close()

		return
	end

	self._cfg = XiaonuoBirthConfig.instance:getPassporttaskById(checknumber(self._activityId), checknumber(self._parameter))
	self._taskPageCfg = EventTaskSummaryConfig.instance:getTaskPageCfg(self._activityId)

	if self._cfg.isFullScreen then
		GameUtil.SetActive(self._topLeft, true)
		GameUtil.SetActive(self._onePage, false)
		GameUtil.SetActive(self._twoPage, true)

		self._txtTitle.text = self._cfg.title
		self._switchId = PassportModel.instance:_getLastSwitchId() or 1
	else
		GameUtil.SetActive(self._topLeft, false)
		GameUtil.SetActive(self._onePage, true)
		GameUtil.SetActive(self._twoPage, false)

		self._switchId = 2
	end

	if not string.nilorempty(tabCfg.limitTime) then
		local timeCfg = string.split(tabCfg.limitTime, "#")
		local startDate = GameUtil.string2date(timeCfg[1])
		local endDate = GameUtil.string2date(timeCfg[2])

		self._txtTime.text = langPara("活动时间：%s.%s 5:00 -%s.%s 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
	else
		local activityType = math.floor(checknumber(self._activityId) / 1000)
		local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, self._activityId)
		local startDate = GameUtil.time2date(startTime)
		local endDate = GameUtil.time2date(endTime)

		self._txtTime.text = langPara("活动时间：%s.%s 5:00 -%s.%s 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
	end

	self:_showPetInfoAndBg()
	self:_sendInfoReq()
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
end

function PassporttaskcommonView:_sendInfoReq()
	EventTaskSummaryAgent.instance:sendPM_EventTaskSummaryGetInfoReq(self._activityId)
end

function PassporttaskcommonView:_onUpdate()
	self:_onUpdateTaskDate()
	self:_onUpdateUI()
end

function PassporttaskcommonView:_onUpdateUI()
	self:_sortTaskCell()

	local tabRedState = {}

	for _, v in ipairs(self._taskLists) do
		if v.data.periodType == "daily" then
			if not tabRedState[1] and v.state == 1 then
				tabRedState[1] = true
			end
		elseif not tabRedState[2] and v.state == 1 then
			tabRedState[2] = true
		end
	end

	for k, v in ipairs(self._btnsSwitch) do
		goutil.setActive(v.select, k == self._switchId)
		goutil.setActive(v.dot, tabRedState[k] == true)
	end
end

function PassporttaskcommonView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtDesc = goutil.findChildTextComponent(cell.go, "txtDesc")
	cell.txtTitle = goutil.findChildTextComponent(cell.go, "txtTitle")
	cell.txtProgress = goutil.findChildTextComponent(cell.go, "txtProgress")
	cell.txtTime = goutil.findChildTextComponent(cell.go, "txtTime")
	cell.item = goutil.findChild(cell.go, "item")
	cell.btnReceive = goutil.findChild(cell.go, "btnRecieve")
	cell.btnGoto = goutil.findChild(cell.go, "btnGoto")
	cell.receive = goutil.findChild(cell.go, "receive")
	cell.noPass = goutil.findChild(cell.go, "noPass")

	MaterialMgr.resetAll(cell.item)
	GameUtil.rmClickHandler(cell.btnReceive)
	GameUtil.rmClickHandler(cell.btnGoto)

	return cell
end

function PassporttaskcommonView:_updateCell(view, goCell, temData)
	local data = temData.data
	local cell = self:_clearCell(goCell)

	cell.txtTitle.text = data.title
	cell.txtDesc.text = data.desc

	local curProgress = EventTaskSummaryModel.instance:getTaskCurProgress(data.taskId)
	local maxProgress = data.maxProgress

	cell.txtProgress.text = string.format("%s/%s", Mathf.Clamp(curProgress, 0, maxProgress), maxProgress)

	MaterialMgr.setCellListByCfg(data.prize, cell.item)

	local startDate, endDate = GameUtil.string2date(data.startTime), GameUtil.string2date(data.endTime)

	cell.txtTime.text = string.format("生效时间：\n%02d.%02d 5:00 - %02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)

	local isCanJump = self:_isTaskCanJump(data.taskId)
	local isInTime = self:_isTaskInTime(data.taskId)

	GameUtil.SetActive(cell.btnReceive, temData.state == 1)
	GameUtil.SetActive(cell.btnGoto, temData.state == 2 and isInTime and isCanJump)
	GameUtil.SetActive(cell.noPass, not isCanJump and temData.state == 2)
	GameUtil.SetActive(cell.receive, temData.state == 3)
	GameUtil.SetActive(cell.txtProgress.gameObject, temData.state ~= 3 and isInTime and isCanJump)
	GameUtil.SetActive(cell.txtTime.gameObject, not isInTime and temData.state == 2)
	GameUtil.addClickHandler(cell.btnGoto, function()
		self:_onClickGoto(data)
	end, self)
	GameUtil.addClickHandler(cell.btnReceive, function()
		self:_onClickRecieve(data.taskId)
	end, self)
end

function PassporttaskcommonView:_onUpdateTaskDate()
	self._taskDataQueue = {}
	self._taskLists = {}

	local queue = EventTaskSummaryConfig.instance:getTaskQueue(self._activityId)

	for pageId, taskList in ipairs(queue) do
		local list = {}

		for idx, data in ipairs(taskList) do
			local tab = {}

			tab.data = data
			tab.state = EventTaskSummaryController.instance:calcTaskState(self._activityId, data.taskId)

			table.insert(list, tab)
			table.insert(self._taskLists, tab)
		end

		table.sort(list, function(a, b)
			self:_checkTimeCfg(a.data.endTime, b.data.endTime, b.data.taskId)

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
		local isInTimeA = self:_isTaskInTime(a.data.taskId)
		local isInTimeB = self:_isTaskInTime(b.data.taskId)

		if isInTimeA == isInTimeB then
			if a.state == b.state then
				if a.data.taskId < b.data.taskId then
					return true
				end

				return false
			end

			return a.state < b.state
		else
			return not not isInTimeA
		end
	end)
end

function PassporttaskcommonView:_sortTaskCell()
	local fitterList = {}

	self._taskLists = self._taskDataQueue[1]

	for _, v in ipairs(self._taskDataQueue[1]) do
		if self._switchId == 1 and v.data.periodType == "daily" then
			table.insert(fitterList, v)
		elseif self._switchId == 2 and v.data.periodType ~= "daily" then
			table.insert(fitterList, v)
		end
	end

	self._Scorelist:reloadData(fitterList)
end

function PassporttaskcommonView:_isTaskInTime(taskId)
	return EventTaskSummaryController.instance:isTaskInTime(self._activityId, taskId)
end

function PassporttaskcommonView:_isTaskCanJump(taskId)
	return EventTaskSummaryController.instance:isTaskHasJumpStr(self._activityId, taskId)
end

function PassporttaskcommonView:_checkTimeCfg(timeA, timeB, taskId)
	if string.nilorempty(timeA) or string.nilorempty(timeB) then
		return
	end

	local timeA = GameUtil.string2time(timeA)
	local timeB = GameUtil.string2time(timeB)

	if timeB < timeA then
		printError("警告！警告！任务id:" .. taskId .. "，任务生效时间配置错误，请修改配置（yh运营-活动任务.xlsx/export_任务方案），前面任务的结束时间要比后面的晚哦")
	end
end

function PassporttaskcommonView:_showPetInfoAndBg()
	local path = GameUrl.getPassportBGUrl(self._cfg.imgBg)

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, path)
	uGuiUtil.setSpriteToImage(self._bgMask, uGuiUtil.SpriteType.BigBg, path)

	local skinId = self._cfg.raceId
	local pos = self._cfg.pos

	if not pos[1] then
		if not pos[2] then
			local y = 0
			local scale = self._cfg.scale

			self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, skinId, self._con, scale, nil, true, pos[1], y)

			MaterialMgr.setCell(MatType.Rare, skinId, self._rare)

			self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, skinId)
		end
	end
end

function PassporttaskcommonView:_onClickSkill()
	local raceId = self._cfg.raceId
	local raceIdByCfg = PetSkinConfig.instance:getPetSkinRaceId(raceId)

	if raceIdByCfg ~= raceId then
		PetbookController.instance:previewBattle(raceIdByCfg, raceId)
	else
		PetbookController.instance:previewBattle(raceId)
	end
end

function PassporttaskcommonView:_onClickInfo()
	local raceId = self._cfg.raceId
	local raceIdByCfg = PetSkinConfig.instance:getPetSkinRaceId(raceId)

	if raceIdByCfg ~= raceId then
		PetbookController.instance:openSkinViewNoSetAttr(raceId)
	else
		PetbookController.instance:openPetinfoView(raceId)
	end
end

function PassporttaskcommonView:_onClickSwitch(id)
	if self._switchId ~= id then
		self._switchId = id

		self:_onUpdate()
	end
end

function PassporttaskcommonView:_onClickGoto(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	GotoMgr.gotoByString(data.jumpTo)
	PassportModel.instance:_setLastSwitchId(self._switchId)

	if data.viewId > 0 then
		EventTaskSummaryController.instance:onSendEventTaskSummaryViewReq(self._activityId, data.viewId)
	end
end

function PassporttaskcommonView:_onClickRecieve(taskId)
	EventTaskSummaryController.instance:onSendEventTaskSummaryGainTaskPrizeReq(self._activityId, taskId)
end

return PassporttaskcommonView
