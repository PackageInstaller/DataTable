-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/Yearcardskininteraction2026ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2026.main.Yearcardskininteraction2026ViewPresentor", package.seeall)

local Yearcardskininteraction2026ViewPresentor = class("Yearcardskininteraction2026ViewPresentor", ViewPresentor)

function Yearcardskininteraction2026ViewPresentor:ctor()
	Yearcardskininteraction2026ViewPresentor.super.ctor(self)
end

function Yearcardskininteraction2026ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Yearcardskininteraction2026ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2026/main/yearcardskininteraction2026view.prefab"
	}
end

function Yearcardskininteraction2026ViewPresentor:buildViews()
	return {
		Yearcardskininteraction2026View.New()
	}
end

return Yearcardskininteraction2026ViewPresentor
