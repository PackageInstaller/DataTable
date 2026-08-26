-- chunkname: @modules/logic/room/view/critter/RoomCritterPlaceView.lua

module("modules.logic.room.view.critter.RoomCritterPlaceView", package.seeall)

local RoomCritterPlaceView = class("RoomCritterPlaceView", BaseView)

function RoomCritterPlaceView:onInitView()
	self._gocritterview1 = gohelper.findChild(self.viewGO, "#go_critterview1")
	self._btnunfold = gohelper.findChildButtonWithAudio(self.viewGO, "#go_critterview1/critterscroll/#btn_unfold")
	self._gocritterview2 = gohelper.findChild(self.viewGO, "#go_critterview2")
	self._btnfold = gohelper.findChildButtonWithAudio(self.viewGO, "#go_critterview2/critterscroll/#btn_fold")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterPlaceView:addEvents()
	self._btnunfold:AddClickListener(self._btnunfoldOnClick, self)
	self._btnfold:AddClickListener(self._btnfoldOnClick, self, true)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterListOnDragBeginListener, self._onListDragBeginListener, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterListOnDragListener, self._onListDragListener, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterListOnDragEndListener, self._onListDragEndListener, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, self._onRestingCritterChange, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingViewChangeBuilding, self._onChangeRestBuilding, self)
end

function RoomCritterPlaceView:removeEvents()
	self._btnunfold:RemoveClickListener()
	self._btnfold:RemoveClickListener()
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterListOnDragBeginListener, self._onListDragBeginListener, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterListOnDragListener, self._onListDragListener, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterListOnDragEndListener, self._onListDragEndListener, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterBuildingChangeRestingCritter, self._onRestingCritterChange, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterBuildingViewChangeBuilding, self._onChangeRestBuilding, self)
end

function RoomCritterPlaceView:_btnunfoldOnClick()
	self._isFold = false
	self._canvasGroup1.blocksRaycasts = false
	self._canvasGroup2.blocksRaycasts = true
	self._critterView1.scrollCritter.horizontalNormalizedPosition = 0
	self._critterView2.scrollCritter.verticalNormalizedPosition = 1

	self:playAnim("switchup")

	local curBuildingUid = self:getViewBuilding()

	RoomCritterPlaceListModel.instance:setCritterPlaceList(curBuildingUid)

	self._scrollRect = self._critterView2.scrollCritter.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))

	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingSetCanOperateRestingCritter, false)
end

function RoomCritterPlaceView:_btnfoldOnClick(playAnim)
	self._isFold = true
	self._canvasGroup1.blocksRaycasts = true
	self._canvasGroup2.blocksRaycasts = false
	self._critterView1.scrollCritter.horizontalNormalizedPosition = 0
	self._critterView2.scrollCritter.verticalNormalizedPosition = 1

	if playAnim then
		self:playAnim("switchdown")
	end

	local curBuildingUid = self:getViewBuilding()

	RoomCritterPlaceListModel.instance:setCritterPlaceList(curBuildingUid)

	self._scrollRect = self._critterView1.scrollCritter.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))

	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingSetCanOperateRestingCritter, true)
end

function RoomCritterPlaceView:_btnsortOnClick(sortItem)
	local order = RoomCritterPlaceListModel.instance:getOrder()
	local curBuildingUid = self:getViewBuilding()

	RoomCritterPlaceListModel.instance:setOrder((order == sortItem.orderDown or nil) and sortItem.orderUp)
	RoomCritterPlaceListModel.instance:setCritterPlaceList(curBuildingUid)
	self:refreshSort()
end

function RoomCritterPlaceView:_onListDragBeginListener(pointerEventData)
	self._scrollRect:OnBeginDrag(pointerEventData)
end

function RoomCritterPlaceView:_onListDragListener(pointerEventData)
	self._scrollRect:OnDrag(pointerEventData)
end

function RoomCritterPlaceView:_onListDragEndListener(pointerEventData)
	self._scrollRect:OnEndDrag(pointerEventData)
end

function RoomCritterPlaceView:_onRestingCritterChange()
	local curBuildingUid = self:getViewBuilding()

	RoomCritterPlaceListModel.instance:setCritterPlaceList(curBuildingUid)
end

function RoomCritterPlaceView:_onChangeRestBuilding(newBuildingUid)
	if not newBuildingUid then
		return
	end

	self.viewContainer:setContainerViewBuildingUid(newBuildingUid)
	self:playAnim(UIAnimationName.Close)
	TaskDispatcher.cancelTask(self._changeFinish, self)
	TaskDispatcher.runDelay(self._changeFinish, self, CritterEnum.CritterBuildingChangeBuildingAnimTime)
end

function RoomCritterPlaceView:_changeFinish()
	local curBuildingUid = self:getViewBuilding()

	RoomCritterPlaceListModel.instance:setCritterPlaceList(curBuildingUid)
	self:playAnim(UIAnimationName.Open)
end

function RoomCritterPlaceView:_editableInitView()
	self._canvasGroup1 = self._gocritterview1:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._canvasGroup2 = self._gocritterview2:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._critterView1 = self:getUserDataTb_()
	self._critterView2 = self:getUserDataTb_()

	self:initCritterView(self._critterView1, self._gocritterview1, 1)
	self:initCritterView(self._critterView2, self._gocritterview2, 2)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function RoomCritterPlaceView:initCritterView(critterView, goCritterView, index)
	critterView.scrollCritter = gohelper.findChildScrollRect(goCritterView, "critterscroll")
	critterView.gomood = gohelper.findChild(goCritterView, "crittersort/leftbtn/#btn_moodrank")
	critterView.gorare = gohelper.findChild(goCritterView, "crittersort/leftbtn/#btn_rarerank")
	critterView.sortMoodItem = self:getUserDataTb_()
	critterView.sortRareItem = self:getUserDataTb_()

	self:_initSortItem(critterView.sortMoodItem, critterView.gomood, CritterEnum.OrderType.MoodUp, CritterEnum.OrderType.MoodDown)
	self:_initSortItem(critterView.sortRareItem, critterView.gorare, CritterEnum.OrderType.RareUp, CritterEnum.OrderType.RareDown)
end

function RoomCritterPlaceView:_initSortItem(sortItem, go, orderUp, orderDown)
	sortItem.btnsort = gohelper.findChildButtonWithAudio(go, "")
	sortItem.go1 = gohelper.findChild(go, "btn1")
	sortItem.go2 = gohelper.findChild(go, "btn2")
	sortItem.goarrow = gohelper.findChild(go, "btn2/arrow")
	sortItem.orderUp = orderUp
	sortItem.orderDown = orderDown

	sortItem.btnsort:AddClickListener(self._btnsortOnClick, self, sortItem)
end

function RoomCritterPlaceView:onUpdateParam()
	return
end

function RoomCritterPlaceView:onOpen()
	self:_btnfoldOnClick()
	self:refreshSort()
end

function RoomCritterPlaceView:refreshSort()
	self:_refreshSortItemSort(self._critterView1.sortMoodItem)
	self:_refreshSortItemSort(self._critterView1.sortRareItem)
	self:_refreshSortItemSort(self._critterView2.sortMoodItem)
	self:_refreshSortItemSort(self._critterView2.sortRareItem)
end

function RoomCritterPlaceView:_refreshSortItemSort(sortItem)
	local order = RoomCritterPlaceListModel.instance:getOrder()

	self:_setSort(sortItem, order == sortItem.orderUp or order == sortItem.orderDown, order == sortItem.orderUp)
end

function RoomCritterPlaceView:_setSort(sortItem, select, reverse)
	if select then
		gohelper.setActive(sortItem.go1, false)
		gohelper.setActive(sortItem.go2, true)
		self:_setReverse(sortItem.goarrow.transform, reverse)
	else
		gohelper.setActive(sortItem.go1, true)
		gohelper.setActive(sortItem.go2, false)
	end
end

function RoomCritterPlaceView:_setReverse(transform, reverse)
	local scaleX, scaleY, scaleZ = transformhelper.getLocalScale(transform)

	if reverse then
		transformhelper.setLocalScale(transform, scaleX, -math.abs(scaleY), scaleZ)
	else
		transformhelper.setLocalScale(transform, scaleX, math.abs(scaleY), scaleZ)
	end
end

function RoomCritterPlaceView:playAnim(animName)
	self._animator.enabled = true

	self._animator:Play(animName)
end

function RoomCritterPlaceView:getViewBuilding()
	local viewBuildingUid, viewBuildingMO = self.viewContainer:getContainerViewBuilding(true)

	return viewBuildingUid, viewBuildingMO
end

function RoomCritterPlaceView:onClose()
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingShowView)
	RoomCritterPlaceListModel.instance:clearData()
	TaskDispatcher.cancelTask(self._changeFinish, self)
end

function RoomCritterPlaceView:onDestroyView()
	self:_critterViewOnDestroy(self._critterView1)
	self:_critterViewOnDestroy(self._critterView2)
end

function RoomCritterPlaceView:_critterViewOnDestroy(critterView)
	self:_sortItemOnDestroy(critterView.sortMoodItem)
	self:_sortItemOnDestroy(critterView.sortRareItem)
end

function RoomCritterPlaceView:_sortItemOnDestroy(sortItem)
	sortItem.btnsort:RemoveClickListener()
end

return RoomCritterPlaceView
