-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin17ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin17ViewPresentor", package.seeall)

local ExteriorOtherSkin17ViewPresentor = class("ExteriorOtherSkin17ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin17ViewPresentor:ctor()
	ExteriorOtherSkin17ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin17ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin17ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_17.prefab"
	}
end

function ExteriorOtherSkin17ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin17View.New()
	}
end

function ExteriorOtherSkin17ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin17ViewPresentor
