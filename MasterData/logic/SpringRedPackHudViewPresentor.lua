-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/springredpack/view/SpringRedPackHudViewPresentor.lua

module("logic.extensions.springredpack.view.SpringRedPackHudViewPresentor", package.seeall)

local SpringRedPackHudViewPresentor = class("SpringRedPackHudViewPresentor", ViewPresentor)

function SpringRedPackHudViewPresentor:ctor()
	SpringRedPackHudViewPresentor.super.ctor(self)
end

function SpringRedPackHudViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SpringRedPackHudViewPresentor:dependWhatResources()
	return {
		"ui/views/springredpack/springredpackhudview.prefab"
	}
end

function SpringRedPackHudViewPresentor:buildViews()
	return {
		SpringRedPackHudView.New()
	}
end

return SpringRedPackHudViewPresentor
