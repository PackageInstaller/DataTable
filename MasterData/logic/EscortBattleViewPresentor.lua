-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/escort/view/EscortBattleViewPresentor.lua

module("logic.extensions.escort.view.EscortBattleViewPresentor", package.seeall)

local EscortBattleViewPresentor = class("EscortBattleViewPresentor", ViewWithGuidePresentor)

function EscortBattleViewPresentor:ctor()
	EscortBattleViewPresentor.super.ctor(self)
end

function EscortBattleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EscortBattleViewPresentor:dependWhatResources()
	return {
		"ui/views/escort/escortbattleview.prefab"
	}
end

function EscortBattleViewPresentor:buildViews()
	return {
		EscortBattleView.New()
	}
end

return EscortBattleViewPresentor
