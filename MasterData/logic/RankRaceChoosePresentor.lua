-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceChoosePresentor.lua

module("logic.extensions.rankrace.view.RankRaceChoosePresentor", package.seeall)

local RankRaceChoosePresentor = class("RankRaceChoosePresentor", ViewWithGuidePresentor)

function RankRaceChoosePresentor:ctor()
	RankRaceChoosePresentor.super.ctor(self)
end

function RankRaceChoosePresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RankRaceChoosePresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankracechooseview.prefab"
	}
end

function RankRaceChoosePresentor:buildViews()
	return {
		RankRaceChooseView.New()
	}
end

return RankRaceChoosePresentor
