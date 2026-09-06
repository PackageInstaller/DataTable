-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinebounty/view/DivineBountyShopView.lua

module("logic.extensions.divinebounty.view.DivineBountyShopView", package.seeall)

local DivineBountyShopView = class("DivineBountyShopView", ViewComponent)

function DivineBountyShopView:ctor()
	DivineBountyShopView.super.ctor(self)

	self._currSearching = nil
end

function DivineBountyShopView:unbindEvents()
	DivineBountyShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSearchClear)
	GameUtil.rmClickHandler(self._daibiBtn)
	GameUtil.rmClickHandler(self._btnJumpWandererPass)
	self._inputSearch:RemoveOnValueChanged()
	self._btnFilter:RemoveClickListener()
end

function DivineBountyShopView:bindEvents()
	DivineBountyShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSearchClear, self._onClearSearchClick, self)
	GameUtil.addClickHandler(self._daibiBtn, self._onClickDaibiBtn, self)
	self._inputSearch:AddOnValueChanged(self._searchItemByInputText, self)
	self._btnFilter:AddClickListener(self._onClickbtnFilter, self)
	GameUtil.addClickHandler(self._btnJumpWandererPass, self._onClickJumpWandererPass, self)
end

function DivineBountyShopView:buildUI()
	DivineBountyShopView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._goTableview = self:getGo("tableview")
	self._goCell = self:getGo("tableview/shopItem")
	self._goEmpty = self:getGo("emptyGo")
	self._inputSearch = self:getInput("searchpart/search")
	self._btnSearchClear = self:getBtn("searchpart/btnClear")
	self._btnJumpWandererPass = self:getGo("btnJumpWandererPass")

	local daibiItem = self:getGo("daibiItem")

	self._imgDaibiIcon = goutil.findChildImageComponent(daibiItem, "daibiIconIma")
	self._txtDaibiCount = goutil.findChildTextComponent(daibiItem, "daibiCountTxt")
	self._daibiBtn = Framework.ButtonAdapter.GetFrom(daibiItem, "daibiAddBtn")
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnFilter = self:getBtn("btnFilter")
	self._tableviewTab = self:getGo("tableviewTab")
	self._tablecellTab = self:getGo("tableviewTab/tablecellTab")
	self._scrollListTab = ScrollerList.create(self._tableviewTab, self._tablecellTab, GameUtil.handler(self._updateCellTab, self), GameUtil.handler(self._clearCellTab, self))
end

function DivineBountyShopView:onExit()
	DivineBountyShopView.super.onExit(self)

	self._inputSearch.input.text = ""

	DivineBountyController.instance:localNotify(DivineBountyController.ShopViewClose)
	self._tableview:dispose()
	self._scrollListTab:dispose()
end

function DivineBountyShopView:onEnter()
	DivineBountyShopView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineBountyGetShopInfoRes, self._refreshShopItem, self)
	self.addGEvent(self, GlobalNotify.DivineBountyBuyShopItemRes, self._onBuyShopItemRes, self)
	self.addGEvent(self, GlobalNotify.OnMaterialCountChange, self._refreshDaiBiItem, self)
	GameUtil.SetActive(self._btnJumpWandererPass, false)

	local activityId = WandererpassController.CURR_ACTIVITY_ID

	if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		GameUtil.SetActive(self._btnJumpWandererPass, true)
	end

	self._cfgsMap = DivineBountyConfig.instance:getShopCfgsMap()
	self._tabIdList = DivineBountyConfig.instance:getShopTabIdList()
	self._curTabIdx = self._tabIdList[1]
	self._cfg = self._cfgsMap[self._curTabIdx]

	if not self._cfg then
		goutil.setActive(self._goEmpty, true)

		return
	end

	self._payCoin = self._cfg[1].price

	local tabNameStr = DivineBountyConfig.instance:getCommonCfg("TAB_NAME")

	self._tabNameArr = string.split(tabNameStr, "#")

	goutil.setActive(self._goEmpty, false)

	self.clickTimer = 0
	self._shopItemInfo = {}

	self:_refreshDaiBiItem()
	self._scrollListTab:reloadData(self._tabIdList)
	DivineBountyAgent.instance:sendPM_DivineBountyGetShopInfoReq()
end

function DivineBountyShopView:_refreshShopItem(cfg)
	self._cfgsMap = DivineBountyConfig.instance:getShopCfgsMap()
	self._cfg = self._cfgsMap[self._curTabIdx]

	if TableUtil.isTableEmpty(cfg) then
		cfg = self._cfg
	end

	self._gainPetMap = self:_calGainPetMap(cfg)
	cfg = self:_sortItems(cfg)

	self._tableview:reloadData(cfg)
end

function DivineBountyShopView:_calGainPetMap(cfgs)
	local map = {}

	for i, v in ipairs(cfgs) do
		map[v.raceId] = BagModel.instance:isExistRaceId(v.raceId)
	end

	return map
end

function DivineBountyShopView:_onBuyShopItemRes()
	GlobalDispatcher:dispatch(GlobalNotify.DivineBountyGetShopInfoRes)
end

function DivineBountyShopView:_onClickJumpWandererPass()
	local activityId = WandererpassController.CURR_ACTIVITY_ID

	UIStateManager.instance:push(ViewName.WandererpassmainView, activityId, 4)
	self:close()
end

function DivineBountyShopView:_sortItems(cfgs)
	local limitBuyList = {}
	local normalList = {}

	for k, v in ipairs(cfgs) do
		local buyTimes = DivineBountyModel.instance:getShopItemBuyTimes(v.itemId)
		local limitTimes = v.limitTimes

		if limitTimes > 0 and buyTimes > 0 and limitTimes <= buyTimes then
			table.insert(limitBuyList, v)
		else
			table.insert(normalList, v)
		end
	end

	local a = 0
	local b = 0

	local function sortFunc(x, y)
		a = not self._gainPetMap[x.raceId] and 1 or 0
		b = not self._gainPetMap[y.raceId] and 1 or 0

		if a == b then
			return x.sortId > y.sortId
		end

		return a > b
	end

	table.sort(limitBuyList, sortFunc)
	table.sort(normalList, sortFunc)
	table.insertto(normalList, limitBuyList)

	return normalList
end

function DivineBountyShopView:setSpriteToImage(icon, folderUrl, imgName)
	local isNeedSetimg = icon and not string.nilorempty(imgName)

	if isNeedSetimg then
		local url = string.format("%s/%s.png", folderUrl, imgName)

		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, url)
	end
end

function DivineBountyShopView:_updateCell(view, goCell, data)
	self:_clearCell(goCell)

	local btnBuy = goCell:GetComponent(goutil.Type_UIButton)
	local item = goutil.findChild(goCell, "item")
	local headIcon = goutil.findChild(goCell, "headIcon/icon")
	local txtLimit = goutil.findChildTextComponent(goCell, "txtLimit")
	local txtPrize = goutil.findChildTextComponent(goCell, "price/txtPrice")
	local txtName = goutil.findChildTextComponent(goCell, "txtName")
	local coin = goutil.findChildImageComponent(goCell, "price/txtPrice/coin")
	local goSellOut = goutil.findChild(goCell, "sellOut")
	local goNotGain = goutil.findChild(goCell, "notGain")
	local soldOut = false
	local proxy = MaterialMgr.setCellByCfg(data.content, item)
	local cfg = CharacterConfig.instance:getModelCo(data.raceId)

	if cfg then
		if not cfg.headName then
			local headIconUrl = "icon_10005_newbaobaolong"

			self:setSpriteToImage(headIcon, "ui/icon/character", headIconUrl)

			local matType, matId, prize = MaterialMgr.getMatParams(data.price)
			local myCoins = MaterialModel.instance:getMaterialsNumber(matType, matId)

			if checknumber(matType) > 0 or checknumber(matId) > 0 then
				MaterialMgr.setIcon(coin, matType, matId)
			end

			local petName = ""
			local petData = CharacterConfig.instance:getPetCo(data.raceId)

			if petData then
				petName = petData.name
			end

			txtPrize.text = prize
			txtName.text = petName

			local str = ""

			if data.limitType ~= "none" then
				goutil.setActive(txtLimit.gameObject, true)

				local limitTimes = data.limitTimes
				local buyTimes = DivineBountyModel.instance:getShopItemBuyTimes(data.itemId) or 0

				if data.limitType == "alltime" then
					str = "永久限购"
				elseif data.limitType == "daily" then
					str = "每日限购"
				elseif data.limitType == "weekly" then
					str = "每周限购"
				end

				str = string.format("%s：%s/%s", str, limitTimes - buyTimes, limitTimes)
				txtLimit.text = str
				soldOut = limitTimes <= buyTimes
			else
				goutil.setActive(txtLimit.gameObject, false)
				goutil.setActive(goSellOut, false)
			end

			goutil.setActive(goSellOut, soldOut)
			GameUtil.rmClickHandler(btnBuy)

			if soldOut then
				GameUtil.addClickHandler(btnBuy, function()
					if not self:PreventTooFastClick() then
						return
					end

					FloatWordMgr.instance:show("已达限购次数")
				end, self)
			elseif myCoins < prize then
				GameUtil.addClickHandler(btnBuy, function()
					if not self:PreventTooFastClick() then
						return
					end

					FloatWordMgr.instance:show("神曜币不足")
				end, self)
			else
				GameUtil.addClickHandler(btnBuy, function()
					self:_openBuyView(data, str)
				end, self)
			end

			goutil.setActive(goNotGain, not self._gainPetMap[data.raceId])
		end
	end
end

function DivineBountyShopView:_openBuyView(data, txt)
	self:_refreshShopItem(nil)
	UIStateManager.instance:push(ViewName.DivineBountyBuyView, data, txt)
end

function DivineBountyShopView:_clearCell(goCell)
	local item = goutil.findChild(goCell, "item")
	local headIcon = goutil.findChild(goCell, "headIcon/icon")

	uGuiUtil.clearImage(item)
	MaterialMgr.resetAll(headIcon)
end

function DivineBountyShopView:_searchItemByInputText()
	local text = self._inputSearch:GetText()
	local cfgList = {}

	for i, v in ipairs(self._cfg) do
		if self:_onFilter(v) then
			local name = MaterialMgr.getMaterialsNameByCfg(v.content) or ""

			if string.find(name, text) then
				table.insert(cfgList, v)
			else
				local petName = MaterialMgr.getMaterialsName(MatType.Pet, v.raceId)

				if string.find(petName, text) then
					table.insert(cfgList, v)
				end
			end
		end
	end

	self:_refreshShopItem(cfgList)
end

function DivineBountyShopView:_onClearSearchClick()
	self._inputSearch.input.text = ""
end

function DivineBountyShopView:_refreshDaiBiItem()
	if self._txtDaibiCount == nil then
		return
	end

	local matType, matId, _ = MaterialMgr.getMatParams(self._payCoin)

	if checknumber(matType) <= 0 or checknumber(matId) <= 0 then
		return
	end

	MaterialMgr.setIcon(self._imgDaibiIcon, matType, matId)

	local count = MaterialModel.instance:getMaterialsNumber(matType, matId)

	self._txtDaibiCount.text = tostring(count)
end

function DivineBountyShopView:_onClickDaibiBtn()
	local matType, matId, _ = MaterialMgr.getMatParams(self._payCoin)

	if checknumber(matType) <= 0 or checknumber(matId) <= 0 then
		return
	end

	MaterialMgr.openGetSource(matType, matId)
end

function DivineBountyShopView:PreventTooFastClick(isTips)
	if self.clickTimer == 0 then
		self.clickTimer = ServerTime.now()
	else
		local now = ServerTime.now()

		if now - self.clickTimer < 1.5 then
			return
		end

		self.clickTimer = now
	end

	return true
end

function DivineBountyShopView:_onClickbtnFilter()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_DIVINEBOUNTY, pos, sizeDelta, GameUtil.handler(self._updateFilterData, self))
end

function DivineBountyShopView:_updateFilterData(starList, jobList, rareList)
	self:_searchItemByInputText()
end

function DivineBountyShopView:_onFilter(cfg)
	local petCo = CharacterConfig.instance:getPetCo(cfg.raceId)

	return (PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_DIVINEBOUNTY, petCo, petCo.rare, cfg.raceId))
end

function DivineBountyShopView:_updateCellTab(view, cell, data)
	local changeGroup = cell:GetComponent(typeof(UIChangeGroup))
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local changeGroupIdx = data == self._curTabIdx and 1 or 0

	txtName.text = self._tabNameArr[data]

	changeGroup:SetState(changeGroupIdx)
	GameUtil.addClickHandler(cell, function()
		self._curTabIdx = data

		self:_onClearSearchClick()
		self._scrollListTab:reloadData(self._tabIdList)
		self:_refreshShopItem()
	end, self)
end

function DivineBountyShopView:_clearCellTab(cell)
	GameUtil.rmClickHandler(cell)
end

return DivineBountyShopView
