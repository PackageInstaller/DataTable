-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyeargoodsshop/view/NewyeargoodsshopmainView.lua

module("logic.extensions.newyeargoodsshop.view.NewyeargoodsshopmainView", package.seeall)

local NewyeargoodsshopmainView = class("NewyeargoodsshopmainView", ViewComponent)

NewyeargoodsshopmainView.MoneySortType = {
	Down = 1,
	Up = 2,
	None = 0
}
NewyeargoodsshopmainView.ShowParamType = {
	tagHot = "tagHot"
}

function NewyeargoodsshopmainView:buildUI()
	NewyeargoodsshopmainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._txtTime = self:getTxt("time/txt")
	self._petCon = self:getGo("petIcon")
	self._goldbarCon = self:getGo("goldBar")
	self._tableview = self:getGo("tableview")
	self._tableContent = self:getGo("tableview/Nego_Viewport/Nego_Content")
	self._tablecell = self:getGo("tableCell")
	self._tabTableView = self:getGo("ScrollView")
	self._tabTableCell = self:getGo("BtnCell")

	local tableOffset = GameUtil.getAnchoredPos(self._tableview)
	local tableItemCon = self:getGo("tableCell/itemGo")
	local itemOffset = GameUtil.getAnchoredPos(tableItemCon)

	self._itemOffset = tableOffset + itemOffset
	self._txtPrePrize = self:getTxt("txtPrePrize")
	self._txtNowPrize = self:getTxt("txtNowPrize")
	self._txtDisCountTip = self:getTxt("txtDisCountTip")
	self._payIconCon = self:getGo("txtNowPrize/payIcon")
	self._itemTable = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tabTable = ScrollerList.create(self._tabTableView, self._tabTableCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._btnClear = self:getBtn("searchpart/btnClear")
	self._inputComp = self:getInput("searchpart/search")
	self._searchpartGo = self:getGo("searchpart")
	self._roleconGo = self:getGo("rolecon")
	self._itemBgPrefabGo = self:getGo("itemBgPrefab")
	self._bgconGo = self:getGo("tableview/Nego_Viewport/Nego_Content/bgcon")
	self._txtTime = self:getTxt("time/txt")
	self._btnFilter = self:getBtn("btnFilter")
	self._btnSort = self:getBtn("btnSort")
	self._ImgSortChange = self:getGo("btnSort/ImgSort"):GetComponent(ComponentType.UIImageSpriteChange)
end

function NewyeargoodsshopmainView:bindEvents()
	NewyeargoodsshopmainView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	self._btnClear:AddClickListener(self._onClickbtnClear, self)
	self._inputComp:AddOnValueChanged(self._inputValueChanged, self)
	self._btnFilter:AddClickListener(self._onClickbtnFilter, self)
	self._btnSort:AddClickListener(self._onClickbtnSort, self)
end

function NewyeargoodsshopmainView:unbindEvents()
	NewyeargoodsshopmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	self._btnClear:RemoveClickListener()
	self._inputComp:RemoveOnValueChanged()
	self._btnFilter:RemoveClickListener()
	self._btnSort:RemoveClickListener()
end

function NewyeargoodsshopmainView:onEnter()
	NewyeargoodsshopmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.UpdateActiveShopInfo, self._updateUI, self)
	self.addGEvent(self, ActivityShopAgent.PM_BuyShopItemRes, self._updateUI, self)

	self._activityType = GameEnum.ActivityType.PriceBreakDiscount
	self._activityId = ActivityDefineController.instance:getActivityIdByType(self._activityType)

	local params = self:getOpenParam()

	self._tabId = params and (params[1] or 1) or checknumber(self._tabId) > 0 and self._tabId or 1
	self._activityCfg = NewyeargoodsshopConfig.instance:getActCfg(self._activityId)

	self:_initMoneySort()
	self:_setTopGoldBar()
	self:_refreshTabs()
	self:_setRole()
	self:_setActTime()
	ActivityshopController.instance:getAllShopItemInfo(self._activityType, self._activityId)
end

function NewyeargoodsshopmainView:onExit()
	NewyeargoodsshopmainView.super.onExit(self)
	MaterialMgr.clearIcon(self._payIconCon)
	uGuiUtil.clearImage(self._petCon)
	self._itemTable:dispose()
	self._tabTable:dispose()

	self._roleObj = RoleObjectPool.instance:removeRole(self._roleObj)

	self:_destroyItemBgs()
end

function NewyeargoodsshopmainView:onExitFinished()
	if self._itemPools then
		self._itemPools:clear()

		self._itemPools = nil
	end
end

function NewyeargoodsshopmainView:_initMoneySort()
	self._sortType = NewyeargoodsshopmainView.MoneySortType.None

	self:_updateSortImg()
end

function NewyeargoodsshopmainView:_refreshTabs()
	local list = ActivityshopConfig.instance:getActivityShopPageCfgs(self._activityType, self._activityId)

	self._tabTable:reloadData(list)
end

function NewyeargoodsshopmainView:_updateUI()
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
	self._tabTable:refresh()
	self:_buildItemBgs(#list1)
end

function NewyeargoodsshopmainView:_sortAndMerge(list1, list2, list3)
	local beforeList = {}

	if self._sortType == NewyeargoodsshopmainView.MoneySortType.None then
		beforeList = list1

		table.sort(list1, NewyeargoodsshopmainView.sortFunc)
	else
		local priceMap = {}
		local isUp = self._sortType == NewyeargoodsshopmainView.MoneySortType.Up
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

	table.sort(list2, NewyeargoodsshopmainView.sortFunc)
	table.sort(list3, NewyeargoodsshopmainView.sortFunc)
	table.insertto(beforeList, list2)
	table.insertto(beforeList, list3)

	return beforeList
end

function NewyeargoodsshopmainView:_getPrice(shopItemId, priceMap, sellPrice)
	if not priceMap[shopItemId] then
		local matType, id, matNum = MaterialMgr.getMatParams(sellPrice)

		priceMap[shopItemId] = {
			matNum = matNum,
			matType = matType
		}
	end

	return priceMap[shopItemId]
end

function NewyeargoodsshopmainView.sortFunc(a, b)
	return a.sort < b.sort
end

function NewyeargoodsshopmainView:_updateCell(view, cell, data, tag)
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
	local tagHotValue = checknumber(self:getShowParam(data.showParams, NewyeargoodsshopmainView.ShowParamType.tagHot))

	if tagHotValue > 0 then
		goutil.setActive(tagHot, true)
		GameUtil.setUIImageSpriteIdx(tagHot, tagHotValue - 1)
	else
		goutil.setActive(tagHot, false)
	end
end

function NewyeargoodsshopmainView:_clearCell(cell)
	local go = cell.gameObject
	local itemGo = goutil.findChild(go, "itemGo")
	local payIcon = goutil.findChild(go, "btnAdd/Text/payIcon")
	local btnBuy = GameUtil.asBtn(goutil.findChild(go, "btnBuy"))

	btnBuy:RemoveClickListener()
	MaterialMgr.clearIcon(payIcon)
	MaterialMgr.resetAll(itemGo)
end

function NewyeargoodsshopmainView:_updateTabCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgBg = goutil.findChildComponent(go, "imgBg", "UIImageSpriteChange")
	local tagBg = goutil.findChildComponent(go, "tag", "UIImageSpriteChange")
	local txtTag = goutil.findChildTextComponent(go, "tag/Text")
	local txtName = goutil.findChildTextComponent(go, "text")
	local txtColor = goutil.findChildComponent(go, "text", "UITextColorChange")
	local btn = GameUtil.asBtn(go)

	txtName.text = data.name

	if not string.nilorempty(data.tag) then
		GameUtil.SetActive(tagBg, true)
		tagBg:SetState(1)

		txtTag.text = data.tag
	else
		GameUtil.SetActive(tagBg, false)
	end

	if data.page == self._tabId then
		imgBg:SetState(1)
		txtColor:SetState(1)
	else
		imgBg:SetState(0)
		txtColor:SetState(0)
	end

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self._tabId = data.page

		self:_onClickbtnClear()
		self:_updateUI()
	end)
end

function NewyeargoodsshopmainView:_clearTabCell(cell)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(goutil.findChild(go, "click"))

	btn:RemoveClickListener()
end

function NewyeargoodsshopmainView:_onClickBtnBuy(shopItemCfg)
	local buyTime = ActivityshopModel.instance:getActiveShopBuyTimes(self._activityType, self._activityId, shopItemCfg.shopItemId)

	if shopItemCfg.sellLimitCount > 0 and buyTime - shopItemCfg.sellLimitCount >= 0 then
		FloatWordMgr.instance:show("可购买次数不足")

		return
	end

	UIStateManager.instance:push(ViewName.NewyeargoodsshopbuyView, shopItemCfg.activityType, shopItemCfg.activityId, shopItemCfg.shopItemId)
end

function NewyeargoodsshopmainView:_onClickClose()
	self:close()
end

function NewyeargoodsshopmainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, self._activityCfg.ruleKey)
end

function NewyeargoodsshopmainView:_onClickbtnClear()
	self._inputComp:SetText("")
end

function NewyeargoodsshopmainView:_onClickbtnFilter()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_NEWYEAR_GOODSSHOP, pos, sizeDelta, GameUtil.handler(self._updateUI, self))
end

function NewyeargoodsshopmainView:_onClickbtnSort()
	self._sortType = self._sortType + 1

	if self._sortType > NewyeargoodsshopmainView.MoneySortType.Up then
		self._sortType = NewyeargoodsshopmainView.MoneySortType.None
	end

	self:_updateSortImg()
	self:_updateUI()
end

function NewyeargoodsshopmainView:_inputValueChanged(text)
	if self._inputComp:GetText() == self._lastInputTxt then
		return
	end

	self._lastInputTxt = text

	self:_updateUI()
end

function NewyeargoodsshopmainView:_isMatch(skinId)
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
	local maxAwaken = CharacterConfig.instance:getMaxAwaken(skinCfg.raceId)
	local rare = CharacterConfig.instance:getRareByAwakenLv(maxAwaken, skinCfg.raceId)
	local cfg = CharacterConfig.instance:getPetCo(skinCfg.raceId)

	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_NEWYEAR_GOODSSHOP, cfg, rare, skinId)
end

function NewyeargoodsshopmainView:_filterByPanel(dataList)
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

function NewyeargoodsshopmainView:_filterBySearchText(dataList)
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

function NewyeargoodsshopmainView:_setTopGoldBar()
	local iconCfg = ActivityshopConfig.instance:getCostIcon(self._activityType, self._activityId)

	if iconCfg then
		local accounts = string.split(iconCfg.icon, "#")
		local btn_list = {}

		for _, v in ipairs(accounts) do
			table.insert(btn_list, {
				showAdd = true,
				id = v
			})
		end

		MainUIController.instance:showGlodBar(self._goldbarCon, self._viewPresentor, btn_list)
	end
end

function NewyeargoodsshopmainView:_setRole()
	local raceId = self._activityCfg.raceId
	local trans = self._activityCfg.trans
	local x, y, scale = trans[1], trans[2], trans[3]

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, raceId, self._roleconGo, scale, nil, true, x, y)
end

function NewyeargoodsshopmainView:_buildItemBgs(count)
	self._itemBgs = {}

	local row = math.ceil(count / 3)

	for i = 1, row do
		local go = goutil.cloneAndSetParent(self._itemBgPrefabGo, self._bgconGo.transform)

		Framework.TransformUtil.SetAnchoredPos(go.transform, 0, -(i - 1) * 270)
		goutil.setActive(go, true)
		table.insert(self._itemBgs, go)
	end
end

function NewyeargoodsshopmainView:_destroyItemBgs()
	if self._itemBgs then
		for i, v in ipairs(self._itemBgs) do
			goutil.destroy(v)
		end
	end

	self._itemBgs = nil
end

function NewyeargoodsshopmainView:_setActTime()
	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
end

function NewyeargoodsshopmainView:_updateSortImg()
	self._ImgSortChange:SetState(self._sortType)
end

function NewyeargoodsshopmainView:getShowParam(paramStr, paramtype)
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

return NewyeargoodsshopmainView
