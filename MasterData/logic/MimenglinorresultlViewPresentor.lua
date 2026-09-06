-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimenglinorresultlViewPresentor.lua

module("logic.extensions.mimengli.view.MimenglinorresultlViewPresentor", package.seeall)

local MimenglinorresultlViewPresentor = class("MimenglinorresultlViewPresentor", ViewPresentor)

function MimenglinorresultlViewPresentor:ctor()
	MimenglinorresultlViewPresentor.super.ctor(self)
end

function MimenglinorresultlViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MimenglinorresultlViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/mimengli/mimenglinorresultlview.prefab"
	}
end

function MimenglinorresultlViewPresentor:buildViews()
	return {
		MimenglinorresultlView.New()
	}
end

return MimenglinorresultlViewPresentor
