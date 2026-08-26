-- chunkname: @modules/logic/partygame/view/coingrabbinggame/CoinGrabbingGameViewContainer.lua

module("modules.logic.partygame.view.coingrabbinggame.CoinGrabbingGameViewContainer", package.seeall)

local CoinGrabbingGameViewContainer = class("CoinGrabbingGameViewContainer", SceneGameCommonViewContainer)

function CoinGrabbingGameViewContainer:getGameView()
	local views = {}

	table.insert(views, CoinGrabbingGameView.New())

	return views
end

return CoinGrabbingGameViewContainer
