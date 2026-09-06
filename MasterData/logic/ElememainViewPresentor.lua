-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eleme/view/ElememainViewPresentor.lua

module("logic.extensions.eleme.view.ElememainViewPresentor", package.seeall)

local ElememainViewPresentor = class("ElememainViewPresentor", ViewPresentor)

function ElememainViewPresentor:ctor()
	ElememainViewPresentor.super.ctor(self)
end

function ElememainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElememainViewPresentor:dependWhatResources()
	return {
		"ui/views/eleme/elememainview.prefab"
	}
end

function ElememainViewPresentor:buildViews()
	return {
		ElememainView.New()
	}
end

return ElememainViewPresentor
