-- chunkname: @modules/logic/versionactivity3_3/marsha/view/MarshaResultView.lua

module("modules.logic.versionactivity3_3.marsha.view.MarshaResultView", package.seeall)

local MarshaResultView = class("MarshaResultView", BaseView)

function MarshaResultView:onInitView()
	self._goSuccess = gohelper.findChild(self.viewGO, "#go_Success")
	self._goFail = gohelper.findChild(self.viewGO, "#go_Fail")
	self._btnExit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Fail/#btn_Exit")
	self._btnRetry = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Fail/#btn_Retry")
	self._txtTarget = gohelper.findChildText(self.viewGO, "Target/#txt_Target")
	self._goStarLight = gohelper.findChild(self.viewGO, "Target/Star/#go_StarLight")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MarshaResultView:addEvents()
	self._btnExit:AddClickListener(self._btnExitOnClick, self)
	self._btnRetry:AddClickListener(self._btnRetryOnClick, self)
end

function MarshaResultView:removeEvents()
	self._btnExit:RemoveClickListener()
	self._btnRetry:RemoveClickListener()
end

function MarshaResultView:onClickModalMask()
	if self.isSuccess then
		MarshaController.instance:onGameFinish()
		ViewMgr.instance:closeView(ViewName.MarshaGameView)
		self:closeThis()
	end
end

function MarshaResultView:_btnExitOnClick()
	ViewMgr.instance:closeView(ViewName.MarshaGameView)
	self:closeThis()
end

function MarshaResultView:_btnRetryOnClick()
	MarshaController.instance:dispatchEvent(MarshaEvent.GameRestart)
	self:closeThis()
end

function MarshaResultView:_editableInitView()
	return
end

function MarshaResultView:onOpen()
	self.isSuccess = self.viewParam.isSuccess
	self.gameCfg = self.viewParam.gameCfg
	self._txtTarget.text = self.gameCfg.targetDesc

	if self.isSuccess then
		AudioMgr.instance:trigger(AudioEnum3_3.Marsha.play_ui_yuanzheng_mrs_win)
	else
		AudioMgr.instance:trigger(AudioEnum3_3.Marsha.play_ui_yuanzheng_mrs_fail)
	end

	gohelper.setActive(self._goFail, not self.isSuccess)
	gohelper.setActive(self._goSuccess, self.isSuccess)
	gohelper.setActive(self._goStarLight, self.isSuccess)
end

return MarshaResultView
