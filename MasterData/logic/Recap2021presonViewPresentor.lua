-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021presonViewPresentor.lua

module("logic.extensions.recap2021.view.Recap2021presonViewPresentor", package.seeall)

local Recap2021presonViewPresentor = class("Recap2021presonViewPresentor", ViewPresentor)

function Recap2021presonViewPresentor:ctor()
	Recap2021presonViewPresentor.super.ctor(self)
end

function Recap2021presonViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Recap2021presonViewPresentor:dependWhatResources()
	return {
		"ui/views/recap2021/recap2021presonview.prefab"
	}
end

function Recap2021presonViewPresentor:buildViews()
	return {
		Recap2021presonView.New()
	}
end

return Recap2021presonViewPresentor
