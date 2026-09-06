-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petdisplay/view/PetDisplayViewPresentor.lua

module("logic.extensions.petdisplay.view.PetDisplayViewPresentor", package.seeall)

local PetDisplayViewPresentor = class("PetDisplayViewPresentor", ViewWithGuidePresentor)

function PetDisplayViewPresentor:ctor()
	PetDisplayViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.PetDisplayViewPriority
end

function PetDisplayViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function PetDisplayViewPresentor:dependWhatResources()
	return {
		"ui/views/petdisplay/petdisplayview_new_1.prefab"
	}
end

function PetDisplayViewPresentor:buildViews()
	local views = {}
	local petdisplayview = PetDisplayView.New()

	table.insert(views, petdisplayview)

	return views
end

function PetDisplayViewPresentor:_onViewShowByHigherPriority()
	local view = self._views[1]

	view:onViewShowByHigherPriority()
end

function PetDisplayViewPresentor:_onViewHideByLowerPriority()
	local view = self._views[1]

	view:onViewHideByLowerPriority()
end

return PetDisplayViewPresentor
