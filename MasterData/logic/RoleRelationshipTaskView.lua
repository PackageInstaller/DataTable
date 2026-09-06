-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rolerelationship/view/RoleRelationshipTaskView.lua

module("logic.extensions.rolerelationship.view.RoleRelationshipTaskView", package.seeall)

local RoleRelationshipTaskView = class("RoleRelationshipTaskView", ViewComponent)

function RoleRelationshipTaskView:ctor()
	RoleRelationshipTaskView.super.ctor(self)
end

function RoleRelationshipTaskView:buildUI()
	RoleRelationshipTaskView.super.buildUI(self)

	self._scrollerview = goutil.findChild(self.mainGO, "contentCol/scrollerview")
	self._scrollercell = goutil.findChild(self.mainGO, "contentCol/scrollercell")

	local updateCellCallBack = GameUtil.handler(self._updateTaskCell, self)
	local clearCellCallBack = GameUtil.handler(self._clearTaskCell, self)

	self._taskScrollList = ScrollerList.create(self._scrollerview, self._scrollercell, updateCellCallBack, clearCellCallBack)
	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
end

function RoleRelationshipTaskView:bindEvents()
	RoleRelationshipTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
end

function RoleRelationshipTaskView:unbindEvents()
	RoleRelationshipTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function RoleRelationshipTaskView:destroyUI()
	RoleRelationshipTaskView.super.destroyUI(self)
end

function RoleRelationshipTaskView:onEnter()
	RoleRelationshipTaskView.super.onEnter(self)

	self._activityId = RoleRelationshipModel.instance:getCurActivityId()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.RoleShip, self._activityId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:_onClickBtnClose()

		return
	end

	self_rsTaskCfg = RoleRelationshipConfig.instance:getRsTaskCfg(self._activityId)

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.RoleShipUpdateTaskInfo, self._onUpdateUI, self)
	RoleRelationshipController.instance:onSendRRMGetTaskInfoReq(self._activityId)
end

function RoleRelationshipTaskView:onExit()
	RoleRelationshipTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RoleShipUpdateTaskInfo, self._onUpdateUI, self)
	self._taskScrollList:dispose()
end

function RoleRelationshipTaskView:_onSetUI()
	return
end

function RoleRelationshipTaskView:_onUpdateUI()
	self:_onUpdateTaskDataMo()
	self:_onUpdateTaskScrollerList()
end

function RoleRelationshipTaskView:_onUpdateTaskDataMo()
	self._taskDataMo = {}

	for taskId, data in ipairs(self_rsTaskCfg) do
		table.insert(self._taskDataMo, {
			taskState = RoleRelationshipController.instance:getTaskState(taskId),
			data = data
		})
	end
end

function RoleRelationshipTaskView:isTaskHasCompleted(taskId)
	local taskState = self._taskDataMo[taskId].taskState

	return taskState == 2
end

function RoleRelationshipTaskView:getTaskData(taskId)
	return self._taskDataMo[taskId].data
end

function RoleRelationshipTaskView:_onUpdateTaskScrollerList()
	local list = {}

	for _, mo in ipairs(self._taskDataMo) do
		table.insert(list, mo)
	end

	self._taskScrollList:reloadData(list)
end

function RoleRelationshipTaskView:_updateTaskCell(view, cell, mo, tag)
	local data = mo.data
	local mainGo = cell.gameObject
	local btnGo = goutil.findChild(mainGo, "btnGo")
	local iconComplete = goutil.findChild(mainGo, "iconComplete")
	local txtDesc = MaterialMgr.findGraphicText(mainGo, "txtDesc")
	local isNeedDesc = txtDesc and not string.nilorempty(data.txtDesc)

	if isNeedDesc then
		txtDesc.text = data.txtDesc
	end

	local isTaskHasCompleted = self:isTaskHasCompleted(data.taskId)

	GameUtil.SetActive(btnGo, not isTaskHasCompleted)
	GameUtil.SetActive(iconComplete, isTaskHasCompleted)
	GameUtil.addClickHandler(btnGo, GameUtil.handler(self._onClickBtnGo, self, data))
end

function RoleRelationshipTaskView:_clearTaskCell(cell)
	return
end

function RoleRelationshipTaskView:_onClickBtnGo(data)
	if string.nilorempty(data.gotoStr) then
		return
	end

	ViewAutoShowController.instance:saveCurModalView()
	GotoMgr.gotoByString(data.gotoStr)
end

function RoleRelationshipTaskView:_onClickBtnClose()
	self:close()
end

return RoleRelationshipTaskView
