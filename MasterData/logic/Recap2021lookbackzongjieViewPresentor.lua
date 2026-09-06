-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021lookbackzongjieViewPresentor.lua

module("logic.extensions.recap2021.view.Recap2021lookbackzongjieViewPresentor", package.seeall)

local Recap2021lookbackzongjieViewPresentor = class("Recap2021lookbackzongjieViewPresentor", ViewPresentor)

function Recap2021lookbackzongjieViewPresentor:ctor()
	Recap2021lookbackzongjieViewPresentor.super.ctor(self)
end

function Recap2021lookbackzongjieViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Recap2021lookbackzongjieViewPresentor:dependWhatResources()
	return {
		"ui/views/recap2021/recap2021lookbackzongjieview.prefab"
	}
end

function Recap2021lookbackzongjieViewPresentor:buildViews()
	return {
		Recap2021lookbackzongjieView.New()
	}
end

function Recap2021lookbackzongjieViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return Recap2021lookbackzongjieViewPresentor
