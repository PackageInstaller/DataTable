-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/ExteriorViewPresentor.lua

module("logic.extensions.roleinfo.view.ExteriorViewPresentor", package.seeall)

local ExteriorViewPresentor = class("ExteriorViewPresentor", ViewPresentor)

function ExteriorViewPresentor:ctor()
	ExteriorViewPresentor.super.ctor(self)
end

function ExteriorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorview.prefab"
	}
end

function ExteriorViewPresentor:buildViews()
	return {
		ExteriorView.New()
	}
end

return ExteriorViewPresentor
