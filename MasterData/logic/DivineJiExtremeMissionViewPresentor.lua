-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/view/DivineJiExtremeMissionViewPresentor.lua

module("logic.extensions.divinejiclg.view.DivineJiExtremeMissionViewPresentor", package.seeall)

local DivineJiExtremeMissionViewPresentor = class("DivineJiExtremeMissionViewPresentor", ViewPresentor)

function DivineJiExtremeMissionViewPresentor:ctor()
	DivineJiExtremeMissionViewPresentor.super.ctor(self)
end

function DivineJiExtremeMissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineJiExtremeMissionViewPresentor:dependWhatResources()
	return {
		"ui/views/divinejiclg/divinejiextrememissionview.prefab"
	}
end

function DivineJiExtremeMissionViewPresentor:buildViews()
	return {
		DivineJiExtremeMissionView.New()
	}
end

return DivineJiExtremeMissionViewPresentor
