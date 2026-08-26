-- chunkname: @modules/logic/versionactivity1_5/sportsnews/view/SportsNewsTipsContainer.lua

module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsTipsContainer", package.seeall)

local SportsNewsTipsContainer = class("SportsNewsTipsContainer", BaseViewContainer)

function SportsNewsTipsContainer:buildViews()
	local views = {}

	table.insert(views, SportsNewsTips.New())

	return views
end

return SportsNewsTipsContainer
