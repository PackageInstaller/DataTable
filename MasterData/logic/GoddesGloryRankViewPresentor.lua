-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddesGloryRankViewPresentor.lua

module("logic.extensions.goddessglory.view.GoddesGloryRankViewPresentor", package.seeall)

local GoddesGloryRankViewPresentor = class("GoddesGloryRankViewPresentor", ViewPresentor)

function GoddesGloryRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GoddesGloryRankViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessglory/goddessgloryrankview.prefab"
	}
end

function GoddesGloryRankViewPresentor:buildViews()
	return {
		GoddesGloryRankView.New()
	}
end

return GoddesGloryRankViewPresentor
