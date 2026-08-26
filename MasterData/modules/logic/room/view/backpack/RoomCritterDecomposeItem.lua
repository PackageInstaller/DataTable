-- chunkname: @modules/logic/room/view/backpack/RoomCritterDecomposeItem.lua

module("modules.logic.room.view.backpack.RoomCritterDecomposeItem", package.seeall)

local RoomCritterDecomposeItem = class("RoomCritterDecomposeItem", ListScrollCellExtend)

function RoomCritterDecomposeItem:onInitView()
	self._gocritterIcon = gohelper.findChild(self.viewGO, "#go_critterIcon")
	self._goselect = gohelper.findChild(self.viewGO, "#go_selected")
	self._goAni = gohelper.findChild(self.viewGO, "vx_compose")
	self.click = gohelper.getClickWithDefaultAudio(self.viewGO)
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterDecomposeItem:addEvents()
	self.click:AddClickListener(self.onClick, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterDecomposeChangeSelect, self.refreshSelected, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.BeforeDecomposeCritter, self.beforeDecompose, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterChangeLockStatus, self._onCritterLockStatusChange, self)
end

function RoomCritterDecomposeItem:removeEvents()
	self.click:RemoveClickListener()
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterDecomposeChangeSelect, self.refreshSelected, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.BeforeDecomposeCritter, self.beforeDecompose, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterChangeLockStatus, self._onCritterLockStatusChange, self)
end

function RoomCritterDecomposeItem:onClick()
	local isLock = self._mo:isLock()

	if isLock then
		GameFacade.showToast(ToastEnum.RoomCritterIsLock)

		return
	end

	local uid = self._mo:getId()
	local isSelected = RoomCritterDecomposeListModel.instance:isSelect(uid)

	if isSelected then
		RoomCritterDecomposeListModel.instance:unselectDecomposeCritter(self._mo)
	else
		RoomCritterDecomposeListModel.instance:selectDecomposeCritter(self._mo)
	end
end

function RoomCritterDecomposeItem:beforeDecompose()
	local uid = self._mo:getId()
	local isSelected = RoomCritterDecomposeListModel.instance:isSelect(uid)

	if isSelected then
		gohelper.setActive(self._goAni, true)
	end
end

function RoomCritterDecomposeItem:_onCritterLockStatusChange(changeCritterUid)
	if self._mo then
		local critterUid = self._mo:getId()

		if not self._critterIcon or not self._mo or self._mo ~= changeCritterUid then
			return
		end

		self._critterIcon:refreshLockIcon()
	end
end

function RoomCritterDecomposeItem:_editableInitView()
	return
end

function RoomCritterDecomposeItem:onUpdateMO(mo)
	self._mo = mo

	if not self._critterIcon then
		self._critterIcon = IconMgr.instance:getCommonCritterIcon(self._gocritterIcon)

		self._critterIcon:setCanClick(false)
		self._critterIcon:setLockIconShow(true)
		self._critterIcon:setMaturityIconShow(true)
	end

	self._critterIcon:onUpdateMO(self._mo)
	self:refreshSelected()
	gohelper.setActive(self._goAni, false)
end

function RoomCritterDecomposeItem:refreshSelected()
	local uid = self._mo:getId()
	local isSelected = RoomCritterDecomposeListModel.instance:isSelect(uid)

	gohelper.setActive(self._goselect, isSelected)
end

function RoomCritterDecomposeItem:getAnimator()
	return self.animator
end

function RoomCritterDecomposeItem:onDestroyView()
	return
end

return RoomCritterDecomposeItem
