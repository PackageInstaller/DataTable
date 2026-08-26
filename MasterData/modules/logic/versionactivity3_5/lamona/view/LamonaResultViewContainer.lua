-- chunkname: @modules/logic/versionactivity3_5/lamona/view/LamonaResultViewContainer.lua

module("modules.logic.versionactivity3_5.lamona.view.LamonaResultViewContainer", package.seeall)

local LamonaResultViewContainer = class("LamonaResultViewContainer", BaseViewContainer)

function LamonaResultViewContainer:buildViews()
	local views = {}

	table.insert(views, LamonaResultView.New())

	return views
end

return LamonaResultViewContainer
