-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin22ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin22ViewPresentor", package.seeall)

local ExteriorOtherSkin22ViewPresentor = class("ExteriorOtherSkin22ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin22ViewPresentor:ctor()
	ExteriorOtherSkin22ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin22ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin22ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_22.prefab"
	}
end

function ExteriorOtherSkin22ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin22View.New()
	}
end

function ExteriorOtherSkin22ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin22ViewPresentor
