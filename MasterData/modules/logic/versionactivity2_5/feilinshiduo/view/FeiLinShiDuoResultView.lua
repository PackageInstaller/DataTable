-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/view/FeiLinShiDuoResultView.lua

module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoResultView", package.seeall)

local FeiLinShiDuoResultView = class("FeiLinShiDuoResultView", BaseView)

function FeiLinShiDuoResultView:onInitView()
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._gotargetitem = gohelper.findChild(self.viewGO, "targets/#go_targetitem")
	self._txttaskdesc = gohelper.findChildText(self.viewGO, "targets/#go_targetitem/#txt_taskdesc")
	self._gofinish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/#go_finish")
	self._gounfinish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/#go_unfinish")
	self._gobtn = gohelper.findChild(self.viewGO, "#go_btn")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_restart")
	self._btnsuccessClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_successClick")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FeiLinShiDuoResultView:addEvents()
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnsuccessClick:AddClickListener(self._btnquitgameOnClick, self)
end

function FeiLinShiDuoResultView:removeEvents()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnsuccessClick:RemoveClickListener()
end

function FeiLinShiDuoResultView:_btnquitgameOnClick()
	ViewMgr.instance:closeView(ViewName.FeiLinShiDuoGameView, false, true)
	self:closeThis()
end

function FeiLinShiDuoResultView:_btnrestartOnClick()
	FeiLinShiDuoStatHelper.instance:initGameStartTime()
	FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.ResultResetGame)
	self:closeThis()
end

function FeiLinShiDuoResultView:_editableInitView()
	return
end

function FeiLinShiDuoResultView:onUpdateParam()
	return
end

function FeiLinShiDuoResultView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_move_loop)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_box_push_loop)
	AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.stop_ui_tangren_ladder_crawl_loop)

	self.isSuccess = self.viewParam.isSuccess

	self:refreshUI()
end

function FeiLinShiDuoResultView:refreshUI()
	gohelper.setActive(self._gosuccess, self.isSuccess)
	gohelper.setActive(self._gofinish, self.isSuccess)
	gohelper.setActive(self._gobtn, not self.isSuccess)
	gohelper.setActive(self._gofail, not self.isSuccess)
	gohelper.setActive(self._gounfinish, not self.isSuccess)
	gohelper.setActive(self._btnsuccessClick.gameObject, self.isSuccess)

	self._txttaskdesc.text = luaLang("act185_gametarget")

	if self.isSuccess then
		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_pkls_endpoint_arrival)
	else
		AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_pkls_challenge_fail)
	end
end

function FeiLinShiDuoResultView:onClose()
	return
end

function FeiLinShiDuoResultView:onDestroyView()
	return
end

return FeiLinShiDuoResultView
