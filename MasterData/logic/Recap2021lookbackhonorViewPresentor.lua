-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021lookbackhonorViewPresentor.lua

module("logic.extensions.recap2021.view.Recap2021lookbackhonorViewPresentor", package.seeall)

local Recap2021lookbackhonorViewPresentor = class("Recap2021lookbackhonorViewPresentor", ViewPresentor)

function Recap2021lookbackhonorViewPresentor:ctor()
	Recap2021lookbackhonorViewPresentor.super.ctor(self)
end

function Recap2021lookbackhonorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Recap2021lookbackhonorViewPresentor:dependWhatResources()
	return {
		"ui/views/recap2021/recap2021lookbackhonorview.prefab"
	}
end

function Recap2021lookbackhonorViewPresentor:buildViews()
	return {
		Recap2021lookbackhonorView.New()
	}
end

function Recap2021lookbackhonorViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return Recap2021lookbackhonorViewPresentor
