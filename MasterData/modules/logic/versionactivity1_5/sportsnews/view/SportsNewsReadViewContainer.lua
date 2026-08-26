-- chunkname: @modules/logic/versionactivity1_5/sportsnews/view/SportsNewsReadViewContainer.lua

module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsReadViewContainer", package.seeall)

local SportsNewsReadViewContainer = class("SportsNewsReadViewContainer", BaseViewContainer)

function SportsNewsReadViewContainer:buildViews()
	local views = {}

	table.insert(views, SportsNewsReadView.New())

	return views
end

return SportsNewsReadViewContainer
