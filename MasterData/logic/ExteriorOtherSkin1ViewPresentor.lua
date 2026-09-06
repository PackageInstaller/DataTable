-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin1ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin1ViewPresentor", package.seeall)

local ExteriorOtherSkin1ViewPresentor = class("ExteriorOtherSkin1ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin1ViewPresentor:ctor()
	ExteriorOtherSkin1ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin1ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin1ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_1.prefab"
	}
end

function ExteriorOtherSkin1ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin1View.New()
	}
end

function ExteriorOtherSkin1ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin1ViewPresentor
