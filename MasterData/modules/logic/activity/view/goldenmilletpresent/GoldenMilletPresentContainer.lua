-- chunkname: @modules/logic/activity/view/goldenmilletpresent/GoldenMilletPresentContainer.lua

module("modules.logic.activity.view.goldenmilletpresent.GoldenMilletPresentContainer", package.seeall)

local GoldenMilletPresentContainer = class("GoldenMilletPresentContainer", GoldenMilletPresentImplContainer)

function GoldenMilletPresentContainer:buildViews()
	local views = {}

	table.insert(views, GoldenMilletPresent.New())

	return views
end

return GoldenMilletPresentContainer
