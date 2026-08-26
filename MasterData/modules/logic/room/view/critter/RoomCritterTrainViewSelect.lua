-- chunkname: @modules/logic/room/view/critter/RoomCritterTrainViewSelect.lua

module("modules.logic.room.view.critter.RoomCritterTrainViewSelect", package.seeall)

local RoomCritterTrainViewSelect = class("RoomCritterTrainViewSelect", BaseView)

function RoomCritterTrainViewSelect:onInitView()
	self._gotrainselect = gohelper.findChild(self.viewGO, "bottom/#go_trainselect")
	self._gohascritter = gohelper.findChild(self._gotrainselect, "critter/#go_hascritter")
	self._gocritterIcon = gohelper.findChild(self._gotrainselect, "critter/#go_hascritter/#go_critterIcon")
	self._gonocritter = gohelper.findChild(self._gotrainselect, "critter/#go_nocritter")
	self._gocritterselected = gohelper.findChild(self._gotrainselect, "critter/#go_critter_selected")
	self._btncritterselect = gohelper.findChildButtonWithAudio(self._gotrainselect, "critter/#btn_critter_select")
	self._gohashero = gohelper.findChild(self._gotrainselect, "hero/#go_hashero")
	self._goheroIcon = gohelper.findChild(self._gotrainselect, "hero/#go_hashero/#go_heroIcon")
	self._simageheroicon = gohelper.findChildSingleImage(self._gotrainselect, "hero/#go_hashero/#simage_heroicon")
	self._gonohero = gohelper.findChild(self._gotrainselect, "hero/#go_nohero")
	self._goheroselected = gohelper.findChild(self._gotrainselect, "hero/#go_hero_selected")
	self._btnheroselect = gohelper.findChildButtonWithAudio(self._gotrainselect, "hero/#btn_hero_select")
	self._gocritterinfo = gohelper.findChild(self._gotrainselect, "#go_critter_info")
	self._txtcrittername = gohelper.findChildText(self._gotrainselect, "#go_critter_info/#txt_critter_name")
	self._btndetail = gohelper.findChildButtonWithAudio(self._gotrainselect, "#go_critter_info/#btn_detail")
	self._scrollcritterarr = gohelper.findChildScrollRect(self._gotrainselect, "#go_critter_info/#scroll_critterarr")
	self._gocritteritem = gohelper.findChild(self._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content/#go_critteritem")
	self._txtname = gohelper.findChildText(self._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content/#go_critteritem/#txt_name")
	self._imageicon = gohelper.findChildImage(self._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content/#go_critteritem/#txt_name/#image_icon")
	self._txtnum = gohelper.findChildText(self._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content/#go_critteritem/#txt_num")
	self._txtratio = gohelper.findChildText(self._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content/#go_critteritem/#txt_ratio")
	self._scrollcritterpreview = gohelper.findChildScrollRect(self._gotrainselect, "#go_critter_info/#scroll_critterpreview")
	self._gobaseitem = gohelper.findChild(self._gotrainselect, "#go_critter_info/#scroll_critterpreview/viewport/content/#go_baseitem")
	self._goheroinfo = gohelper.findChild(self._gotrainselect, "#go_hero_info")
	self._txtheroname = gohelper.findChildText(self._gotrainselect, "#go_hero_info/#txt_hero_name")
	self._txtheroinfo = gohelper.findChildText(self._gotrainselect, "#go_hero_info/#txt_hero_info")
	self._scrollheroarr = gohelper.findChildScrollRect(self._gotrainselect, "#go_hero_info/#scroll_heroarr")
	self._goheroitem = gohelper.findChild(self._gotrainselect, "#go_hero_info/#scroll_heroarr/viewport/content/#go_heroitem")
	self._txtpreference = gohelper.findChildText(self._gotrainselect, "#go_hero_info/#scroll_heroarr/viewport/content/go_preferenceitem/#txt_preference")
	self._simagepreference = gohelper.findChildSingleImage(self._gotrainselect, "#go_hero_info/#scroll_heroarr/viewport/content/go_preferenceitem/#simage_preference")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterTrainViewSelect:addEvents()
	self._btncritterselect:AddClickListener(self._btncritterselectOnClick, self)
	self._btnheroselect:AddClickListener(self._btnheroselectOnClick, self)
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
end

function RoomCritterTrainViewSelect:removeEvents()
	self._btncritterselect:RemoveClickListener()
	self._btnheroselect:RemoveClickListener()
	self._btndetail:RemoveClickListener()
end

function RoomCritterTrainViewSelect:_btncritterselectOnClick()
	self:setSelectCritter(true)
	self.viewContainer:dispatchEvent(CritterEvent.UITrainSubTab, 2)
end

function RoomCritterTrainViewSelect:_btnheroselectOnClick()
	self:setSelectCritter(false)
	self.viewContainer:dispatchEvent(CritterEvent.UITrainSubTab, 3)
end

function RoomCritterTrainViewSelect:_btndetailOnClick()
	local critterMO = CritterModel.instance:getCritterMOByUid(self._selectCritterUid)

	if critterMO then
		CritterController.instance:openRoomCritterDetailView(critterMO.finishTrain ~= true, critterMO, true)
	end
end

function RoomCritterTrainViewSelect:_editableInitView()
	self._trainPreveSendDict = {}
	self._attributeItems = {}
	self._goCritterAttrContent = gohelper.findChild(self._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content")
	self._gopreferenceitem = gohelper.findChild(self._gotrainselect, "#go_hero_info/#scroll_heroarr/viewport/content/go_preferenceitem")
	self._referenceCanvasGroup = gohelper.onceAddComponent(self._gopreferenceitem, typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(self._gobaseitem, false)

	self._heroAttrComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goheroitem, RoomCritterAttrScrollCell)
	self._heroAttrComp._view = self
	self._tempAttrList = {}

	local attrIds = {
		CritterEnum.AttributeType.Efficiency,
		CritterEnum.AttributeType.Patience,
		CritterEnum.AttributeType.Lucky
	}

	for i, attrId in ipairs(attrIds) do
		local infoMO = CritterAttributeInfoMO.New()

		infoMO:init({
			attributeId = attrId
		})
		table.insert(self._tempAttrList, infoMO)
	end

	self._txtheroinfo.text = luaLang(CritterEnum.LangKey.HeroTrainLevel)
end

function RoomCritterTrainViewSelect:onUpdateParam()
	return
end

function RoomCritterTrainViewSelect:onOpen()
	self.__isOpenFlage = true

	if self.viewContainer then
		self.addEventCb(self, self.viewContainer, CritterEvent.UITrainSelectCritter, self._onSelectCritterItem, self)
		self.addEventCb(self, self.viewContainer, CritterEvent.UITrainSelectHero, self._onSelectHeroItem, self)
		self.addEventCb(self, self.viewContainer, CritterEvent.UITrainSelectSlot, self._onSelectSlotItem, self)
		self.addEventCb(self, self.viewContainer, CritterEvent.UIChangeTrainCritter, self._onChangeTrainCritter, self)
		self.addEventCb(self, self.viewContainer, CritterEvent.UITrainViewGoBack, self._onTrainGoBack, self)
	end

	self.addEventCb(self, CritterController.instance, CritterEvent.CritterInfoPushUpdate, self._onCritterInfoPushUpdate, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.StartTrainCritterPreviewReply, self._onTrainPreviewReplay, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.CameraStateUpdate, self.showSceneSpine, self)
	self:setSelectCritter(true)
	self:refreshSelectCritterUI()
	self:refreshSelectHeroUI()
end

function RoomCritterTrainViewSelect:onClose()
	self.__isOpenFlage = false

	RoomCritterController.instance:showTrainSceneHero(nil)
	RoomCritterController.instance:showTrainSceneCritter(nil)
end

function RoomCritterTrainViewSelect:onDestroyView()
	self._heroAttrComp:onDestroy()

	if self._attributeItems then
		for _, v in pairs(self._attributeItems) do
			v:destroy()
		end

		self._attributeItems = nil
	end
end

function RoomCritterTrainViewSelect:_onSelectCritterItem(mo)
	self._selectCritterUid = mo.id

	self:refreshSelectCritterUI()
end

function RoomCritterTrainViewSelect:_onSelectHeroItem(mo)
	self._selectHeroId = mo.id

	self:refreshSelectHeroUI()
end

function RoomCritterTrainViewSelect:_onCritterInfoPushUpdate()
	self:refreshSelectCritterUI()
end

function RoomCritterTrainViewSelect:_onChangeTrainCritter(slotMO)
	self:_updateBySlotMO(slotMO)
	self:setSelectCritter(true)
	self:refreshSelectCritterUI()
	self:refreshSelectHeroUI()
end

function RoomCritterTrainViewSelect:_onSelectSlotItem(mo)
	self:_updateBySlotMO(mo)
	self:setSelectCritter(true)
	self:refreshSelectCritterUI()
	self:refreshSelectHeroUI()
end

function RoomCritterTrainViewSelect:_updateBySlotMO(slotMO)
	self._selectCritterUid = nil
	self._selectHeroId = nil
	self._selectSlotMO = slotMO
	self._selectSiteId = slotMO and slotMO.id

	local critterMO = slotMO and slotMO.critterMO

	if critterMO then
		self._selectCritterUid = critterMO.id
		self._selectHeroId = critterMO.trainInfo.heroId
	end
end

function RoomCritterTrainViewSelect:_onTrainGoBack()
	self:_updateBySlotMO(self._selectSlotMO)
	self:showSceneSpine()
end

function RoomCritterTrainViewSelect:_onTrainPreviewReplay(critterUid, heroId)
	self:refreshAttributeItem()
end

function RoomCritterTrainViewSelect:setSelectCritter(isCritter)
	self._isSelectCritter = isCritter

	gohelper.setActive(self._goheroinfo, not isCritter)
	gohelper.setActive(self._goheroselected, not isCritter)
	gohelper.setActive(self._gocritterinfo, isCritter)
	gohelper.setActive(self._gocritterselected, isCritter)
	self:showSceneSpine()
end

function RoomCritterTrainViewSelect:refreshSelectCritterUI()
	local critterUid = self._selectCritterUid
	local critterMO = CritterModel.instance:getCritterMOByUid(critterUid)
	local hasCritter = critterMO ~= nil

	gohelper.setActive(self._gohascritter, hasCritter)
	gohelper.setActive(self._gonocritter, not hasCritter)

	local attrList = self._tempAttrList

	if hasCritter then
		self.critterIcon = self.critterIcon or IconMgr.instance:getCommonCritterIcon(self._gocritterIcon)

		self.critterIcon:setMOValue(critterMO:getId(), critterMO:getDefineId())

		self._txtcrittername.text = critterMO:getName()
		attrList = critterMO:getAttributeInfos()
	else
		self._txtcrittername.text = luaLang("critter_train_noselect_critter_text")
	end

	self._isHasSelectCritter = hasCritter

	local parent_obj = self._goCritterAttrContent
	local model_obj = self._gocritteritem

	gohelper.CreateObjList(self, self._onCritterArrComp, attrList, parent_obj, model_obj, RoomCritterAttrScrollCell)
	self:refreshAttributeItem()
	self:showSceneSpine()
	self:refreshReferenceUI()
end

function RoomCritterTrainViewSelect:refreshReferenceUI()
	self._referenceCanvasGroup.alpha = self:_isPreference() and 1 or 0.5
end

function RoomCritterTrainViewSelect:_isPreference()
	if self._selectCritterUid and self._selectHeroId then
		local critterMO = CritterModel.instance:getCritterMOByUid(self._selectCritterUid)
		local trainHeroMO = RoomTrainHeroListModel.instance:getById(self._selectHeroId)

		if critterMO and trainHeroMO and trainHeroMO:chcekPrefernectCritterId(critterMO:getDefineId()) then
			return true
		end
	end

	return false
end

function RoomCritterTrainViewSelect:refreshAttributeItem()
	local critterMO = self:_getTrainPreviewMO()
	local show = true

	if critterMO then
		for _, v in pairs(self._attributeItems) do
			v:hideItem()
		end

		local attrInfos = critterMO:getAttributeInfos()

		for i = 1, #attrInfos do
			if not self._attributeItems[i] then
				self._attributeItems[i] = RoomCritterTrainDetailItemAttributeItem.New()

				self._attributeItems[i]:init(self._gobaseitem)
			end

			self._attributeItems[i]:setShowLv(self._showLv)
			self._attributeItems[i]:refresh(attrInfos[i], critterMO)
		end
	elseif not self._selectCritterUid or not self._selectHeroId then
		show = false
	end

	gohelper.setActive(self._scrollcritterarr, not show)
	gohelper.setActive(self._scrollcritterpreview, show)
end

function RoomCritterTrainViewSelect:_getTrainPreviewMO()
	if self._selectCritterUid and self._selectHeroId then
		local critterMO = CritterModel.instance:getCritterMOByUid(self._selectCritterUid)

		if critterMO and critterMO:isCultivating() and critterMO.trainInfo.heroId == self._selectHeroId then
			return critterMO
		end

		if critterMO and critterMO:isMaturity() then
			return nil
		end

		local previewMO = CritterModel.instance:getTrainPreviewMO(self._selectCritterUid, self._selectHeroId)

		if previewMO then
			return previewMO
		end

		local nextTime = RoomHelper.get2KeyValue(self._trainPreveSendDict, self._selectCritterUid, self._selectHeroId)

		if nextTime == nil or nextTime < Time.time then
			RoomHelper.add2KeyValue(self._trainPreveSendDict, self._selectCritterUid, self._selectHeroId, Time.time + 2)
			CritterRpc.instance:sendStartTrainCritterPreviewRequest(self._selectCritterUid, self._selectHeroId)
		end
	end

	return nil
end

function RoomCritterTrainViewSelect:refreshSelectHeroUI()
	local trainHeroMO = RoomTrainHeroListModel.instance:getById(self._selectHeroId)
	local isHasHero = trainHeroMO ~= nil

	gohelper.setActive(self._gohashero, isHasHero)
	gohelper.setActive(self._gonohero, not isHasHero)
	gohelper.setActive(self._txtheroinfo, isHasHero)
	gohelper.setActive(self._scrollheroarr, isHasHero)

	if isHasHero then
		self._simageheroicon:LoadImage(ResUrl.getRoomHeadIcon(trainHeroMO.skinConfig.headIcon))

		self._txtheroname.text = trainHeroMO.heroConfig and trainHeroMO.heroConfig.name

		self._heroAttrComp:onUpdateMO(trainHeroMO:getAttributeInfoMO())

		self._txtpreference.text = trainHeroMO:getPrefernectName()

		if trainHeroMO.critterHeroConfig then
			self._simagepreference:LoadImage(ResUrl.getCritterHedaIcon(trainHeroMO.critterHeroConfig.critterIcon))
		end
	else
		self._txtheroname.text = luaLang("critter_train_noselect_hero_text")
	end

	self:refreshAttributeItem()
	self:showSceneSpine()
	self:refreshReferenceUI()
end

function RoomCritterTrainViewSelect:showSceneSpine()
	self._lastHeroId = self._selectHeroId
	self._lastCritterUiId = self._selectCritterUid

	if self:_isHideSpine() then
		self._lastHeroId = nil
		self._lastCritterUiId = nil
	end

	local trainHeroMO = RoomTrainHeroListModel.instance:getById(self._lastHeroId)
	local critterMO = CritterModel.instance:getCritterMOByUid(self._lastCritterUiId)
	local buildingUi = self.viewContainer:getContainerViewBuildingUid()
	local heroSlitId = 7
	local critterSlitId = 6

	RoomCritterController.instance:showTrainSceneHero(trainHeroMO, buildingUi, heroSlitId)
	RoomCritterController.instance:showTrainSceneCritter(critterMO, buildingUi, critterSlitId)
end

function RoomCritterTrainViewSelect:_isHideSpine()
	if not self.__isOpenFlage then
		return true
	end

	if self.viewContainer:getContainerCurSelectTab() ~= RoomCritterBuildingViewContainer.SubViewTabId.Training then
		return true
	end

	local scene = RoomCameraController.instance:getRoomScene()

	if not scene then
		return true
	end

	local cameraState = scene.camera:getCameraState()

	return cameraState == RoomEnum.CameraState.ThirdPerson
end

function RoomCritterTrainViewSelect:_onCritterArrComp(cell_component, data, index)
	cell_component:onUpdateMO(data)

	cell_component._view = cell_component._view or self

	if not self._isHasSelectCritter then
		cell_component._txtratio.text = "--"
		cell_component._txtnum.text = "--"
	end
end

return RoomCritterTrainViewSelect
