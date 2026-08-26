-- chunkname: @modules/logic/versionactivity2_8/molideer/view/game/MoLiDeErResultViewContainer.lua

module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErResultViewContainer", package.seeall)

local MoLiDeErResultViewContainer = class("MoLiDeErResultViewContainer", BaseViewContainer)

function MoLiDeErResultViewContainer:buildViews()
	local views = {}

	table.insert(views, MoLiDeErResultView.New())

	return views
end

return MoLiDeErResultViewContainer
