-- chunkname: @modules/logic/room/view/gift/RoomBlockGiftBuildingItem.lua

module("modules.logic.room.view.gift.RoomBlockGiftBuildingItem", package.seeall)

local RoomBlockGiftBuildingItem = class("RoomBlockGiftBuildingItem", ListScrollCellExtend)

RoomBlockGiftBuildingItem.DRAG_RADIUS = 15

function RoomBlockGiftBuildingItem:onInitView()
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
	self._govehicle = gohelper.findChild(self.viewGO, "#go_content/#go_vehicle")
	self._gohasget = gohelper.findChild(self.viewGO, "#go_content/go_hasget")
	self._btnbuildselect = gohelper.findChildButtonWithAudio(self.viewGO, "#go_content/#go_select/#btn_check")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomBlockGiftBuildingItem:addEvents()
	return
end

function RoomBlockGiftBuildingItem:removeEvents()
	return
end

function RoomBlockGiftBuildingItem:addEventListeners()
	self._btnUIlongPrees:SetLongPressTime(self._longPressArr)
	self._btnUIlongPrees:AddLongPressListener(self._onbtnlongPrees, self)
	self._btnUIclick:AddClickListener(self._btnclickOnClick, self)
	self._btnbuildselect:AddClickListener(self._onbtnlongPrees, self)

	if self._btnUIdrag then
		self._btnUIdrag:AddDragBeginListener(self._onDragBegin, self)
		self._btnUIdrag:AddDragListener(self._onDragIng, self)
		self._btnUIdrag:AddDragEndListener(self._onDragEnd, self)
	end
end

function RoomBlockGiftBuildingItem:removeEventListeners()
	self._btnUIlongPrees:RemoveLongPressListener()
	self._btnUIclick:RemoveClickListener()
	self._btnbuildselect:RemoveClickListener()

	if self._btnUIdrag then
		self._btnUIdrag:RemoveDragBeginListener()
		self._btnUIdrag:RemoveDragListener()
		self._btnUIdrag:RemoveDragEndListener()
	end
end

function RoomBlockGiftBuildingItem:_btnclickOnClick()
	if self._mo:isCollect() then
		return
	end

	RoomBlockBuildingGiftModel.instance:onSelect(self._mo)
	RoomBlockGiftController.instance:dispatchEvent(RoomBlockGiftEvent.OnSelect, self._mo.subType, self._mo.id)
end

function RoomBlockGiftBuildingItem:_editableInitView()
	self._longPressArr = {
		1,
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
	self._buildingTypeDefindeColor = "#FFFFFF"
	self._buildingTypeIconColor = {
		[RoomBuildingEnum.BuildingType.Collect] = "#6E9FB1",
		[RoomBuildingEnum.BuildingType.Process] = "#C6BA7B",
		[RoomBuildingEnum.BuildingType.Manufacture] = "#7BB19A"
	}
end

function RoomBlockGiftBuildingItem:_refreshUI()
	self._simageicon:LoadImage(ResUrl.getRoomImage("building/" .. self._mo:getIcon()))
	gohelper.setActive(self._gobeplaced, self._mo.use)

	self._txtcount.text = luaLang("multiple") .. 1
	self._txtaddvalue.text = self._mo.config.buildDegree
	self._txtbuildingname.text = self._mo.config.name

	gohelper.setActive(self._txtcostres.gameObject, false)

	local areaConfig = self._mo:getBuildingAreaConfig()

	UISpriteSetMgr.instance:setRoomSprite(self._imagearea, "xiaowuliubianxing_" .. areaConfig.icon)

	if not RoomBuildingEnum.RareIcon[self._mo.config.rare] then
		UISpriteSetMgr.instance:setRoomSprite(self._imagerare, RoomBuildingEnum.RareIcon[self._mo.config.rare])

		if self._refresCostBuilding ~= self._mo.buildingId then
			self._refresCostBuilding = self._mo.buildingId

			self:_refreshCostResList(self._mo.buildingId)
		end

		gohelper.setActive(self._govehicle, self._mo.config.vehicleType ~= 0)

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

		gohelper.setActive(self._gohasget, self._mo:isCollect())
		self:onSelect()
	end
end

function RoomBlockGiftBuildingItem:_refreshCostResList(buildingId)
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

function RoomBlockGiftBuildingItem:onUpdateMO(mo)
	self._mo = mo

	local flag = mo and mo.config

	gohelper.setActive(self._gocontent, flag)

	if flag then
		self:_refreshUI()
	end
end

function RoomBlockGiftBuildingItem:getAnimator()
	return self._animator
end

function RoomBlockGiftBuildingItem:onSelect()
	self._isSelect = self._mo.isSelect

	gohelper.setActive(self._goselect, self._isSelect)
end

function RoomBlockGiftBuildingItem:onDestroy()
	self._simageicon:UnLoadImage()
end

function RoomBlockGiftBuildingItem:_refreshBuildingTypeIcon(buildingCfg)
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

function RoomBlockGiftBuildingItem:_onbtnlongPrees()
	local type = self._mo.subType
	local id = self._mo.id
	local data = {
		type = type,
		id = id
	}

	MaterialTipController.instance:showMaterialInfoWithData(type, id, data)
end

function RoomBlockGiftBuildingItem:_onDragBegin(param, pointerEventData)
	RoomBlockGiftController.instance:dispatchEvent(RoomBlockGiftEvent.OnStartDragItem, pointerEventData)
end

function RoomBlockGiftBuildingItem:_onDragIng(param, pointerEventData)
	RoomBlockGiftController.instance:dispatchEvent(RoomBlockGiftEvent.OnDragingItem, pointerEventData)
end

function RoomBlockGiftBuildingItem:_onDragEnd(param, pointerEventData)
	RoomBlockGiftController.instance:dispatchEvent(RoomBlockGiftEvent.OnEndDragItem, pointerEventData)
end

function RoomBlockGiftBuildingItem:setActive(isActive)
	gohelper.setActive(self.viewGO, isActive)
end

function RoomBlockGiftBuildingItem:initViewGo(viewGO)
	self.viewGO = viewGO

	self:onInitView()
end

return RoomBlockGiftBuildingItem
