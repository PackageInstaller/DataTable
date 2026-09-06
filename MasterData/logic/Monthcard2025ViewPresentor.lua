-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/Monthcard2025ViewPresentor.lua

module("logic.extensions.monthcard.view.Monthcard2025ViewPresentor", package.seeall)

local Monthcard2025ViewPresentor = class("Monthcard2025ViewPresentor", ViewPresentor)

function Monthcard2025ViewPresentor:ctor()
	Monthcard2025ViewPresentor.super.ctor(self)
end

function Monthcard2025ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Monthcard2025ViewPresentor:dependWhatResources()
	return {
		"ui/views/monthcard/monthcard2025view.prefab"
	}
end

function Monthcard2025ViewPresentor:buildViews()
	return {
		Monthcard2025View.New()
	}
end

return Monthcard2025ViewPresentor
