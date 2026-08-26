-- chunkname: @modules/logic/room/view/critter/RoomCritterPlaceItem.lua

module("modules.logic.room.view.critter.RoomCritterPlaceItem", package.seeall)

local RoomCritterPlaceItem = class("RoomCritterPlaceItem", ListScrollCellExtend)

function RoomCritterPlaceItem:onInitView()
	self._goicon = gohelper.findChild(self.viewGO, "#go_icon")
	self._goclick = gohelper.findChild(self.viewGO, "#go_click")
	self._goratio = gohelper.findChild(self.viewGO, "#go_ratio")
	self._txtratio = gohelper.findChildText(self.viewGO, "#go_ratio/#txt_ratio")
	self._uiclick = gohelper.getClickWithDefaultAudio(self._goclick)
	self._uidrag = SLFramework.UGUI.UIDragListener.Get(self._goclick)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterPlaceItem:addEvents()
	self._uiclick:AddClickListener(self._btnclickOnClick, self)
	self._uiclick:AddClickDownListener(self._btnclickOnClickDown, self)
	self._uidrag:AddDragBeginListener(self._onDragBegin, self)
	self._uidrag:AddDragListener(self._onDrag, self)
	self._uidrag:AddDragEndListener(self._onDragEnd, self)
end

function RoomCritterPlaceItem:removeEvents()
	self._uiclick:RemoveClickListener()
	self._uiclick:RemoveClickDownListener()
	self._uidrag:RemoveDragBeginListener()
	self._uidrag:RemoveDragListener()
	self._uidrag:RemoveDragEndListener()
end

function RoomCritterPlaceItem:_btnclickOnClickDown()
	self._isDragUI = false
end

function RoomCritterPlaceItem:_btnclickOnClick()
	if self._isDragUI then
		return
	end

	local curBuildingUid = self:getViewBuilding()
	local critterUid = self:getCritterId()

	CritterController.instance:clickCritterPlaceItem(curBuildingUid, critterUid)
end

function RoomCritterPlaceItem:_onDragBegin(param, pointerEventData)
	self._isDragUI = true

	CritterController.instance:dispatchEvent(CritterEvent.CritterListOnDragBeginListener, pointerEventData)
end

function RoomCritterPlaceItem:_onDrag(param, pointerEventData)
	self._isDragUI = true

	CritterController.instance:dispatchEvent(CritterEvent.CritterListOnDragListener, pointerEventData)
end

function RoomCritterPlaceItem:_onDragEnd(param, pointerEventData)
	self._isDragUI = false

	CritterController.instance:dispatchEvent(CritterEvent.CritterListOnDragEndListener, pointerEventData)
end

function RoomCritterPlaceItem:_editableInitView()
	self._goarrow = gohelper.findChild(self.viewGO, "#go_ratio/#txt_ratio/arrow")
	self._isDragUI = false
	self._dragStartY = 250 * UnityEngine.Screen.height / 1080
end

function RoomCritterPlaceItem:_editableAddEvents()
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterUpdateAttrPreview, self._onAttrPreviewUpdate, self)
end

function RoomCritterPlaceItem:_editableRemoveEvents()
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterUpdateAttrPreview, self._onAttrPreviewUpdate, self)
end

function RoomCritterPlaceItem:_onAttrPreviewUpdate(critterUidDict)
	if self._mo and critterUidDict[self._mo:getId()] then
		self:setCritter()
	end
end

function RoomCritterPlaceItem:onUpdateMO(mo)
	self._mo = mo

	self:setCritter()
	self:refresh()
end

function RoomCritterPlaceItem:setCritter()
	local critterUid, critterId = self:getCritterId()

	if not self.critterIcon then
		self.critterIcon = IconMgr.instance:getCommonCritterIcon(self._goicon)

		self.critterIcon:setSelectUIVisible(true)
	end

	self.critterIcon:setMOValue(critterUid, critterId)
	self.critterIcon:showMood()

	local curBuildingUid, viewBuildingMO = self:getViewBuilding()
	local restingBuildingUid = ManufactureModel.instance:getCritterRestingBuilding(critterUid)

	self.critterIcon:setIsShowBuildingIcon(restingBuildingUid ~= curBuildingUid)

	local showMoodRatio = false

	if restingBuildingUid then
		local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(restingBuildingUid)
		local buildingId = buildingMO and buildingMO.buildingId
		local value = CritterHelper.getPreViewAttrValue(CritterEnum.AttributeType.MoodRestore, critterUid, buildingId, false)

		if value > 0 then
			self._txtratio.text = "+" .. CritterHelper.formatAttrValue(CritterEnum.AttributeType.MoodRestore, value)
			showMoodRatio = true
		end

		if viewBuildingMO then
			::label_14_0::

			local var_14_0 = viewBuildingMO.config

			if viewBuildingMO.config then
				local buildingType = viewBuildingMO.config.buildingType
				local buildingMoodValue = self:getBuildingMoodValue(buildingType)
				local isUp = buildingMoodValue < value

				gohelper.setActive(self._goarrow, isUp)
				SLFramework.UGUI.GuiHelper.SetColor(self._txtratio, isUp and "#D9A06F" or "#D4C399")
			end
		end
	end

	gohelper.setActive(self._goratio, showMoodRatio)
end

function RoomCritterPlaceItem:getBuildingMoodValue(buildingType)
	return CritterHelper.getPatienceChangeValue(buildingType)
end

function RoomCritterPlaceItem:refresh()
	return
end

function RoomCritterPlaceItem:onSelect(isSelect)
	if self.critterIcon then
		self.critterIcon:onSelect(isSelect)
	end

	self._isSelect = isSelect
end

function RoomCritterPlaceItem:getCritterId()
	local critterUid, critterId

	if self._mo then
		critterUid = self._mo:getId()
		critterId = self._mo:getDefineId()
	end

	return critterUid, critterId
end

function RoomCritterPlaceItem:getViewBuilding()
	local viewBuildingUid, viewBuildingMO = self._view.viewContainer:getContainerViewBuilding(true)

	return viewBuildingUid, viewBuildingMO
end

function RoomCritterPlaceItem:onDestroy()
	return
end

return RoomCritterPlaceItem
