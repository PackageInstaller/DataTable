-- chunkname: @modules/logic/versionactivity3_1/survivaloperact/view/SurvivalOperActFullViewContainer.lua

module("modules.logic.versionactivity3_1.survivaloperact.view.SurvivalOperActFullViewContainer", package.seeall)

local SurvivalOperActFullViewContainer = class("SurvivalOperActFullViewContainer", BaseViewContainer)

function SurvivalOperActFullViewContainer:buildViews()
	local views = {}

	table.insert(views, SurvivalOperActFullView.New())

	return views
end

return SurvivalOperActFullViewContainer
