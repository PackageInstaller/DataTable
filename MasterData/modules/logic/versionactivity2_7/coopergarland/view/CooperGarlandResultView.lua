-- chunkname: @modules/logic/versionactivity2_7/coopergarland/view/CooperGarlandResultView.lua

module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandResultView", package.seeall)

local CooperGarlandResultView = class("CooperGarlandResultView", BaseView)

function CooperGarlandResultView:onInitView()
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._gotargetitem = gohelper.findChild(self.viewGO, "targets/#go_targetitem")
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

function CooperGarlandResultView:addEvents()
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnsuccessClick:AddClickListener(self._btnsuccessClickOnClick, self)
end

function CooperGarlandResultView:removeEvents()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnsuccessClick:RemoveClickListener()
end

function CooperGarlandResultView:_btnquitgameOnClick()
	CooperGarlandStatHelper.instance:sendGameExit(self.viewName)
	CooperGarlandController.instance:exitGame()
	self:closeThis()
end

function CooperGarlandResultView:_btnrestartOnClick()
	CooperGarlandStatHelper.instance:sendMapReset(self.viewName)
	CooperGarlandController.instance:resetGame()
	self:closeThis()
end

function CooperGarlandResultView:_btnsuccessClickOnClick()
	CooperGarlandController.instance:exitGame()
	self:closeThis()
end

function CooperGarlandResultView:_editableInitView()
	return
end

function CooperGarlandResultView:onUpdateParam()
	return
end

function CooperGarlandResultView:onOpen()
	if self.viewParam then
		gohelper.setActive(self._gosuccess, self.viewParam)
		gohelper.setActive(self._btnsuccessClick, self.viewParam)
		gohelper.setActive(self._gofail, not self.viewParam)
		gohelper.setActive(self._gobtn, not self.viewParam)
		gohelper.setActive(self._gotargetitem, self.viewParam)
		gohelper.setActive(self._gofinish, self.viewParam)
		gohelper.setActive(self._gounfinish, not self.viewParam)

		if self.viewParam then
			if not AudioEnum2_7.CooperGarland.play_ui_pkls_endpoint_arrival then
				local audioId = AudioEnum2_7.CooperGarland.play_ui_pkls_challenge_fail

				AudioMgr.instance:trigger(audioId)
			end
		end
	end
end

function CooperGarlandResultView:onClose()
	return
end

function CooperGarlandResultView:onDestroyView()
	return
end

return CooperGarlandResultView
