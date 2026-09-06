-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/view/Lightgame2ViewPresentor.lua

module("logic.extensions.duolalight.view.Lightgame2ViewPresentor", package.seeall)

local Lightgame2ViewPresentor = class("Lightgame2ViewPresentor", ViewPresentor)

function Lightgame2ViewPresentor:ctor()
	Lightgame2ViewPresentor.super.ctor(self)
end

function Lightgame2ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Lightgame2ViewPresentor:dependWhatResources()
	return {
		"ui/views/duolalight/lightgame2view.prefab"
	}
end

function Lightgame2ViewPresentor:buildViews()
	return {
		Lightgame2View.New()
	}
end

return Lightgame2ViewPresentor
