-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/view/WaitingViewPresentor.lua

module("logic.extensions.loading.view.WaitingViewPresentor", package.seeall)

local WaitingViewPresentor = class("WaitingViewPresentor", ViewPresentor)

function WaitingViewPresentor:dependWhatResources()
	return {
		ResName.Loading_wait_view
	}
end

function WaitingViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function WaitingViewPresentor:buildViews()
	local views = {}

	table.insert(views, WaitingView.New())

	return views
end

return WaitingViewPresentor
