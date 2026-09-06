-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/ShenJiSelectViewPresentor.lua

module("logic.extensions.shenjichallenge.view.ShenJiSelectViewPresentor", package.seeall)

local ShenJiSelectViewPresentor = class("ShenJiSelectViewPresentor", ViewPresentor)

function ShenJiSelectViewPresentor:ctor()
	ShenJiSelectViewPresentor.super.ctor(self)
end

function ShenJiSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShenJiSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/shenjichallenge/shenjiselectview.prefab"
	}
end

function ShenJiSelectViewPresentor:buildViews()
	return {
		ShenJiSelectView.New()
	}
end

return ShenJiSelectViewPresentor
