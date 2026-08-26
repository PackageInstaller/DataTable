-- chunkname: @modules/logic/versionactivity1_5/sportsnews/view/SportsNewsPaperViewContainer.lua

module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsPaperViewContainer", package.seeall)

local SportsNewsPaperViewContainer = class("SportsNewsPaperViewContainer", BaseViewContainer)

function SportsNewsPaperViewContainer:buildViews()
	local views = {}

	table.insert(views, SportsNewsPaperView.New())

	return views
end

return SportsNewsPaperViewContainer
