-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/PaladinBattleViewPresentor.lua

module("logic.extensions.moonking.view.PaladinBattleViewPresentor", package.seeall)

local PaladinBattleViewPresentor = class("PaladinBattleViewPresentor", ViewWithGuidePresentor)

function PaladinBattleViewPresentor:ctor()
	PaladinBattleViewPresentor.super.ctor(self)
end

function PaladinBattleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PaladinBattleViewPresentor:dependWhatResources()
	return {
		"ui/views/moonking/paladinbattleview.prefab"
	}
end

function PaladinBattleViewPresentor:buildViews()
	return {
		PaladinBattleView.New()
	}
end

return PaladinBattleViewPresentor
