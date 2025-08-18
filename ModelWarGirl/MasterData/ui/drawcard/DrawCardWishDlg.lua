-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawCardWishDlg.lua

local WishCardListPanel = require("UI/DrawCard/WishCardListPanel")
local WishCardSelectPanel = require("UI/DrawCard/WishCardSelectPanel")
local DrawCardConfig = require("DesignerScript/DrawCardConfig")
local strClassName = "DrawCardWishDlg"
local DrawCardWishDlg = Class(strClassName, UIControls.Window)

function DrawCardWishDlg:ctor(...)
	self:initUI()
end

function DrawCardWishDlg:initUI(...)
	self.cardSelectPanel = WishCardSelectPanel(self, "CardListPanel")

	self.cardSelectPanel:setCellClickCallback(Slot(self.onHeroCellClick, self))

	self.clickPanel = UIControls.Button(self, "UIClickThrough")

	self.clickPanel:addEventClick(self._onClickCloseSelect)

	self.campList = {
		Const.CAMP_TYPE.CLASS,
		Const.CAMP_TYPE.POPULAR,
		Const.CAMP_TYPE.LEGEND
	}
	self.campWishListPanel = {}
	self.slotOfWishListClick = Slot(self.onWishListClick, self)
	self.slotOfWishCardClick = Slot(self.onWishCardClick, self)

	for i, camp in ipairs(self.campList) do
		local wishList = WishCardListPanel(self, "InforPanel/CardList0" .. i)

		wishList:setCardListInfo(camp, self.slotOfWishListClick, self.slotOfWishCardClick)

		self.campWishListPanel[camp] = wishList
	end

	self.closeBtn = UIControls.Button(self, "BtnClose")

	self.closeBtn:addEventClick(self._onClickClose)

	self.tipsBtn = UIControls.Button(self, "BtnTips")

	self.tipsBtn:addEventClick(self._onClickTips)

	self.tipsTxt = UIControls.Label(self, "InforPanel/TipsText")

	self.tipsTxt:setText(DrawCardConfig.WISH_DLG_TIPS)

	self.rootAnim = UIControls.UIAni(self, "")
	self.campNewList = {}
	self._allHeros = {}
	self.bagMaxHeros = {}
	self.wishLists = {}
	self.heros = {}
end

function DrawCardWishDlg:onOpen()
	DrawCardWishDlg.super.onOpen(self)
	self:_initAllHerosList()
	self:_initWishLists()
	self:_refreshWishList()
	self:_refreshNewFlag()
	self:_refreshDesireRecommendList()

	self._curEditCamp = nil

	self:_refreshEditState()
end

function DrawCardWishDlg:_initAllHerosList()
	self.bagMaxHeros = CurAvatar:getHeroIdMaxStarHeroDic()
	self._allHeros = CurAvatar:getHandBookHeroList()
end

function DrawCardWishDlg:_initWishLists()
	self.wishLists = CurAvatar.wishList
end

function DrawCardWishDlg:_refreshWishList(camp)
	if not camp then
		for _, camp in ipairs(self.campList) do
			self:_refreshWishList(camp)
		end

		return
	end

	local wishListPanel = self.campWishListPanel[camp]
	local wishList = self.wishLists[camp]

	if not wishListPanel or not wishList then
		return
	end

	wishListPanel:setWishList(wishList)
end

function DrawCardWishDlg:_refreshNewFlag(...)
	local hasNew, newDict = CurAvatar:checkWishListNew()
	local campHasNew = {}

	self.campNewList = {}

	if hasNew then
		for heroId, heroCamp in pairs(newDict) do
			campHasNew[heroCamp] = true

			if not self.campNewList[heroCamp] then
				self.campNewList[heroCamp] = {}
			end

			table.insert(self.campNewList[heroCamp], heroId)
		end
	end

	for panelCamp, wishListPanel in pairs(self.campWishListPanel) do
		if not hasNew then
			wishListPanel:setNew(false)
		else
			wishListPanel:setNew(campHasNew[panelCamp] or false)
		end
	end
end

function DrawCardWishDlg:_refreshDesireRecommendList()
	self.desireRecommendList = CurAvatar.desireRecommendList or CurAvatar:unpackDefaultDesireRecommendList()
end

function DrawCardWishDlg:_refreshEditState(needInit)
	if not self._curEditCamp then
		self.clickPanel:setVisible(false)
		self.cardSelectPanel:setVisible(false)
	else
		self.clickPanel:setVisible(true)
		self.cardSelectPanel:setVisible(true)

		if needInit then
			if self.campNewList[self._curEditCamp] then
				CurAvatar:seenNewHero(self.campNewList[self._curEditCamp])
				self.campWishListPanel[self._curEditCamp]:setNew(false)
			end

			self:_filterHeros(self._curEditCamp)
		end

		local wishList = self.wishLists[self._curEditCamp]

		if self.heros and wishList then
			self.cardSelectPanel:setHeroList(self.heros, wishList, self.campNewList[self._curEditCamp], self.desireRecommendList[self._curEditCamp], self._curEditCamp)
		end
	end
end

function DrawCardWishDlg:_filterHeros(camp)
	self.heros = {}

	for i, hero in ipairs(self._allHeros) do
		if hero.camp == camp and hero.star == 5 and hero:notLimitedHero() and self:_heroValid(hero.id) then
			if self.bagMaxHeros[hero.id] then
				table.insert(self.heros, self.bagMaxHeros[hero.id])
			else
				table.insert(self.heros, hero)
			end
		end
	end
end

function DrawCardWishDlg:_heroValid(heroId)
	return CurAvatar:wishHeroTimeValid(heroId)
end

function DrawCardWishDlg:selectOneHero(camp, heroId)
	if #self.wishLists[camp] >= 5 then
		MsgManager.notice(Lang.get(30268))

		return false
	end

	table.insert(self.wishLists[camp], heroId)

	self.dirty = true

	return true
end

function DrawCardWishDlg:cancelOneHero(camp, heroId)
	if #self.wishLists[camp] <= 0 then
		return false
	end

	for i, id in ipairs(self.wishLists[camp]) do
		if id == heroId then
			table.remove(self.wishLists[camp], i)

			self.dirty = true

			return true
		end
	end

	return false
end

function DrawCardWishDlg:_saveWishList(...)
	if not self.dirty then
		return
	end

	local idList = CurAvatar:packWishList(self.wishLists)

	RPC.drawSetDesire(idList)

	self.dirty = nil
end

function DrawCardWishDlg:onWishListClick(camp)
	if self._curEditCamp ~= camp then
		local preCamp = self._curEditCamp

		self:_saveWishList()

		self._curEditCamp = camp

		for panelCamp, wishListPanel in pairs(self.campWishListPanel) do
			wishListPanel:setSelected(panelCamp == camp)
		end

		self:_refreshEditState(true)

		if camp == nil then
			self.rootAnim:startAni("WishHideCard", true)
		elseif preCamp == nil then
			self.rootAnim:startAni("WishShowCard", true)
		else
			self.rootAnim:startAni("WishRiseInfo", true)
		end
	end
end

function DrawCardWishDlg:onWishCardClick(camp, heroId)
	if not self._curEditCamp or self._curEditCamp ~= camp then
		self:onWishListClick(camp)
	else
		local suc = self:cancelOneHero(camp, heroId)

		if suc then
			self:_refreshWishList(camp)
			self:_refreshEditState()
		end
	end
end

function DrawCardWishDlg:onHeroCellClick(hero, isAdd)
	local suc

	if isAdd then
		suc = self:selectOneHero(self._curEditCamp, hero.id)
	else
		suc = self:cancelOneHero(self._curEditCamp, hero.id)
	end

	local campNewHeros = self.campNewList[hero.camp]

	if campNewHeros then
		for order, heroId in ipairs(campNewHeros) do
			if heroId == hero.id then
				table.remove(campNewHeros, order)

				break
			end
		end
	end

	if suc then
		self:_refreshWishList(self._curEditCamp)
		self:_refreshEditState()
	end
end

function DrawCardWishDlg:_hasEmpty()
	for camp, wishList in pairs(self.wishLists) do
		if #wishList < 5 then
			return true
		end
	end

	return false
end

function DrawCardWishDlg:_onClickCloseSelect(...)
	self:onWishListClick(nil)
end

function DrawCardWishDlg:_onClickClose(...)
	if self:_hasEmpty() then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), DrawCardConfig.WISH_EMPTY_NOTICE, Slot(self._readClose, self), nil, -1)
	else
		self:_readClose()
	end
end

function DrawCardWishDlg:_readClose()
	self:_saveWishList()
	self:setVisible(false)
end

function DrawCardWishDlg:_onClickTips(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_WISH_LIST)
end

return DrawCardWishDlg
