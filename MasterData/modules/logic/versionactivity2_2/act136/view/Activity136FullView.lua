-- chunkname: @modules/logic/versionactivity2_2/act136/view/Activity136FullView.lua

module("modules.logic.versionactivity2_2.act136.view.Activity136FullView", package.seeall)

local Activity136FullView = class("Activity136FullView", BaseView)

function Activity136FullView:onInitView()
	self._txtremainTime = gohelper.findChildText(self.viewGO, "timebg/#txt_remainTime")
	self._gouninvite = gohelper.findChild(self.viewGO, "#go_inviteContent/#go_uninvite")
	self._btninvite = gohelper.findChildButtonWithAudio(self.viewGO, "#go_inviteContent/#go_uninvite/#btn_invite")
	self._goinvited = gohelper.findChild(self.viewGO, "#go_inviteContent/#go_invited")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity136FullView:addEvents()
	self._btninvite:AddClickListener(self._btninviteOnClick, self)
	Activity136Controller.instance:registerCallback(Activity136Event.ActivityDataUpdate, self.refresh, self)
end

function Activity136FullView:removeEvents()
	self._btninvite:RemoveClickListener()
	Activity136Controller.instance:unregisterCallback(Activity136Event.ActivityDataUpdate, self.refresh, self)
end

function Activity136FullView:_btninviteOnClick()
	Activity136Controller.instance:openActivity136ChoiceView()
end

function Activity136FullView:_editableInitView()
	return
end

function Activity136FullView:onUpdateParam()
	return
end

function Activity136FullView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	self:refresh()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
end

function Activity136FullView:refresh()
	self:refreshStatus()
	self:refreshRemainTime()
end

function Activity136FullView:refreshStatus()
	local hasReceive = Activity136Model.instance:hasReceivedCharacter()

	gohelper.setActive(self._goinvited, hasReceive)
	gohelper.setActive(self._gouninvite, not hasReceive)
end

function Activity136FullView:refreshRemainTime()
	local actId = Activity136Controller.instance:actId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)
	local timeStr, isEnd = actInfoMo:getRemainTimeStr3()

	self._txtremainTime.text = string.format(luaLang("remain"), timeStr)

	if isEnd then
		TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	end
end

function Activity136FullView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function Activity136FullView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

return Activity136FullView
