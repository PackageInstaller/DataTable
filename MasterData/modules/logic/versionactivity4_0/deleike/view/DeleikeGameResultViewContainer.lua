-- chunkname: @modules/logic/versionactivity4_0/deleike/view/DeleikeGameResultViewContainer.lua

module("modules.logic.versionactivity4_0.deleike.view.DeleikeGameResultViewContainer", package.seeall)

local DeleikeGameResultViewContainer = class("DeleikeGameResultViewContainer", BaseViewContainer)

function DeleikeGameResultViewContainer:buildViews()
	local views = {}

	table.insert(views, DeleikeGameResultView.New())

	return views
end

return DeleikeGameResultViewContainer
