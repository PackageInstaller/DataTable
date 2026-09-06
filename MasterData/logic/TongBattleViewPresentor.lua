-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/view/TongBattleViewPresentor.lua

module("logic.extensions.tongbattle.view.TongBattleViewPresentor", package.seeall)

local TongBattleViewPresentor = class("TongBattleViewPresentor", ViewWithGuidePresentor)

function TongBattleViewPresentor:ctor()
	TongBattleViewPresentor.super.ctor(self)
end

function TongBattleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TongBattleViewPresentor:dependWhatResources()
	return {
		"ui/views/tongbattle/tongbattleview.prefab"
	}
end

function TongBattleViewPresentor:buildViews()
	return {
		TongBattleView.New()
	}
end

return TongBattleViewPresentor
