-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin3ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin3ViewPresentor", package.seeall)

local ExteriorOtherSkin3ViewPresentor = class("ExteriorOtherSkin3ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin3ViewPresentor:ctor()
	ExteriorOtherSkin3ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin3ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin3ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_3.prefab"
	}
end

function ExteriorOtherSkin3ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin3View.New()
	}
end

function ExteriorOtherSkin3ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin3ViewPresentor
