-- chunkname: @modules/logic/sp01/act208/view/V2a9_Act208MainViewContainer.lua

module("modules.logic.sp01.act208.view.V2a9_Act208MainViewContainer", package.seeall)

local V2a9_Act208MainViewContainer = class("V2a9_Act208MainViewContainer", BaseViewContainer)

function V2a9_Act208MainViewContainer:buildViews()
	local views = {}

	table.insert(views, V2a9_Act208MainView.New())

	return views
end

return V2a9_Act208MainViewContainer
