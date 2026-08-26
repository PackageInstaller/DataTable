-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186GameInviteView.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186GameInviteView", package.seeall)

local Activity186GameInviteView = class("Activity186GameInviteView", BaseView)

function Activity186GameInviteView:onInitView()
	self.goSelect = gohelper.findChild(self.viewGO, "root/goSelect")
	self.goRight = gohelper.findChild(self.viewGO, "root/right")
	self.btnSure = gohelper.findChildButtonWithAudio(self.goSelect, "btnSure")
	self.btnCancel = gohelper.findChildButtonWithAudio(self.goSelect, "btnCancel")
	self.txtTitle = gohelper.findChildTextMesh(self.goSelect, "content")
	self.txtSure = gohelper.findChildTextMesh(self.goSelect, "btnSure/txt")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity186GameInviteView:addEvents()
	self.addClickCb(self, self.btnSure, self.onClickBtnSure, self)
	self.addClickCb(self, self.btnCancel, self.onClickBtnCancel, self)
end

function Activity186GameInviteView:removeEvents()
	return
end

function Activity186GameInviteView:_editableInitView()
	return
end

function Activity186GameInviteView:onClickBtnSure()
	Activity186Controller.instance:enterGame(self.actId, self.gameId)
end

function Activity186GameInviteView:onClickBtnCancel()
	self:closeThis()
end

function Activity186GameInviteView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function Activity186GameInviteView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_leimi_theft_open)
	self:refreshParam()
	self:refreshView()
end

function Activity186GameInviteView:refreshParam()
	self.actId = self.viewParam.activityId
	self.gameId = self.viewParam.gameId
	self.gameStatus = self.viewParam.gameStatus
	self.gameType = self.viewParam.gameType
end

function Activity186GameInviteView:refreshView()
	gohelper.setActive(self.goSelect, self.gameStatus == Activity186Enum.GameStatus.Start)
	gohelper.setActive(self.goRight, self.gameStatus == Activity186Enum.GameStatus.Playing)

	if self.gameStatus == Activity186Enum.GameStatus.Start then
		if self.gameType == 1 then
			self.viewContainer.heroView:showText(luaLang("p_activity186gameinviteview_txt_content1"))

			self.txtTitle.text = luaLang("p_activity186gameinviteview_txt_title1")
			self.txtSure.text = luaLang("p_activity186gameinviteview_txt_start2")
		else
			self.viewContainer.heroView:showText(luaLang("p_activity186gameinviteview_txt_content2"))

			self.txtTitle.text = luaLang("p_activity186gameinviteview_txt_title2")
			self.txtSure.text = luaLang("p_activity186gameinviteview_txt_start")
		end

		self:_showDeadline()
	else
		TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	end
end

function Activity186GameInviteView:_showDeadline()
	self:_onRefreshDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
end

function Activity186GameInviteView:_onRefreshDeadline()
	self:checkGameNotOnline()
end

function Activity186GameInviteView:checkGameNotOnline()
	local mo = Activity186Model.instance:getById(self.actId)

	if not mo then
		return
	end

	local gameInfo = mo:getGameInfo(self.gameId)

	if not gameInfo then
		return
	end

	if not mo:isGameOnline(self.gameId) then
		self:closeThis()
	end
end

function Activity186GameInviteView:onClose()
	return
end

function Activity186GameInviteView:onDestroyView()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
end

return Activity186GameInviteView
