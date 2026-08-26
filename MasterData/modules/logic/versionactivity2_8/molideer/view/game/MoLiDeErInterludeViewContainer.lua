-- chunkname: @modules/logic/versionactivity2_8/molideer/view/game/MoLiDeErInterludeViewContainer.lua

module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErInterludeViewContainer", package.seeall)

local MoLiDeErInterludeViewContainer = class("MoLiDeErInterludeViewContainer", BaseViewContainer)

function MoLiDeErInterludeViewContainer:buildViews()
	local views = {}

	table.insert(views, MoLiDeErInterludeView.New())

	return views
end

return MoLiDeErInterludeViewContainer
