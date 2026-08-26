-- chunkname: @modules/logic/room/view/critter/RoomCritterTrainViewDetail.lua

module("modules.logic.room.view.critter.RoomCritterTrainViewDetail", package.seeall)

local RoomCritterTrainViewDetail = class("RoomCritterTrainViewDetail", BaseView)

function RoomCritterTrainViewDetail:onInitView()
	self._gotrainingdetail = gohelper.findChild(self.viewGO, "bottom/#go_trainingdetail")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterTrainViewDetail:addEvents()
	self._btntrainevent:AddClickListener(self._btntraineventOnClick, self)
end

function RoomCritterTrainViewDetail:removeEvents()
	self._btntrainevent:RemoveClickListener()
end

function RoomCritterTrainViewDetail:_btntrainfinishOnClick()
	if self._slotMO then
		if self._slotMO and self._slotMO.trainInfo then
			if self._slotMO.trainInfo:isFinishAllEvent() then
				RoomCritterController.instance:sendFinishTrainCritter(self._slotMO.id)
			else
				RoomCritterController.instance:openTrainEventView(self._slotMO.id)
			end
		end
	end
end

function RoomCritterTrainViewDetail:_btntraineventOnClick()
	if self:_isHasEventTrigger() then
		RoomCritterController.instance:openTrainEventView(self._critterMO.id)
	end
end

function RoomCritterTrainViewDetail:_editableInitView()
	local go = self:getResInst(RoomCritterTrainDetailItem.prefabPath, self._gotrainingdetail)

	self.detailItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomCritterTrainDetailItem, self)
	self._gomapui = gohelper.findChild(self.viewGO, "#go_mapui")
	self._goeventicon = gohelper.findChild(self.viewGO, "#go_mapui/go_eventicon")
	self._btntrainevent = gohelper.findChildButtonWithAudio(self.viewGO, "#go_mapui/go_eventicon/btn_trainevent")
	self._goeventiconTrs = self._goeventicon.transform
	self._gomapuiTrs = self._gomapui.transform
end

function RoomCritterTrainViewDetail:onUpdateParam()
	return
end

function RoomCritterTrainViewDetail:onOpen()
	self._scene = RoomCameraController.instance:getRoomScene()

	self.addEventCb(self, CritterController.instance, CritterEvent.TrainStartTrainCritterReply, self._onTrainStartTrainCritterReply, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterInfoPushUpdate, self._onCritterInfoChanged, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.TrainSelectEventOptionReply, self._onTrainSelectEventOptionReply, self)

	if self.viewContainer then
		self.addEventCb(self, self.viewContainer, CritterEvent.UITrainSelectSlot, self._onSelectSlotItem, self)
		self.addEventCb(self, self.viewContainer, CritterEvent.UITrainCdTime, self._opTranCdTimeUpdate, self)
	end

	self.addEventCb(self, RoomMapController.instance, RoomEvent.CameraTransformUpdate, self._refreshPosition, self)
	self.detailItem:setCritterChanageCallback(self._critterChangeCallblck, self)
end

function RoomCritterTrainViewDetail:onClose()
	return
end

function RoomCritterTrainViewDetail:onDestroyView()
	self.detailItem:onDestroy()
	TaskDispatcher.cancelTask(self._playLevelUp, self)

	self._specialEventIds = nil
end

function RoomCritterTrainViewDetail:_critterChangeCallblck()
	self.viewContainer:dispatchEvent(CritterEvent.UIChangeTrainCritter, self._slotMO)
end

function RoomCritterTrainViewDetail:_onSelectSlotItem(mo)
	self._slotMO = mo
	self._critterMO = mo.critterMO
	self._critterUid = self._critterMO and self._critterMO.id

	self.detailItem:onUpdateMO(mo.critterMO)
	self:_refreshUI()
end

function RoomCritterTrainViewDetail:_opTranCdTimeUpdate()
	if not self._specialEventIds or #self._specialEventIds < 1 then
		self.detailItem:tranCdTimeUpdate()
	end

	self:_refreshUI()
end

function RoomCritterTrainViewDetail:_refreshUI()
	local isHas = self:_isHasEventTrigger()

	if self._isLastHasTrigger ~= isHas then
		self._isLastHasTrigger = isHas

		gohelper.setActive(self._goeventicon, isHas)
		self:_refreshPosition()
	end
end

function RoomCritterTrainViewDetail:_onTrainStartTrainCritterReply(critterUid, heroId)
	self.detailItem:refreshUI()
end

function RoomCritterTrainViewDetail:_onTrainSelectEventOptionReply(critterUid, eventId, option)
	local eventCfg = CritterConfig.instance:getCritterTrainEventCfg(eventId)

	if eventCfg and eventCfg.type == CritterEnum.EventType.Special then
		self._specialEventIds = self._specialEventIds or {}

		if #self._specialEventIds < 1 then
			TaskDispatcher.runDelay(self._playLevelUp, self, 0.1)
		end

		table.insert(self._specialEventIds, eventId)
	end
end

function RoomCritterTrainViewDetail:_onCritterInfoChanged()
	self._critterMO = CritterModel.instance:getCritterMOByUid(self._critterUid)

	self.detailItem:onUpdateMO(self._critterMO)
end

function RoomCritterTrainViewDetail:_isHasEventTrigger()
	if self._critterMO and self._critterMO.trainInfo:isHasEventTrigger() then
		return true
	end

	return false
end

function RoomCritterTrainViewDetail:_playLevelUp()
	local eventIds = self._specialEventIds

	self._specialEventIds = nil

	local critterMO = self._critterMO

	if eventIds and critterMO and critterMO:isCultivating() then
		local addAttributeMOs = {}
		local eventMOList = critterMO.trainInfo.events

		for i = 1, #eventMOList do
			local eventMO = eventMOList[i]

			if tabletool.indexOf(eventIds, eventMO.eventId) then
				tabletool.addValues(addAttributeMOs, eventMO.addAttributes)
			end
		end

		ViewMgr.instance:openView(ViewName.RoomCritterTrainEventResultView, {
			critterMO = critterMO,
			addAttributeMOs = addAttributeMOs
		})
	end
end

function RoomCritterTrainViewDetail:_refreshPosition()
	if not self._isLastHasTrigger then
		return
	end

	local critterEntity = self:_getCritterEntity()

	if not critterEntity then
		return
	end

	local trs = critterEntity.critterspine:getMountheadGOTrs() or critterEntity.goTrs

	if not trs then
		return
	end

	local px, py, pz = transformhelper.getPos(trs)
	local bendingPos = RoomBendingHelper.worldToBendingSimple(Vector3(px, py, pz))
	local anchorPos = RoomBendingHelper.worldPosToAnchorPos(bendingPos, self._gomapuiTrs)

	if anchorPos then
		recthelper.setAnchor(self._goeventiconTrs, anchorPos.x, anchorPos.y)
	end
end

function RoomCritterTrainViewDetail:_getCritterEntity()
	if not self._scene then
		return nil
	end

	if self._scene.cameraFollow:isFollowing() then
		return self._scene.crittermgr:getCritterEntity(self._critterUid, SceneTag.RoomCharacter)
	end

	return self._scene.crittermgr:getTempCritterEntity()
end

return RoomCritterTrainViewDetail
