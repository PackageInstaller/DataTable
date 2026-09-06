-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin10ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin10ViewPresentor", package.seeall)

local ExteriorSkin10ViewPresentor = class("ExteriorSkin10ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin10ViewPresentor:ctor()
	ExteriorSkin10ViewPresentor.super.ctor(self)
end

function ExteriorSkin10ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin10ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_10.prefab"
	}
end

function ExteriorSkin10ViewPresentor:buildViews()
	return {
		ExteriorSkin10View.New()
	}
end

function ExteriorSkin10ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin10ViewPresentor
