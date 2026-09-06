-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin6ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin6ViewPresentor", package.seeall)

local ExteriorOtherSkin6ViewPresentor = class("ExteriorOtherSkin6ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin6ViewPresentor:ctor()
	ExteriorOtherSkin6ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin6ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin6ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_6.prefab"
	}
end

function ExteriorOtherSkin6ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin6View.New()
	}
end

function ExteriorOtherSkin6ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin6ViewPresentor
