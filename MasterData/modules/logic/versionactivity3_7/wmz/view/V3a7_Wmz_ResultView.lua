-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_ResultView.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_ResultView", package.seeall)

local V3a7_Wmz_ResultView = class("V3a7_Wmz_ResultView", BaseView)

function V3a7_Wmz_ResultView:onInitView()
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._gobtn = gohelper.findChild(self.viewGO, "#go_btn")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_restart")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_Wmz_ResultView:addEvents()
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
end

function V3a7_Wmz_ResultView:removeEvents()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
end

function V3a7_Wmz_ResultView:_btnquitgameOnClick()
	WmzController.instance:dispatchEvent(WmzEvent.onGameResultClickQuit)
	self:closeThis()
end

function V3a7_Wmz_ResultView:_btnrestartOnClick()
	WmzController.instance:dispatchEvent(WmzEvent.onGameResultClickRestart)
	self:closeThis()
end

function V3a7_Wmz_ResultView:_editableInitView()
	return
end

function V3a7_Wmz_ResultView:onUpdateParam()
	return
end

function V3a7_Wmz_ResultView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_2.HuiDiaoLan.play_ui_shengyan_hdl_fail)
end

function V3a7_Wmz_ResultView:onClose()
	return
end

function V3a7_Wmz_ResultView:onDestroyView()
	return
end

return V3a7_Wmz_ResultView
