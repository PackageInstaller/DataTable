-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameSkillTreeViewPresentor.lua

module("logic.extensions.orimatgame.view.OriMatGameSkillTreeViewPresentor", package.seeall)

local OriMatGameSkillTreeViewPresentor = class("OriMatGameSkillTreeViewPresentor", ViewPresentor)

function OriMatGameSkillTreeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriMatGameSkillTreeViewPresentor:dependWhatResources()
	return {
		"ui/views/orimatgame/orimatgameskilltreeview.prefab"
	}
end

function OriMatGameSkillTreeViewPresentor:buildViews()
	return {
		OriMatGameSkillTreeView.New()
	}
end

return OriMatGameSkillTreeViewPresentor
