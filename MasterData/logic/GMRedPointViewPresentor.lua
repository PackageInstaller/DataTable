-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/gmredpoint/GMRedPointViewPresentor.lua

module("logic.extensions.gm.view.gmredpoint.GMRedPointViewPresentor", package.seeall)

local GMRedPointViewPresentor = class("GMRedPointViewPresentor", ViewPresentor)

function GMRedPointViewPresentor:ctor()
	GMRedPointViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.PopupWindowViewPriority
end

function GMRedPointViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function GMRedPointViewPresentor:dependWhatResources()
	return {
		"ui/views/gm/gmredpointview.prefab"
	}
end

function GMRedPointViewPresentor:buildViews()
	return {
		GMRedPointView.New()
	}
end

return GMRedPointViewPresentor
