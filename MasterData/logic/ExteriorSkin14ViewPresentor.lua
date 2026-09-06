-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin14ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin14ViewPresentor", package.seeall)

local ExteriorSkin14ViewPresentor = class("ExteriorSkin14ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin14ViewPresentor:ctor()
	ExteriorSkin14ViewPresentor.super.ctor(self)
end

function ExteriorSkin14ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin14ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_14.prefab"
	}
end

function ExteriorSkin14ViewPresentor:buildViews()
	return {
		ExteriorSkin14View.New()
	}
end

function ExteriorSkin14ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin14ViewPresentor
