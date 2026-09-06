-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin7ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin7ViewPresentor", package.seeall)

local ExteriorSkin7ViewPresentor = class("ExteriorSkin7ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin7ViewPresentor:ctor()
	ExteriorSkin7ViewPresentor.super.ctor(self)
end

function ExteriorSkin7ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin7ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_7.prefab"
	}
end

function ExteriorSkin7ViewPresentor:buildViews()
	return {
		ExteriorSkin7View.New()
	}
end

function ExteriorSkin7ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin7ViewPresentor
