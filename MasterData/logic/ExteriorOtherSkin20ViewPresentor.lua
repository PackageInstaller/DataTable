-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin20ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin20ViewPresentor", package.seeall)

local ExteriorOtherSkin20ViewPresentor = class("ExteriorOtherSkin20ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin20ViewPresentor:ctor()
	ExteriorOtherSkin20ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin20ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin20ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_20.prefab"
	}
end

function ExteriorOtherSkin20ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin20View.New()
	}
end

function ExteriorOtherSkin20ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin20ViewPresentor
