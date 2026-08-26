-- chunkname: @modules/logic/versionactivity3_3/igor/view/IgorGameSuccessView.lua

module("modules.logic.versionactivity3_3.igor.view.IgorGameSuccessView", package.seeall)

local IgorGameSuccessView = class("IgorGameSuccessView", BaseView)

function IgorGameSuccessView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gobtn = gohelper.findChild(self.viewGO, "#go_btns")

	gohelper.setActive(self._gobtn, false)

	self.btnQuitGame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#btn_quitgame")
	self.btnRestartGame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#btn_restart")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function IgorGameSuccessView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.btnQuitGame:AddClickListener(self.btnQuitGameOnClick, self)
	self.btnRestartGame:AddClickListener(self.btnRestartGameOnClick, self)
end

function IgorGameSuccessView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.btnQuitGame:RemoveClickListener()
	self.btnRestartGame:RemoveClickListener()
end

function IgorGameSuccessView:_btncloseOnClick()
	self:closeThis()
end

function IgorGameSuccessView:btnQuitGameOnClick()
	self:_btncloseOnClick()
end

function IgorGameSuccessView:btnRestartGameOnClick()
	IgorController.instance:resetGame()

	self.isRestart = true

	self:closeThis()
end

function IgorGameSuccessView:_editableInitView()
	return
end

function IgorGameSuccessView:onUpdateParam()
	return
end

function IgorGameSuccessView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_3.Igor.play_ui_pkls_endpoint_arrival)

	local param = self.viewParam

	self.actId = param.episodeCo.activityId
	self.episodeId = param.episodeCo.episodeId

	self:refreshUI()
end

function IgorGameSuccessView:refreshUI()
	return
end

function IgorGameSuccessView:onClose()
	if self.isRestart then
		self.isRestart = false

		return
	end

	ViewMgr.instance:closeView(ViewName.IgorGameView)

	if self.actId and self.episodeId then
		Activity220Controller.instance:onGameFinished(self.actId, self.episodeId)
	end
end

function IgorGameSuccessView:onDestroyView()
	return
end

return IgorGameSuccessView
