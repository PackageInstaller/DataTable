-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin24ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin24ViewPresentor", package.seeall)

local ExteriorOtherSkin24ViewPresentor = class("ExteriorOtherSkin24ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin24ViewPresentor:ctor()
	ExteriorOtherSkin24ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin24ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin24ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_24.prefab"
	}
end

function ExteriorOtherSkin24ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin24View.New()
	}
end

function ExteriorOtherSkin24ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin24ViewPresentor
