-- chunkname: @modules/logic/matchgame/fight/view/MatchGameFightQuitTipViewContainer.lua

module("modules.logic.matchgame.fight.view.MatchGameFightQuitTipViewContainer", package.seeall)

local MatchGameFightQuitTipViewContainer = class("MatchGameFightQuitTipViewContainer", BaseViewContainer)

function MatchGameFightQuitTipViewContainer:buildViews()
	local views = {}

	table.insert(views, MatchGameFightQuitTipView.New())

	return views
end

return MatchGameFightQuitTipViewContainer
