-- chunkname: @modules/logic/versionactivity1_5/peaceulu/view/PeaceUluResultView.lua

module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluResultView", package.seeall)

local PeaceUluResultView = class("PeaceUluResultView", BaseView)

function PeaceUluResultView:onInitView()
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._txttips = gohelper.findChildText(self.viewGO, "tips/#txt_tips")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_restart")
	self._canvasGroupRestart = self._btnrestart.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._canvasGroupQuitegame = self._btnquitgame.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._gorestarticon = gohelper.findChild(self.viewGO, "#btn_restart/icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "#btn_restart/icon/#txt_Num")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PeaceUluResultView:addEvents()
	self.addEventCb(self, PeaceUluController.instance, PeaceUluEvent.reInitResultView, self._reInitUI, self)
	self._btnquitgame:AddClickListener(self._btnexitOnClick, self)
	self._btnrestart:AddClickListener(self._btncontinueOnClick, self)
end

function PeaceUluResultView:removeEvents()
	self.removeEventCb(self, PeaceUluController.instance, PeaceUluEvent.reInitResultView, self._reInitUI, self)
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
end

function PeaceUluResultView:_btnexitOnClick()
	self._animator:Play("close", 0, 0)
	self._animator:Update(0)
	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onSwitchTab, PeaceUluEnum.TabIndex.Main)
end

function PeaceUluResultView:_btncontinueOnClick()
	if not PeaceUluModel.instance:checkCanPlay() then
		return
	end

	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onSwitchTab, PeaceUluEnum.TabIndex.Game)
end

function PeaceUluResultView:_editableInitView()
	return
end

function PeaceUluResultView:_reInitUI()
	gohelper.setActive(self._gosuccess, false)
	gohelper.setActive(self._gofail, false)
end

function PeaceUluResultView:onUpdateParam()
	return
end

function PeaceUluResultView:onOpen()
	self:refreshUI()

	if self._cannotPlay then
		self._animator:Play("open1", 0, 0)
		self._animator:Update(0)
	else
		self._animator:Play("open", 0, 0)
		self._animator:Update(0)
	end

	local navigatetionview = self.viewContainer:getNavigateButtonView()

	navigatetionview:setParam({
		true,
		true,
		false
	})
	PeaceUluRpc.instance:sendAct145ClearGameRecordRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu)
end

function PeaceUluResultView:_killTween()
	return
end

function PeaceUluResultView:refreshUI()
	local result = PeaceUluModel.instance:getGameRes()
	local isSucess

	if result == PeaceUluEnum.GameResult.Win then
		isSucess = true

		PeaceUluController.instance:dispatchEvent(PeaceUluEvent.playVoice, PeaceUluEnum.VoiceType.Win)
		AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_win)
	elseif result == PeaceUluEnum.GameResult.Fail then
		isSucess = false

		PeaceUluController.instance:dispatchEvent(PeaceUluEvent.playVoice, PeaceUluEnum.VoiceType.Fail)
		AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.ui_settleaccounts_lose)
	end

	self._txttips.text = isSucess and luaLang("p_v1a5_peaceulu_resultview_txt_tips1") or luaLang("p_v1a5_peaceulu_resultview_txt_tips2")

	gohelper.setActive(self._gosuccess, isSucess)
	gohelper.setActive(self._gofail, not isSucess)

	local num = PeaceUluConfig.instance:getGameTimes()
	local haveTimes = PeaceUluModel.instance:getGameHaveTimes()

	self._cannotPlay = haveTimes == 0
	self._txtnum.text = string.format("<color=#DB8542>%s</color>", haveTimes) .. "/" .. num

	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onOpenResultView)
end

function PeaceUluResultView:onClose()
	return
end

function PeaceUluResultView:onDestroyView()
	return
end

return PeaceUluResultView
