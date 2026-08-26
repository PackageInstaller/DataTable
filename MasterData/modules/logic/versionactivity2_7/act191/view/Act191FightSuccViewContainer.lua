-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191FightSuccViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191FightSuccViewContainer", package.seeall)

local Act191FightSuccViewContainer = class("Act191FightSuccViewContainer", BaseViewContainer)

function Act191FightSuccViewContainer:buildViews()
	local views = {}

	table.insert(views, Act191FightSuccView.New())

	return views
end

return Act191FightSuccViewContainer
