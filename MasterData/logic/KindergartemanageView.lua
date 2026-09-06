-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergartemanageView.lua

module("logic.extensions.kindergarten.view.KindergartemanageView", package.seeall)

local KindergartemanageView = class("KindergartemanageView", ViewComponent)

function KindergartemanageView:ctor()
	KindergartemanageView.super.ctor(self)
end

function KindergartemanageView:unbindEvents()
	KindergartemanageView.super.unbindEvents(self)
	self._btn3:RemoveClickListener()
	self._btn2:RemoveClickListener()
	self._btn1:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function KindergartemanageView:bindEvents()
	KindergartemanageView.super.bindEvents(self)
	self._btn3:AddClickListener(self._onClickbtn3, self)
	self._btn2:AddClickListener(self._onClickbtn2, self)
	self._btn1:AddClickListener(self._onClickbtn1, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
end

function KindergartemanageView:buildUI()
	KindergartemanageView.super.buildUI(self)

	self._btn3 = self:getBtn("btn3")
	self._btn2 = self:getBtn("btn2")
	self._btn1 = self:getBtn("btn1")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtbubble = self:getTxt("txtbubble")
end

function KindergartemanageView:onExit()
	KindergartemanageView.super.onExit(self)
end

function KindergartemanageView:onEnter()
	KindergartemanageView.super.onEnter(self)

	self._activityId = KindergartenModel.instance:getActivityId()

	self:_initView()
end

function KindergartemanageView:_initView()
	if not KindergartenModel.instance:getFirstIntoManage(self._activityId) then
		self:_onClickbtnTip()
		KindergartenModel.instance:saveFirstIntoManage(self._activityId)
	end
end

function KindergartemanageView:_onClickbtn3()
	UIStateManager.instance:push(ViewName.KindergarteemployView)
end

function KindergartemanageView:_onClickbtn2()
	UIStateManager.instance:push(ViewName.KindergartenJobTendencyView, self._activityId)
end

function KindergartemanageView:_onClickbtn1()
	UIStateManager.instance:push(ViewName.KindergartenCourseView, self._activityId)
end

function KindergartemanageView:_onClickbtnClose()
	self:close()
end

function KindergartemanageView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("kindergarte_manager_rule")
end

return KindergartemanageView
