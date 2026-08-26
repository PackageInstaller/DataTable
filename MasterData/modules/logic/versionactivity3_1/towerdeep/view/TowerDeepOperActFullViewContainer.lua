-- chunkname: @modules/logic/versionactivity3_1/towerdeep/view/TowerDeepOperActFullViewContainer.lua

module("modules.logic.versionactivity3_1.towerdeep.view.TowerDeepOperActFullViewContainer", package.seeall)

local TowerDeepOperActFullViewContainer = class("TowerDeepOperActFullViewContainer", BaseViewContainer)

function TowerDeepOperActFullViewContainer:buildViews()
	local views = {}

	table.insert(views, TowerDeepOperActFullView.New())

	return views
end

return TowerDeepOperActFullViewContainer
