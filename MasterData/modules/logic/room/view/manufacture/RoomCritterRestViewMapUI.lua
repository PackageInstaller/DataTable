-- chunkname: @modules/logic/room/view/manufacture/RoomCritterRestViewMapUI.lua

module("modules.logic.room.view.manufacture.RoomCritterRestViewMapUI", package.seeall)

local RoomCritterRestViewMapUI = class("RoomCritterRestViewMapUI", BaseView)

function RoomCritterRestViewMapUI:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterRestViewMapUI:_editableInitView()
	self._gomap = gohelper.findChild(self.viewGO, "content/go_map")
	self._gomood = gohelper.findChild(self.viewGO, "content/#go_select/mood")
	self._moodItemCompList = {}
	self._critterMoodShowDict = {}
	self._gomapTrs = self._gomap.transform
	self._offX, self._offY = recthelper.getAnchor(self._gomood.transform)

	gohelper.setActive(self._gomood, false)
end

function RoomCritterRestViewMapUI:onUpdateParam()
	return
end

function RoomCritterRestViewMapUI:onOpen()
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingSelectCritter, self._startRefreshMoodTask, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingSetCanOperateRestingCritter, self._startRefreshMoodTask, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingCameraTweenFinish, self._startRefreshMoodTask, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, self._startRefreshMoodTask, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterDecomposeReply, self._startRefreshMoodTask, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterUpdateAttrPreview, self._startRefreshMoodTask, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.CameraTransformUpdate, self._cameraTransformUpdate, self)
	self.addEventCb(self, self.viewContainer, CritterEvent.UICritterDragIng, self._cameraTransformUpdate, self)
	self.addEventCb(self, self.viewContainer, CritterEvent.UICritterDragEnd, self._startRefreshMoodTask, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, self._startRequestTask, self)

	self._scene = RoomCameraController.instance:getRoomScene()

	self:_startRefreshMoodTask()
end

function RoomCritterRestViewMapUI:onClose()
	return
end

function RoomCritterRestViewMapUI:onDestroyView()
	self:_stopRefreshMoodTask()
end

function RoomCritterRestViewMapUI:_startRequestTask()
	local buildingUid, buildingMO = self:getViewBuilding()

	CritterController.instance:waitSendBuildManufacturAttrByBuid(buildingUid)
end

function RoomCritterRestViewMapUI:_startRefreshMoodTask()
	if not self._hasWaitRefreshMoodTask then
		self._hasWaitRefreshMoodTask = true

		TaskDispatcher.runDelay(self._onRunRefreshMoodTask, self, 0.1)
	end
end

function RoomCritterRestViewMapUI:_stopRefreshMoodTask()
	self._hasWaitRefreshMoodTask = false

	TaskDispatcher.cancelTask(self._onRunRefreshMoodTask, self)
end

function RoomCritterRestViewMapUI:_onRunRefreshMoodTask()
	self._hasWaitRefreshMoodTask = false

	local isAllSucce = self:_refreshMood()

	if not isAllSucce then
		self:_startRefreshMoodTask()
	end

	if not self._isSendCritterRequest then
		local buildingUid, buildingMO = self:getViewBuilding()

		if buildingMO and buildingMO.config and buildingMO.config.buildingType then
			self._isSendCritterRequest = true

			CritterController.instance:sendBuildManufacturAttrByBtype(buildingMO.config.buildingType)
		end
	end
end

function RoomCritterRestViewMapUI:_cameraTransformUpdate()
	self:_refreshMood()
end

function RoomCritterRestViewMapUI:_refreshMood()
	local allMOList = CritterModel.instance:getAllCritters()
	local index = 0
	local buildingUid, buildingMO = self:getViewBuilding()
	local isAllSucce = true

	for _, critterMO in ipairs(allMOList) do
		local critterUid = critterMO:getId()

		if buildingMO and buildingMO:isCritterInSeatSlot(critterUid) then
			index = index + 1

			local itemComp = self._moodItemCompList[index]

			if not itemComp then
				local go = gohelper.clone(self._gomood, self._gomap)

				itemComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, CritterMoodItem)
				itemComp.goViewTrs = go.transform

				table.insert(self._moodItemCompList, itemComp)
				itemComp:setShowMoodRestore(false)
			end

			itemComp:setCritterUid(critterUid)

			local isScuss = self:_updateMoodPos(critterUid, itemComp.goViewTrs)

			self._critterMoodShowDict[critterUid] = isScuss

			if not isScuss then
				isAllSucce = false
			end
		end
	end

	for i = 1, #self._moodItemCompList do
		local itemComp = self._moodItemCompList[i]
		local critterUid = itemComp.critterUid

		gohelper.setActive(itemComp.go, self._critterMoodShowDict[critterUid] and i <= index)
	end

	return isAllSucce
end

function RoomCritterRestViewMapUI:_updateMoodPos(critterUid, goViewTrs)
	if not self._scene then
		return false
	end

	local entity = self._scene.buildingcrittermgr:getCritterEntity(critterUid)

	if entity then
		::label_13_0::

		local critterPointTrans = entity.critterspine:getMountheadGOTrs()

		if gohelper.isNil(critterPointTrans) then
			return false
		end

		local position = critterPointTrans.position
		local bendingPos = RoomBendingHelper.worldToBendingSimple(position)
		local anchorPos = RoomBendingHelper.worldPosToAnchorPos(bendingPos, self._gomapTrs)

		if anchorPos then
			recthelper.setAnchor(goViewTrs, anchorPos.x + self._offX, anchorPos.y + self._offY)

			return true
		end

		return false
	end
end

function RoomCritterRestViewMapUI:getViewBuilding()
	return self.viewContainer:getContainerViewBuilding()
end

return RoomCritterRestViewMapUI
