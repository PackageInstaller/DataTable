-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtree/view/IntothecarViewPresentor.lua

module("logic.extensions.wishtree.view.IntothecarViewPresentor", package.seeall)

local IntothecarViewPresentor = class("IntothecarViewPresentor", ViewPresentor)

function IntothecarViewPresentor:ctor()
	IntothecarViewPresentor.super.ctor(self)
end

function IntothecarViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IntothecarViewPresentor:dependWhatResources()
	return {
		"ui/views/wishtree/intothecarview.prefab"
	}
end

function IntothecarViewPresentor:buildViews()
	return {
		InToTheCarView.New()
	}
end

return IntothecarViewPresentor
