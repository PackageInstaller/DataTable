-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021mainViewPresentor.lua

module("logic.extensions.recap2021.view.Recap2021mainViewPresentor", package.seeall)

local Recap2021mainViewPresentor = class("Recap2021mainViewPresentor", ViewPresentor)

function Recap2021mainViewPresentor:ctor()
	Recap2021mainViewPresentor.super.ctor(self)
end

function Recap2021mainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Recap2021mainViewPresentor:dependWhatResources()
	return {
		"ui/views/recap2021/recap2021mainview.prefab"
	}
end

function Recap2021mainViewPresentor:buildViews()
	return {
		Recap2021mainView.New()
	}
end

return Recap2021mainViewPresentor
