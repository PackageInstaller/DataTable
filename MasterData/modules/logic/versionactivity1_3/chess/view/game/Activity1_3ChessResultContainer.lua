-- chunkname: @modules/logic/versionactivity1_3/chess/view/game/Activity1_3ChessResultContainer.lua

module("modules.logic.versionactivity1_3.chess.view.game.Activity1_3ChessResultContainer", package.seeall)

local Activity1_3ChessResultContainer = class("Activity1_3ChessResultContainer", BaseViewContainer)

function Activity1_3ChessResultContainer:buildViews()
	local views = {}

	self._resultview = Activity1_3ChessResultView.New()
	views[#views + 1] = self._resultview

	return views
end

function Activity1_3ChessResultContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return Activity1_3ChessResultContainer
