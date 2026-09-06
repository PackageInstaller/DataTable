-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/Resmonthcard2024ViewPresentor.lua

module("logic.extensions.monthcard.view.Resmonthcard2024ViewPresentor", package.seeall)

local Resmonthcard2024ViewPresentor = class("Resmonthcard2024ViewPresentor", ViewPresentor)

function Resmonthcard2024ViewPresentor:ctor()
	Resmonthcard2024ViewPresentor.super.ctor(self)
end

function Resmonthcard2024ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Resmonthcard2024ViewPresentor:dependWhatResources()
	return {
		"ui/views/monthcard/resmonthcard2024view.prefab"
	}
end

function Resmonthcard2024ViewPresentor:buildViews()
	return {
		Resmonthcard2024View.New()
	}
end

function Resmonthcard2024ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return Resmonthcard2024ViewPresentor
