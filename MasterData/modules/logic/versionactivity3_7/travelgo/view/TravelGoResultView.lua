-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/TravelGoResultView.lua

module("modules.logic.versionactivity3_7.travelgo.view.TravelGoResultView", package.seeall)

local TravelGoResultView = class("TravelGoResultView", BaseView)

function TravelGoResultView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self.btnExit = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_quitgame")
	self.btnReplay = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_restart")
	self._gowin = gohelper.findChild(self.viewGO, "#go_success")
	self._gofailed = gohelper.findChild(self.viewGO, "#go_fail")
	self._txtTip = gohelper.findChildTextMesh(self.viewGO, "targets/#go_targetitem/txt_taskdesc")
	self.go_finish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/go_finish")
	self.go_unfinish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/go_unfinish")

	gohelper.setActive(self.btnExit, false)
	gohelper.setActive(self.btnReplay, false)
end

function TravelGoResultView:addEvents()
	self.addClickCb(self, self._btnclose, self.closeThis, self)
end

function TravelGoResultView:onOpen()
	self.isWin = self.viewParam.isWin
	self.gameId = self.viewParam.gameId

	gohelper.setActive(self._gowin, self.isWin)
	gohelper.setActive(self._gofailed, not self.isWin)
	gohelper.setActive(self.go_finish, self.isWin)
	gohelper.setActive(self.go_unfinish, not self.isWin)

	local cfg = lua_activity220_game.configDict[self.gameId]

	if self.isWin then
		AudioMgr.instance:trigger(AudioEnum3_5.Lamona.play_ui_yuanzheng_mrs_win)

		self._txtTip.text = cfg.winText
	else
		AudioMgr.instance:trigger(AudioEnum3_5.Lamona.play_ui_yuanzheng_mrs_fail)

		local day = TravelGoModel.instance.day

		self._txtTip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("TravelGoResultView_1"), {
			day,
			day,
			cfg.levelDay
		})
	end
end

function TravelGoResultView:onClose()
	TravelGoController.instance:onSettleEnd()
end

function TravelGoResultView:onDestroyView()
	return
end

return TravelGoResultView
