-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguessselectView.lua

module("logic.extensions.drawandguess.view.DrawandguessselectView", package.seeall)

local DrawandguessselectView = class("DrawandguessselectView", ViewComponent)

function DrawandguessselectView:ctor()
	DrawandguessselectView.super.ctor(self)
end

function DrawandguessselectView:unbindEvents()
	DrawandguessselectView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function DrawandguessselectView:bindEvents()
	DrawandguessselectView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function DrawandguessselectView:buildUI()
	DrawandguessselectView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTime = self:getTxt("txtTime")
end

function DrawandguessselectView:onExit()
	DrawandguessselectView.super.onExit(self)
	self._scrollerList:dispose()
	removetimer(self._tickTime, self)
end

function DrawandguessselectView:onEnter()
	DrawandguessselectView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.NotifyDrawAndGuessDrawStartRes, self.close, self)

	self._activityId = self:getFirstParam()
	self._selectQuestionId = 0

	local questionIds = DrawandguessModel.instance:getQuestionIds()

	self._scrollerList:reloadData(questionIds)

	self._targetTime = DrawandguessModel.instance:getStartTime() + DrawandguessConfig.instance:getCommonValue("SELECT_QUESTION_SEC", true) - 3

	settimer(1, self._tickTime, self, true)
	self:_tickTime()
	goutil.setActive(self._btnSure.gameObject, true)
end

function DrawandguessselectView:_onClickbtnSure()
	local qId = DrawandguessModel.instance:getCurQuestionId()

	if qId and qId > 0 then
		FloatWordMgr.instance:show("题目已选好，进入绘画界面中")
		self:close()

		return
	end

	if self._selectQuestionId <= 0 then
		FloatWordMgr.instance:show("请选择题目")

		return
	end

	DrawAndGuessAgent.instance:sendPM_DrawAndGuessSelectQuestionReq(self._activityId, self._selectQuestionId)
end

function DrawandguessselectView:_updateCell(view, cell, questionId, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local cfg = DrawandguessConfig.instance:getQuestionCfg(self._activityId, questionId)
	local typeCfg = DrawandguessConfig.instance:getQuestionTypeCfg(cfg.typeId)

	txtDesc.text = string.format("题库类型:%s\n题目:%s", typeCfg.desc, cfg.question)

	goutil.setActive(goSelect, self._selectQuestionId == questionId)
	btn:AddClickListener(function()
		self._selectQuestionId = questionId

		self._scrollerList:refresh()
	end)
end

function DrawandguessselectView:_clearCell(cell)
	return
end

function DrawandguessselectView:_tickTime()
	local left = self._targetTime - ServerTime.now()

	if left > 0 then
		self._txtTime.text = string.format("剩余%s秒", left)
	else
		removetimer(self._tickTime, self)
		self:_onHandleTimeOut()
	end
end

function DrawandguessselectView:_onHandleTimeOut()
	self._txtTime.text = "请等待"

	goutil.setActive(self._btnSure.gameObject, false)
end

return DrawandguessselectView
