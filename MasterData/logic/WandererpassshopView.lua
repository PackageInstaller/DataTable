-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wandererpass/view/WandererpassshopView.lua

module("logic.extensions.wandererpass.view.WandererpassshopView", package.seeall)

local WandererpassshopView = class("WandererpassshopView", ViewComponent)

WandererpassshopView.MoneySortType = {
	Down = 1,
	Up = 2,
	None = 0
}
WandererpassshopView.ShowParamType = {
	tagHot = "tagHot"
}

function WandererpassshopView:buildUI()
	WandererpassshopView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._tableContent = self:getGo("tableview/Nego_Viewport/Nego_Content")
	self._tablecell = self:getGo("tableCell")

	local tableOffset = GameUtil.getAnchoredPos(self._tableview)
	local tableItemCon = self:getGo("tableCell/itemGo")
	local itemOffset = GameUtil.getAnchoredPos(tableItemCon)

	self._itemOffset = tableOffset + itemOffset
	self._itemTable = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClear = self:getBtn("searchpart/btnClear")
	self._inputComp = self:getInput("searchpart/search")
	self._searchpartGo = self:getGo("searchpart")
	self._itemBgPrefabGo = self:getGo("itemBgPrefab")

	GameUtil.SetActive(self._itemBgPrefabGo, false)

	self._bgconGo = self:getGo("tableview/Nego_Viewport/Nego_Content/bgcon")
	self._btnFilter = self:getBtn("btnFilter")
	self._btnSort = self:getBtn("btnSort")
	self._ImgSortChange = self:getGo("btnSort/ImgSort"):GetComponent(ComponentType.UIImageSpriteChange)
	self._pass = self:getGo("pass")
	self._btnBuy = self:getGo("btnBuy")
end

function WandererpassshopView:bindEvents()
	WandererpassshopView.super.buildUI(self)
	self._btnClear:AddClickListener(self._onClickbtnClear, self)
	self._inputComp:AddOnValueChanged(self._inputValueChanged, self)
	self._btnFilter:AddClickListener(self._onClickbtnFilter, self)
	self._btnSort:AddClickListener(self._onClickbtnSort, self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
end

function WandererpassshopView:unbindEvents()
	WandererpassshopView.super.unbindEvents(self)
	self._btnClear:RemoveClickListener()
	self._inputComp:RemoveOnValueChanged()
	self._btnFilter:RemoveClickListener()
	self._btnSort:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnBuy)
end

function WandererpassshopView:onEnter()
	WandererpassshopView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.UpdateActiveShopInfo, self._updateUI, self)
	self.addGEvent(self, ActivityShopAgent.PM_BuyShopItemRes, self._updateUI, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = math.floor(self._activityId / 1000)
	self._tabId = checknumber(params[2])

	if self._tabId == 0 then
		self._tabId = 1
	end

	self:_initMoneySort()
	self:_setTopGoldBar()
	ActivityshopController.instance:getAllShopItemInfo(self._activityType, self._activityId)
	self:_onClickbtnClear()
	self:_updateUI()
	self.addGEvent(self, GlobalNotify.ON_WANDERER_PASS_GET_INFO, self._refreshUI, self)
	WandererPassAgent.instance:sendPM_WandererPassGetInfoReq(self._activityId)
	self:_refreshUI()
end

function WandererpassshopView:_refreshUI()
	local info = WandererpassModel.instance:getInfo(self._activityId) or {}

	GameUtil.SetActive(self._pass, checkbool(info.hasBuy))
end

function WandererpassshopView:onExit()
	WandererpassshopView.super.onExit(self)
	self._itemTable:dispose()
	self:_destroyItemBgs()
end

function WandererpassshopView:onExitFinished()
	if self._itemPools then
		self._itemPools:clear()

		self._itemPools = nil
	end
end

function WandererpassshopView:_initMoneySort()
	self._sortType = WandererpassshopView.MoneySortType.None

	self:_updateSortImg()
end

function WandererpassshopView:_refreshTabs()
	return
end

function WandererpassshopView:_updateUI()
	self:_destroyItemBgs()

	self._tabDataList = ActivityshopConfig.instance:getActivityShopCfgWithPage(self._activityType, self._activityId) or {}

	local dataList = self._tabDataList[self._tabId]

	if not dataList then
		return
	end

	dataList = self:_filterByPanel(dataList)
	dataList = self:_filterBySearchText(dataList)

	local list1 = {}
	local list2 = {}
	local list3 = {}
	local sellOut = false

	for i, v in ipairs(dataList) do
		local isShow = v.showflag ~= 1

		if isShow then
			sellOut = false

			if v.sellPeriodLimit ~= "none" then
				local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, v.shopItemId)

				if buyTime >= v.sellLimitCount then
					sellOut = true
				end
			end

			if not sellOut and v.activityLimitCount > 0 then
				local buyTimeInActive = ActivityshopModel.instance:getActiveShopBuyTimesInActivity(self._activityType, self._activityId, v.shopItemId)

				sellOut = buyTimeInActive >= v.activityLimitCount
			end

			if not sellOut then
				if PayShopController.instance:checkTimeStr(v.sellTime) then
					table.insert(list1, v)
				else
					table.insert(list3, v)
				end
			else
				table.insert(list2, v)
			end
		end
	end

	local finalList = self:_sortAndMerge(list1, list2, list3)

	self._itemTable:reloadData(finalList)
	self:_buildItemBgs(#list1)
end

function WandererpassshopView:_sortAndMerge(list1, list2, list3)
	local beforeList = {}

	if self._sortType == WandererpassshopView.MoneySortType.None then
		beforeList = list1

		table.sort(list1, WandererpassshopView.sortFunc)
	else
		local priceMap = {}
		local isUp = self._sortType == WandererpassshopView.MoneySortType.Up
		local godDiamondList = {}
		local diamondList = {}
		local otherList = {}

		for i, v in ipairs(list1) do
			local param = self:_getPrice(v.shopItemId, priceMap, v.sellPrice)

			if param.matType == MatType.Diamond or param.matType == MatType.Diamond_Consume then
				table.insert(diamondList, v)
			elseif param.matType == MatType.GodGem then
				table.insert(godDiamondList, v)
			else
				table.insert(otherList, v)
			end
		end

		local paramA, paramB

		local function sortFunc(a, b)
			paramA = self:_getPrice(a.shopItemId, priceMap, a.sellPrice)
			paramB = self:_getPrice(b.shopItemId, priceMap, b.sellPrice)

			if isUp then
				return paramA.matNum < paramB.matNum
			else
				return paramA.matNum > paramB.matNum
			end
		end

		table.sort(diamondList, sortFunc)
		table.sort(godDiamondList, sortFunc)
		table.sort(otherList, sortFunc)
		table.insertto(godDiamondList, diamondList)
		table.insertto(godDiamondList, otherList)

		beforeList = godDiamondList
	end

	table.sort(list2, WandererpassshopView.sortFunc)
	table.sort(list3, WandererpassshopView.sortFunc)
	table.insertto(beforeList, list2)
	table.insertto(beforeList, list3)

	return beforeList
end

function WandererpassshopView:_getPrice(shopItemId, priceMap, sellPrice)
	if not priceMap[shopItemId] then
		local matType, id, matNum = MaterialMgr.getMatParams(sellPrice)

		priceMap[shopItemId] = {
			matNum = matNum,
			matType = matType
		}
	end

	return priceMap[shopItemId]
end

function WandererpassshopView.sortFunc(a, b)
	return a.sort < b.sort
end

function WandererpassshopView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local btnBuy = GameUtil.asBtn(goutil.findChild(go, "btnBuy"))
	local payIcon = goutil.findChild(go, "btnBuy/Text/payIcon")
	local itemGo = goutil.findChild(go, "itemGo")
	local txtPrice = goutil.findChildTextComponent(go, "btnBuy/Text")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtLimit = goutil.findChildTextComponent(go, "txtLimit")
	local sellOutGo = goutil.findChild(go, "selloutGo")
	local lockGo = goutil.findChild(go, "lockGo")
	local tagGo = goutil.findChild(go, "tag")
	local txtTag = goutil.findChildTextComponent(go, "tag/txtTag")
	local hasTagStr = not string.nilorempty(data.tagStr)
	local matType, id, matNum = MaterialMgr.getMatParams(data.sellPrice)
	local sellContents = string.split(data.sellContent, "#")

	MaterialMgr.setIcon(payIcon, matType, id)
	MaterialMgr.setCellByCfg(sellContents[1], itemGo)

	txtName.text = data.name == "" and MaterialMgr.getMaterialsName(matType, id) or data.name
	txtPrice.text = matNum

	local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, data.shopItemId)

	txtLimit.text = data.sellLimitCount > 0 and langPara("限购次数：%d/%d", data.sellLimitCount - buyTime, data.sellLimitCount) or ""

	GameUtil.SetActive(sellOutGo, data.sellLimitCount > 0 and buyTime >= data.sellLimitCount)
	goutil.setActive(tagGo, hasTagStr)

	if hasTagStr then
		txtTag.text = data.tagStr
	end

	local isIntime, startTime = GameUtil.checkTimeStr(data.sellTime, true)

	goutil.setActive(lockGo, not isIntime)
	btnBuy:RemoveClickListener()
	btnBuy:AddClickListener(function()
		if not isIntime then
			FloatWordMgr.instance:show(data.notSellTimeTips)

			return
		end

		self:_onClickBtnBuy(data)
	end)

	local tagHot = goutil.findChild(go, "tagHot")
	local tagHotValue = checknumber(self:getShowParam(data.showParams, WandererpassshopView.ShowParamType.tagHot))

	if tagHotValue > 0 then
		goutil.setActive(tagHot, true)
		GameUtil.setUIImageSpriteIdx(tagHot, tagHotValue - 1)
	else
		goutil.setActive(tagHot, false)
	end
end

function WandererpassshopView:_clearCell(cell)
	local go = cell.gameObject
	local itemGo = goutil.findChild(go, "itemGo")
	local payIcon = goutil.findChild(go, "btnAdd/Text/payIcon")
	local btnBuy = GameUtil.asBtn(goutil.findChild(go, "btnBuy"))

	btnBuy:RemoveClickListener()
	MaterialMgr.clearIcon(payIcon)
	MaterialMgr.resetAll(itemGo)
end

function WandererpassshopView:_onClickBtnBuy(shopItemCfg)
	local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, shopItemCfg.shopItemId)

	if shopItemCfg.sellLimitCount > 0 and buyTime - shopItemCfg.sellLimitCount >= 0 then
		FloatWordMgr.instance:show("可购买次数不足")

		return
	end

	local info = WandererpassModel.instance:getInfo(self._activityId) or {}

	if not checkbool(info.hasBuy) then
		FloatWordMgr.instance:show("尚未解锁逍遥令，无法购买")

		return
	end

	UIStateManager.instance:push(ViewName.NewyeargoodsshopbuyView, shopItemCfg.activityType, shopItemCfg.activityId, shopItemCfg.shopItemId)
end

function WandererpassshopView:_onClickClose()
	self:close()
end

function WandererpassshopView:_onClickbtnClear()
	self._inputComp:SetText("")
end

function WandererpassshopView:_onClickbtnFilter()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_NEWYEAR_GOODSSHOP, pos, sizeDelta, GameUtil.handler(self._updateUI, self))
end

function WandererpassshopView:_onClickbtnSort()
	self._sortType = self._sortType + 1

	if self._sortType > WandererpassshopView.MoneySortType.Up then
		self._sortType = WandererpassshopView.MoneySortType.None
	end

	self:_updateSortImg()
	self:_updateUI()
end

function WandererpassshopView:_inputValueChanged(text)
	if self._inputComp:GetText() == self._lastInputTxt then
		return
	end

	self._lastInputTxt = text

	self:_updateUI()
end

function WandererpassshopView:_isMatch(skinId)
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
	local maxAwaken = CharacterConfig.instance:getMaxAwaken(skinCfg.raceId)
	local rare = CharacterConfig.instance:getRareByAwakenLv(maxAwaken, skinCfg.raceId)
	local cfg = CharacterConfig.instance:getPetCo(skinCfg.raceId)

	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_NEWYEAR_GOODSSHOP, cfg, rare, skinId)
end

function WandererpassshopView:_filterByPanel(dataList)
	local list = {}
	local matType, matId

	for i, cfg in ipairs(dataList) do
		local arr = string.split(cfg.sellContent, "#")
		local isSkinOrPet = false

		for _, matStr in ipairs(arr) do
			matType, matId = MaterialMgr.getMatParams(matStr)

			if matType == MatType.Pet or matType == MatType.PET_SKIN then
				isSkinOrPet = true

				if self:_isMatch(matId) then
					table.insert(list, cfg)
				end
			end
		end

		if not isSkinOrPet then
			table.insert(list, cfg)
		end
	end

	return list
end

function WandererpassshopView:_filterBySearchText(dataList)
	local filterDataList = {}
	local text = self._inputComp:GetText()

	if string.nilorempty(text) then
		return dataList
	end

	for i, cfg in ipairs(dataList) do
		if string.find(cfg.name, text) then
			table.insert(filterDataList, cfg)
		end
	end

	return filterDataList
end

function WandererpassshopView:_setTopGoldBar()
	return
end

function WandererpassshopView:_setRole()
	return
end

function WandererpassshopView:_buildItemBgs(count)
	self._itemBgs = {}

	local row = math.ceil(count / 3)

	for i = 1, row do
		local go = goutil.cloneAndSetParent(self._itemBgPrefabGo, self._bgconGo.transform)

		Framework.TransformUtil.SetAnchoredPos(go.transform, 0, -(i - 1) * 270)
		goutil.setActive(go, true)
		table.insert(self._itemBgs, go)
	end
end

function WandererpassshopView:_destroyItemBgs()
	if self._itemBgs then
		for i, v in ipairs(self._itemBgs) do
			goutil.destroy(v)
		end
	end

	self._itemBgs = nil
end

function WandererpassshopView:_setActTime()
	return
end

function WandererpassshopView:_updateSortImg()
	self._ImgSortChange:SetState(self._sortType)
end

function WandererpassshopView:getShowParam(paramStr, paramtype)
	if string.nilorempty(paramStr) then
		return nil
	end

	local showParamAttrs = string.split(paramStr, "#") or {}

	for index, paramStr in ipairs(showParamAttrs) do
		local keyValue = string.split(paramStr, ":")

		if #keyValue == 2 and keyValue[1] == paramtype then
			return keyValue[2]
		end
	end

	return nil
end

function WandererpassshopView:_onClickBuy()
	local info = WandererpassModel.instance:getInfo(self._activityId) or {}

	if not checkbool(info.hasBuy) then
		local cfg = WandererpassConfig.instance:getActivityCfgById(self._activityId)

		if cfg then
			local goodsId = cfg.payGoodsId

			PayController.instance:pay(goodsId, GameEnum.PaySubGoodsType.WANDERER_PASS, self._activityId)
		end
	else
		TipsFacade.instance:openCommonTips("已经购买")
	end
end

return WandererpassshopView
