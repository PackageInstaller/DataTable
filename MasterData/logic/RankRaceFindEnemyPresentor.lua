-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceFindEnemyPresentor.lua

module("logic.extensions.rankrace.view.RankRaceFindEnemyPresentor", package.seeall)

local RankRaceFindEnemyPresentor = class("RankRaceFindEnemyPresentor", ViewPresentor)

function RankRaceFindEnemyPresentor:ctor()
	RankRaceFindEnemyPresentor.super.ctor(self)
end

function RankRaceFindEnemyPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RankRaceFindEnemyPresentor:dependWhatResources()
	return {
		"ui/views/rankrace/rankracefindenemyview.prefab"
	}
end

function RankRaceFindEnemyPresentor:buildViews()
	return {
		RankRaceFindEnemyView.New()
	}
end

return RankRaceFindEnemyPresentor
