-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin1ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin1ViewPresentor", package.seeall)

local ExteriorSkin1ViewPresentor = class("ExteriorSkin1ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin1ViewPresentor:ctor()
	ExteriorSkin1ViewPresentor.super.ctor(self)
end

function ExteriorSkin1ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin1ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_1.prefab"
	}
end

function ExteriorSkin1ViewPresentor:buildViews()
	return {
		ExteriorSkin1View.New()
	}
end

function ExteriorSkin1ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin1ViewPresentor
