-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolQuestionView.lua

module("logic.extensions.magicschool.view.MagicSchoolQuestionView", package.seeall)

local MagicSchoolQuestionView = class("MagicSchoolQuestionView", ViewComponent)

function MagicSchoolQuestionView:ctor()
	MagicSchoolQuestionView.super.ctor(self)
end

function MagicSchoolQuestionView:unbindEvents()
	MagicSchoolQuestionView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function MagicSchoolQuestionView:bindEvents()
	MagicSchoolQuestionView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function MagicSchoolQuestionView:buildUI()
	MagicSchoolQuestionView.super.buildUI(self)

	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtQuestionDesc = self:getTxt("ask/txt")
	self._txtProgress = self:getTxt("progress/txtProgress")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function MagicSchoolQuestionView:onExit()
	MagicSchoolQuestionView.super.onExit(self)
	self._scrollList:dispose()
	removetimer(self._updateQuestion, self)
end

function MagicSchoolQuestionView:onEnter()
	MagicSchoolQuestionView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MagicSchoolJoinCampRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 514001
	end

	self._questionId = 1
	self._answer = ""
	self._info = MagicSchoolModel.instance:getInfo(self._activityId)
	self._campId = self._info and self._info.campId
	self._actCfg = MagicSchoolConfig.instance:getActCfg(self._activityId)

	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	if checknumber(self._campId) == 0 then
		MagicSchoolController.instance:sendPM_MagicSchoolJoinCampReq(self._activityId)
	else
		self:_onUpdate()
	end
end

function MagicSchoolQuestionView:_onUpdate()
	self._info = MagicSchoolModel.instance:getInfo(self._activityId)
	self._campId = self._info.campId
	self._questionCfgs = MagicSchoolConfig.instance:getQuestionCfgs(self._activityId, self._campId)

	local curQuestionCfg = self._questionCfgs[self._questionId]
	local questionNum = checknumber(#self._questionCfgs)

	self._selectCfgs = MagicSchoolConfig.instance:getSelectCfgsById(self._activityId, self._campId, self._questionId)
	self._txtQuestionDesc.text = curQuestionCfg.content
	self._txtProgress.text = string.format("%d/%d", self._questionId, questionNum)

	self._scrollList:reloadData(self._selectCfgs)
end

function MagicSchoolQuestionView:_updateCell(view, cell, data)
	local imgChoose = goutil.findChild(cell, "imgChoose")
	local txtAnswer = goutil.findChildTextComponent(cell, "txtAnswer")

	txtAnswer.text = data.content

	GameUtil.SetActive(imgChoose, false)
	GameUtil.addClickHandler(cell, function()
		ViewBlockMgr.instance:blockClick(true, self)

		self._answer = self._answer .. data.answerKey
		self._questionId = self._questionId + 1

		GameUtil.SetActive(imgChoose, true)
		settimer(2, self._updateQuestion, self)
	end, self)
end

function MagicSchoolQuestionView:_clearCell(cell)
	GameUtil.rmClickHandler(cell)
end

function MagicSchoolQuestionView:_updateQuestion()
	removetimer(self._updateQuestion, self)

	if self._questionId > #self._questionCfgs then
		UIStateManager.instance:push(ViewName.MagicSchoolQuestionEndView, self._activityId, self._campId, self._answer)
		ViewBlockMgr.instance:blockClick(false, self)
		self:close()

		return
	end

	local curQuestionCfg = self._questionCfgs[self._questionId]
	local questionNum = checknumber(#self._questionCfgs)

	self._selectCfgs = MagicSchoolConfig.instance:getSelectCfgsById(self._activityId, self._campId, self._questionId)
	self._txtQuestionDesc.text = curQuestionCfg.content
	self._txtProgress.text = string.format("%d/%d", self._questionId, questionNum)

	self._scrollList:reloadData(self._selectCfgs)
	ViewBlockMgr.instance:blockClick(false, self)
end

function MagicSchoolQuestionView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

return MagicSchoolQuestionView
