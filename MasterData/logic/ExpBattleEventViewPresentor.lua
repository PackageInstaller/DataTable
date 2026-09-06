-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpBattleEventViewPresentor.lua

module("logic.extensions.expedition.view.ExpBattleEventViewPresentor", package.seeall)

local ExpBattleEventViewPresentor = class("ExpBattleEventViewPresentor", ViewWithGuidePresentor)

function ExpBattleEventViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ExpBattleEventViewPresentor:dependWhatResources()
	return {
		"ui/views/expedition/battleeventview.prefab"
	}
end

function ExpBattleEventViewPresentor:buildViews()
	return {
		ExpBattleEventView.New()
	}
end

return ExpBattleEventViewPresentor
