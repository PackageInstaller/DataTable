-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportBirthdayTaskView.lua

module("logic.extensions.passport.view.PassportBirthdayTaskView", package.seeall)

local PassportBirthdayTaskView = class("PassportBirthdayTaskView", ViewComponent)

function PassportBirthdayTaskView:buildUI()
	PassportBirthdayTaskView.super.buildUI(self)

	self._goTable = self:getGo("tableview")
	self._goCell = self:getGo("cell")
	self._tableView = ScrollerList.create(self._goTable, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getGo("btnClose")
	self._btnsSwitch = {}

	for i = 1, 2 do
		local btn = {}

		btn.go = self:getGo("btn_" .. i)
		btn.select = goutil.findChild(btn.go, "select")
		btn.dot = goutil.findChild(btn.go, "dot")
		self._btnsSwitch[i] = btn
	end

	self._bg = self:getGo("viewBgGo")
	self._con = self:getGo("con")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._rare = self:getGo("petInfo/rare")
	self._txtName = self:getTxt("petInfo/txtName")
	self._txtTime = self:getTxt("time/txt")
	self._btnHelp = self:getGo("btnHelp")
end

function PassportBirthdayTaskView:bindEvents()
	PassportBirthdayTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnsSwitch[1].go, GameUtil.handler(self._onClickSwitch, self, 1))
	GameUtil.addClickHandler(self._btnsSwitch[2].go, GameUtil.handler(self._onClickSwitch, self, 2))
	GameUtil.addClickHandler(self._btnHelp, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickPetInfo, self)
end

function PassportBirthdayTaskView:unbindEvents()
	PassportBirthdayTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnsSwitch[1].go)
	GameUtil.rmClickHandler(self._btnsSwitch[2].go)
	GameUtil.rmClickHandler(self._btnHelp)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
end

function PassportBirthdayTaskView:onEnter()
	PassportBirthdayTaskView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._funcId = checknumber(params[2])
	self._switchId = 1
	self._timeScrollConf = TimeScrollerConfig.instance:getActConfig(self._activityId)

	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	self:dealLoadBGRes()
	self:_sendInfoReq()

	local startTime, endTime = ActivityDefineController:getStartTimeAndEndTime(GameEnum.ActivityType.FUN_CAMP_EXCHANGE, self._activityId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = langPara("活动时间：%s.%s 5:00 -%s.%s 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

function PassportBirthdayTaskView:onExit()
	PassportBirthdayTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)
	self._tableView:dispose()
	uGuiUtil.clearImage(self._bg)

	self.loader = RoleObjectPool.instance:removeRole(self.loader)

	MaterialMgr.resetAll(self._rare)
end

function PassportBirthdayTaskView:_sendInfoReq()
	EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._activityId)
end

function PassportBirthdayTaskView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function PassportBirthdayTaskView:_onUpdateData()
	self:_onUpdateTaskData()
end

function PassportBirthdayTaskView:_onUpdateUI()
	self:_updateTaskScrollerList()

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

function PassportBirthdayTaskView:_onUpdateTaskData()
	self._taskDataQueue = {}
	self._taskLists = {}

	local queue = EventTaskSummaryConfig.instance:getTaskQueue(self._activityId)

	for pageId, taskList in pairs(queue) do
		local list = {}

		for idx, data in pairs(taskList) do
			local tab = {}

			tab.data = data
			tab.state = EventTaskSummaryController.instance:calcTaskState(self._activityId, data.taskId)

			table.insert(list, tab)
			table.insert(self._taskLists, tab)
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

function PassportBirthdayTaskView:_updateTaskScrollerList()
	local list = {}
	local fitterList = {}

	for _, taskDataList in ipairs(self._taskDataQueue) do
		if taskDataList[1].state == 3 then
			table.insert(list, taskDataList[#taskDataList])
		else
			table.insert(list, taskDataList[1])
		end
	end

	self._taskLists = list

	for _, v in ipairs(list) do
		if self._switchId == 1 and v.data.periodType == "daily" then
			table.insert(fitterList, v)
		elseif self._switchId == 2 and v.data.periodType ~= "daily" then
			table.insert(fitterList, v)
		end
	end

	self._tableView:reloadData(fitterList)
end

function PassportBirthdayTaskView:_clearCell(goCell)
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

function PassportBirthdayTaskView:_updateCell(view, goCell, temData)
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

function PassportBirthdayTaskView:_onClickBtnGo(data)
	if string.nilorempty(data.jumpTo) then
		return
	end

	if checknumber(data.viewId) then
		PassportAgent:sendPM_PassportViewReq(checknumber(data.viewId), self._funcId)
	end

	GotoMgr.gotoByString(data.jumpTo)
end

function PassportBirthdayTaskView:_onClickBtnRecieve(taskId)
	EventTaskSummaryController.instance:onSendEventTaskSummaryGainTaskPrizeReq(self._activityId, taskId)
end

function PassportBirthdayTaskView:_onClickSwitch(id)
	if self._switchId ~= id then
		self._switchId = id

		self:_onUpdate()
	end
end

function PassportBirthdayTaskView:dealLoadBGRes()
	local path = GameUrl.getPassportBGUrl(self._timeScrollConf.taskBgPath)

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, path)

	local skinId = self._timeScrollConf.taskShowPetRaceId
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId) or {}

	if not modelCfg[1] then
		local x = 0

		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, skinId, self._con, scale, nil, true, x, y)

				MaterialMgr.setCell(MatType.PetSkin_Rare, skinId, self._rare)

				self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, skinId)
			end
		end
	end
end

function PassportBirthdayTaskView:_onClickHelp()
	UIStateManager.instance:push(ViewName.RulesView, "passportbirthdaytaskview_rule")
end

function PassportBirthdayTaskView:_onClickPetInfo()
	PetbookController.instance:openPetinfoView(self._timeScrollConf.taskShowPetRaceId)
end

function PassportBirthdayTaskView:_onClickSkill()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self._timeScrollConf.taskShowPetRaceId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self._timeScrollConf.taskShowPetRaceId)
	end
end

return PassportBirthdayTaskView
