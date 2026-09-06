-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin21ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin21ViewPresentor", package.seeall)

local ExteriorOtherSkin21ViewPresentor = class("ExteriorOtherSkin21ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin21ViewPresentor:ctor()
	ExteriorOtherSkin21ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin21ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin21ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_21.prefab"
	}
end

function ExteriorOtherSkin21ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin21View.New()
	}
end

function ExteriorOtherSkin21ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin21ViewPresentor
