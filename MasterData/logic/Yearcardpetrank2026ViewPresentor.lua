-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/Yearcardpetrank2026ViewPresentor.lua

module("logic.extensions.yearcard.view.yearcard2026.main.Yearcardpetrank2026ViewPresentor", package.seeall)

local Yearcardpetrank2026ViewPresentor = class("Yearcardpetrank2026ViewPresentor", ViewPresentor)

function Yearcardpetrank2026ViewPresentor:ctor()
	Yearcardpetrank2026ViewPresentor.super.ctor(self)
end

function Yearcardpetrank2026ViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Yearcardpetrank2026ViewPresentor:dependWhatResources()
	return {
		"ui/views/yearcard2026/main/yearcardpetrank2026view.prefab"
	}
end

function Yearcardpetrank2026ViewPresentor:buildViews()
	return {
		Yearcardpetrank2026view.New()
	}
end

return Yearcardpetrank2026ViewPresentor
