-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/musicgame/MusicGameResultView.lua

module("modules.logic.versionactivity4_0.concertlimit.view.musicgame.MusicGameResultView", package.seeall)

local MusicGameResultView = class("MusicGameResultView", BaseView)

function MusicGameResultView:onInitView()
	self._goresult = gohelper.findChild(self.viewGO, "root/#go_result")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/#go_result/#txt_desc")
	self._txtscore = gohelper.findChildText(self.viewGO, "root/#go_result/#txt_score")
	self._btnquit = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_result/btn/#btn_quit")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_result/btn/#btn_restart")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MusicGameResultView:addEvents()
	self._btnquit:AddClickListener(self._btnquitOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
end

function MusicGameResultView:removeEvents()
	self._btnquit:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
end

function MusicGameResultView:_btnquitOnClick()
	MusicGameController.instance:exitGame()
end

function MusicGameResultView:_btnrestartOnClick()
	MusicGameController.instance:restartGame()
end

function MusicGameResultView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self._onEscapeBtnClick, self)

	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function MusicGameResultView:_onEscapeBtnClick()
	return
end

function MusicGameResultView:onOpen()
	AudioMgr.instance:trigger(AudioEnum4_0.MusicGame.play_ui_yingmen4_0_short_music)
	self:_refresh()
end

function MusicGameResultView:_refresh()
	if not self.viewParam then
		local score = MusicGameModel.instance:getCurScore()

		self._txtscore.text = score

		local scorelv = MusicGameModel.instance:getGameScoreLv(score)
		local lvCo = MusicGameConfig.instance:getLevelCo(scorelv)

		if lvCo then
			self._txtdesc.text = lvCo.strValue or ""
		end
	end
end

function MusicGameResultView:onClose()
	AudioMgr.instance:trigger(AudioEnum4_0.MusicGame.stop_ui_yingmen4_0_short_music)
end

function MusicGameResultView:onDestroyView()
	return
end

return MusicGameResultView
