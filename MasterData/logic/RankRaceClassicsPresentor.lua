-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceClassicsPresentor.lua

module("logic.extensions.rankrace.view.RankRaceClassicsPresentor", package.seeall)

local RankRaceClassicsPresentor = class("RankRaceClassicsPresentor", ViewPresentor)

function RankRaceClassicsPresentor:ctor()
	RankRaceClassicsPresentor.super.ctor(self)
end

function RankRaceClassicsPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RankRaceClassicsPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankraceclassicsview.prefab"
	}
end

function RankRaceClassicsPresentor:buildViews()
	return {
		RankRaceClassicsView.New()
	}
end

return RankRaceClassicsPresentor
