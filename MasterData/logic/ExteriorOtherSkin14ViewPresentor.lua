-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorOtherSkin14ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorOtherSkin14ViewPresentor", package.seeall)

local ExteriorOtherSkin14ViewPresentor = class("ExteriorOtherSkin14ViewPresentor", ViewWithGuidePresentor)

function ExteriorOtherSkin14ViewPresentor:ctor()
	ExteriorOtherSkin14ViewPresentor.super.ctor(self)
end

function ExteriorOtherSkin14ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorOtherSkin14ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorotherskin_14.prefab"
	}
end

function ExteriorOtherSkin14ViewPresentor:buildViews()
	return {
		ExteriorOtherSkin14View.New()
	}
end

function ExteriorOtherSkin14ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorOtherSkin14ViewPresentor
