-- chunkname: @modules/logic/versionactivity1_3/va3chess/view/Va3ChessGameRewardView.lua

module("modules.logic.versionactivity1_3.va3chess.view.Va3ChessGameRewardView", package.seeall)

local Va3ChessGameRewardView = class("Va3ChessGameRewardView", BaseView)

function Va3ChessGameRewardView:onClose()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RewardIsClose)
end

return Va3ChessGameRewardView
