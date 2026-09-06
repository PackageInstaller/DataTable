-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/Yearcardbuyfewsandfxs2026ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2026.main.Yearcardbuyfewsandfxs2026ViewPresentor", package.seeall)

local Yearcardbuyfewsandfxs2026ViewPresentor = class("Yearcardbuyfewsandfxs2026ViewPresentor", ViewPresentor)

function Yearcardbuyfewsandfxs2026ViewPresentor:ctor()
	Yearcardbuyfewsandfxs2026ViewPresentor.super.ctor(self)
end

function Yearcardbuyfewsandfxs2026ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Yearcardbuyfewsandfxs2026ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2026/main/yearcardbuyfewsandfxs2026view.prefab"
	}
end

function Yearcardbuyfewsandfxs2026ViewPresentor:buildViews()
	return {
		Yearcardbuyfewsandfxs2026View.New()
	}
end

return Yearcardbuyfewsandfxs2026ViewPresentor
