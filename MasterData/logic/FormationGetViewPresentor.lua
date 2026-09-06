-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FormationGetViewPresentor.lua

module("logic.extensions.itemget.FormationGetViewPresentor", package.seeall)

local FormationGetViewPresentor = class("FormationGetViewPresentor", ViewPresentor)

function FormationGetViewPresentor:ctor()
	FormationGetViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.ObtainItemsViewPriority
	self._availableToClose = nil
end

function FormationGetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FormationGetViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/formationgetview.prefab"
	}
end

function FormationGetViewPresentor:buildViews()
	local views = {}
	local view = FormationGetView.New()

	table.insert(views, view)

	return views
end

function FormationGetViewPresentor:onClickOutside()
	if self._availableToClose then
		UIStateManager.instance:popByName(self.viewName)
	end
end

function FormationGetViewPresentor:_onEnterAnimationDone()
	FormationGetViewPresentor.super._onEnterAnimationDone(self)

	self._availableToClose = nil

	removetimer(self._delayTimeWithClosing, self)
	settimer(2, self._delayTimeWithClosing, self, false)
end

function FormationGetViewPresentor:_onCloseAnimationDone()
	FormationGetViewPresentor.super._onCloseAnimationDone(self)

	self._availableToClose = nil

	removetimer(self._delayTimeWithClosing, self)
end

function FormationGetViewPresentor:_delayTimeWithClosing()
	removetimer(self._delayTimeWithClosing, self)

	self._availableToClose = true
end

return FormationGetViewPresentor
