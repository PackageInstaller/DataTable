-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickapet/view/PickStartViewPresentor.lua

module("logic.extensions.pickapet.view.PickStartViewPresentor", package.seeall)

local PickStartViewPresentor = class("PickStartViewPresentor", ViewPresentor)

function PickStartViewPresentor:ctor()
	PickStartViewPresentor.super.ctor(self)
end

function PickStartViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PickStartViewPresentor:dependWhatResources()
	return {
		"ui/views/pickapet/pickstartview.prefab"
	}
end

function PickStartViewPresentor:buildViews()
	local views = {}
	local view = PickStartView.New()

	table.insert(views, view)

	return views
end

function PickStartViewPresentor:onClickOutside()
	UIStateManager.instance:pop()
end

return PickStartViewPresentor
