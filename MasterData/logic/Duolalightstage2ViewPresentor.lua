-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/view/Duolalightstage2ViewPresentor.lua

module("logic.extensions.duolalight.view.Duolalightstage2ViewPresentor", package.seeall)

local Duolalightstage2ViewPresentor = class("Duolalightstage2ViewPresentor", ViewPresentor)

function Duolalightstage2ViewPresentor:ctor()
	Duolalightstage2ViewPresentor.super.ctor(self)
end

function Duolalightstage2ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Duolalightstage2ViewPresentor:dependWhatResources()
	return {
		"ui/views/duolalight/duolalightstage2view.prefab"
	}
end

function Duolalightstage2ViewPresentor:buildViews()
	return {
		Duolalightstage2View.New()
	}
end

return Duolalightstage2ViewPresentor
