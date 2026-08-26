-- chunkname: @modules/logic/room/view/critter/RoomCritterTrainViewAnim.lua

module("modules.logic.room.view.critter.RoomCritterTrainViewAnim", package.seeall)

local RoomCritterTrainViewAnim = class("RoomCritterTrainViewAnim", BaseView)

function RoomCritterTrainViewAnim:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterTrainViewAnim:addEvents()
	return
end

function RoomCritterTrainViewAnim:removeEvents()
	return
end

function RoomCritterTrainViewAnim:_editableInitView()
	self._lastIshow = true
end

function RoomCritterTrainViewAnim:onUpdateParam()
	return
end

function RoomCritterTrainViewAnim:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function RoomCritterTrainViewAnim:_onOpenView(viewName)
	self:_setShowView(self:_isCheckShowView())
end

function RoomCritterTrainViewAnim:_onCloseView(viewName)
	self:_setShowView(self:_isCheckShowView())
end

function RoomCritterTrainViewAnim:_setShowView(isShow)
	if self._lastIshow ~= isShow then
		self._lastIshow = isShow

		gohelper.setActive(self.viewGO, isShow)

		if isShow then
			CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingShowView)
		else
			CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView)
		end
	end
end

function RoomCritterTrainViewAnim:_setBuildingShowView(isShow)
	if self._lastBuildingShow ~= isShow then
		self._lastBuildingShow = isShow
	end
end

function RoomCritterTrainViewAnim:_isCheckShowView()
	self._showHitViewNameList = self._showHitViewNameList or {
		ViewName.RoomCritterTrainEventView,
		ViewName.RoomCritterTrainStoryView,
		ViewName.RoomBranchView,
		ViewName.RoomCritterTrainEventResultView
	}

	for _, viewName in ipairs(self._showHitViewNameList) do
		if ViewMgr.instance:isOpen(viewName) then
			return false
		end
	end

	return true
end

function RoomCritterTrainViewAnim:onClose()
	return
end

function RoomCritterTrainViewAnim:onDestroyView()
	return
end

return RoomCritterTrainViewAnim
