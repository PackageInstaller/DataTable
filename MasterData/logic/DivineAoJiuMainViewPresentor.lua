-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/view/DivineAoJiuMainViewPresentor.lua

module("logic.extensions.divineaojiu.view.DivineAoJiuMainViewPresentor", package.seeall)

local DivineAoJiuMainViewPresentor = class("DivineAoJiuMainViewPresentor", ViewPresentor)

function DivineAoJiuMainViewPresentor:ctor()
	DivineAoJiuMainViewPresentor.super.ctor(self)
end

function DivineAoJiuMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineAoJiuMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divineaojiu/divineaojiumainview.prefab"
	}
end

function DivineAoJiuMainViewPresentor:buildViews()
	return {
		DivineAoJiuMainView.New()
	}
end

return DivineAoJiuMainViewPresentor
