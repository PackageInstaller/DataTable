-- chunkname: @modules/logic/versionactivity3_7/goldenmilletpresent/view/V3a7_GoldenMilletPresentContainer.lua

module("modules.logic.versionactivity3_7.goldenmilletpresent.view.V3a7_GoldenMilletPresentContainer", package.seeall)

local V3a7_GoldenMilletPresentContainer = class("V3a7_GoldenMilletPresentContainer", V3a7_GoldenMilletPresentImplContainer)

function V3a7_GoldenMilletPresentContainer:buildViews()
	local views = {}

	table.insert(views, V3a7_GoldenMilletPresent.New())

	return views
end

return V3a7_GoldenMilletPresentContainer
