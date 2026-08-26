-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114OperView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114OperView", package.seeall)

local Activity114OperView = class("Activity114OperView", BaseView)

function Activity114OperView:ctor(path)
	self._path = path
end

function Activity114OperView:onInitView()
	self.go = gohelper.findChild(self.viewGO, self._path)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity114OperView:addEvents()
	self.viewContainer:registerCallback(Activity114Event.ShowHideEduOper, self.changeGoShow, self)
	Activity114Controller.instance:registerCallback(Activity114Event.OnRoundUpdate, self.updateLock, self)
	Activity114Controller.instance:registerCallback(Activity114Event.UnLockRedDotUpdate, self.updateUnLockRed, self)
end

function Activity114OperView:removeEvents()
	self.viewContainer:unregisterCallback(Activity114Event.ShowHideEduOper, self.changeGoShow, self)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnRoundUpdate, self.updateLock, self)
	Activity114Controller.instance:unregisterCallback(Activity114Event.UnLockRedDotUpdate, self.updateUnLockRed, self)
end

function Activity114OperView:_editableInitView()
	self.opers = {}

	for i = 1, 4 do
		self.opers[i] = self:getUserDataTb_()
		self.opers[i].btn = gohelper.findChildButtonWithAudio(self.go, "#btn_oper" .. i)
		self.opers[i].icon = gohelper.findChildImage(self.go, "#btn_oper" .. i .. "/icon")
		self.opers[i].txticon = gohelper.findChildImage(self.go, "#btn_oper" .. i .. "/txt")
		self.opers[i].line = gohelper.findChildImage(self.go, "#btn_oper" .. i .. "/line")
		self.opers[i].go_lock = gohelper.findChild(self.go, "#btn_oper" .. i .. "/#go_lock")
		self.opers[i].redPoint = gohelper.findChild(self.go, "#btn_oper" .. i .. "/redPoint")
		self.opers[i].lockdesc = gohelper.findChildTextMesh(self.go, "#btn_oper" .. i .. "/#go_lock/lockdesc")

		self.addClickCb(self, self.opers[i].btn, self.onBtnClick, self, i)
	end

	self:updateLock()
end

function Activity114OperView:onBtnClick(type)
	if self.opers[type].go_lock.activeSelf then
		GameFacade.showToast(ToastEnum.Act114LockOper)

		return
	end

	if Activity114Model.instance:have114StoryFlow() then
		local roundCo = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, Activity114Model.instance.serverData.day, Activity114Model.instance.serverData.round)

		if roundCo and roundCo.isSkip == 1 then
			return
		end
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)

	if type == Activity114Enum.EventType.Edu then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open)
		self:_btneduOnClick()
	elseif type == Activity114Enum.EventType.Travel then
		self:_btntravelOnClick()
	elseif type == Activity114Enum.EventType.Meet then
		self:_btnmeetOnClick()
	elseif type == Activity114Enum.EventType.Rest then
		self:_btnrestOnClick()
	end
end

function Activity114OperView:changeGoShow(isShow)
	if self.go.activeSelf ~= isShow then
		return
	end

	if not isShow then
		gohelper.setActive(self.go, true)
	end
end

function Activity114OperView:updateUnLockRed()
	gohelper.setActive(self.opers[Activity114Enum.EventType.Meet].redPoint, Activity114Model.instance:haveUnLockMeeting() and not self.opers[Activity114Enum.EventType.Meet].go_lock.activeSelf)
	gohelper.setActive(self.opers[Activity114Enum.EventType.Travel].redPoint, Activity114Model.instance:haveUnLockTravel() and not self.opers[Activity114Enum.EventType.Travel].go_lock.activeSelf)
end

function Activity114OperView:updateLock()
	local week = Activity114Model.instance.serverData.week
	local nowDay = Activity114Model.instance.serverData.day
	local nowRound = Activity114Model.instance.serverData.round
	local roundCo = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, nowDay, nowRound)

	if not roundCo["banButton" .. week] then
		for i = 1, 4 do
			self:setLock(i, false)
		end

		self:updateUnLockRed()

		return
	end

	local banTypes = string.splitToNumber(roundCo["banButton" .. week], "#")
	local dict = {}

	for _, v in pairs(banTypes) do
		dict[v] = true
	end

	for i = 1, 4 do
		self:setLock(i, dict[i])
	end

	self:updateUnLockRed()
end

function Activity114OperView:setLock(index, isLock)
	self:setLockColor(self.opers[index].icon, isLock)

	if self.opers[index].txticon then
		self:setLockColor(self.opers[index].txticon, isLock)
		self:setLockColor(self.opers[index].line, isLock)
	end

	gohelper.setActive(self.opers[index].go_lock, isLock)

	self.opers[index].btn.enabled = not isLock

	if isLock then
		local roundCo = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, Activity114Model.instance.serverData.day, Activity114Model.instance.serverData.round)

		self.opers[index].lockdesc.text = formatLuaLang("versionactivity_1_2_114mainview_lockdesc", roundCo.desc)
	end
end

function Activity114OperView:setLockColor(graphic, isLock)
	SLFramework.UGUI.GuiHelper.SetColor(graphic, isLock and "#666666" or "#FFFFFF")
	ZProj.UGUIHelper.SetColorAlpha(graphic, isLock and 0.8 or 1)
end

function Activity114OperView:_btneduOnClick()
	gohelper.setActive(self.go, false)
	self.viewContainer:dispatchEvent(Activity114Event.ShowHideEduOper, true)
end

function Activity114OperView:_btntravelOnClick()
	ViewMgr.instance:openView(ViewName.Activity114TravelView)
end

function Activity114OperView:_btnrestOnClick()
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.Act114Rest, MsgBoxEnum.BoxType.Yes_No, self._restClick, nil, nil, self)
end

function Activity114OperView:_restClick()
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	Activity114Rpc.instance:restRequest(Activity114Model.instance.id)
end

function Activity114OperView:_btnmeetOnClick()
	ViewMgr.instance:openView(ViewName.Activity114MeetView)
end

return Activity114OperView
