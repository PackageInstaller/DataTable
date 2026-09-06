-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021presonlookbackViewPresentor.lua

module("logic.extensions.recap2021.view.Recap2021presonlookbackViewPresentor", package.seeall)

local Recap2021presonlookbackViewPresentor = class("Recap2021presonlookbackViewPresentor", ViewPresentor)

function Recap2021presonlookbackViewPresentor:ctor()
	Recap2021presonlookbackViewPresentor.super.ctor(self)
end

function Recap2021presonlookbackViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Recap2021presonlookbackViewPresentor:dependWhatResources()
	return {
		"ui/views/recap2021/recap2021presonlookbackview.prefab"
	}
end

function Recap2021presonlookbackViewPresentor:buildViews()
	return {
		Recap2021presonlookbackView.New()
	}
end

return Recap2021presonlookbackViewPresentor
