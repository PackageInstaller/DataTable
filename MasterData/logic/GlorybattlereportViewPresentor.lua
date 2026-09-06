-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattlereportViewPresentor.lua

module("logic.extensions.glorybattle.view.GlorybattlereportViewPresentor", package.seeall)

local GlorybattlereportViewPresentor = class("GlorybattlereportViewPresentor", ViewPresentor)

function GlorybattlereportViewPresentor:ctor()
	GlorybattlereportViewPresentor.super.ctor(self)
end

function GlorybattlereportViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GlorybattlereportViewPresentor:dependWhatResources()
	return {
		"ui/views/glorybattle/glorybattlereportview.prefab"
	}
end

function GlorybattlereportViewPresentor:buildViews()
	return {
		GlorybattlereportView.New()
	}
end

return GlorybattlereportViewPresentor
