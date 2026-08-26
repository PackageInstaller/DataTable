-- chunkname: @modules/logic/activitywelfare/subview/NewWelfareViewContainer.lua

module("modules.logic.activitywelfare.subview.NewWelfareViewContainer", package.seeall)

local NewWelfareViewContainer = class("NewWelfareViewContainer", BaseViewContainer)

function NewWelfareViewContainer:buildViews()
	local views = {}

	table.insert(views, NewWelfareView.New())

	return views
end

return NewWelfareViewContainer
