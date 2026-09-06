-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternfestival/view/LanternFestivalAnswerViewPresentor.lua

module("logic.extensions.lanternfestival.view.LanternFestivalAnswerViewPresentor", package.seeall)

local LanternFestivalAnswerViewPresentor = class("LanternFestivalAnswerViewPresentor", ViewPresentor)

function LanternFestivalAnswerViewPresentor:ctor()
	LanternFestivalAnswerViewPresentor.super.ctor(self)
end

function LanternFestivalAnswerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LanternFestivalAnswerViewPresentor:dependWhatResources()
	return {
		"ui/views/lanternfestival/lanternfestivalanswerview.prefab"
	}
end

function LanternFestivalAnswerViewPresentor:buildViews()
	return {
		LanternFestivalAnswerView.New()
	}
end

return LanternFestivalAnswerViewPresentor
