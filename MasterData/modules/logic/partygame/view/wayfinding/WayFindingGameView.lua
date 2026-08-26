-- chunkname: @modules/logic/partygame/view/wayfinding/WayFindingGameView.lua

module("modules.logic.partygame.view.wayfinding.WayFindingGameView", package.seeall)

local WayFindingGameInterface = PartyGame.Runtime.Games.WayFinding.WayFindingGameInterface
local WayFindingGameView = class("WayFindingGameView", SceneGameCommonView)

function WayFindingGameView:viewUpdate()
	local uid = PartyGameController.instance:getCurPartyGame():getMainPlayerUid()
	local finishTime = WayFindingGameInterface.GetPlayerFinishTime(uid)

	gohelper.setActive(self._gofinish, finishTime > 0)
end

return WayFindingGameView
