-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin23ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin23ViewPresentor", package.seeall)

local ExteriorSkin23ViewPresentor = class("ExteriorSkin23ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin23ViewPresentor:ctor()
	ExteriorSkin23ViewPresentor.super.ctor(self)
end

function ExteriorSkin23ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin23ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_23.prefab"
	}
end

function ExteriorSkin23ViewPresentor:buildViews()
	return {
		ExteriorSkin23View.New()
	}
end

function ExteriorSkin23ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin23ViewPresentor
