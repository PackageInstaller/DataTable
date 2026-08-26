-- chunkname: @modules/logic/autochess/main/view/AutoChessLeaderNextView.lua

module("modules.logic.autochess.main.view.AutoChessLeaderNextView", package.seeall)

local AutoChessLeaderNextView = class("AutoChessLeaderNextView", BaseView)

function AutoChessLeaderNextView:onInitView()
	self._goLeaderRoot = gohelper.findChild(self.viewGO, "#go_LeaderRoot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessLeaderNextView:onClickModalMask()
	return
end

function AutoChessLeaderNextView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_qishou_confirm)

	if self.viewParam and self.viewParam.leaderId then
		local itemGo = self:getResInst(AutoChessStrEnum.ResPath.LeaderItem, self._goLeaderRoot)
		local leaderItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, AutoChessLeaderItem)

		leaderItem:setData(self.viewParam.leaderId)
		leaderItem:setActiveChesk(false)
		TaskDispatcher.runDelay(self.closeThis, self, 2)
	end
end

function AutoChessLeaderNextView:onClose()
	if not self.viewParam.actId then
		local actId = Activity182Model.instance:getCurActId()

		AutoChessRpc.instance:sendAutoChessEnterSceneRequest(self.viewParam.actId, self.viewParam.moduleId, self.viewParam.episodeId, self.viewParam.leaderId, true)
	end
end

return AutoChessLeaderNextView
