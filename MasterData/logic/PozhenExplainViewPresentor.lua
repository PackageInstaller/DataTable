-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breakformation/view/PozhenExplainViewPresentor.lua

module("logic.extensions.breakformation.view.PozhenExplainViewPresentor", package.seeall)

local PozhenExplainViewPresentor = class("PozhenExplainViewPresentor", ViewWithGuidePresentor)

function PozhenExplainViewPresentor:ctor()
	PozhenExplainViewPresentor.super.ctor(self)
end

function PozhenExplainViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PozhenExplainViewPresentor:dependWhatResources()
	return {
		"ui/views/breakformation/pozhenexplainview.prefab"
	}
end

function PozhenExplainViewPresentor:buildViews()
	return {
		PozhenExplainView.New()
	}
end

return PozhenExplainViewPresentor
