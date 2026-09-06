-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin20ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin20ViewPresentor", package.seeall)

local ExteriorSkin20ViewPresentor = class("ExteriorSkin20ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin20ViewPresentor:ctor()
	ExteriorSkin20ViewPresentor.super.ctor(self)
end

function ExteriorSkin20ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin20ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_20.prefab"
	}
end

function ExteriorSkin20ViewPresentor:buildViews()
	return {
		ExteriorSkin20View.New()
	}
end

function ExteriorSkin20ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin20ViewPresentor
