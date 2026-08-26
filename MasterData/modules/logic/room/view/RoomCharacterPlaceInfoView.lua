-- chunkname: @modules/logic/room/view/RoomCharacterPlaceInfoView.lua

module("modules.logic.room.view.RoomCharacterPlaceInfoView", package.seeall)

local RoomCharacterPlaceInfoView = class("RoomCharacterPlaceInfoView", BaseView)

function RoomCharacterPlaceInfoView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_close")
	self._btnsure = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_sure")
	self._txttip = gohelper.findChildText(self.viewGO, "tip/#txt_tip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCharacterPlaceInfoView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnsure:AddClickListener(self._btnsureOnClick, self)
end

function RoomCharacterPlaceInfoView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnsure:RemoveClickListener()
end

function RoomCharacterPlaceInfoView:_btncloseOnClick()
	self:closeThis()

	if self._closeCallback then
		if self._callbackObj then
			self._closeCallback(self._callbackObj, self._callbackParam)
		else
			self._closeCallback(self._callbackParam)
		end
	end
end

function RoomCharacterPlaceInfoView:_btnsureOnClick()
	local removeCount = #self._removeHeroMOList

	if removeCount < self._needRemoveCount then
		GameFacade.showToast(ToastEnum.RoomCharacterPlaceInfo, self._needRemoveCount - removeCount)

		return
	end

	if removeCount > 0 then
		if self._notUpdateMapModel ~= true then
			for i, roomCharacterMO in ipairs(self._removeHeroMOList) do
				RoomCharacterModel.instance:editRemoveCharacterMO(roomCharacterMO.heroId)
			end
		end

		local roomHeroIds = {}

		for _, roomCharacterMO in ipairs(self._currentHeroMOList) do
			local tempMO, index = self:_findHeroMOById(self._removeHeroMOList, roomCharacterMO.heroId)

			if not tempMO then
				table.insert(roomHeroIds, roomCharacterMO.heroId)
			end
		end

		RoomRpc.instance:sendUpdateRoomHeroDataRequest(roomHeroIds)
	end

	self:closeThis()

	if self._sureCallback then
		if self._callbackObj then
			self._sureCallback(self._callbackObj, self._callbackParam)
		else
			self._sureCallback(self._callbackParam)
		end
	end
end

function RoomCharacterPlaceInfoView:_btnclickOnclick(heroId)
	local characterMO, index = self:_findHeroMOById(self._currentHeroMOList, heroId)

	if characterMO then
		table.remove(self._currentHeroMOList, index)
		table.insert(self._removeHeroMOList, characterMO)
	else
		characterMO, index = self:_findHeroMOById(self._removeHeroMOList, heroId)

		if characterMO then
			table.remove(self._removeHeroMOList, index)
			table.insert(self._currentHeroMOList, characterMO)
		end
	end

	self:_sort()
	self:_refreshUI()
end

function RoomCharacterPlaceInfoView:_findHeroMOById(heroMOList, heroId)
	for i, roomCharacterMO in ipairs(heroMOList) do
		if roomCharacterMO.heroId == heroId then
			return roomCharacterMO, i
		end
	end

	return nil
end

function RoomCharacterPlaceInfoView:_editableInitView()
	self._gocurrentplacecontent = gohelper.findChild(self.viewGO, "currentplace/#scroll_currentplace/Viewport/Content")
	self._goremoveplacecontent = gohelper.findChild(self.viewGO, "removeplace/#scroll_removeplace/Viewport/Content")
	self._gotip = gohelper.findChild(self.viewGO, "tip")

	self._simagebg:LoadImage(ResUrl.getRoomImage("characterplace/bg_dajiandi"))
end

function RoomCharacterPlaceInfoView.initCharacterItem(heroItem)
	heroItem.simageicon = gohelper.findChildSingleImage(heroItem.go, "role/heroicon")
	heroItem.goclick = gohelper.findChild(heroItem.go, "go_click")
	heroItem.txttrust = gohelper.findChildText(heroItem.go, "trust/txt_trust")
	heroItem.gorole = gohelper.findChild(heroItem.go, "role")
	heroItem.imagecareer = gohelper.findChildImage(heroItem.go, "role/career")
	heroItem.imagerare = gohelper.findChildImage(heroItem.go, "role/rare")
	heroItem.txtname = gohelper.findChildText(heroItem.go, "role/name")
	heroItem.txtnameen = gohelper.findChildText(heroItem.go, "role/name/nameEn")
	heroItem.btnclick = gohelper.getClickWithAudio(heroItem.goclick)

	local gotrust = gohelper.findChild(heroItem.go, "trust")
	local gobeplaced = gohelper.findChild(heroItem.go, "placeicon")
	local goselect = gohelper.findChild(heroItem.go, "select")
	local goonbirthdayicon = gohelper.findChild(heroItem.go, "#go_onbirthdayicon")
	local canvasGroup = heroItem.gorole:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(gotrust, true)
	gohelper.setActive(gobeplaced, false)
	gohelper.setActive(goselect, false)
	gohelper.setActive(goonbirthdayicon, false)

	canvasGroup.alpha = 1
end

function RoomCharacterPlaceInfoView.refreshCharacterItem(heroItem, roomCharacterMO)
	heroItem.simageicon:LoadImage(ResUrl.getHeadIconSmall(roomCharacterMO.skinConfig.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(heroItem.imagecareer, "lssx_" .. roomCharacterMO.heroConfig.career)
	UISpriteSetMgr.instance:setCommonSprite(heroItem.imagerare, "equipbar" .. CharacterEnum.Color[roomCharacterMO.heroConfig.rare])

	heroItem.txtname.text = roomCharacterMO.heroConfig.name
	heroItem.txtnameen.text = roomCharacterMO.heroConfig.nameEng

	local heroMO = HeroModel.instance:getByHeroId(roomCharacterMO.heroId)
	local faith = heroMO and HeroConfig.instance:getFaithPercent(heroMO.faith)[1] or 0

	heroItem.txttrust.text = string.format("%s%%", faith * 100)
end

function RoomCharacterPlaceInfoView.destroyCharacterItem(heroItem)
	heroItem.simageicon:UnLoadImage()
	heroItem.btnclick:RemoveClickListener()
end

function RoomCharacterPlaceInfoView:_sort()
	table.sort(self._currentHeroMOList, function(x, y)
		local xHeroMO = HeroModel.instance:getByHeroId(x.heroId)
		local yHeroMO = HeroModel.instance:getByHeroId(y.heroId)
		local xFaith = xHeroMO and HeroConfig.instance:getFaithPercent(xHeroMO.faith)[1] or 0
		local yFaith = yHeroMO and HeroConfig.instance:getFaithPercent(yHeroMO.faith)[1] or 0

		if xFaith ~= yFaith then
			return yFaith < xFaith
		end

		if x.heroConfig.rare ~= y.heroConfig.rare then
			return x.heroConfig.rare > y.heroConfig.rare
		end

		return x.heroId < y.heroId
	end)
end

function RoomCharacterPlaceInfoView:_refreshBtnTips()
	local removeCount = #self._removeHeroMOList

	gohelper.setActive(self._gotip, removeCount < self._needRemoveCount)

	if removeCount < self._needRemoveCount then
		self._txttip.text = string.format(luaLang("room_character_remove_tips"), self._needRemoveCount - removeCount)
	end
end

function RoomCharacterPlaceInfoView:_refreshUI()
	for i, roomCharacterMO in ipairs(self._currentHeroMOList) do
		local heroItem = self._currentHeroItemList[i]

		if not heroItem then
			heroItem = self:getUserDataTb_()
			heroItem.go = self.viewContainer:getResInst(self.viewContainer._viewSetting.otherRes[1], self._gocurrentplacecontent, "item" .. i)

			RoomCharacterPlaceInfoView.initCharacterItem(heroItem)
			table.insert(self._currentHeroItemList, heroItem)
		end

		heroItem.btnclick:RemoveClickListener()
		heroItem.btnclick:AddClickListener(self._btnclickOnclick, self, roomCharacterMO.heroId)
		RoomCharacterPlaceInfoView.refreshCharacterItem(heroItem, roomCharacterMO)
		gohelper.setActive(heroItem.go, true)
	end

	for i = #self._currentHeroMOList + 1, #self._currentHeroItemList do
		local heroItem = self._currentHeroItemList[i]

		gohelper.setActive(heroItem.go, false)
	end

	for i, roomCharacterMO in ipairs(self._removeHeroMOList) do
		local heroItem = self._removeHeroItemList[i]

		if not heroItem then
			heroItem = self:getUserDataTb_()
			heroItem.go = self.viewContainer:getResInst(self.viewContainer._viewSetting.otherRes[1], self._goremoveplacecontent, "item" .. i)

			RoomCharacterPlaceInfoView.initCharacterItem(heroItem)
			table.insert(self._removeHeroItemList, heroItem)
		end

		heroItem.btnclick:RemoveClickListener()
		heroItem.btnclick:AddClickListener(self._btnclickOnclick, self, roomCharacterMO.heroId)
		RoomCharacterPlaceInfoView.refreshCharacterItem(heroItem, roomCharacterMO)
		gohelper.setActive(heroItem.go, true)
	end

	for i = #self._removeHeroMOList + 1, #self._removeHeroItemList do
		local heroItem = self._removeHeroItemList[i]

		gohelper.setActive(heroItem.go, false)
	end

	self:_refreshBtnTips()
end

function RoomCharacterPlaceInfoView:onOpen()
	if self.viewParam then
		self._needRemoveCount = self.viewParam.needRemoveCount or 0
	end

	self._closeCallback = self.viewParam and self.viewParam.closeCallback
	self._sureCallback = self.viewParam and self.viewParam.sureCallback
	self._callbackObj = self.viewParam and self.viewParam.callbackObj
	self._callbackParam = self.viewParam and self.viewParam.callbackParam
	self._notUpdateMapModel = self.viewParam and self.viewParam.notUpdateMapModel

	if self.viewParam then
		if not self.viewParam.roomCharacterMOList then
			local roomCharacterMOList = RoomCharacterModel.instance:getList()

			self._currentHeroMOList = {}

			for i, roomCharacterMO in ipairs(roomCharacterMOList) do
				if roomCharacterMO:isPlaceSourceState() then
					table.insert(self._currentHeroMOList, roomCharacterMO)
				end
			end

			self._removeHeroMOList = {}
			self._currentHeroItemList = {}
			self._removeHeroItemList = {}

			self:_sort()
			self:_refreshUI()
		end
	end
end

function RoomCharacterPlaceInfoView:onClose()
	return
end

function RoomCharacterPlaceInfoView:onDestroyView()
	self._simagebg:UnLoadImage()

	for i, heroItem in ipairs(self._currentHeroItemList) do
		RoomCharacterPlaceInfoView.destroyCharacterItem(heroItem)
	end

	for i, heroItem in ipairs(self._removeHeroItemList) do
		RoomCharacterPlaceInfoView.destroyCharacterItem(heroItem)
	end
end

return RoomCharacterPlaceInfoView
