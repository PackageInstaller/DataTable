-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoocancelfollowPresentor.lua

module("logic.extensions.zoo.view.ZoocancelfollowPresentor", package.seeall)

local ZoocancelfollowPresentor = class("ZoocancelfollowPresentor", ViewPresentor)

function ZoocancelfollowPresentor:ctor()
	ZoocancelfollowPresentor.super.ctor(self)
end

function ZoocancelfollowPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ZoocancelfollowPresentor:dependWhatResources()
	return {
		"ui/views/zoo/zoocancelfollowview.prefab"
	}
end

function ZoocancelfollowPresentor:buildViews()
	return {
		ZoocancelfollowView.New()
	}
end

return ZoocancelfollowPresentor
