-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/KingBattleViewPresentor.lua

module("logic.extensions.kingway.view.KingBattleViewPresentor", package.seeall)

local KingBattleViewPresentor = class("KingBattleViewPresentor", ViewWithGuidePresentor)

function KingBattleViewPresentor:ctor()
	KingBattleViewPresentor.super.ctor(self)
end

function KingBattleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingBattleViewPresentor:dependWhatResources()
	return {
		"ui/views/kingway/kingbattleview.prefab"
	}
end

function KingBattleViewPresentor:buildViews()
	return {
		KingBattleView.New()
	}
end

return KingBattleViewPresentor
