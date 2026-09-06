-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/Monthcard2024ViewPresentor.lua

module("logic.extensions.monthcard.view.Monthcard2024ViewPresentor", package.seeall)

local Monthcard2024ViewPresentor = class("Monthcard2024ViewPresentor", ViewPresentor)

function Monthcard2024ViewPresentor:ctor()
	Monthcard2024ViewPresentor.super.ctor(self)
end

function Monthcard2024ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Monthcard2024ViewPresentor:dependWhatResources()
	return {
		"ui/views/monthcard/monthcard2024view.prefab"
	}
end

function Monthcard2024ViewPresentor:buildViews()
	return {
		Monthcard2024View.New()
	}
end

function Monthcard2024ViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return Monthcard2024ViewPresentor
