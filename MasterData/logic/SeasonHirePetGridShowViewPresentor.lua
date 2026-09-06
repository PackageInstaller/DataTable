-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonHirePetGridShowViewPresentor.lua

module("logic.extensions.season.view.SeasonHirePetGridShowViewPresentor", package.seeall)

local SeasonHirePetGridShowViewPresentor = class("SeasonHirePetGridShowViewPresentor", ViewPresentor)

function SeasonHirePetGridShowViewPresentor:ctor()
	SeasonHirePetGridShowViewPresentor.super.ctor(self)
end

function SeasonHirePetGridShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeasonHirePetGridShowViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonhirepetgridshowview.prefab"
	}
end

function SeasonHirePetGridShowViewPresentor:buildViews()
	return {
		SeasonHirePetGridShowView.New()
	}
end

return SeasonHirePetGridShowViewPresentor
