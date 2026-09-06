-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/springredpack/view/SpringRedPackSelectViewPresentor.lua

module("logic.extensions.springredpack.view.SpringRedPackSelectViewPresentor", package.seeall)

local SpringRedPackSelectViewPresentor = class("SpringRedPackSelectViewPresentor", ViewPresentor)

function SpringRedPackSelectViewPresentor:ctor()
	SpringRedPackSelectViewPresentor.super.ctor(self)
end

function SpringRedPackSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SpringRedPackSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/springredpack/springredpackselectview.prefab"
	}
end

function SpringRedPackSelectViewPresentor:buildViews()
	return {
		SpringRedPackSelectView.New()
	}
end

return SpringRedPackSelectViewPresentor
