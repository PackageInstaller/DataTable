-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightregress/view/SaintKnightRegressTaskView.lua

module("logic.extensions.saintknightregress.view.SaintKnightRegressTaskView", package.seeall)

local SaintKnightRegressTaskView = class("SaintKnightRegressTaskView", ViewComponent)

function SaintKnightRegressTaskView:ctor()
	SaintKnightRegressTaskView.super.ctor(self)
end

function SaintKnightRegressTaskView:unbindEvents()
	SaintKnightRegressTaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SaintKnightRegressTaskView:bindEvents()
	SaintKnightRegressTaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SaintKnightRegressTaskView:buildUI()
	SaintKnightRegressTaskView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._taskScrollerView = self:getGo("taskScrollerview")
	self._taskScrollerCell = self:getGo("taskScrollercell")
	self._taksTableList = ScrollerList.create(self._taskScrollerView, self._taskScrollerCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTitle = self:getTxt("txtTitle")
end

function SaintKnightRegressTaskView:onExit()
	SaintKnightRegressTaskView.super.onExit(self)
end

function SaintKnightRegressTaskView:onEnter()
	SaintKnightRegressTaskView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SaintKnightRegressGetInfo, self._refreshView, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._playerId = checknumber(params[2])
	self._playerName = params[3]

	SaintKnightRegressAgent.instance:sendPM_SaintKnightRegressGetTaskInfoReq(self._activityId, self._playerId)

	self._txtTitle.text = string.nilorempty(self._playerName) and lang("我的任务") or langPara("%s玩家的任务", self._playerName)
end

function SaintKnightRegressTaskView:_refreshView()
	local taskCfgs = SaintKnightRegressConfig.instance:getRegressTasks(self._activityId)

	self._taksTableList:reloadData(taskCfgs)
end

function SaintKnightRegressTaskView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local receivedGo = goutil.findChild(go, "receivedGo")
	local unreceivedGo = goutil.findChild(go, "unreceivedGo")
	local txtTitle = goutil.findChildTextComponent(go, "txtTitle")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local taskInfo = SaintKnightRegressModel.instance:getRegressPlayerTaskInfo(data.id)

	txtTitle.text = data.title
	txtDesc.text = data.desc

	GameUtil.SetActive(receivedGo, taskInfo.curProgress >= data.maxProgress)
	GameUtil.SetActive(unreceivedGo, taskInfo.curProgress < data.maxProgress)
end

function SaintKnightRegressTaskView:_clearCell(cell)
	return
end

return SaintKnightRegressTaskView
