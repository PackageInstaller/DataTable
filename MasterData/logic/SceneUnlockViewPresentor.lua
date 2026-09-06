-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/unlock/view/SceneUnlockViewPresentor.lua

module("logic.extensions.tips.view.SceneUnlockViewPresentor", package.seeall)

local SceneUnlockViewPresentor = class("SceneUnlockViewPresentor", ViewPresentor)

function SceneUnlockViewPresentor:ctor()
	SceneUnlockViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.PopupWindowViewPriority
end

function SceneUnlockViewPresentor:dependWhatResources()
	return {
		"ui/views/unlock/scene_unlock.prefab"
	}
end

function SceneUnlockViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function SceneUnlockViewPresentor:buildViews()
	local views = {}
	local view = SceneUnlockView.New()

	table.insert(views, view)

	return views
end

return SceneUnlockViewPresentor
