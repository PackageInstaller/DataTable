-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mission/TLCBattleResultViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.mission.TLCBattleResultViewPresentor", package.seeall)

local TLCBattleResultViewPresentor = class("TLCBattleResultViewPresentor", ViewPresentor)

function TLCBattleResultViewPresentor:ctor()
	TLCBattleResultViewPresentor.super.ctor(self)
end

function TLCBattleResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TLCBattleResultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/tlcbattleresultview.prefab"
	}
end

function TLCBattleResultViewPresentor:buildViews()
	return {
		TLCBattleResultView.New()
	}
end

return TLCBattleResultViewPresentor
