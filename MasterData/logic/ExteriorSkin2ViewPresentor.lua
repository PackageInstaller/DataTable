-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin2ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin2ViewPresentor", package.seeall)

local ExteriorSkin2ViewPresentor = class("ExteriorSkin2ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin2ViewPresentor:ctor()
	ExteriorSkin2ViewPresentor.super.ctor(self)
end

function ExteriorSkin2ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin2ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_2.prefab"
	}
end

function ExteriorSkin2ViewPresentor:buildViews()
	return {
		ExteriorSkin2View.New()
	}
end

function ExteriorSkin2ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin2ViewPresentor
