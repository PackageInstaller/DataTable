-- chunkname: @modules/logic/versionactivity3_3/igor/view/IgorGameFailView.lua

module("modules.logic.versionactivity3_3.igor.view.IgorGameFailView", package.seeall)

local IgorGameFailView = class("IgorGameFailView", BaseView)

function IgorGameFailView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_fail")
	self.btnQuitGame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#btn_quitgame")
	self.btnRestartGame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#btn_restart")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function IgorGameFailView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.btnQuitGame:AddClickListener(self.btnQuitGameOnClick, self)
	self.btnRestartGame:AddClickListener(self.btnRestartGameOnClick, self)
end

function IgorGameFailView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.btnQuitGame:RemoveClickListener()
	self.btnRestartGame:RemoveClickListener()
end

function IgorGameFailView:_btncloseOnClick()
	self:closeThis()
end

function IgorGameFailView:btnQuitGameOnClick()
	self:_btncloseOnClick()
end

function IgorGameFailView:btnRestartGameOnClick()
	IgorController.instance:resetGame()

	self.isRestart = true

	self:closeThis()
end

function IgorGameFailView:_editableInitView()
	return
end

function IgorGameFailView:onUpdateParam()
	return
end

function IgorGameFailView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_3.Igor.play_ui_pkls_challenge_fail)
	self:refreshUI()
end

function IgorGameFailView:refreshUI()
	return
end

function IgorGameFailView:onClose()
	if self.isRestart then
		self.isRestart = false

		return
	end

	ViewMgr.instance:closeView(ViewName.IgorGameView)
end

function IgorGameFailView:onDestroyView()
	return
end

return IgorGameFailView
