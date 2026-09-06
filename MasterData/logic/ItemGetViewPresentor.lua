-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itemget/ItemGetViewPresentor.lua

module("logic.extensions.itemget.ItemGetViewPresentor", package.seeall)

local ItemGetViewPresentor = class("ItemGetViewPresentor", ViewWithGuidePresentor)

function ItemGetViewPresentor:ctor()
	ItemGetViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.ObtainItemsViewPriority
	self._availableToClose = nil
end

function ItemGetViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ItemGetViewPresentor:dependWhatResources()
	return {
		"ui/views/itemget/itemgetview.prefab"
	}
end

function ItemGetViewPresentor:buildViews()
	local views = {}
	local view = ItemGetView.New()

	table.insert(views, view)

	return views
end

function ItemGetViewPresentor:onClickOutside()
	if self._availableToClose then
		-- block empty
	end
end

function ItemGetViewPresentor:_onEnterAnimationDone()
	ItemGetViewPresentor.super._onEnterAnimationDone(self)
	removetimer(self._delayTimeWithClosing, self)
	settimer(1, self._delayTimeWithClosing, self, false)
end

function ItemGetViewPresentor:_onCloseAnimationDone()
	ItemGetViewPresentor.super._onCloseAnimationDone(self)
	removetimer(self._delayTimeWithClosing, self)
end

function ItemGetViewPresentor:_delayTimeWithClosing()
	removetimer(self._delayTimeWithClosing, self)

	self._availableToClose = true
end

return ItemGetViewPresentor
