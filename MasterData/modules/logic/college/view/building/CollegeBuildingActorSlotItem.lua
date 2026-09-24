-- chunkname: @modules/logic/college/view/building/CollegeBuildingActorSlotItem.lua

module("modules.logic.college.view.building.CollegeBuildingActorSlotItem", package.seeall)

local CollegeBuildingActorSlotItem = class("CollegeBuildingActorSlotItem", ListScrollCell)

function CollegeBuildingActorSlotItem:init(go)
	self.go = go
	self._btnAddDispatch = gohelper.findChildButtonWithAudio(self.go, "#btn_AddDispatch")
	self._btnLockedSlot = gohelper.findChildButtonWithAudio(self.go, "#btn_LockedSlot")
	self._btnHasDispatch = gohelper.findChildButtonWithAudio(self.go, "#btn_HasDispatch")
	self._simageDispatchHead = gohelper.findChildSingleImage(self.go, "#btn_HasDispatch/#simage_DispatchHead")
	self._imageBuildingLevel = gohelper.findChildImage(self.go, "#btn_LockedSlot/#image_BuildingLevel")
	self._goAddDispatch = self._btnAddDispatch.gameObject
	self._goLockedSlot = self._btnLockedSlot.gameObject
	self._goHasDispatch = self._btnHasDispatch.gameObject
	self._anim = gohelper.findComponentAnim(go)
	self._anim.keepAnimatorStateOnDisable = true
end

function CollegeBuildingActorSlotItem:addEventListeners()
	self._btnAddDispatch:AddClickListener(self._btnAddDispatchOnClick, self)
	self._btnLockedSlot:AddClickListener(self._btnLockedSlotOnClick, self)
	self._btnHasDispatch:AddClickListener(self._btnHasDispatchOnClick, self)
end

function CollegeBuildingActorSlotItem:removeEventListeners()
	self._btnAddDispatch:RemoveClickListener()
	self._btnLockedSlot:RemoveClickListener()
	self._btnHasDispatch:RemoveClickListener()
end

function CollegeBuildingActorSlotItem:_btnAddDispatchOnClick()
	ViewMgr.instance:openView(ViewName.CollegeRoleDispatchView, {
		locationMo = self._locationMo,
		slotIndex = self._index
	})
end

function CollegeBuildingActorSlotItem:_btnLockedSlotOnClick()
	GameFacade.showToast(ToastEnum.CollegeBuildingSlotLock, self._unlockLv)
end

function CollegeBuildingActorSlotItem:_btnHasDispatchOnClick()
	ViewMgr.instance:openView(ViewName.CollegeRoleDispatchView, {
		selectMo = self._actorMo,
		locationMo = self._locationMo,
		slotIndex = self._index
	})
end

function CollegeBuildingActorSlotItem:onUpdateMO(slotMo, index)
	if self._state and slotMo.state == CollegeEnum.BuildingActorSlotState.Use and self._actorMo ~= slotMo.actorMo then
		self._anim:Play("add", 0, 0)
		CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.DispatchRole)
	end

	self._slotMo = slotMo
	self._actorMo = slotMo.actorMo
	self._locationMo = slotMo.locationMo
	self._index = index
	self._state = slotMo.state
	self._unlockLv = slotMo.unlockLv

	self:refreshUI()
end

function CollegeBuildingActorSlotItem:refreshUI()
	gohelper.setActive(self._goAddDispatch, self._state == CollegeEnum.BuildingActorSlotState.Empty)
	gohelper.setActive(self._goLockedSlot, self._state == CollegeEnum.BuildingActorSlotState.Lock)
	gohelper.setActive(self._goHasDispatch, self._state == CollegeEnum.BuildingActorSlotState.Use)

	if self._state == CollegeEnum.BuildingActorSlotState.Use then
		CollegeIconHelper.setActorIcon(self._actorMo.id, self._simageDispatchHead)
	elseif self._state == CollegeEnum.BuildingActorSlotState.Lock then
		local slotInfo = CollegeConfig.instance:getBuildingSlotInfo(self._locationMo.id)
		local slotNumUpdateMap = slotInfo and slotInfo.slotNumUpdateMap

		CollegeIconHelper.setBuildingLv(self._imageBuildingLevel, slotNumUpdateMap and slotNumUpdateMap[self._index])
	end
end

function CollegeBuildingActorSlotItem:onDestroy()
	self._simageDispatchHead:UnLoadImage()
end

return CollegeBuildingActorSlotItem
