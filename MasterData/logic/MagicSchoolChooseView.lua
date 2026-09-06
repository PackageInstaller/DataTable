-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolChooseView.lua

module("logic.extensions.magicschool.view.MagicSchoolChooseView", package.seeall)

local MagicSchoolChooseView = class("MagicSchoolChooseView", ViewComponent)

function MagicSchoolChooseView:ctor()
	MagicSchoolChooseView.super.ctor(self)
end

function MagicSchoolChooseView:unbindEvents()
	MagicSchoolChooseView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBookTest)
end

function MagicSchoolChooseView:bindEvents()
	MagicSchoolChooseView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnBookTest, self._onClickBtnBookTest, self)
end

function MagicSchoolChooseView:buildUI()
	MagicSchoolChooseView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnBookTest = self:getGo("btnBookTest")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
end

function MagicSchoolChooseView:onExit()
	MagicSchoolChooseView.super.onExit(self)
end

function MagicSchoolChooseView:onEnter()
	MagicSchoolChooseView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 514001
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	self._actCfg = MagicSchoolConfig.instance:getActCfg(self._activityId)
end

function MagicSchoolChooseView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function MagicSchoolChooseView:_onClickBtnBookTest()
	local info = MagicSchoolModel.instance:getInfo(self._activityId)
	local curCampId = info and info.campId
	local campKey = "MagicSchoolChallengeView" .. self._activityId .. "#" .. curCampId
	local hasSaveCampId = GameUtil.getUserData(campKey)

	if hasSaveCampId then
		FloatWordMgr.instance:show("已分配阵营，无需重复答题")

		return
	end

	UIStateManager.instance:push(ViewName.MagicSchoolQuestionView, self._activityId)
end

return MagicSchoolChooseView
