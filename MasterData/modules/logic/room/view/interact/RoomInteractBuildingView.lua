-- chunkname: @modules/logic/room/view/interact/RoomInteractBuildingView.lua

module("modules.logic.room.view.interact.RoomInteractBuildingView", package.seeall)

local RoomInteractBuildingView = class("RoomInteractBuildingView", BaseView)

function RoomInteractBuildingView:onInitView()
	self._goleft = gohelper.findChild(self.viewGO, "#go_left")
	self._simagebuildingIcon = gohelper.findChildSingleImage(self.viewGO, "#go_left/headerInfo/#simage_buildingIcon")
	self._txtbuildingname = gohelper.findChildText(self.viewGO, "#go_left/headerInfo/#txt_buildingname")
	self._txttips = gohelper.findChildText(self.viewGO, "#go_left/layout/#txt_tips")
	self._goheroitem = gohelper.findChild(self.viewGO, "#go_left/layout/hero/#go_heroitem")
	self._goright = gohelper.findChild(self.viewGO, "#go_right")
	self._gohero = gohelper.findChild(self.viewGO, "#go_right/#go_hero")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "#go_right/#go_hero/#simage_rightbg")
	self._scrollhero = gohelper.findChildScrollRect(self.viewGO, "#go_right/#go_hero/#scroll_hero")
	self._goempty = gohelper.findChild(self.viewGO, "#go_right/#go_hero/#go_empty")
	self._btnsort = gohelper.findChildButtonWithAudio(self.viewGO, "#go_right/#go_hero/sort/#drop_sort/#btn_sort")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#go_right/#go_hero/#btn_confirm")
	self._btnconfirmgrey = gohelper.findChildButtonWithAudio(self.viewGO, "#go_right/#go_hero/#btn_confirm_grey")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_right/#btn_skip")
	self._imageskip = gohelper.findChildImage(self.viewGO, "#go_right/#btn_skip/#image_skip")
	self._btnhide = gohelper.findChildButtonWithAudio(self.viewGO, "#go_right/#btn_hide")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomInteractBuildingView:addEvents()
	self._btnsort:AddClickListener(self._btnsortOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnconfirmgrey:AddClickListener(self._btnconfirmgreyOnClick, self)
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
	self._btnhide:AddClickListener(self._btnhideOnClick, self)
end

function RoomInteractBuildingView:removeEvents()
	self._btnsort:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btnconfirmgrey:RemoveClickListener()
	self._btnskip:RemoveClickListener()
	self._btnhide:RemoveClickListener()
end

function RoomInteractBuildingView:_btnsortOnClick()
	if self:_isRareDown() then
		if not RoomCharacterEnum.CharacterOrderType.RareUp then
			local orderType = RoomCharacterEnum.CharacterOrderType.RareDown
			local tRoomInteractCharacterListModel = RoomInteractCharacterListModel.instance

			tRoomInteractCharacterListModel:setOrder(orderType)
			tRoomInteractCharacterListModel:setCharacterList()
			self:_refreshArrowUI()
		end
	end
end

function RoomInteractBuildingView:_btnconfirmOnClick()
	local roomScene = RoomCameraController.instance:getRoomScene()

	if not roomScene then
		return
	end

	local buildingEntity = roomScene.buildingmgr:getBuildingEntity(self._buildingUid)

	if buildingEntity and buildingEntity.interactComp then
		RoomStatController.instance:roomInteractBuildingInvite(self._interactBuildingMO.config.buildingId, self._interactBuildingMO:getHeroIdList())
		buildingEntity.interactComp:startInteract()

		self._isInteractShow = true

		self:_refreshShowHide()

		local showTime = self._interactBuildingMO.config.showTime * 0.001

		TaskDispatcher.cancelTask(self._onInteractShowtimeFinish, self)
		TaskDispatcher.runDelay(self._onInteractShowtimeFinish, self, showTime + 0.1)
	end
end

function RoomInteractBuildingView:_btnconfirmgreyOnClick()
	GameFacade.showToast(ToastEnum.RoomInteractBuildingNoHero)
end

function RoomInteractBuildingView:_btnskipOnClick()
	return
end

function RoomInteractBuildingView:_btnhideOnClick()
	RoomMapController.instance:setUIHide(true)
end

function RoomInteractBuildingView:_onValueChanged(index)
	if index == 0 then
		RoomInteractCharacterListModel.instance:setFilterCareer()
	else
		RoomInteractCharacterListModel.instance:setFilterCareer({
			index
		})
	end

	RoomInteractCharacterListModel.instance:setCharacterList()
end

function RoomInteractBuildingView:_editableInitView()
	self._selectItemList = {}

	gohelper.setActive(self._btnskip, false)
	gohelper.setActive(self._goheroitem, false)

	self._golayout = gohelper.findChildText(self.viewGO, "#go_left/layout")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_right/#go_hero/sort/#drop_sort/arrow")
	self._goarrowTrs = self._goarrow.transform
	self._dropfilter = gohelper.findChildDropdown(self.viewGO, "#go_right/#go_hero/sort/#drop_filter")

	self._dropfilter:AddOnValueChanged(self._onValueChanged, self)

	local options = {
		luaLang("all_language_filter_option")
	}

	for career = 1, 6 do
		table.insert(options, luaLang("career" .. career))
	end

	self._dropfilter:AddOptions(options)

	self._isInteractShow = false
	self._isHidAllUI = false
end

function RoomInteractBuildingView:goBackClose()
	if RoomMapController.instance:isUIHide() then
		RoomMapController.instance:setUIHide(false)

		return false
	end

	self:closeThis()

	return true
end

function RoomInteractBuildingView:onUpdateParam()
	return
end

function RoomInteractBuildingView:onOpen()
	if self.viewContainer then
		self.addEventCb(self, self.viewContainer, RoomEvent.InteractBuildingSelectHero, self._onSelectHero, self)
	end

	self.addEventCb(self, RoomMapController.instance, RoomEvent.ShowUI, self._refreshShowHide, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.HideUI, self._refreshShowHide, self)

	self._buildingUid = self.viewParam.buildingUid
	self._buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self._buildingUid)
	self._interactBuildingMO = self._buildingMO:getInteractMO()

	RoomInteractBuildingModel.instance:setSelectBuildingMO(self._buildingMO)
	RoomInteractCharacterListModel.instance:initOrder()
	RoomInteractCharacterListModel.instance:setCharacterList()
	NavigateMgr.instance:addEscape(self.viewName, self.goBackClose, self)
	self:_refreshUI()
	RoomMapController.instance:dispatchEvent(RoomEvent.InteractBuildingShowChanged)
end

function RoomInteractBuildingView:onClose()
	RoomCameraController.instance:resetCameraStateByKey(ViewName.RoomInteractBuildingView)
	RoomMapController.instance:dispatchEvent(RoomEvent.InteractBuildingShowChanged)
end

function RoomInteractBuildingView:onDestroyView()
	if self._selectItemList then
		for _, selectItem in ipairs(self._selectItemList) do
			selectItem:onDestroy()
		end

		self._selectItemList = nil
	end

	self._dropfilter:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(self._onInteractShowtimeFinish, self)
end

function RoomInteractBuildingView:_onSelectHero(heroId)
	if self._isInteractShow == true then
		return
	end

	if self._interactBuildingMO:isHasHeroId(heroId) then
		RoomInteractBuildingModel.instance:removeInteractHeroId(self._buildingUid, heroId)
	else
		if self._interactBuildingMO:isHeroMax() then
			GameFacade.showToast(ToastEnum.RoomInteractBuildingHeroMax)

			return
		end

		RoomInteractBuildingModel.instance:addInteractHeroId(self._buildingUid, heroId)
	end

	self:_refreshSelectHeroList()
	RoomInteractCharacterListModel.instance:updateCharacterList()
end

function RoomInteractBuildingView:_onInteractShowtimeFinish()
	self._isInteractShow = false

	self:_refreshShowHide()
end

function RoomInteractBuildingView:_refreshShowHide()
	local isShow = not RoomMapController.instance:isUIHide()

	gohelper.setActive(self._golayout, not self._isInteractShow and isShow)
	gohelper.setActive(self._gohero, not self._isInteractShow and isShow)
	gohelper.setActive(self._goleft, isShow)
	gohelper.setActive(self._goright, isShow)
	gohelper.setActive(self._goBackBtns, isShow)
end

function RoomInteractBuildingView:_refreshUI()
	if self._buildingMO then
		self._txtbuildingname.text = self._buildingMO.config.name
	end

	if self._interactBuildingMO then
		self._txttips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("room_interactbuilding_slotnum_txt"), self._interactBuildingMO:getHeroMax())
	end

	self:_refreshArrowUI()
	self:_refreshSelectHeroList()
end

function RoomInteractBuildingView:_refreshArrowUI()
	local scleY = self:_isRareDown() and -1 or 1

	transformhelper.setLocalScale(self._goarrowTrs, 1, scleY, 1)
end

function RoomInteractBuildingView:_refreshSelectHeroList()
	if not self._selectItemList then
		return
	end

	if self._interactBuildingMO then
		local heroIdList = self._interactBuildingMO:getHeroIdList()
		local heroCount = self._interactBuildingMO and self._interactBuildingMO:getHeroMax() or 0

		for i = 1, heroCount do
			local selectItem = self._selectItemList[i]

			if not selectItem then
				local go = gohelper.cloneInPlace(self._goheroitem)

				gohelper.setActive(go, true)

				selectItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomInteractSelectItem, self)
				selectItem._view = self

				table.insert(self._selectItemList, selectItem)
			end

			local heroId = heroIdList[i]

			if heroId then
				::label_21_0::

				local characterMO = RoomCharacterModel.instance:getCharacterMOById(heroId)

				selectItem:onUpdateMO(characterMO)
			end
		end

		local hasHero = heroIdList and #heroIdList > 0

		gohelper.setActive(self._btnconfirm, hasHero)
		gohelper.setActive(self._btnconfirmgrey, not hasHero)
	end
end

function RoomInteractBuildingView:_isRareDown()
	if RoomInteractCharacterListModel.instance:getOrder() == RoomCharacterEnum.CharacterOrderType.RareDown then
		return true
	end

	return false
end

return RoomInteractBuildingView
