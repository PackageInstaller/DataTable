-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasontotempoleViewPresentor.lua

module("logic.extensions.season.view.SeasontotempoleViewPresentor", package.seeall)

local SeasontotempoleViewPresentor = class("SeasontotempoleViewPresentor", ViewPresentor)

function SeasontotempoleViewPresentor:ctor()
	SeasontotempoleViewPresentor.super.ctor(self)
end

function SeasontotempoleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasontotempoleViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasontotempoleview.prefab"
	}
end

function SeasontotempoleViewPresentor:buildViews()
	return {
		SeasonTotemPoleView.New()
	}
end

return SeasontotempoleViewPresentor
