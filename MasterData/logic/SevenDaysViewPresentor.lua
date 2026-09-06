-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/SevenDaysViewPresentor.lua

module("logic.extensions.sevendays.view.SevenDaysViewPresentor", package.seeall)

local SevenDaysViewPresentor = class("SevenDaysViewPresentor", ViewWithGuidePresentor)

function SevenDaysViewPresentor:ctor()
	SevenDaysViewPresentor.super.ctor(self)
end

function SevenDaysViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SevenDaysViewPresentor:dependWhatResources()
	return {
		"ui/views/sevendays/sevendaysview.prefab"
	}
end

function SevenDaysViewPresentor:buildViews()
	return {
		SevenDaysView.New()
	}
end

return SevenDaysViewPresentor
