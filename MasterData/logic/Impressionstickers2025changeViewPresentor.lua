-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/impressionstickers/view/Impressionstickers2025changeViewPresentor.lua

module("logic.extensions.impressionstickers.view.Impressionstickers2025changeViewPresentor", package.seeall)

local Impressionstickers2025changeViewPresentor = class("Impressionstickers2025changeViewPresentor", ViewPresentor)

function Impressionstickers2025changeViewPresentor:ctor()
	Impressionstickers2025changeViewPresentor.super.ctor(self)
end

function Impressionstickers2025changeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function Impressionstickers2025changeViewPresentor:dependWhatResources()
	return {
		"ui/views/impressionstickers/impressionstickers2025changeview.prefab"
	}
end

function Impressionstickers2025changeViewPresentor:buildViews()
	return {
		Impressionstickers2025changeView.New()
	}
end

return Impressionstickers2025changeViewPresentor
