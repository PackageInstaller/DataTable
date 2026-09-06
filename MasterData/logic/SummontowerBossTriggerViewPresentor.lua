-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerBossTriggerViewPresentor.lua

module("logic.extensions.summontower.view.SummontowerBossTriggerViewPresentor", package.seeall)

local SummontowerBossTriggerViewPresentor = class("SummontowerBossTriggerViewPresentor", ViewPresentor)

function SummontowerBossTriggerViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SummontowerBossTriggerViewPresentor:dependWhatResources()
	return {
		"ui/views/summontower/sumtowtriggerview.prefab"
	}
end

function SummontowerBossTriggerViewPresentor:buildViews()
	return {
		SummontowerBossTriggerView.New()
	}
end

return SummontowerBossTriggerViewPresentor
