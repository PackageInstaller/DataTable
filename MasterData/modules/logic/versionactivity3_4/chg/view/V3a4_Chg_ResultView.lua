-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_ResultView.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_ResultView", package.seeall)

local V3a4_Chg_ResultView = class("V3a4_Chg_ResultView", BaseView)

function V3a4_Chg_ResultView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_restart")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4_Chg_ResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
end

function V3a4_Chg_ResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
end

function V3a4_Chg_ResultView:_btncloseOnClick()
	return
end

function V3a4_Chg_ResultView:_btnquitgameOnClick()
	local kViewName = ViewName.V3a4_Chg_GameView

	if ViewMgr.instance:isOpen(kViewName) then
		local c = ViewMgr.instance:getContainer(kViewName)

		c:closeThis()
	end

	self:closeThis()
	self.viewContainer:trackFailExit()
end

function V3a4_Chg_ResultView:_btnrestartOnClick()
	local kViewName = ViewName.V3a4_Chg_GameView

	if ViewMgr.instance:isOpen(kViewName) then
		local c = ViewMgr.instance:getContainer(kViewName)

		c:doRestart()
	end

	self:closeThis()
	self.viewContainer:trackFailReset()
end

function V3a4_Chg_ResultView:_editableInitView()
	return
end

function V3a4_Chg_ResultView:onUpdateParam()
	return
end

function V3a4_Chg_ResultView:onOpen()
	self:onUpdateParam()
	GameFacade.showToast(ToastEnum.ChgFail)
	AudioMgr.instance:trigger(AudioEnum3_4.Chg.play_ui_bulaochun_cheng_fail)
end

function V3a4_Chg_ResultView:onClose()
	return
end

function V3a4_Chg_ResultView:onDestroyView()
	return
end

return V3a4_Chg_ResultView
