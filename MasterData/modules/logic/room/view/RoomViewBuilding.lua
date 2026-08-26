-- chunkname: @modules/logic/room/view/RoomViewBuilding.lua

module("modules.logic.room.view.RoomViewBuilding", package.seeall)

local RoomViewBuilding = class("RoomViewBuilding", BaseView)

function RoomViewBuilding:onInitView()
	self._goemptybuiling = gohelper.findChild(self.viewGO, "go_building/#go_emptybuilding")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomViewBuilding:addEvents()
	return
end

function RoomViewBuilding:removeEvents()
	return
end

function RoomViewBuilding:_btnbackOnClick()
	RoomBuildingController.instance:setBuildingListShow(false)
	RoomMapController.instance:switchBackBlock(true)
end

function RoomViewBuilding:_btnresetOnClick()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomReset, MsgBoxEnum.BoxType.Yes_No, function()
			RoomMapController.instance:resetRoom()
		end)
	end
end

function RoomViewBuilding:_editableInitView()
	self._gobuilding = gohelper.findChild(self.viewGO, "go_building")
	self._gofilterswitch = gohelper.findChild(self.viewGO, "go_building/filterswitch")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "go_building/filterswitch/btn_filter")
	self._scrollbuilding = gohelper.findChildScrollRect(self.viewGO, "go_building/scroll_building")
	self._scrollView = gohelper.findChildComponent(self.viewGO, "go_building/scroll_building", gohelper.Type_ScrollRect)
	self._rectMaskComp = gohelper.findChildComponent(self.viewGO, "go_building/scroll_building/viewport", typeof(UnityEngine.UI.RectMask2D))
	self._goscrollContent = gohelper.findChild(self.viewGO, "go_building/scroll_building/viewport/content")
	self._gorescontent = gohelper.findChild(self.viewGO, "go_building/filterswitch/rescontent")
	self._gototalitem = gohelper.findChild(self.viewGO, "go_building/filterswitch/rescontent/totalitem")
	self._goresitem = gohelper.findChild(self.viewGO, "go_building/filterswitch/rescontent/resitem")
	self._btntheme = gohelper.findChildButtonWithAudio(self.viewGO, "go_building/btn_theme")
	self._gothemeSelect = gohelper.findChild(self.viewGO, "go_building/btn_theme/go_select")
	self._gothemeUnSelect = gohelper.findChild(self.viewGO, "go_building/btn_theme/go_unselect")
	self._gofilterSelect = gohelper.findChild(self.viewGO, "go_building/filterswitch/btn_filter/go_select")
	self._gofilterUnSelect = gohelper.findChild(self.viewGO, "go_building/filterswitch/btn_filter/go_unselect")
	self._gofilter = self._btnfilter.gameObject
	self._scrollViewTransform = self._scrollView.transform
	self._scrollContentTransform = self._goscrollContent.transform

	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
	self._btntheme:AddClickListener(self._btnthemeOnClick, self)
	gohelper.setActive(self._goresitem, false)
	gohelper.setActive(self._gototalitem, false)

	local rType = RoomBuildingEnum.BuildingListViewResTabType
	local bType = RoomBuildingEnum.BuildingType

	self._resDataList = {
		[rType.All] = {
			nameLanguage = "room_building_type_name_all_txt",
			buildingTypes = {}
		},
		[rType.Adornment] = {
			nameLanguage = "room_building_type_name_decoration_txt",
			buildingTypes = {
				bType.Decoration
			}
		},
		[rType.Produce] = {
			nameLanguage = "room_building_type_name_manufacture_txt",
			buildingTypes = {
				bType.Collect,
				bType.Process,
				bType.Manufacture,
				bType.Trade,
				bType.Rest
			}
		},
		[rType.Play] = {
			nameLanguage = "room_building_type_name_interact_txt",
			buildingTypes = {
				bType.Interact
			}
		}
	}

	self:_initResList()

	self._isShowBuilding = false
	self._isHasBuilding = nil

	gohelper.setActive(self._gobuilding, false)

	self._scene = GameSceneMgr.instance:getCurScene()
	self._animator = self._gobuilding:GetComponent(typeof(UnityEngine.Animator))

	if self.viewParam then
		local defaultResType = self.viewParam.defaultBuildingResType

		if not defaultResType or defaultResType <= 0 or defaultResType > #self._resDataList then
			defaultResType = rType.All
		end

		self:_setSelectResData(self._resDataList[defaultResType])
	end
end

function RoomViewBuilding:_btnstoreOnClick()
	RoomInventorySelectView.tryConfirmAndToStore()
end

function RoomViewBuilding:_initResList()
	self._resItemList = self._resItemList or {}

	for i = #self._resItemList + 1, #self._resDataList do
		local goItem = self._gototalitem
		local cloneGo = gohelper.clone(goItem, self._gorescontent, "btn_resItem" .. i)

		gohelper.setActive(cloneGo, true)
		gohelper.addUIClickAudio(cloneGo, AudioEnum.UI.play_ui_role_open)

		local resItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, RoomViewBuildingResItem, self)

		resItem:setCallback(self._onResItemOnClick, self)
		table.insert(self._resItemList, resItem)
	end

	for i = 1, #self._resDataList do
		local resItem = self._resItemList[i]

		gohelper.setActive(resItem:getGO(), true)
		resItem:setData(self._resDataList[i])
		resItem:setSelect(self._curSelectResData == self._resDataList[i])
		resItem:setLineActive(i > 1)
	end

	for i = #self._resDataList + 1, #self._resItemList do
		gohelper.setActive(self._resItemList[i]:getGO(), false)
	end
end

function RoomViewBuilding:_getHasBuildingResIds()
	local resIds = {}
	local resConfigList = lua_block_resource.configList

	for i, resConfig in ipairs(resConfigList) do
		if resConfig.buildingFilter == 1 then
			table.insert(resIds, resConfig.id)
		end
	end

	if #resIds > 1 then
		table.sort(resIds, function(a, b)
			if a ~= b then
				return a < b
			end
		end)
	end

	return resIds
end

function RoomViewBuilding:_updateResList()
	self:_initResList()

	if not tabletool.indexOf(self._resDataList, self._curSelectResData) then
		self:_setSelectResData(self._resDataList[RoomBuildingEnum.BuildingListViewResTabType.All])
	end
end

function RoomViewBuilding:_refreshFilterUI()
	local buildingInfoList = RoomModel.instance:getBuildingInfoList()
	local isHasBuilding = buildingInfoList and #buildingInfoList > 0 or false

	if self._lastHasBuilding ~= isHasBuilding then
		gohelper.setActive(self._gofilterswitch, isHasBuilding)
		gohelper.setActive(self._gofilter, isHasBuilding)
		gohelper.setActive(self._btntheme, isHasBuilding)
	end

	self:_refreshFilterState()
end

function RoomViewBuilding:_onResItemOnClick(resData)
	if self._curSelectResData == resData then
		return
	end

	self:_setSelectResData(resData)
end

function RoomViewBuilding:_setSelectResData(resData)
	self._curSelectResData = resData

	for i = 1, #self._resItemList do
		local resItem = self._resItemList[i]

		resItem:setSelect(resData == resItem:getData())
	end

	if resData then
		RoomShowBuildingListModel.instance:setFilterType(resData.buildingTypes)
	else
		RoomShowBuildingListModel.instance:setFilterType({})
	end

	RoomShowBuildingListModel.instance:setShowBuildingList()

	self._scrollbuilding.horizontalNormalizedPosition = 0
end

function RoomViewBuilding:_btnfilterOnClick()
	ViewMgr.instance:openView(ViewName.RoomBuildingFilterView)
end

function RoomViewBuilding:_btnthemeOnClick()
	RoomController.instance:openThemeFilterView(true)
end

function RoomViewBuilding:_btncloseOnClick()
	RoomBuildingController.instance:setBuildingListShow(false)
end

function RoomViewBuilding:_btnconfirmOnClick()
	RoomInventorySelectView.confirmYesCallback()
end

function RoomViewBuilding:_refreshUI()
	if not RoomController.instance:isObMode() then
		return
	end
end

function RoomViewBuilding:_buildingListViewShowChanged(isShowBuilding)
	local changed = self._isShowBuilding ~= isShowBuilding

	self._isShowBuilding = isShowBuilding

	RoomShowBuildingListModel.instance:clearSelect()

	if changed then
		TaskDispatcher.cancelTask(self._delayOpenOrClose, self)
		TaskDispatcher.runDelay(self._delayOpenOrClose, self, 0.13333333333333333)

		if not isShowBuilding then
			self._animator:Play("close", 0, 0)
		end
	end

	if not isShowBuilding then
		ViewMgr.instance:closeView(ViewName.RoomBuildingFilterView)
	end

	if isShowBuilding then
		RoomShowBuildingListModel.instance:setShowBuildingList()

		self._scrollbuilding.horizontalNormalizedPosition = 0

		if changed and self._buildingScrollView then
			self._buildingScrollView:playOpenAnimation()
		end
	end
end

function RoomViewBuilding:_delayOpenOrClose()
	gohelper.setActive(self._gobuilding, self._isShowBuilding)

	if self._isShowBuilding then
		self._animator:Play(UIAnimationName.Open, 0, 0)
	end
end

function RoomViewBuilding:_newBuildingPush()
	self:_updateResList()
	self:_refreshFilterUI()
	RoomShowBuildingListModel.instance:setShowBuildingList()
end

function RoomViewBuilding:_buildingFilterChanged()
	self._scrollbuilding.horizontalNormalizedPosition = 0

	self:_refreshFilterState()
end

function RoomViewBuilding:_themeFilterChanged()
	RoomShowBuildingListModel.instance:setShowBuildingList()

	self._scrollbuilding.horizontalNormalizedPosition = 0

	self:_refreshFilterState()
end

function RoomViewBuilding:_onListDataChanged()
	local hasCount = RoomShowBuildingListModel.instance:getCount() - RoomShowBuildingListModel.instance:getEmptyCount()

	gohelper.setActive(self._goemptybuiling, hasCount < 1)

	local width = recthelper.getWidth(self._scrollViewTransform)
	local width2 = recthelper.getWidth(self._scrollContentTransform)

	RoomShowBuildingListModel.instance:setItemAnchorX(0)

	if width and width2 and width2 < width then
		RoomShowBuildingListModel.instance:setItemAnchorX(width - width2)
	end

	self._rectMaskComp.padding = width - width2 > 0 and Vector4.New(0, 0, -20, 0) or Vector4.New(0, 0, 0, 0)
end

function RoomViewBuilding:_onListDragBeginListener(pointerEventData)
	self._scrollView:OnBeginDrag(pointerEventData)

	local contentWidth = recthelper.getWidth(self._scrollViewTransform)

	self._dragMinX = -contentWidth * 0.5 + 1
	self._dragMaxX = contentWidth * 0.5 - 1
end

function RoomViewBuilding:_onListDragListener(pointerEventData)
	local anchorPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._scrollViewTransform)
	local posX = anchorPos.x

	if posX > self._dragMinX and posX < self._dragMaxX then
		self._scrollView:OnDrag(pointerEventData)
	end
end

function RoomViewBuilding:_onListDragEndListener(pointerEventData)
	self._scrollView:OnEndDrag(pointerEventData)
end

function RoomViewBuilding:_addBtnAudio()
	gohelper.addUIClickAudio(self._btnfilter.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function RoomViewBuilding:onOpen()
	self:_refreshUI()
	self:_addBtnAudio()
	self:_onListDataChanged()
	self:_refreshFilterUI()
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, self._buildingListViewShowChanged, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.NewBuildingPush, self._newBuildingPush, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.BuildingLevelUpPush, self._newBuildingPush, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.BuildingFilterChanged, self._buildingFilterChanged, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.ClientPlaceBuilding, self._tweenToBuildingUid, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.BuildingListOnDataChanged, self._onListDataChanged, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.BuildingListOnDragListener, self._onListDragListener, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.BuildingListOnDragBeginListener, self._onListDragBeginListener, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.BuildingListOnDragEndListener, self._onListDragEndListener, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UIRoomThemeFilterChanged, self._themeFilterChanged, self)

	if self.viewParam and self.viewParam.defaultBuildingResType == RoomBuildingEnum.BuildingListViewResTabType.Produce then
		self.viewContainer:switch2BuildingView(true)
	end
end

function RoomViewBuilding:_refreshFilterState()
	local isOpen = RoomThemeFilterListModel.instance:getSelectCount() > 0

	if self._isLastThemeOpen ~= isOpen then
		self._isLastThemeOpen = isOpen

		gohelper.setActive(self._gothemeUnSelect, not isOpen)
		gohelper.setActive(self._gothemeSelect, isOpen)
	end

	isOpen = self:_checkFilterOpen()

	if self._isLastFilterOpen ~= isOpen then
		self._isLastFilterOpen = isOpen

		gohelper.setActive(self._gofilterUnSelect, not isOpen)
		gohelper.setActive(self._gofilterSelect, isOpen)
	end
end

function RoomViewBuilding:_checkFilterOpen()
	local tRoomShowBuildingListModel = RoomShowBuildingListModel.instance

	if not tRoomShowBuildingListModel:isFilterOccupyIdEmpty() or not tRoomShowBuildingListModel:isFilterUseEmpty() then
		return true
	end

	return false
end

function RoomViewBuilding:_tweenToBuildingUid(buildingUid)
	if self._tweenId then
		self._scene.tween:killById(self._tweenId)

		self._tweenId = nil
	end

	local list = RoomShowBuildingListModel.instance:getList()
	local index = 0

	for i, showBuildingMO in ipairs(list) do
		if showBuildingMO.id == buildingUid then
			index = i

			break
		end
	end

	if index == 0 then
		return
	end

	local contentWidth = recthelper.getWidth(self._scrollbuilding.content)
	local viewportWidth = recthelper.getWidth(self._scrollbuilding.gameObject.transform)
	local itemWidth = math.floor(self:getBuildingItemWidth())
	local itemSpaceH = math.floor(self:getBuildingItemSpaceH())
	local areaWidth = contentWidth - viewportWidth
	local pos = (index - 0.5) * itemWidth - 0.5 * viewportWidth + math.max(0, index - 1) * itemSpaceH
	local normalizedPos = pos / areaWidth
	local normalizedArea = 0.5 * (viewportWidth - itemWidth - itemSpaceH) / areaWidth
	local leftNormalizedPos = normalizedPos - normalizedArea
	local rightNormalizedPos = normalizedPos + normalizedArea
	local currentNormalizedPos = self._scrollbuilding.horizontalNormalizedPosition

	if leftNormalizedPos <= currentNormalizedPos and currentNormalizedPos <= rightNormalizedPos then
		return
	elseif currentNormalizedPos < leftNormalizedPos then
		normalizedPos = leftNormalizedPos
	elseif rightNormalizedPos < currentNormalizedPos then
		normalizedPos = rightNormalizedPos
	end

	normalizedPos = Mathf.Clamp(normalizedPos, 0, 1)
	self._tweenId = self._scene.tween:tweenFloat(currentNormalizedPos, normalizedPos, 0.2, self._tweenFrameCallback, self._tweenFinishCallback, self, normalizedPos)
end

function RoomViewBuilding:_tweenFrameCallback(value, param)
	self._scrollbuilding.horizontalNormalizedPosition = value
end

function RoomViewBuilding:_tweenFinishCallback(param)
	self._scrollbuilding.horizontalNormalizedPosition = param
end

function RoomViewBuilding:onClose()
	TaskDispatcher.cancelTask(self._delayOpenOrClose, self)

	if self._tweenId then
		self._scene.tween:killById(self._tweenId)

		self._tweenId = nil
	end
end

function RoomViewBuilding:onDestroyView()
	self._btnfilter:RemoveClickListener()
	self._scrollbuilding:RemoveOnValueChanged()
	self._btntheme:RemoveClickListener()
end

function RoomViewBuilding:getBuildingListView()
	if self._buildingScrollView then
		return self._buildingScrollView
	end

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "go_building/scroll_building"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "go_building/roombuildingitem"
	scrollParam.cellClass = RoomBuildingItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = self:getBuildingItemWidth()
	scrollParam.cellHeight = 234
	scrollParam.cellSpaceH = self:getBuildingItemSpaceH()
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	local animationDelayTimes = {}

	for i = 1, 10 do
		animationDelayTimes[i] = (i - 1) * 0.03
	end

	self._buildingScrollView = LuaListScrollViewWithAnimator.New(RoomShowBuildingListModel.instance, scrollParam, animationDelayTimes)

	return self._buildingScrollView
end

function RoomViewBuilding:getBuildingItemWidth()
	return 367.7297
end

function RoomViewBuilding:getBuildingItemSpaceH()
	return 22.5
end

RoomViewBuilding.prefabPath = "ui/viewres/room/roomviewbuilding.prefab"

return RoomViewBuilding
