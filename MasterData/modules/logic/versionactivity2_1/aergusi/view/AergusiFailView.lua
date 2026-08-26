-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiFailView.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiFailView", package.seeall)

local AergusiFailView = class("AergusiFailView", BaseView)

function AergusiFailView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._txtclassnum = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classnum")
	self._txtclassname = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classname")
	self._btnquitgame = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_quitgame")
	self._btnrestart = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_restart")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AergusiFailView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnquitgame:AddClickListener(self._btnquitgameOnClick, self)
	self._btnrestart:AddClickListener(self._btnrestartOnClick, self)
end

function AergusiFailView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnquitgame:RemoveClickListener()
	self._btnrestart:RemoveClickListener()
end

function AergusiFailView:_btncloseOnClick()
	return
end

function AergusiFailView:_btnquitgameOnClick()
	self:closeThis()
	ViewMgr.instance:closeView(ViewName.AergusiDialogView)
end

function AergusiFailView:_btnrestartOnClick()
	self:closeThis()
	ViewMgr.instance:closeView(ViewName.AergusiDialogView)
	AergusiController.instance:dispatchEvent(AergusiEvent.RestartEvidence)
end

function AergusiFailView:_editableInitView()
	return
end

function AergusiFailView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
	self:refreshTips()
end

function AergusiFailView:refreshTips()
	local episodeCo = AergusiConfig.instance:getEpisodeConfig(nil, self.viewParam.episodeId)
	local index = AergusiModel.instance:getEpisodeIndex(self.viewParam.episodeId)

	self._txtclassnum.text = string.format("STAGE %02d", index)
	self._txtclassname.text = episodeCo.name
end

function AergusiFailView:onClose()
	return
end

function AergusiFailView:onDestroyView()
	TaskDispatcher.cancelTask(self._realRestart, self)
end

return AergusiFailView
