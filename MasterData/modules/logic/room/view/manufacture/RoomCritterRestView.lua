-- chunkname: @modules/logic/room/view/manufacture/RoomCritterRestView.lua

module("modules.logic.room.view.manufacture.RoomCritterRestView", package.seeall)

local RoomCritterRestView = class("RoomCritterRestView", BaseView)

function RoomCritterRestView:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "content")
	self._btnoverview = gohelper.findChildButtonWithAudio(self.viewGO, "content/leftbtn/#btn_overview")
	self._goOverviewReddot = gohelper.findChild(self.viewGO, "content/leftbtn/#btn_overview/#go_reddot")
	self._btnwarehouse = gohelper.findChildButtonWithAudio(self.viewGO, "content/leftbtn/#btn_warehouse")
	self._btnhide = gohelper.findChildButtonWithAudio(self.viewGO, "content/rightbtn/#btn_hide")
	self._btnseat = gohelper.findChildButtonWithAudio(self.viewGO, "content/rightbtn/#btn_seat")
	self._btnreplaceAll = gohelper.findChildButtonWithAudio(self.viewGO, "content/quickbtn/#btn_replaceAll")
	self._btnunloadAll = gohelper.findChildButtonWithAudio(self.viewGO, "content/quickbtn/#btn_unloadAll")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "#go_arrow/#btn_left")
	self._txtleftIndex = gohelper.findChildText(self.viewGO, "#go_arrow/#btn_left/#txt_leftIndex")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "#go_arrow/#btn_right")
	self._goselectedArrow = gohelper.findChild(self.viewGO, "content/#go_select")
	self._goselectedMood = gohelper.findChild(self.viewGO, "content/#go_select/mood")
	self._txtrightIndex = gohelper.findChildText(self.viewGO, "#go_arrow/#btn_right/#txt_rightIndex")
	self._contentAnimator = gohelper.findChildComponent(self.viewGO, "content", typeof(UnityEngine.Animator))
	self._txttopName = gohelper.findChildText(self.viewGO, "content/top/tips/#txt_name")
	self._gotopmood = gohelper.findChild(self.viewGO, "content/top/tips/#txt_name/mood")
	self._gotopcrittericon = gohelper.findChild(self.viewGO, "content/top/tips/#txt_name/crittericon")
	self._goseatSlotBtnRoot = gohelper.findChild(self.viewGO, "#go_seatSlotBtns")
	self._transseatSlotBtnRoot = self._goseatSlotBtnRoot.transform
	self._goseatSlotBtn = gohelper.findChild(self.viewGO, "#go_seatSlotBtns/#btn_seatSlot")
	self._btnShowView = gohelper.findChildClickWithAudio(self.viewGO, "#btn_show")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterRestView:addEvents()
	self._btnoverview:AddClickListener(self._btnoverviewOnClick, self)
	self._btnwarehouse:AddClickListener(self._btnwarehouseOnClick, self)
	self._btnhide:AddClickListener(self._btnhideOnClick, self)
	self._btnseat:AddClickListener(self._btnseatOnClick, self)
	self._btnreplaceAll:AddClickListener(self._btnreplaceAllOnClick, self)
	self._btnunloadAll:AddClickListener(self._btnunloadAllOnClick, self)
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	self._btnShowView:AddClickListener(self._btnShowViewOnClick, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingSelectCritter, self.refreshSelectCritter, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingSetCanOperateRestingCritter, self._canOperateCritter, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingCameraTweenFinish, self.refreshSeatSlotBtns, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, self._checkSelectedCritter, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterDecomposeReply, self._checkSelectedCritter, self)
end

function RoomCritterRestView:removeEvents()
	self._btnoverview:RemoveClickListener()
	self._btnwarehouse:RemoveClickListener()
	self._btnhide:RemoveClickListener()
	self._btnseat:RemoveClickListener()
	self._btnreplaceAll:RemoveClickListener()
	self._btnunloadAll:RemoveClickListener()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self._btnShowView:RemoveClickListener()

	if self._seatSlotBtnDict then
		for _, seatSlotBtn in pairs(self._seatSlotBtnDict) do
			seatSlotBtn.click:RemoveClickListener()
			seatSlotBtn.drag:RemoveDragBeginListener()
			seatSlotBtn.drag:RemoveDragListener()
			seatSlotBtn.drag:RemoveDragEndListener()
		end
	end

	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterBuildingSelectCritter, self.refreshSelectCritter, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterBuildingSetCanOperateRestingCritter, self._canOperateCritter, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterBuildingCameraTweenFinish, self.refreshSeatSlotBtns, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, self._checkSelectedCritter, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterDecomposeReply, self._checkSelectedCritter, self)
end

function RoomCritterRestView:_btnreplaceAllOnClick()
	local buildingUid = self:getViewBuilding()

	if buildingUid then
		RoomRpc.instance:sendReplaceRestBuildingCrittersRequest(buildingUid)
	end
end

function RoomCritterRestView:_btnunloadAllOnClick()
	local buildingUid = self:getViewBuilding()

	if buildingUid then
		RoomRpc.instance:sendUnloadRestBuildingCrittersRequest(buildingUid)
	end
end

function RoomCritterRestView:_btnoverviewOnClick()
	ManufactureController.instance:openOverView(true)
end

function RoomCritterRestView:_btnwarehouseOnClick()
	ManufactureController.instance:openRoomBackpackView()
end

function RoomCritterRestView:_btnhideOnClick()
	CritterController.instance:clearSelectedCritterSeatSlot()
	self:playAnim(UIAnimationName.Close)
	gohelper.setActive(self._goShowViewBtn, true)
	self:_canOperateCritter(false)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView)
end

function RoomCritterRestView:_btnseatOnClick()
	self:playAnim("hide")

	local curBuildingUid = self:getViewBuilding()

	ManufactureController.instance:openCritterPlaceView(curBuildingUid)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView, true, true)
end

function RoomCritterRestView:_btnleftOnClick()
	local newBuildingUid
	local isFirst = self.index <= 1
	local buildingList = ManufactureModel.instance:getCritterBuildingListInOrder()

	if not isFirst and buildingList then
		local preBuildingMO = buildingList[self.index - 1]

		newBuildingUid = preBuildingMO.buildingUid

		self.viewContainer:setContainerViewBuildingUid(preBuildingMO.buildingUid)
		CritterController.instance:clearSelectedCritterSeatSlot()
	end

	self:updateBuildingIndex()
	self.refreshCamera(self, self.refreshSeatSlotBtns, self)
	self:_playSwitchBuildingAnim()
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewChangeBuilding, newBuildingUid)
end

function RoomCritterRestView:_btnrightOnClick()
	local newBuildingUid
	local buildingList = ManufactureModel.instance:getCritterBuildingListInOrder()

	if buildingList and self.index < #buildingList then
		local lastBuildingMO = buildingList[self.index + 1]

		newBuildingUid = lastBuildingMO.buildingUid

		self.viewContainer:setContainerViewBuildingUid(lastBuildingMO.buildingUid)
		CritterController.instance:clearSelectedCritterSeatSlot()
	end

	self:updateBuildingIndex()
	self.refreshCamera(self, self.refreshSeatSlotBtns, self)
	self:_playSwitchBuildingAnim()
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewChangeBuilding, newBuildingUid)
end

function RoomCritterRestView:_playSwitchBuildingAnim()
	if ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView) then
		self:refreshArrow()

		return
	end

	self:playAnim(UIAnimationName.Close)
	TaskDispatcher.cancelTask(self._switchFinish, self)
	TaskDispatcher.runDelay(self._switchFinish, self, CritterEnum.CritterBuildingChangeBuildingAnimTime)
end

function RoomCritterRestView:_switchFinish()
	self:refreshArrow()
	self:playAnim(UIAnimationName.Open)
end

function RoomCritterRestView:_btnShowViewOnClick()
	self:playAnim(UIAnimationName.Open)
	gohelper.setActive(self._goShowViewBtn, false)
	self:_canOperateCritter(true)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingShowView)
end

function RoomCritterRestView:_onClickSeatSlot(seatSlotId)
	if self._dragCritterEntity then
		return
	end

	local curBuildingUid, curBuildingMO = self:getViewBuilding()

	if not curBuildingUid or not curBuildingMO then
		return
	end

	local isOpenPlaceView = ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView)
	local allCanclick = true
	local critterUid = curBuildingMO:getRestingCritter(seatSlotId)

	if critterUid and (not isOpenPlaceView or allCanclick) then
		CritterController.instance:clickCritterInCritterBuilding(curBuildingUid, critterUid)
	else
		local seatSlotMO = curBuildingMO:getSeatSlotMO(seatSlotId)

		if seatSlotMO then
			if not isOpenPlaceView then
				self:_btnseatOnClick()
				AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
			end
		else
			ViewMgr.instance:openView(ViewName.RoomCritterRestTipsView, {
				buildingUid = curBuildingUid,
				seatSlotId = seatSlotId
			})
		end
	end
end

function RoomCritterRestView:_onDragBegin(seatSlotId, pointerEventData)
	if self._dragCritterEntity or not self._scene then
		return
	end

	local curBuildingUid, curBuildingMO = self:getViewBuilding()
	local critterUid = curBuildingMO and curBuildingMO:getRestingCritter(seatSlotId)
	local entity = self._scene.buildingcrittermgr:getCritterEntity(critterUid)

	if not entity then
		return
	end

	local buildingEntity = self._scene.buildingmgr:getBuildingEntity(curBuildingUid, SceneTag.RoomBuilding)
	local critterPointGO = buildingEntity and buildingEntity:getCritterPoint(seatSlotId)

	if gohelper.isNil(critterPointGO) then
		logError(string.format("RoomCritterRestView:_onDragBegin error, no critter point, buildingUid:%s,index:%s", curBuildingUid, seatSlotId + 1))

		return
	end

	CritterController.instance:clearSelectedCritterSeatSlot()

	self._critterPointPos = critterPointGO.transform.position
	self._dragCritterEntity = entity

	self._dragCritterEntity:tweenUp()
end

local DRAG_CRITTER_HEIGHT_OFFSET = 0.02

function RoomCritterRestView:_onDragIng(seatSlotId, pointerEventData)
	if not self._dragCritterEntity then
		return
	end

	local screenPosition = pointerEventData.position
	local ray = RoomBendingHelper.screenPosToRay(screenPosition)
	local isHit, hitInfo = UnityEngine.Physics.Raycast(ray.origin, ray.direction, nil, 10, LayerMask.GetMask("UI3D"))

	if not isHit then
		return
	end

	local posX = hitInfo.point.x
	local posY = hitInfo.point.y + DRAG_CRITTER_HEIGHT_OFFSET
	local posZ = hitInfo.point.z

	self._dragCritterEntity:setLocalPos(posX, posY, posZ)
	self.viewContainer:dispatchEvent(CritterEvent.UICritterDragIng)
end

function RoomCritterRestView:_onDragEnd(seatSlotId, pointerEventData)
	if not self._dragCritterEntity then
		return
	end

	local position = pointerEventData.position
	local clickPosX, clickPosY = recthelper.screenPosToAnchorPos2(position, self._transseatSlotBtnRoot)
	local targetSeatSlotId

	if self._seatSlotBtnDict then
		for btnSeatSlotId, seatSlotBtn in pairs(self._seatSlotBtnDict) do
			local x, y = recthelper.getAnchor(seatSlotBtn.trans)
			local halfWidth = recthelper.getWidth(seatSlotBtn.trans) / 2
			local height = recthelper.getHeight(seatSlotBtn.trans)

			if clickPosX >= x - halfWidth and clickPosX <= x + halfWidth and y <= clickPosY and clickPosY <= y + height then
				targetSeatSlotId = btnSeatSlotId
			end
		end
	end

	if targetSeatSlotId then
		local curBuildingUid = self:getViewBuilding()

		CritterController.instance:exchangeSeatSlot(curBuildingUid, seatSlotId, targetSeatSlotId)
	else
		self._scene.buildingcrittermgr:refreshAllCritterEntityPos()
	end

	self._dragCritterEntity:tweenDown()

	self._dragCritterEntity = nil
	self._critterPointPos = nil

	self.viewContainer:dispatchEvent(CritterEvent.UICritterDragEnd)
end

function RoomCritterRestView:_canOperateCritter(canOperate)
	gohelper.setActive(self._goseatSlotBtnRoot, canOperate)
	gohelper.setActive(self._goarrow, canOperate)
end

function RoomCritterRestView:_onCloseView(viewName)
	if viewName == ViewName.RoomCritterPlaceView then
		self:playAnim(UIAnimationName.Open)
		self:_canOperateCritter(true)
		self:_checkQuickbtnActive()
	end
end

function RoomCritterRestView:_onOpenView(viewName)
	self:_checkQuickbtnActive()
end

function RoomCritterRestView:_checkSelectedCritter()
	local critterUid
	local curBuildingUid, curBuildingMO = self:getViewBuilding()
	local selectedBuildingUid, critterSeatSlotId = ManufactureModel.instance:getSelectedCritterSeatSlot()

	if not ((selectedBuildingUid == curBuildingUid or nil) and curBuildingMO:getRestingCritter(critterSeatSlotId)) then
		CritterController.instance:clearSelectedCritterSeatSlot()
	end
end

function RoomCritterRestView:_editableInitView()
	self._goquickbtn = gohelper.findChild(self.viewGO, "content/quickbtn")
	self._transcontent = self._gocontent.transform
	self._transselectedArrow = self._goselectedArrow.transform
	self._gobtnLeft = self._btnleft.gameObject
	self._gobtnright = self._btnright.gameObject
	self._goShowViewBtn = self._btnShowView.gameObject
	self._scene = RoomCameraController.instance:getRoomScene()

	self:initSeatSlotBtns()
	self:refreshSeatSlotBtns()

	self._topMoodItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._gotopmood, CritterMoodItem)
	self._selectMoodItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goselectedMood, CritterMoodItem)
	self._topCritterIcon = IconMgr.instance:getCommonCritterIcon(self._gotopcrittericon)

	self._selectMoodItem:setShowMoodRestore(false)
end

function RoomCritterRestView:initSeatSlotBtns()
	local seatSlotList = {}

	for index = 1, CritterEnum.CritterMaxSeatCount do
		seatSlotList[index] = index - 1
	end

	self._seatSlotBtnDict = {}

	gohelper.CreateObjList(self, self.onSetSeatSlotBtn, seatSlotList, self._goseatSlotBtnRoot, self._goseatSlotBtn)
end

function RoomCritterRestView:onSetSeatSlotBtn(obj, data, index)
	local seatSlotBtn = self:getUserDataTb_()

	seatSlotBtn.go = obj
	seatSlotBtn.trans = obj.transform
	seatSlotBtn.seatSlotId = data
	seatSlotBtn.click = SLFramework.UGUI.UIClickListener.Get(seatSlotBtn.go)

	seatSlotBtn.click:AddClickListener(self._onClickSeatSlot, self, data)

	seatSlotBtn.drag = SLFramework.UGUI.UIDragListener.Get(seatSlotBtn.go)

	seatSlotBtn.drag:AddDragBeginListener(self._onDragBegin, self, data)
	seatSlotBtn.drag:AddDragListener(self._onDragIng, self, data)
	seatSlotBtn.drag:AddDragEndListener(self._onDragEnd, self, data)

	self._seatSlotBtnDict[data] = seatSlotBtn
end

function RoomCritterRestView:onUpdateParam()
	return
end

function RoomCritterRestView:onOpen()
	self:updateBuildingIndex()
	self:refresh(true)
	gohelper.setActive(self._goShowViewBtn, false)
	RedDotController.instance:addRedDot(self._goOverviewReddot, RedDotEnum.DotNode.OverviewEntrance)
	self:_checkQuickbtnActive()
end

function RoomCritterRestView:_checkQuickbtnActive()
	gohelper.setActive(self._goquickbtn, ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView))
end

function RoomCritterRestView:refresh(isOnOpen)
	self:refreshArrow()
	self:refreshSelectCritter(isOnOpen)
end

function RoomCritterRestView:refreshArrow()
	local isFirst = self.index <= 1

	if not isFirst then
		self._txtleftIndex.text = self.index - 1
	end

	gohelper.setActive(self._gobtnLeft, not isFirst)

	local isLast = true
	local buildingList = ManufactureModel.instance:getCritterBuildingListInOrder()

	if buildingList then
		isLast = self.index >= #buildingList
	end

	if not isLast then
		self._txtrightIndex.text = self.index + 1
	end

	gohelper.setActive(self._gobtnright, not isLast)
end

function RoomCritterRestView:refreshCamera(cb, cbObj)
	local curBuildingUid, curBuildingMO = self:getViewBuilding()

	if not curBuildingMO then
		return
	end

	local buildingId = curBuildingMO.buildingId
	local firstCamera = ManufactureConfig.instance:getBuildingCameraIdByIndex(buildingId)
	local roomCamera = RoomCameraController.instance:getRoomCamera()

	if roomCamera and firstCamera then
		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(curBuildingUid, firstCamera, cb, cbObj)
	end
end

function RoomCritterRestView:refreshSelectCritter(isOnOpen)
	local curBuildingUid, curBuildingMO = self:getViewBuilding()
	local critterMO
	local selectedBuildingUid, critterSeatSlotId = ManufactureModel.instance:getSelectedCritterSeatSlot()
	local critterUid = curBuildingMO:getRestingCritter(critterSeatSlotId)

	if selectedBuildingUid == curBuildingUid then
		critterMO = CritterModel.instance:getCritterMOByUid(critterUid)
	end

	if critterMO then
		local critterId = critterMO:getDefineId()

		self._txttopName.text = critterMO:getName()

		self._topCritterIcon:onUpdateMO(critterMO)
		self._topMoodItem:setCritterUid(critterUid)
		self._selectMoodItem:setCritterUid(critterUid)
		self:refreshSelectArrow(critterSeatSlotId)
		self:refreshCritterFood(critterId)
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_value)
	end

	gohelper.setActive(self._gotop, critterMO)

	if isOnOpen then
		self._contentAnimator:Play(UIAnimationName.Close, 0, 1)
	else
		self._contentAnimator:Play((critterMO or nil) and (UIAnimationName.Open or UIAnimationName.Close))

		if critterMO and not ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView) then
			self:_btnseatOnClick()
		end
	end
end

function RoomCritterRestView:refreshSelectArrow(seatSlotId)
	local _, curBuildingMO = self:getViewBuilding()

	if not self._scene or not curBuildingMO then
		return
	end

	local critterUid = curBuildingMO:getRestingCritter(seatSlotId)
	local entity = self._scene.buildingcrittermgr:getCritterEntity(critterUid)

	if entity then
		::label_33_0::

		local critterPointTrans = entity.critterspine:getMountheadGOTrs()

		if gohelper.isNil(critterPointTrans) then
			return
		end

		local position = critterPointTrans.position
		local bendingPos = RoomBendingHelper.worldToBendingSimple(position)
		local anchorPos = RoomBendingHelper.worldPosToAnchorPos(bendingPos, self._transcontent)

		if anchorPos then
			recthelper.setAnchor(self._transselectedArrow, anchorPos.x, anchorPos.y)
		end
	end
end

function RoomCritterRestView:refreshCritterFood(critterId)
	RoomCritterFoodListModel.instance:setCritterFoodList(critterId)
end

local OFFSET_Y = -15

function RoomCritterRestView:refreshSeatSlotBtns()
	if not self._seatSlotBtnDict or not self._scene then
		return
	end

	local curBuildingUid = self:getViewBuilding()
	local buildingEntity = self._scene.buildingmgr:getBuildingEntity(curBuildingUid, SceneTag.RoomBuilding)

	for seatSlotId, seatSlotBtn in pairs(self._seatSlotBtnDict) do
		local critterPointGO = buildingEntity and buildingEntity:getCritterPoint(seatSlotId)

		if not gohelper.isNil(critterPointGO) then
			local position = critterPointGO.transform.position
			local bendingPos = RoomBendingHelper.worldToBendingSimple(position)
			local anchorPos = RoomBendingHelper.worldPosToAnchorPos(bendingPos, self._transseatSlotBtnRoot)

			if anchorPos then
				recthelper.setAnchor(seatSlotBtn.trans, anchorPos.x, anchorPos.y + OFFSET_Y)
			end
		else
			logError(string.format("RoomCritterRestView:refreshSeatSlotBtns error, no critter point, buildingUid:%s, index:%s", curBuildingUid, seatSlotId + 1))
		end
	end
end

function RoomCritterRestView:updateBuildingIndex()
	self.index = 0

	local buildingList = ManufactureModel.instance:getCritterBuildingListInOrder()
	local curBuildingUid = self:getViewBuilding()

	if not buildingList then
		return
	end

	for i, buildingMO in ipairs(buildingList) do
		if curBuildingUid == buildingMO.buildingUid then
			self.index = i
		end
	end
end

function RoomCritterRestView:playAnim(animName)
	self._animator.enabled = true

	self._animator:Play(animName, 0, 0)
end

function RoomCritterRestView:getViewBuilding()
	local viewBuildingUid, viewBuildingMO = self.viewContainer:getContainerViewBuilding()

	return viewBuildingUid, viewBuildingMO
end

function RoomCritterRestView:onClose()
	if self._dragCritterEntity then
		self._scene.buildingcrittermgr:refreshAllCritterEntityPos()
		self._dragCritterEntity:tweenDown()

		self._dragCritterEntity = nil
		self._critterPointPos = nil
	end

	CritterController.instance:clearSelectedCritterSeatSlot()
	TaskDispatcher.cancelTask(self._switchFinish, self)
end

function RoomCritterRestView:onDestroyView()
	return
end

return RoomCritterRestView
