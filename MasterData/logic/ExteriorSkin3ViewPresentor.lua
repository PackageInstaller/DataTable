-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin3ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin3ViewPresentor", package.seeall)

local ExteriorSkin3ViewPresentor = class("ExteriorSkin3ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin3ViewPresentor:ctor()
	ExteriorSkin3ViewPresentor.super.ctor(self)
end

function ExteriorSkin3ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin3ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_3.prefab"
	}
end

function ExteriorSkin3ViewPresentor:buildViews()
	return {
		ExteriorSkin3View.New()
	}
end

function ExteriorSkin3ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin3ViewPresentor
