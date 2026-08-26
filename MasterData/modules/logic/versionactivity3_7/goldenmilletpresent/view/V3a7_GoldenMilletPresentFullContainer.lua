-- chunkname: @modules/logic/versionactivity3_7/goldenmilletpresent/view/V3a7_GoldenMilletPresentFullContainer.lua

module("modules.logic.versionactivity3_7.goldenmilletpresent.view.V3a7_GoldenMilletPresentFullContainer", package.seeall)

local V3a7_GoldenMilletPresentFullContainer = class("V3a7_GoldenMilletPresentFullContainer", V3a7_GoldenMilletPresentImplContainer)

function V3a7_GoldenMilletPresentFullContainer:buildViews()
	local views = {}

	table.insert(views, V3a7_GoldenMilletPresentFull.New())

	return views
end

return V3a7_GoldenMilletPresentFullContainer
