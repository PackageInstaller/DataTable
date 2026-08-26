-- chunkname: @modules/logic/versionactivity2_8/molideer/view/game/MoLiDeErEventViewContainer.lua

module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErEventViewContainer", package.seeall)

local MoLiDeErEventViewContainer = class("MoLiDeErEventViewContainer", BaseViewContainer)

function MoLiDeErEventViewContainer:buildViews()
	local views = {}

	table.insert(views, MoLiDeErEventView.New())

	return views
end

return MoLiDeErEventViewContainer
