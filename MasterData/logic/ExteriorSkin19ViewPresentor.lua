-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/exteriorskin/ExteriorSkin19ViewPresentor.lua

module("logic.extensions.roleinfo.view.exteriorskin.ExteriorSkin19ViewPresentor", package.seeall)

local ExteriorSkin19ViewPresentor = class("ExteriorSkin19ViewPresentor", ViewWithGuidePresentor)

function ExteriorSkin19ViewPresentor:ctor()
	ExteriorSkin19ViewPresentor.super.ctor(self)
end

function ExteriorSkin19ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ExteriorSkin19ViewPresentor:dependWhatResources()
	return {
		"ui/views/roleinfo/exteriorskin/exteriorskin_19.prefab"
	}
end

function ExteriorSkin19ViewPresentor:buildViews()
	return {
		ExteriorSkin19View.New()
	}
end

function ExteriorSkin19ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return ExteriorSkin19ViewPresentor
