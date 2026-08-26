-- chunkname: @modules/logic/activity/view/goldenmilletpresent/GoldenMilletPresentFullContainer.lua

module("modules.logic.activity.view.goldenmilletpresent.GoldenMilletPresentFullContainer", package.seeall)

local GoldenMilletPresentFullContainer = class("GoldenMilletPresentFullContainer", GoldenMilletPresentImplContainer)

function GoldenMilletPresentFullContainer:buildViews()
	local views = {}

	table.insert(views, GoldenMilletPresentFull.New())

	return views
end

return GoldenMilletPresentFullContainer
