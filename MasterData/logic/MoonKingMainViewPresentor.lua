-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/MoonKingMainViewPresentor.lua

module("logic.extensions.moonking.view.MoonKingMainViewPresentor", package.seeall)

local MoonKingMainViewPresentor = class("MoonKingMainViewPresentor", ViewWithGuidePresentor)

function MoonKingMainViewPresentor:ctor()
	MoonKingMainViewPresentor.super.ctor(self)
end

function MoonKingMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MoonKingMainViewPresentor:dependWhatResources()
	return {
		"ui/views/moonking/moonkingmainview.prefab"
	}
end

function MoonKingMainViewPresentor:buildViews()
	return {
		MoonKingMainView.New()
	}
end

return MoonKingMainViewPresentor
