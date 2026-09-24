-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/view/game/SpLilyaGameTipViewContainer.lua

module("modules.logic.versionactivity4_0.sp_lilya.view.game.SpLilyaGameTipViewContainer", package.seeall)

local SpLilyaGameTipViewContainer = class("SpLilyaGameTipViewContainer", BaseViewContainer)

function SpLilyaGameTipViewContainer:buildViews()
	local views = {}

	table.insert(views, SpLilyaGameTipView.New())

	return views
end

return SpLilyaGameTipViewContainer
