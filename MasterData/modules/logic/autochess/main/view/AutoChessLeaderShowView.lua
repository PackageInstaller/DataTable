-- chunkname: @modules/logic/autochess/main/view/AutoChessLeaderShowView.lua

module("modules.logic.autochess.main.view.AutoChessLeaderShowView", package.seeall)

local AutoChessLeaderShowView = class("AutoChessLeaderShowView", BaseView)

function AutoChessLeaderShowView:onInitView()
	self._goCard = gohelper.findChild(self.viewGO, "#go_Card")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessLeaderShowView:onClickModalMask()
	self:closeThis()
end

function AutoChessLeaderShowView:onOpen()
	if self.viewParam then
		local go = self:getResInst(AutoChessStrEnum.ResPath.LeaderCard, self._goCard)
		local leaderCard = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessLeaderCard)

		leaderCard:setData(self.viewParam)
	end
end

return AutoChessLeaderShowView
