-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021lookbackyijieViewPresentor.lua

module("logic.extensions.recap2021.view.Recap2021lookbackyijieViewPresentor", package.seeall)

local Recap2021lookbackyijieViewPresentor = class("Recap2021lookbackyijieViewPresentor", ViewPresentor)

function Recap2021lookbackyijieViewPresentor:ctor()
	Recap2021lookbackyijieViewPresentor.super.ctor(self)
end

function Recap2021lookbackyijieViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Recap2021lookbackyijieViewPresentor:dependWhatResources()
	return {
		"ui/views/recap2021/recap2021lookbackyijieview.prefab"
	}
end

function Recap2021lookbackyijieViewPresentor:buildViews()
	return {
		Recap2021lookbackyijieView.New()
	}
end

return Recap2021lookbackyijieViewPresentor
