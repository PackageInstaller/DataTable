-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pickapet/view/PickResultViewPresentor.lua

module("logic.extensions.pickapet.view.PickResultViewPresentor", package.seeall)

local PickResultViewPresentor = class("PickResultViewPresentor", ViewPresentor)

function PickResultViewPresentor:ctor()
	PickResultViewPresentor.super.ctor(self)
end

function PickResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function PickResultViewPresentor:dependWhatResources()
	return {
		"ui/views/pickapet/pickresultview.prefab"
	}
end

function PickResultViewPresentor:buildViews()
	local views = {}
	local view = PickResultView.New()

	table.insert(views, view)

	return views
end

return PickResultViewPresentor
