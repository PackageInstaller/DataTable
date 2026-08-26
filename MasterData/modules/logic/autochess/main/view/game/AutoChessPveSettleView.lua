-- chunkname: @modules/logic/autochess/main/view/game/AutoChessPveSettleView.lua

module("modules.logic.autochess.main.view.game.AutoChessPveSettleView", package.seeall)

local AutoChessPveSettleView = class("AutoChessPveSettleView", BaseView)

function AutoChessPveSettleView:onInitView()
	self._goSuccess = gohelper.findChild(self.viewGO, "#go_Success")
	self._goFail = gohelper.findChild(self.viewGO, "#go_Fail")
	self._btnRestart = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_Restart")
	self._btnExit = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_Exit")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessPveSettleView:addEvents()
	self._btnRestart:AddClickListener(self._btnRestartOnClick, self)
	self._btnExit:AddClickListener(self._btnExitOnClick, self)
end

function AutoChessPveSettleView:removeEvents()
	self._btnRestart:RemoveClickListener()
	self._btnExit:RemoveClickListener()
end

function AutoChessPveSettleView:_onEscBtnClick()
	return
end

function AutoChessPveSettleView:_btnRestartOnClick()
	self.restart = true

	self:closeThis()
end

function AutoChessPveSettleView:_btnExitOnClick()
	self:closeThis()
end

function AutoChessPveSettleView:_editableInitView()
	NavigateMgr.instance:addEscape(ViewName.AutoChessPveSettleView, self._onEscBtnClick, self)
end

function AutoChessPveSettleView:onUpdateParam()
	return
end

function AutoChessPveSettleView:onOpen()
	local settleData = AutoChessModel.instance.settleData

	if settleData then
		gohelper.setActive(self._goSuccess, tonumber(settleData.remainingHp) ~= 0)
		gohelper.setActive(self._goFail, tonumber(settleData.remainingHp) == 0)
	end
end

function AutoChessPveSettleView:onClose()
	local episodeId = AutoChessModel.instance.episodeId

	AutoChessController.instance:onSettleViewClose()

	if self.restart then
		local actId = Activity182Model.instance:getCurActId()
		local moduleId = AutoChessEnum.ModuleId.PVE
		local masterId = AutoChessConfig.instance:getEpisodeCO(episodeId).masterId

		AutoChessRpc.instance:sendAutoChessEnterSceneRequest(actId, moduleId, episodeId, masterId)
	end
end

function AutoChessPveSettleView:onDestroyView()
	return
end

return AutoChessPveSettleView
