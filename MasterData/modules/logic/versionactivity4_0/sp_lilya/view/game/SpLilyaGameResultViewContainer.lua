-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/view/game/SpLilyaGameResultViewContainer.lua

module("modules.logic.versionactivity4_0.sp_lilya.view.game.SpLilyaGameResultViewContainer", package.seeall)

local SpLilyaGameResultViewContainer = class("SpLilyaGameResultViewContainer", BaseViewContainer)

function SpLilyaGameResultViewContainer:buildViews()
	local views = {}

	table.insert(views, SpLilyaGameResultView.New())

	return views
end

function SpLilyaGameResultViewContainer:getView()
	return self.views[1]
end

return SpLilyaGameResultViewContainer
