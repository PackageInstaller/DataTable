-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin6ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin6ViewPresentor", package.seeall)

local ExteriorSkin6ViewPresentor = class("ExteriorSkin6ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin6ViewPresentor:ctor()
	ExteriorSkin6ViewPresentor.super.ctor(self)
end

function ExteriorSkin6ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin6ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_6.prefab"
	}
end

function ExteriorSkin6ViewPresentor:buildViews()
	return {
		ExteriorSkin6View.New()
	}
end

function ExteriorSkin6ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin6ViewPresentor
