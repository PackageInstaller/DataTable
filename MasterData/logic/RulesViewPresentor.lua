-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rules/view/RulesViewPresentor.lua

module("logic.extensions.roleinfo.view.RulesViewPresentor", package.seeall)

local RulesViewPresentor = class("RulesViewPresentor", ViewWithGuidePresentor)

function RulesViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RulesViewPresentor:dependWhatResources()
	return {
		"ui/views/rules/functionsrulesview.prefab"
	}
end

function RulesViewPresentor:buildViews()
	return {
		RulesView.New()
	}
end

return RulesViewPresentor
