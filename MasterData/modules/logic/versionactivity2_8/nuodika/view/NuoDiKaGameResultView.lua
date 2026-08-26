-- chunkname: @modules/logic/versionactivity2_8/nuodika/view/NuoDiKaGameResultView.lua

module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaGameResultView", package.seeall)

local NuoDiKaGameResultView = class("NuoDiKaGameResultView", BaseView)

function NuoDiKaGameResultView:onInitView()
	self._gotop = gohelper.findChild(self.viewGO, "#go_top")
	self._txtstage = gohelper.findChildText(self.viewGO, "#go_top/#txt_stage")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_top/#txt_name")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._txttaskdesc = gohelper.findChildText(self.viewGO, "targets/#go_targetitem/#txt_taskdesc")
	self._gounfinish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/#go_unfinish")
	self._gofinish = gohelper.findChild(self.viewGO, "targets/#go_targetitem/result/#go_finish")
	self._gobtn = gohelper.findChild(self.viewGO, "#go_btn")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btn/#btn_restart")
	self._btnsuccessClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_successClick")
	self._goTargetParent = gohelper.findChild(self.viewGO, "targets")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NuoDiKaGameResultView:addEvents()
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
	self._btnsuccessClick:AddClickListener(self._btnsuccessClickOnClick, self)
end

function NuoDiKaGameResultView:removeEvents()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
	self._btnsuccessClick:RemoveClickListener()
end

function NuoDiKaGameResultView:_btnquitgameOnClick()
	self._tipType = NuoDiKaEnum.ResultTipType.Quit

	self:closeThis()
end

function NuoDiKaGameResultView:_btnrestartOnClick()
	self._tipType = NuoDiKaEnum.ResultTipType.Restart

	self:closeThis()
end

function NuoDiKaGameResultView:_btnsuccessClickOnClick()
	self:closeThis()
end

function NuoDiKaGameResultView:_editableInitView()
	self._tipType = NuoDiKaEnum.ResultTipType.None
end

function NuoDiKaGameResultView:onUpdateParam()
	return
end

function NuoDiKaGameResultView:onOpen()
	local isSuccess = self.viewParam.isSuccess

	if isSuccess then
		AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_game_fail_tip)
	else
		AudioMgr.instance:trigger(AudioEnum2_8.NuoDiKa.play_ui_game_success_tip)
	end

	gohelper.setActive(self._gosuccess, isSuccess)
	gohelper.setActive(self._goTargetParent, isSuccess)
	gohelper.setActive(self._gofail, not isSuccess)
	gohelper.setActive(self._gobtn, not isSuccess)
	gohelper.setActive(self._btnsuccessClick, isSuccess)

	local episodeId = NuoDiKaModel.instance:getCurEpisode()
	local episodeConfig = NuoDiKaConfig.instance:getEpisodeCo(VersionActivity2_8Enum.ActivityId.NuoDiKa, episodeId)

	self._txtname.text = episodeConfig.name
	self._txtstage.text = string.format("%02d", NuoDiKaModel.instance:getCurEpisodeIndex())
end

function NuoDiKaGameResultView:onClose()
	if self.viewParam.isSuccess then
		if self.viewParam.callback then
			self.viewParam.callback(self.viewParam.callbackObj)
		end
	elseif self.viewParam.callback then
		self.viewParam.callback(self.viewParam.callbackObj, self._tipType)
	end
end

function NuoDiKaGameResultView:onDestroyView()
	return
end

return NuoDiKaGameResultView
