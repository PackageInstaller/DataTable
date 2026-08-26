-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/MaLiAnNaNoticeView.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.MaLiAnNaNoticeView", package.seeall)

local MaLiAnNaNoticeView = class("MaLiAnNaNoticeView", BaseView)

function MaLiAnNaNoticeView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goPaper = gohelper.findChild(self.viewGO, "#go_Paper")
	self._simagePaper3 = gohelper.findChildSingleImage(self.viewGO, "#go_Paper/Panel/#simage_Paper3")
	self._simagePaper2 = gohelper.findChildSingleImage(self.viewGO, "#go_Paper/Panel/#simage_Paper2")
	self._simagePaper1 = gohelper.findChildSingleImage(self.viewGO, "#go_Paper/Panel/#simage_Paper1")
	self._scrollDescr = gohelper.findChildScrollRect(self.viewGO, "#go_Paper/Panel/#scroll_Descr")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#go_Paper/Panel/#scroll_Descr/viewport/#txt_Descr")
	self._goStart = gohelper.findChild(self.viewGO, "#go_Start")
	self._simageMaskBG = gohelper.findChildSingleImage(self.viewGO, "#go_Start/#simage_MaskBG")
	self._simageStart = gohelper.findChildSingleImage(self.viewGO, "#go_Start/#simage_Start")
	self._txtStart = gohelper.findChildText(self.viewGO, "#go_Start/#txt_Start")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MaLiAnNaNoticeView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function MaLiAnNaNoticeView:removeEvents()
	self._btnClose:RemoveClickListener()
end

local step = {
	showPaper = 1,
	showStart = 2
}

function MaLiAnNaNoticeView:_btnCloseOnClick()
	if self._step == step.showPaper then
		self._step = step.showStart

		self:refresh()

		return
	end

	self:closeThis()
end

function MaLiAnNaNoticeView:_editableInitView()
	return
end

function MaLiAnNaNoticeView:onUpdateParam()
	return
end

function MaLiAnNaNoticeView:onOpen()
	self._step = step.showPaper
	self._config = Activity201MaLiAnNaGameModel.instance:getCurGameConfig()

	if string.nilorempty(self._config.battledesc) then
		self._step = step.showStart
	else
		self._txtDescr.text = self._config.battledesc
	end

	self:refresh()
end

function MaLiAnNaNoticeView:refresh()
	gohelper.setActive(self._goPaper, self._step == step.showPaper)
	gohelper.setActive(self._goStart, self._step == step.showStart)

	if self._step == step.showStart then
		TaskDispatcher.runDelay(self.closeThis, self, 2.4)
		TaskDispatcher.runDelay(self._playFireAudio, self, 1)
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_fight_begin_1)
	end
end

function MaLiAnNaNoticeView:_playFireAudio()
	AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_fight_begin_2)
end

function MaLiAnNaNoticeView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.cancelTask(self._playFireAudio, self)
	ViewMgr.instance:openView(ViewName.Activity201MaLiAnNaGameView)
end

function MaLiAnNaNoticeView:onDestroyView()
	return
end

return MaLiAnNaNoticeView
