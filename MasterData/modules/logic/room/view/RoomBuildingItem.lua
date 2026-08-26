-- chunkname: @modules/logic/room/view/RoomBuildingItem.lua

module("modules.logic.room.view.RoomBuildingItem", package.seeall)

local RoomBuildingItem = class("RoomBuildingItem", ListScrollCellExtend)

RoomBuildingItem.DRAG_RADIUS = 15

function RoomBuildingItem:onInitView()
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._imagerare = gohelper.findChildImage(self.viewGO, "#go_content/#image_rare")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_content/#simage_icon")
	self._txtcount = gohelper.findChildText(self.viewGO, "#go_content/#txt_count")
	self._txtbuildingname = gohelper.findChildText(self.viewGO, "#go_content/#txt_buildingname")
	self._imagearea = gohelper.findChildImage(self.viewGO, "#go_content/#image_area")
	self._gogroupres = gohelper.findChild(self.viewGO, "#go_content/#go_groupres")
	self._imageres = gohelper.findChildImage(self.viewGO, "#go_content/#go_groupres/#image_res")
	self._txtaddvalue = gohelper.findChildText(self.viewGO, "#go_content/#txt_addvalue")
	self._txtcostres = gohelper.findChildText(self.viewGO, "#go_content/#txt_costres")
	self._imagecostresicon = gohelper.findChildImage(self.viewGO, "#go_content/#txt_costres/#image_costresicon")
	self._buildingusedesc = gohelper.findChildText(self.viewGO, "#go_content/#txt_buildingusedesc")
	self._imagebuildingtype = gohelper.findChildImage(self.viewGO, "#go_content/#image_buildingtype")
	self._txtcritternum = gohelper.findChildText(self.viewGO, "#go_content/#txt_critternum")
	self._simagebuilddegree = gohelper.findChildImage(self.viewGO, "#go_content/#txt_addvalue/#simage_builddegree")
	self._gobeplaced = gohelper.findChild(self.viewGO, "#go_content/#go_beplaced")
	self._goselect = gohelper.findChild(self.viewGO, "#go_content/#go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/#btn_click")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_content/#go_reddot")
	self._govehicle = gohelper.findChild(self.viewGO, "#go_content/#go_vehicle")
	self._goneed2buy = gohelper.findChild(self.viewGO, "#go_content/#go_need2buy")
	self._gocostitem = gohelper.findChild(self.viewGO, "#go_content/#go_need2buy/go_costcontent/#go_costitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomBuildingItem:addEvents()
	return
end

function RoomBuildingItem:removeEvents()
	return
end

function RoomBuildingItem:addEventListeners()
	self._btnUIlongPrees:SetLongPressTime(self._longPressArr)
	self._btnUIlongPrees:AddLongPressListener(self._onbtnlongPrees, self)
	self._btnUIclick:AddClickListener(self._btnclickOnClick, self)

	if self._btnUIdrag then
		self._btnUIdrag:AddDragBeginListener(self._onDragBegin, self)
		self._btnUIdrag:AddDragListener(self._onDragIng, self)
		self._btnUIdrag:AddDragEndListener(self._onDragEnd, self)
	end
end

function RoomBuildingItem:removeEventListeners()
	self._btnUIlongPrees:RemoveLongPressListener()
	self._btnUIclick:RemoveClickListener()

	if self._btnUIdrag then
		self._btnUIdrag:RemoveDragBeginListener()
		self._btnUIdrag:RemoveDragListener()
		self._btnUIdrag:RemoveDragEndListener()
	end
end

function RoomBuildingItem:_btnclickOnClick()
	if self._scene.camera:isTweening() or self:_cancelTouch() then
		return
	end

	self:_hideReddot()

	local uid = self._mo.uids[1]

	if RoomHelper.isFSMState(RoomEnum.FSMObState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) or RoomHelper.isFSMState(RoomEnum.FSMEditState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm) then
		local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

		if tempBuildingMO and tempBuildingMO.id == uid then
			self._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, {
				focus = true,
				buildingUid = uid
			})

			return
		end

		if self._mo.use then
			if uid then
				::label_6_0::

				local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(uid)

				self._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, {
					buildingUid = uid,
					hexPoint = buildingMO.hexPoint,
					rotate = buildingMO.rotate
				})
				self:_playPlaceAudio(buildingMO)
			end
		else
			local nearRotate = self._scene.camera:getCameraRotate()
			local rotation = nearRotate * Mathf.Rad2Deg

			nearRotate = RoomRotateHelper.getCameraNearRotate(rotation)

			if uid then
				::label_6_1::

				local buildingMO = RoomInventoryBuildingModel.instance:getBuildingMOById(uid)
				local buildingConfig = RoomConfig.instance:getBuildingConfig(buildingMO.buildingId)

				nearRotate = nearRotate + buildingConfig.rotate

				local bestPositionParam = self:_getRecommendHexPoint(buildingMO, nearRotate)

				if bestPositionParam then
					if not bestPositionParam.hexPoint then
						local hexPoint = self:_findNearHexPoint()

						if bestPositionParam then
							if not bestPositionParam.rotate then
								local rotate = nearRotate

								if not bestPositionParam then
									local success, errorCode = RoomBuildingAreaHelper.checkBuildingArea(buildingMO.buildingId, hexPoint, rotate)

									if errorCode == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.NoAreaMainBuilding then
										GameFacade.showToast(ToastEnum.NoAreaMainBuilding)
									elseif errorCode == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.OutSizeAreaBuilding then
										GameFacade.showToast(ToastEnum.OutSizeAreaBuilding)
									else
										GameFacade.showToast(ToastEnum.RoomBuilding)
									end
								end

								local param = {
									buildingUid = uid,
									hexPoint = hexPoint,
									rotate = rotate
								}

								TaskDispatcher.runDelay(function()
									local scene = GameSceneMgr.instance:getCurScene()

									scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, param)
								end, self, 0.05)
								self:_playPlaceAudio(buildingMO)
							end
						end
					end
				end
			end
		end
	end

	RoomShowBuildingListModel.instance:setSelect(self._mo.id)
end

function RoomBuildingItem:_playPlaceAudio(buildingMO)
	if buildingMO then
		local placeAudio = buildingMO:getPlaceAudioId(true)

		if placeAudio ~= 0 then
			AudioMgr.instance:trigger(placeAudio)
		end
	end
end

function RoomBuildingItem:_findNearHexPoint()
	local vector2 = self._scene.camera:getCameraFocus()
	local hexPoint = HexMath.positionToRoundHex(vector2, RoomBlockEnum.BlockSize)

	return RoomBuildingHelper.findNearBlockHexPoint(hexPoint, self._mo.id) or hexPoint
end

function RoomBuildingItem:_getRecommendHexPoint(buildingMO, nearRotate)
	local config = buildingMO.config
	local bestPositionParam

	return (config.vehicleType ~= 0 or nil) and self:_getVehicleHexPoint(buildingMO, nearRotate) or RoomBuildingHelper.getRecommendHexPoint(buildingMO.buildingId, nil, nil, buildingMO.levels, nearRotate)
end

function RoomBuildingItem:_getVehicleHexPoint(buildingMO, nearRotate)
	local config = buildingMO.config
	local vehicleCfg = RoomConfig.instance:getVehicleConfig(config.vehicleId)

	if not vehicleCfg then
		return nil
	end

	local resCfg = RoomConfig.instance:getResourceConfig(vehicleCfg.resId)

	if resCfg then
		if not resCfg.numLimit then
			local numLimit = 2
			local dic = RoomResourceHelper.getResourcePointAreaMODict(nil, {
				vehicleCfg.resId
			})
			local mo = dic[vehicleCfg.resId]

			if not mo then
				return nil
			end

			local areaList = mo:findeArea()
			local allResPointList = {}

			for i, resourcePointList in ipairs(areaList) do
				local num = self:_getNumByResourcePointList(resourcePointList)

				if numLimit <= num then
					tabletool.addValues(allResPointList, resourcePointList)
				end
			end

			if #allResPointList > 0 then
				return self:_getHexPointByResourcePoint(buildingMO, nearRotate, allResPointList)
			end
		end
	end
end

function RoomBuildingItem:_getNumByResourcePointList(resourcePointList)
	local tempDic = {}
	local count = 0
	local tRoomResourceModel = RoomResourceModel.instance

	for _, resourcePoint in ipairs(resourcePointList) do
		local index = tRoomResourceModel:getIndexByXY(resourcePoint.x, resourcePoint.y)

		if not tempDic[index] then
			count = count + 1
			tempDic[index] = true
		end
	end

	return count
end

function RoomBuildingItem:_getHexPointByResourcePoint(buildingMO, nearRotate, resourcePointList)
	local tempDic = {}
	local mapBlockMODict = RoomMapBlockModel.instance:getBlockMODict()

	for _, resourcePoint in ipairs(resourcePointList) do
		local x = resourcePoint.x
		local y = resourcePoint.y

		tempDic[x] = tempDic[x] or {}
		tempDic[x][y] = mapBlockMODict[x][y]
	end

	return RoomBuildingHelper.getRecommendHexPoint(buildingMO.buildingId, tempDic, nil, buildingMO.levels, nearRotate)
end

function RoomBuildingItem:_starDragBuilding()
	self._isStarDrag = true

	self._scene.touch:setUIDragScreenScroll(true)

	local uid = self._mo.uids[1]
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(uid) or RoomInventoryBuildingModel.instance:getBuildingMOById(uid)
	local var_14_0 = RoomSceneEvent.TryPlaceBuilding
	local var_14_1 = {
		press = true,
		buildingUid = uid,
		hexPoint = RoomBendingHelper.screenPosToHex(GamepadController.instance:getMousePosition())
	}

	if buildingMO then
		var_14_1.rotate = buildingMO.rotate or 0
	end

	self._scene.fsm:triggerEvent(var_14_0, var_14_1)
	RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, GamepadController.instance:getMousePosition(), uid)
	self:_hideReddot()
end

function RoomBuildingItem:_onbtnlongPrees()
	if self._scene.camera:isTweening() or not self._mo or self._mo.use then
		return
	end

	if self:_cancelTouch() then
		return
	end
end

function RoomBuildingItem:_onDragBegin(param, pointerEventData)
	self._isDragBeginOp = true
	self._dragBginePosition = pointerEventData.position

	RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingListOnDragBeginListener, pointerEventData)
end

function RoomBuildingItem:_onDragIng(param, pointerEventData)
	if not self._isDragBeginOp then
		return
	end

	if not self._isStarDrag then
		local mosuePositionY = pointerEventData.position.y
		local disValue = mosuePositionY - self._dragBginePosition.y

		if disValue > 50 and mosuePositionY > self._buildingDragStarY then
			self:_starDragBuilding()
		end
	end

	if self._isStarDrag then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, pointerEventData.position)
	else
		RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingListOnDragListener, pointerEventData)
	end
end

function RoomBuildingItem:_onDragEnd(param, pointerEventData)
	self._isDragBeginOp = false
	self._dragBginePosition = nil

	if self._isStarDrag then
		self._isStarDrag = false

		self._scene.touch:setUIDragScreenScroll(false)
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropBuilding, pointerEventData.position)
	end

	RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingListOnDragEndListener, pointerEventData)
end

function RoomBuildingItem:_cancelTouch()
	if self._dragBginePosition then
		if GamepadController.instance:isOpen() then
			return Vector2.Distance(self._dragBginePosition, GamepadController.instance:getScreenPos()) > RoomBuildingItem.DRAG_RADIUS
		else
			return Vector2.Distance(self._dragBginePosition, GamepadController.instance:getMousePosition()) > RoomBuildingItem.DRAG_RADIUS
		end
	end

	return false
end

function RoomBuildingItem:_editableInitView()
	self._longPressArr = {
		0.2,
		99999
	}
	self._buildingDragStarY = 350 * UnityEngine.Screen.height / 1080
	self._scene = GameSceneMgr.instance:getCurScene()

	UISpriteSetMgr.instance:setRoomSprite(self._simagebuilddegree, "jianshezhi")

	self._isSelect = false
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local btnclickGO = self._btnclick.gameObject

	gohelper.addUIClickAudio(btnclickGO, AudioEnum.UI.UI_Common_Click)

	self._btnUIlongPrees = SLFramework.UGUI.UILongPressListener.Get(btnclickGO)
	self._btnUIclick = SLFramework.UGUI.UIClickListener.Get(btnclickGO)
	self._btnUIdrag = SLFramework.UGUI.UIDragListener.Get(btnclickGO)

	gohelper.setActive(self._gocostitem, false)

	self._buildingTypeDefindeColor = "#FFFFFF"
	self._buildingTypeIconColor = {
		[RoomBuildingEnum.BuildingType.Collect] = "#6E9FB1",
		[RoomBuildingEnum.BuildingType.Process] = "#C6BA7B",
		[RoomBuildingEnum.BuildingType.Manufacture] = "#7BB19A"
	}
end

function RoomBuildingItem:_refreshUI()
	self._simageicon:LoadImage(ResUrl.getRoomImage("building/" .. self._mo:getIcon()))
	gohelper.setActive(self._gobeplaced, self._mo.use)

	self._txtcount.text = luaLang("multiple") .. tostring(#self._mo.uids)
	self._txtaddvalue.text = self._mo.config.buildDegree
	self._txtbuildingname.text = self._mo.config.name

	gohelper.setActive(self._txtcostres.gameObject, false)

	local areaConfig = RoomConfig.instance:getBuildingAreaConfig(self._mo.config.areaId)

	UISpriteSetMgr.instance:setRoomSprite(self._imagearea, "xiaowuliubianxing_" .. areaConfig.icon)

	if not RoomBuildingEnum.RareIcon[self._mo.config.rare] then
		UISpriteSetMgr.instance:setRoomSprite(self._imagerare, RoomBuildingEnum.RareIcon[self._mo.config.rare])
		gohelper.setActive(self._goreddot, not self._mo.use)

		if not self._mo.use then
			RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.RoomBuildingPlace, self._mo.buildingId)
		end

		if self._refresCostBuilding ~= self._mo.buildingId then
			self._refresCostBuilding = self._mo.buildingId

			self:_refreshCostResList(self._mo.buildingId)
		end

		gohelper.setActive(self._govehicle, self._mo.config.vehicleType ~= 0)
		gohelper.setActive(self._goneed2buy, self._mo.isNeedToBuy == true and self._mo.isBuyNoCost ~= true)

		if self._mo.isNeedToBuy == true and self._mo.isBuyNoCost ~= true then
			self:_refreshPlaceCost(self._mo.buildingId)
		end

		local isDet = self._mo.config.buildingType == RoomBuildingEnum.BuildingType.Decoration

		gohelper.setActive(self._txtcount, isDet)
		gohelper.setActive(self._txtaddvalue, isDet)
		gohelper.setActive(self._buildingusedesc, not isDet)
		gohelper.setActive(self._imagebuildingtype, not isDet)

		if isDet then
			gohelper.setActive(self._txtcritternum, false)
		else
			self:_refreshBuildingTypeIcon(self._mo.config)
		end
	end
end

function RoomBuildingItem:_refreshCostResList(buildingId)
	self._imageResList = self._imageResList or {
		self._imageres
	}

	local costResIds = RoomBuildingHelper.getCostResource(buildingId)

	if costResIds then
		if not #costResIds then
			local costResNum = 0

			for i = 1, costResNum do
				local imageRes = self._imageResList[i]

				if not imageRes then
					local cloneGo = gohelper.clone(self._imageres.gameObject, self._gogroupres, "imageres" .. i)

					imageRes = gohelper.onceAddComponent(cloneGo, gohelper.Type_Image)

					table.insert(self._imageResList, imageRes)
				end

				gohelper.setActive(imageRes.gameObject, true)
				UISpriteSetMgr.instance:setRoomSprite(imageRes, string.format("fanzhi_icon_%s", costResIds[i]))
			end

			for i = costResNum + 1, #self._imageResList do
				local imageRes = self._imageResList[i]

				gohelper.setActive(imageRes.gameObject, false)
			end
		end
	end
end

function RoomBuildingItem:_refreshPlaceCost(buildingId)
	if self._lastCostPlaceId == buildingId then
		return
	end

	self._lastCostPlaceId = buildingId

	local placeCfg = ManufactureConfig.instance:getManufactureBuildingCfg(buildingId)

	if placeCfg then
		self._costDataList = ItemModel.instance:getItemDataListByConfigStr(placeCfg.placeCost)
	end

	self._costDataList = self._costDataList or {}
	self._costItemList = self._costItemList or {}

	for index, costData in ipairs(self._costDataList) do
		local itemTb = self._costItemList[index]

		if not itemTb then
			itemTb = {}

			table.insert(self._costItemList, itemTb)

			local go = gohelper.cloneInPlace(self._gocostitem, "gocostitem_" .. index)

			gohelper.setActive(go, true)

			itemTb.go = go
			itemTb.txtnum = gohelper.findChildText(go, "txt_num")
			itemTb.imageicon = gohelper.findChildImage(go, "image_icon")
		else
			gohelper.setActive(itemTb.go, true)
		end

		itemTb.txtnum.text = costData.quantity

		local materilId = costData.materilId

		if costData.materilType == MaterialEnum.MaterialType.Currency then
			local currencyCfg = CurrencyConfig.instance:getCurrencyCo(materilId)

			if currencyCfg then
				materilId = currencyCfg.icon
			end
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(itemTb.imageicon, materilId .. "_1")
	end

	for i = #self._costDataList + 1, #self._costItemList do
		gohelper.setActive(self._costItemList[i].go, true)
	end
end

function RoomBuildingItem:onUpdateMO(mo)
	gohelper.setActive(self._goselect, self._isSelect)

	self._mo = mo

	local flag = mo and mo.config

	gohelper.setActive(self._gocontent, flag)

	if flag then
		self:_refreshUI()
		self:_updateAnchorX()
	end
end

function RoomBuildingItem:_updateAnchorX()
	local anchorX = RoomShowBuildingListModel.instance:getItemAnchorX()

	recthelper.setAnchorX(self._gocontent.transform, anchorX or 0)
end

function RoomBuildingItem:getAnimator()
	return self._animator
end

function RoomBuildingItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)

	self._isSelect = isSelect

	self:_updateAnchorX()
end

function RoomBuildingItem:onDestroy()
	self._simageicon:UnLoadImage()

	if self._costItemList and #self._costItemList > 0 then
		local itemList = self._costItemList

		self._costItemList = nil

		for i = 1, #itemList do
			local item = itemList[i]

			for itemkey in pairs(item) do
				rawset(item, itemkey, nil)
			end
		end
	end
end

function RoomBuildingItem:_refreshBuildingTypeIcon(buildingCfg)
	local buildingType = buildingCfg.buildingType
	local buildingId = buildingCfg.id

	if not self._buildingTypeIconColor[buildingType] then
		SLFramework.UGUI.GuiHelper.SetColor(self._buildingusedesc, self._buildingTypeIconColor[buildingType])
		SLFramework.UGUI.GuiHelper.SetColor(self._imagebuildingtype, self._buildingTypeIconColor[buildingType])

		local iconName

		self._buildingusedesc.text = buildingCfg.useDesc

		UISpriteSetMgr.instance:setRoomSprite(self._imagebuildingtype, RoomBuildingEnum.BuildingArea[buildingType] and ManufactureConfig.instance:getManufactureBuildingIcon(buildingId) or RoomConfig.instance:getBuildingTypeIcon(buildingType))

		local num = 0

		if RoomBuildingEnum.BuildingArea[buildingType] or buildingType == RoomBuildingEnum.BuildingType.Rest then
			local tradeLevel = ManufactureModel.instance:getTradeLevel()

			num = ManufactureConfig.instance:getBuildingCanPlaceCritterCount(buildingId, tradeLevel)
		end

		gohelper.setActive(self._txtcritternum, num > 0)

		if num > 0 then
			self._txtcritternum.text = num
		end
	end
end

function RoomBuildingItem:_hideReddot()
	if self._mo.use then
		return
	end

	local reddotInfo = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.RoomBuildingPlace)

	if not reddotInfo or not reddotInfo.infos then
		return
	end

	local info = reddotInfo.infos[self._mo.buildingId]

	if not info then
		return
	end

	if info.value > 0 then
		RoomRpc.instance:sendHideBuildingReddotRequset(self._mo.buildingId)
	end
end

return RoomBuildingItem
