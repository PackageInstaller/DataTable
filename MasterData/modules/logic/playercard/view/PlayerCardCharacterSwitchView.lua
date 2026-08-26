-- chunkname: @modules/logic/playercard/view/PlayerCardCharacterSwitchView.lua

module("modules.logic.playercard.view.PlayerCardCharacterSwitchView", package.seeall)

local PlayerCardCharacterSwitchView = class("PlayerCardCharacterSwitchView", BaseView)

function PlayerCardCharacterSwitchView:onInitView()
	self.switchViewGO = gohelper.findChild(self.viewGO, "#go_characterswitchview/characterswitchview")
	self._btnClose = gohelper.findChildButton(self.viewGO, "#go_characterswitchview/characterswitchview/#btn_close")
	self._btnchange = gohelper.findChildButtonWithAudio(self.switchViewGO, "right/start/#btn_change", AudioEnum.UI.Store_Good_Click)
	self._goshowing = gohelper.findChild(self.switchViewGO, "right/start/#go_showing")
	self._scrollcard = gohelper.findChildScrollRect(self.switchViewGO, "right/mask/#scroll_card")
	self._btntimerank = gohelper.findChildButtonWithAudio(self.switchViewGO, "right/#btn_timerank")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.switchViewGO, "right/#btn_rarerank")
	self._gobtns = gohelper.findChild(self.switchViewGO, "#go_btns")
	self._goinfo = gohelper.findChild(self.switchViewGO, "left/#go_info")
	self._simagesignature = gohelper.findChildSingleImage(self.switchViewGO, "left/#go_info/#simage_signature")
	self._txttime = gohelper.findChildText(self.switchViewGO, "left/#go_info/#txt_time")
	self._goheroskin = gohelper.findChild(self.switchViewGO, "left/#go_heroskin")
	self._gobgbottom = gohelper.findChild(self.switchViewGO, "left/#go_heroskin/#go_bgbottom")
	self._scrollskin = gohelper.findChildScrollRect(self.switchViewGO, "left/#go_heroskin/#scroll_skin")
	self._goheroskinItem = gohelper.findChild(self.switchViewGO, "left/#go_heroskin/#scroll_skin/Viewport/Content/#go_heroskinItem")
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardCharacterSwitchView:addEvents()
	self._btnchange:AddClickListener(self._btnchangeOnClick, self)
	self._btntimerank:AddClickListener(self._btntimerankOnClick, self)
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
	self._btnClose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.SwitchHero, self._onSwitchHero, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.SwitchHeroSkin, self._switchHeroSkin, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.SwitchHeroL2d, self._switchL2d, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.RefreshSwitchView, self._onRefreshSwitchView, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.UpdateCardInfo, self.refreshView, self)
end

function PlayerCardCharacterSwitchView:removeEvents()
	self._btnchange:RemoveClickListener()
	self._btntimerank:RemoveClickListener()
	self._btnrarerank:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function PlayerCardCharacterSwitchView:_editableInitView()
	self._showItemList = self:getUserDataTb_()
	self._cacheItemList = self:getUserDataTb_()

	self._goinfo:SetActive(true)

	self._timeBtns = self:getUserDataTb_()
	self._timeArrow = self:getUserDataTb_()
	self._rareBtns = self:getUserDataTb_()
	self._rareArrow = self:getUserDataTb_()

	for i = 1, 2 do
		self._timeBtns[i] = gohelper.findChild(self._btntimerank.gameObject, "btn" .. tostring(i))
		self._timeArrow[i] = gohelper.findChild(self._timeBtns[i], "txt/arrow").transform
		self._rareBtns[i] = gohelper.findChild(self._btnrarerank.gameObject, "btn" .. tostring(i))
		self._rareArrow[i] = gohelper.findChild(self._rareBtns[i], "txt/arrow").transform
	end

	self._sortIndex = 2
	self._asceTime = false
	self._asceRare = false
end

function PlayerCardCharacterSwitchView:_btncloseOnClick()
	if not PlayerCardModel.instance:checkHeroDiff() then
		GameFacade.showMessageBox(MessageBoxIdDefine.PlayerCardSelectTips, MsgBoxEnum.BoxType.Yes_No, PlayerCardCharacterSwitchViewContainer.yesCallback)
	else
		self:closeThis()
	end
end

function PlayerCardCharacterSwitchView:_btnchangeOnClick()
	PlayerCardCharacterSwitchListModel.instance:changeMainHero(self._heroId, self._skinId, self._isRandom, self._isL2d)
end

function PlayerCardCharacterSwitchView:_btntimerankOnClick()
	if self._sortIndex ~= 1 then
		self._sortIndex = 1
	else
		self._asceTime = not self._asceTime
	end

	self._asceRare = false

	self:_refreshBtnIcon()
end

function PlayerCardCharacterSwitchView:_btnrarerankOnClick()
	if self._sortIndex ~= 2 then
		self._sortIndex = 2
	else
		self._asceRare = not self._asceRare
	end

	self._asceTime = false

	self:_refreshBtnIcon()
end

function PlayerCardCharacterSwitchView:_onSwitchHero(param)
	self:_switchHero(param[1], param[2], param[3], self._isL2d)
end

function PlayerCardCharacterSwitchView:_switchHeroSkin(heroId, skinId)
	self:_switchHero(heroId, skinId, false, self._isL2d)
end

function PlayerCardCharacterSwitchView:_switchL2d()
	self._isL2d = not self._isL2d

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshSwitchView, {
		heroId = self._heroId,
		skinId = self._skinId,
		isL2d = self._isL2d
	})
end

function PlayerCardCharacterSwitchView:_switchHero(heroId, skinId, isRandom, isL2d)
	if isRandom then
		self:_updateHero(self._curHeroId, self._curSkinId, isRandom, isL2d)
	else
		self:_updateHero(heroId, skinId, isRandom, isL2d)
	end
end

function PlayerCardCharacterSwitchView:_showMainHero()
	self._curHeroId, self._curSkinId, self._curRandom, self._curIsL2d = self.cardInfo:getMainHero()

	if self._curHeroId and self._curSkinId then
		self:_switchHero(self._curHeroId, self._curSkinId, self._curRandom, self._curIsL2d)
		self:_refreshSelect()
	end
end

function PlayerCardCharacterSwitchView:_refreshSelect()
	local heroId = not self._isRandom and self._heroId
	local mo = PlayerCardCharacterSwitchListModel.instance:getMoByHeroId(heroId)
	local scrollView = self.viewContainer.scrollView

	if mo then
		scrollView:setSelect(mo)
	end
end

function PlayerCardCharacterSwitchView:onUpdateParam()
	self:_updateParam()
	self:refreshView()
end

function PlayerCardCharacterSwitchView:onOpen()
	self:_updateParam()
	PlayerCardCharacterSwitchListModel.instance:initHeroList()
	self:refreshView()
	self:_refreshBtnIcon()
end

function PlayerCardCharacterSwitchView:_updateParam()
	self.userId = PlayerModel.instance:getMyUserId()
	self.cardInfo = PlayerCardModel.instance:getCardInfo(self.userId)
end

function PlayerCardCharacterSwitchView:refreshView()
	if not self.cardInfo then
		return
	end

	self:_showMainHero()
end

function PlayerCardCharacterSwitchView:_refreshBtnIcon()
	local tag = self._sortIndex

	if tag == 1 then
		PlayerCardCharacterSwitchListModel.instance:sortByTime(self._asceTime)
	else
		PlayerCardCharacterSwitchListModel.instance:sortByRare(self._asceRare)
	end

	gohelper.setActive(self._timeBtns[1], tag ~= 1)
	gohelper.setActive(self._timeBtns[2], tag == 1)
	gohelper.setActive(self._rareBtns[1], tag ~= 2)
	gohelper.setActive(self._rareBtns[2], tag == 2)

	local scaleTime = self._asceTime and -1 or 1
	local scaleRare = self._asceRare and -1 or 1

	transformhelper.setLocalScale(self._timeArrow[1], 1, scaleTime, 1)
	transformhelper.setLocalScale(self._timeArrow[2], 1, scaleTime, 1)
	transformhelper.setLocalScale(self._rareArrow[1], 1, scaleRare, 1)
	transformhelper.setLocalScale(self._rareArrow[2], 1, scaleRare, 1)
end

function PlayerCardCharacterSwitchView:changeHero(id)
	PlayerCardCharacterSwitchListModel.instance.curHeroId = id
end

function PlayerCardCharacterSwitchView:_updateHero(heroId, skinId, isRandom, isL2d)
	if isRandom then
		self:changeHero()
	else
		self:changeHero(heroId)
	end

	self._heroId = heroId
	self._skinId = skinId
	self._isRandom = isRandom
	self._isL2d = isL2d

	local hero = HeroModel.instance:getByHeroId(self._heroId)

	self._hero = hero
	self._heroSkinConfig = SkinConfig.instance:getSkinCo(self._skinId or hero and hero.skin)

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshSwitchView, {
		heroId = self._heroId,
		skinId = self._skinId,
		isL2d = self._isL2d
	})
	PlayerCardModel.instance:setSelectHero(self._heroId, self._skinId)
end

function PlayerCardCharacterSwitchView:_onRefreshSwitchView()
	self:showTip()
	self:refreshSignature()
	self:refreshCreateTime()
	self:_showSkinList()
end

function PlayerCardCharacterSwitchView:refreshSignature()
	if not self._hero then
		return
	end

	self._simagesignature:UnLoadImage()
	self._simagesignature:LoadImage(ResUrl.getSignature(self._hero.config.signature))
end

function PlayerCardCharacterSwitchView:showTip()
	local showCurHero = self._curHeroId == self._heroId and self._curSkinId == self._skinId and self._curRandom == self._isRandom and self._curIsL2d == self._isL2d

	gohelper.setActive(self._btnchange.gameObject, not showCurHero)
	gohelper.setActive(self._goshowing.gameObject, showCurHero)
end

function PlayerCardCharacterSwitchView:refreshCreateTime()
	if not self._hero then
		return
	end

	local timeStr = ServerTime.formatTimeInLocal(self._hero.createTime / 1000, "%Y / %m / %d")

	if not timeStr then
		return
	end

	self._txttime.text = timeStr
end

local yOffset = {
	149.2,
	-64.3,
	-151.4
}

function PlayerCardCharacterSwitchView:_showSkinList(heroId, showSkinId)
	local heroId = self._heroId
	local showSkinId = self._skinId
	local isRandom = self._isRandom

	gohelper.setActive(self._goheroskin, not isRandom)

	if not heroId then
		return
	end

	local heroMO = HeroModel.instance:getByHeroId(heroId)
	local skinInfoList = tabletool.copy(heroMO.skinInfoList)

	table.sort(skinInfoList, PlayerCardCharacterSwitchView._sort)

	local skinInfoMO = SkinInfoMO.New()

	skinInfoMO:init({
		expireSec = 0,
		skin = heroMO.config.skinId
	})
	table.insert(skinInfoList, 1, skinInfoMO)

	skinInfoList = self:removeDuplicates(skinInfoList)

	self:_hideAllItems()

	for _, skinInfo in ipairs(skinInfoList) do
		local skinId = skinInfo.skin

		self:_showSkinItem(heroId, skinId, skinId == showSkinId)
	end

	local offsetIndex = math.min(#skinInfoList, #yOffset)

	recthelper.setAnchorY(self._gobgbottom.transform, yOffset[offsetIndex])
end

function PlayerCardCharacterSwitchView._sort(a, b)
	return a.skin < b.skin
end

function PlayerCardCharacterSwitchView:removeDuplicates(skinInfoList)
	local checkDict = {}
	local newArray = {}

	for _, skinInfo in ipairs(skinInfoList) do
		if not checkDict[skinInfo.skin] then
			checkDict[skinInfo.skin] = true

			table.insert(newArray, skinInfo)
		end
	end

	return newArray
end

function PlayerCardCharacterSwitchView:_hideAllItems()
	local count = #self._showItemList

	for i = 1, count do
		local item = self._showItemList[i]

		gohelper.setActive(item.viewGO, false)
		table.insert(self._cacheItemList, item)

		self._showItemList[i] = nil
	end
end

function PlayerCardCharacterSwitchView:_showSkinItem(heroId, skinId, selected)
	local item = table.remove(self._cacheItemList)

	if not item then
		local go = gohelper.cloneInPlace(self._goheroskinItem)

		item = MonoHelper.addLuaComOnceToGo(go, PlayerCardCharacterSwitchSkinItem)
	end

	gohelper.setAsLastSibling(item.viewGO)
	table.insert(self._showItemList, item)
	item:showSkin(heroId, skinId)
	item:setSelected(selected)
end

function PlayerCardCharacterSwitchView:onClose()
	self.animator:Play("close")
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.OnCloseHeroView)
end

function PlayerCardCharacterSwitchView:onDestroyView()
	self._simagesignature:UnLoadImage()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 1, self)
end

return PlayerCardCharacterSwitchView
