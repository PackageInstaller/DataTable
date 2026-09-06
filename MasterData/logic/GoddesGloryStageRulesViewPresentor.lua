-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddesGloryStageRulesViewPresentor.lua

module("logic.extensions.goddessglory.view.GoddesGloryStageRulesViewPresentor", package.seeall)

local GoddesGloryStageRulesViewPresentor = class("GoddesGloryStageRulesViewPresentor", ViewPresentor)

function GoddesGloryStageRulesViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GoddesGloryStageRulesViewPresentor:dependWhatResources()
	return {
		"ui/views/goddessglory/goddessgloryruleview.prefab"
	}
end

function GoddesGloryStageRulesViewPresentor:buildViews()
	return {
		GoddesGloryStageRulesView.New()
	}
end

return GoddesGloryStageRulesViewPresentor
