-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeBagView.lua

module("logic.extensions.holystripe.view.HolyStripeBagView", package.seeall)

local HolyStripeBagView = class("HolyStripeBagView", ViewComponent)

function HolyStripeBagView:ctor()
	HolyStripeBagView.super.ctor(self)

	self._suitFilterId = nil
	self._posFilterId = nil
	self._qualityFilterId = nil
	self._conditionSortId = nil
	self._conditionFilterIds = {}
	self._qualityName = {
		"绿",
		"蓝",
		"紫",
		"橙",
		"红"
	}
end

function HolyStripeBagView:buildUI()
	HolyStripeBagView.super.buildUI(self)

	self._suitFilterGo = self:_getSuitFilterGo()
	self._suitFilter = self:_getSuitFilterBtn()
	self._suitFilterName = self:_getSuitFilterName()
	self._suitFilterUIChange = self:_getSuitFilterUIChange()
	self._posFilterGo = self:_getPosFilterGo()
	self._posFilter = self:_getPosFilterBtn()
	self._posFilterName = self:_getPosFilterName()
	self._posFilterUIChange = self:_getPosFilterUIChange()
	self._qualityFilterGo = self:_getQualityFilterGo()
	self._qualityFilter = self:_getQualityFilterBtn()
	self._qualityFilterName = self:_getQualityFilterName()
	self._qualityFilterUIChange = self:_getQualityFilteUIChange()
	self._conditionSortGo = self:_getConditionSortGo()
	self._conditionSort = self:_getConditionSortBtn()
	self._conditionSortName = self:_getConditionSortName()
	self._conditionSortUIChange = self:_getConditionSortUIChange()
	self._conditionFilterGo = self:_getConditionFilterGo()
	self._conditionFilter = self:_getConditionFilteBtn()
	self._conditionFilterName = self:_getConditionFilteName()
	self._conditionFilterUIChange = self:_getConditionFilteUIChange()
	self._emptyGo = self:_getEmptyGo()
	self._quickActionBtn = self:_getQuickActionBtn()

	local path = self:_getPath()

	self._tableView = self:getGo(path.viewPath):GetComponent(ComponentType.UITableview)
	self._tableCell = self:getGo(path.cellPath)
	self._itemList = ScrollerList.create(self._tableView.gameObject, self._tableCell, GameUtil.handler(self._updataCell, self), GameUtil.handler(self._clearCell, self))
	self._tableviewBagGo = self:getGo("tableviewBag")
	self._tablecellBagGo = self:getGo("tablecellBag")
	self._hasBagboxScroller = self._tableviewBagGo

	if self._hasBagboxScroller then
		self._bagScrollerList = ScrollerList.create(self._tableviewBagGo, self._tablecellBagGo, GameUtil.handler(self._updateBagCell, self), GameUtil.handler(self._clearBagCell, self))

		goutil.setActive(self._tableviewBagGo, false)
		goutil.setActive(self._tablecellBagGo, false)
	end

	self._limit = self:getGo("limit")
	self._txtNum = self:getTxt("limit/txtNum")
	self._tipBtn = self:getGo("limit/tipBtn")
end

function HolyStripeBagView:bindEvents()
	HolyStripeBagView.super.bindEvents(self)
	self._suitFilter:AddClickListener(self._onSuitFilterBtnClick, self)
	self._posFilter:AddClickListener(self._onPosFilterBtnClick, self)
	self._qualityFilter:AddClickListener(self._onAttrFilterBtnClick, self)
	self._conditionSort:AddClickListener(self._onConditionSortBtnClick, self)
	GameUtil.addClickHandler(self._conditionFilter, self._onConditionFilterBtnClick, self)
	GameUtil.addClickHandler(self._tipBtn, self._onClickTips, self)

	if self._quickActionBtn then
		GameUtil.addClickHandler(self._quickActionBtn, self._onClickQuickActionBtn, self)
	end
end

function HolyStripeBagView:unbindEvents()
	HolyStripeBagView.super.unbindEvents(self)
	self._suitFilter:RemoveClickListener()
	self._posFilter:RemoveClickListener()
	self._qualityFilter:RemoveClickListener()
	self._conditionSort:RemoveClickListener()
	GameUtil.rmClickHandler(self._conditionFilter)
	GameUtil.rmClickHandler(self._tipBtn)

	if self._quickActionBtn then
		GameUtil.rmClickHandler(self._quickActionBtn)
	end
end

function HolyStripeBagView:onEnter()
	HolyStripeBagView.super.onEnter(self)
	self.addGEvent(self, HolyStripeController.On_Select_FilterSuit, self._onSuitFilterChange, self)
	self.addGEvent(self, HolyStripeController.On_Select_FilterPos, self._onPosFilterChange, self)
	self.addGEvent(self, HolyStripeController.On_Select_FilterQuality, self._onQualityFilterChange, self)
	self.addGEvent(self, HolyStripeController.On_Select_ConditionSort, self._onConditionSortChange, self)
	self.addGEvent(self, HolyStripeController.PM_HolyStripeEquipRes, self.refreshView, self)
	self.addGEvent(self, HolyStripeController.PM_HolyStripeUnloadRes, self.refreshView, self)
	self.addGEvent(self, HolyStripeController.PM_HolyStripeUnloadAllRes, self.refreshView, self)
	self.addGEvent(self, HolyStripeController.PM_HolyStripeStrengthenRes, self.refreshView, self)
	self.addGEvent(self, HolyStripeAgent.PM_HolyStripeLockOperationRes, self._onPM_HolyStripeLockOperationRes, self)
	self.addGEvent(self, HolyStripeController.PM_HolyStripeChangeReadyToDiscardRes, self.refreshView, self)
	self.addGEvent(self, HolyStripeController.On_Select_ConditionFilter, self._onConditionFilterChange, self)
	self.addGEvent(self, GlobalNotify.OnMaterialGet, self.refreshView, self)

	local params = self:getOpenParam()

	self._suitFilterId = nil
	self._posFilterId = nil

	if params and #params >= 2 then
		self._posFilterId = params[2]
	end

	self._qualityFilterId = nil
	self._conditionSortId = -1

	table.clear(self._conditionFilterIds)

	self._autoSmeltDays = HolyStripeModel.instance:getAutoSmeltDays() or 0
	self._autoSmeltQuality = HolyStripeModel.instance:getAutoSmeltQualityList() or {}

	self:refreshView()
end

function HolyStripeBagView:_onClickTips()
	local type = MatType.HolyStripe

	ItemBagController.instance:showLimitTipsWithType(type)
end

function HolyStripeBagView:_showCurrLiitWithType()
	local type = MatType.HolyStripe
	local cur, total = ItemBagController.instance:getCurrLiitWithType(type)

	if self._txtNum then
		self._txtNum.text = cur > total * 0.9 and langPara("<color=#eb4642>%s</color>/%s", cur, total) or langPara("%s/%s", cur, total)
	end
end

function HolyStripeBagView:onExit()
	HolyStripeBagView.super.onExit(self)
	self._itemList:dispose()

	if self._bagScrollerList then
		self._bagScrollerList:dispose()
	end
end

function HolyStripeBagView:_updataCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = Framework.ButtonAdapter.GetFrom(go, "raycast")
	local nameText = goutil.findChildTextComponent(go, "nameText")
	local cfg = HolyStripeConfig.instance:getHolyStripeCfg(data:getDefineId())
	local itemCon = goutil.findChild(go, "itemCon")
	local autoDestroyTagGo = goutil.findChild(go, "autoDestroyTag")
	local lockGo = goutil.findChild(go, "lock")
	local discardGo = goutil.findChild(go, "discard")
	local autoSmelt = false

	if self._autoSmeltDays > 0 and not data:getIsLock() and data:getEquipPetId() < 0 then
		for i, v in ipairs(self._autoSmeltQuality) do
			if checknumber(cfg.quality) == v then
				autoSmelt = true

				break
			end
		end
	end

	goutil.setActive(autoDestroyTagGo, autoSmelt)

	if lockGo then
		goutil.setActive(lockGo, data:getIsLock())
	end

	if discardGo then
		goutil.setActive(discardGo, data:getIsReadyToDiscard())
	end

	local quality = goutil.findChild(go, "quality")
	local qualityUIChange = goutil.findChildComponent(go, "quality", "UIImageSpriteChange")

	if quality then
		Framework.TransformUtil.SetLocalRotation(quality.transform, 0, 0, HolyStripeMainView.HolyStripePosition[cfg.positionType].rotate)
		qualityUIChange:SetState(cfg.quality - 1)
	end

	MaterialMgr.resetAll(itemCon)

	local proxy = MaterialMgr.setCellByMo(data, itemCon)

	if proxy then
		proxy.binder:setNumStr(" ")
		proxy.binder:setNumBg(false)
		proxy.binder:setAutoTips(false)
	end

	local _, color
	local var_9_0, var_9_1 = PetEquipController:GetQualityStrByNum(data:getQuality())

	_ = var_9_0
	nameText.text = langPara("<color=%s>%s</color>", var_9_1, cfg.name)

	btn:AddClickListener(function()
		self:_onItemClick(data:getId())
	end)
end

function HolyStripeBagView:_clearCell(cell)
	local itemCon = goutil.findChild(cell.gameObject, "itemCon")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "raycast")

	btn:RemoveClickListener()
	MaterialMgr.resetAll(itemCon)
end

function HolyStripeBagView:refreshView()
	local list = HolyStripeModel.instance:getAllHolyStripeMo()

	self:_refreshBag(list)
	self:_refreshFilter()

	local isEmpty = self._curViewDatas and #self._curViewDatas <= 0 or #list <= 0
	local hasBagBox = false

	if isEmpty then
		hasBagBox = self:_calAndShowBagCell()
	end

	if hasBagBox then
		isEmpty = false
	end

	goutil.setActive(self._tableviewBagGo, hasBagBox)
	goutil.setActive(self._emptyGo, isEmpty)
	self:_showCurrLiitWithType()
end

function HolyStripeBagView:_onSuitFilterBtnClick()
	self:showTabAt(self._suitFilterGo, ViewName.HolyStripeSuitFilterView, self._suitFilterId)
end

function HolyStripeBagView:_onPosFilterBtnClick()
	self:showTabAt(self._posFilterGo, ViewName.HolyStripePosFilterView, self._posFilterId)
end

function HolyStripeBagView:_onAttrFilterBtnClick()
	self:showTabAt(self._qualityFilterGo, ViewName.HolyStripeQualityFilterView, self._qualityFilterId)
end

function HolyStripeBagView:_onConditionSortBtnClick()
	self:showTabAt(self._conditionSortGo, ViewName.HolyStripeConditionSortView, self._conditionSortId)
end

function HolyStripeBagView:_onConditionFilterBtnClick()
	self:showTabAt(self._conditionFilterGo, ViewName.HolyStripeConditionFilterView, self._conditionFilterIds)
end

function HolyStripeBagView:_onClickQuickActionBtn()
	UIStateManager.instance:push(ViewName.HolyStripeQuickActionView, {
		suitFilterId = self._suitFilterId,
		posFilterId = self._posFilterId,
		qualityFilterId = self._qualityFilterId,
		conditionSortId = self._conditionSortId,
		conditionFilterIds = clone(self._conditionFilterIds)
	})
end

function HolyStripeBagView:_onSuitFilterChange(suitFilterId)
	self._suitFilterId = suitFilterId

	self:refreshView()
end

function HolyStripeBagView:_onPosFilterChange(posFilterId)
	self._posFilterId = posFilterId

	self:refreshView()
end

function HolyStripeBagView:_onQualityFilterChange(qualityFilterId)
	self._qualityFilterId = qualityFilterId

	self:refreshView()
end

function HolyStripeBagView:_onConditionSortChange(condition)
	self._conditionSortId = condition

	self:refreshView()
end

function HolyStripeBagView:_onConditionFilterChange(conditionIds)
	self._conditionFilterIds = conditionIds

	self:refreshView()
end

function HolyStripeBagView:_refreshBag(moList)
	if self._suitFilterId then
		moList = HolyStripeModel.instance:filterListBySuitId(moList, self._suitFilterId)
	end

	if self._posFilterId then
		moList = HolyStripeModel.instance:filterListByPosId(moList, self._posFilterId)
	end

	if self._qualityFilterId then
		moList = HolyStripeModel.instance:filterListByQualityId(moList, self._qualityFilterId)
	end

	if #self._conditionFilterIds > 0 then
		moList = HolyStripeModel.instance:filterListByConditonId(moList, self._conditionFilterIds)
	end

	if self._conditionSortId then
		moList = HolyStripeModel.instance:filterListBySortId(moList, self._conditionSortId)
	end

	moList = self:doListSorting(moList)

	local data = self:_dataPretreatment(moList)

	self._itemList:reloadData(data)

	self._curViewDatas = data
end

function HolyStripeBagView:_dataPretreatment(moList)
	return moList
end

function HolyStripeBagView:doListSorting(moList)
	if self._conditionSortId then
		table.sort(moList, function(a, b)
			return self:_compareHoly(a, b, self._conditionSortId)
		end)
	end

	return moList
end

function HolyStripeBagView:_refreshFilter()
	if self._suitFilterId then
		local suitFilterInfo = HolyStripeConfig.instance:getSuitInfo(self._suitFilterId)

		self._suitFilterName.text = suitFilterInfo.name

		self._suitFilterUIChange:SetState(0)
	else
		self._suitFilterName.text = lang("类型")

		self._suitFilterUIChange:SetState(1)
	end

	if self._posFilterId then
		self._posFilterName.text = langPara("%s号位", self._posFilterId)

		self._posFilterUIChange:SetState(0)
	else
		self._posFilterName.text = lang("部位")

		self._posFilterUIChange:SetState(1)
	end

	if self._qualityFilterId then
		self._qualityFilterName.text = lang(self._qualityName[self._qualityFilterId])

		self._qualityFilterUIChange:SetState(0)
	else
		self._qualityFilterName.text = lang("品质")

		self._qualityFilterUIChange:SetState(1)
	end

	if #self._conditionFilterIds > 0 then
		self._conditionFilterUIChange:SetState(0)
	else
		self._conditionFilterUIChange:SetState(1)
	end

	if self._conditionSortId then
		local showtext = ""

		showtext = self._conditionSortId == -1 and lang("已镶嵌") or self._conditionSortId == -2 and lang("入手时间") or self._conditionSortId == -3 and lang("等级") or self._conditionSortId == -5 and lang("弃置") or self._conditionSortId == -4 and lang("品质") or ConstString.HolyStripeAttr[GameEnum.HolyStripeAttrType[self._conditionSortId]]
		self._conditionSortName.text = not string.nilorempty(showtext) and showtext or "--"

		self._conditionSortUIChange:SetState(0)
	else
		self._conditionSortName.text = lang("入手时间")

		self._conditionSortUIChange:SetState(1)
	end
end

function HolyStripeBagView:_onItemClick(itemId)
	GlobalDispatcher:dispatch(HolyStripeController.Bag_Item_Tips_Show, itemId)
end

function HolyStripeBagView:_compareHoly(a, b, conditionId, isReverse)
	if conditionId == -1 then
		return self:_compareEquip(a, b, isReverse)
	elseif conditionId == -2 then
		return self:_compareTime(a, b, isReverse)
	elseif conditionId == -3 then
		return self:_compareLv(a, b, isReverse)
	elseif conditionId == -5 then
		return self:_compareDiscard(a, b, isReverse)
	elseif conditionId == -4 then
		return self:_compareQuality(a, b, isReverse)
	end

	return self:_compareAttr(a, b, conditionId, isReverse)
end

function HolyStripeBagView:_compareDiscard(a, b, isReverse, reverseNotPass)
	if a:getIsReadyToDiscard() ~= b:getIsReadyToDiscard() then
		if isReverse == true then
			return not a:getIsReadyToDiscard() and b:getIsReadyToDiscard()
		else
			return a:getIsReadyToDiscard() and not b:getIsReadyToDiscard()
		end
	end

	if reverseNotPass == true then
		return self:_compareLv(a, b, false)
	end

	return self:_compareLv(a, b, isReverse)
end

function HolyStripeBagView:_compareEquip(a, b, isReverse, reverseNotPass)
	if a:getEquipPetId() ~= b:getEquipPetId() then
		if isReverse == true then
			return a:getEquipPetId() < b:getEquipPetId()
		else
			return a:getEquipPetId() > b:getEquipPetId()
		end
	end

	if reverseNotPass == true then
		return self:_compareLv(a, b, false)
	end

	return self:_compareLv(a, b, isReverse)
end

function HolyStripeBagView:_compareTime(a, b, isReverse, reverseNotPass)
	if isReverse == true then
		return a:getId() > b:getId()
	else
		return a:getId() < b:getId()
	end
end

function HolyStripeBagView:_compareLv(a, b, isReverse, reverseNotPass)
	if a:getLv() ~= b:getLv() then
		if isReverse == true then
			return a:getLv() < b:getLv()
		else
			return a:getLv() > b:getLv()
		end
	end

	if reverseNotPass == true then
		return self:_compareQuality(a, b, false)
	end

	return self:_compareQuality(a, b, isReverse)
end

function HolyStripeBagView:_compareQuality(a, b, isReverse, reverseNotPass)
	if a:getQuality() ~= b:getQuality() then
		if isReverse == true then
			return a:getQuality() < b:getQuality()
		else
			return a:getQuality() > b:getQuality()
		end
	end

	if reverseNotPass == true then
		return self:_compareTime(a, b, false)
	end

	return self:_compareTime(a, b, isReverse)
end

function HolyStripeBagView:_compareAttr(a, b, attrId, isReverse, reverseNotPass)
	local aline = a:getAttrInLine(attrId)
	local bline = b:getAttrInLine(attrId)

	if aline ~= bline then
		if isReverse == true then
			return aline < bline
		else
			return bline < aline
		end
	end

	if reverseNotPass == true then
		return self:_compareEquip(a, b, false)
	end

	return self:_compareEquip(a, b, isReverse)
end

function HolyStripeBagView:_getPath()
	return {
		cellPath = "bagRoot/tablecell",
		viewPath = "bagRoot/tableview"
	}
end

function HolyStripeBagView:_getSuitFilterGo()
	return self:getGo("bagRoot/tabCon/suitFitlerBtn")
end

function HolyStripeBagView:_getSuitFilterBtn()
	return self:getBtn("bagRoot/tabCon/suitFitlerBtn/bg")
end

function HolyStripeBagView:_getConditionSortGo()
	return self:getGo("bagRoot/tabCon/conditionSortBtn")
end

function HolyStripeBagView:_getConditionFilterGo()
	return self:getGo("bagRoot/tabCon/conditionFilterBtn")
end

function HolyStripeBagView:_getConditionSortBtn()
	return self:getBtn("bagRoot/tabCon/conditionSortBtn/bg")
end

function HolyStripeBagView:_getConditionFilteBtn()
	return self:getBtn("bagRoot/tabCon/conditionFilterBtn/bg")
end

function HolyStripeBagView:_getPosFilterGo()
	return self:getGo("bagRoot/tabCon/posFilterBtn")
end

function HolyStripeBagView:_getPosFilterBtn()
	return self:getBtn("bagRoot/tabCon/posFilterBtn/bg")
end

function HolyStripeBagView:_getEmptyGo()
	return self:getGo("bagRoot/empty")
end

function HolyStripeBagView:_getSuitFilterName()
	return self:getTxt("bagRoot/tabCon/suitFitlerBtn/bg/text")
end

function HolyStripeBagView:_getSuitFilterUIChange()
	return (self._suitFilterGo:GetComponent("UIChangeGroup"))
end

function HolyStripeBagView:_getPosFilterName()
	return self:getTxt("bagRoot/tabCon/posFilterBtn/bg/text")
end

function HolyStripeBagView:_getPosFilterUIChange()
	return (self._posFilterGo:GetComponent("UIChangeGroup"))
end

function HolyStripeBagView:_getConditionSortName()
	return self:getTxt("bagRoot/tabCon/conditionSortBtn/bg/text")
end

function HolyStripeBagView:_getConditionFilteName()
	return self:getTxt("bagRoot/tabCon/conditionFilterBtn/bg/text")
end

function HolyStripeBagView:_getConditionSortUIChange()
	return (self._conditionSortGo:GetComponent("UIChangeGroup"))
end

function HolyStripeBagView:_getConditionFilteUIChange()
	return (self._conditionFilterGo:GetComponent("UIChangeGroup"))
end

function HolyStripeBagView:_getQualityFilterGo()
	return self:getGo("bagRoot/tabCon/qualityFilterBtn")
end

function HolyStripeBagView:_getQualityFilterBtn()
	return self:getBtn("bagRoot/tabCon/qualityFilterBtn/bg")
end

function HolyStripeBagView:_getQualityFilterName()
	return self:getTxt("bagRoot/tabCon/qualityFilterBtn/bg/text")
end

function HolyStripeBagView:_getQualityFilteUIChange()
	return (self._qualityFilterGo:GetComponent("UIChangeGroup"))
end

function HolyStripeBagView:_getQuickActionBtn()
	local btnGo = goutil.findChild(self.mainGO, "quickActionBtn")

	btnGo = btnGo or goutil.findChild(self.mainGO, "bagRoot/quickActionBtn")

	return btnGo
end

function HolyStripeBagView:_onPM_HolyStripeLockOperationRes(status)
	if status == 0 then
		self._itemList:refresh()
	end
end

function HolyStripeBagView:_updateBagCell(view, cell, data, tag)
	local btnUse = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnUse")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local matName = MaterialMgr.getMaterialsName(data.matType, data.matId)

	txtDesc.text = string.format("背包-%s\n(库存：%s)", matName, data.matNum)

	btnUse:AddClickListener(function()
		ItemBagController.instance:openUsePanel(data.mo)
	end)
end

function HolyStripeBagView:_clearBagCell(cell)
	return
end

function HolyStripeBagView:_calAndShowBagCell()
	if not self._bagScrollerList then
		return false
	end

	local list = MaterialModel.instance:getMaterialsByTypeExceptSub(MatType.Item_GoodFeel) or {}
	local bagBoxList = {}
	local isPass = false

	for i, v in ipairs(list) do
		local type, id = v:getMatType(), v:getDefineId()
		local matCfg = MaterialMgr.getMatCfg(type, id)

		isPass = false

		if matCfg and matCfg.useType == 1 then
			local useCfg = MaterialConfig.instance:getCfgByMatAndId(type, id)

			if useCfg and ItemBagController.instance:checkCanUseNotWithTips(useCfg) then
				if self:_checkUseContentMatch(useCfg.content, MatType.HolyStripe) then
					isPass = true
				elseif self:_checkUseContentMatch(useCfg.content, MatType.DROP_ITEM) then
					local matStr = MaterialMgr.changeIfDrop(useCfg.content)

					isPass = self:_checkUseContentMatch(matStr, MatType.HolyStripe)
				end

				if isPass then
					local hasNum = MaterialFacade.instance:getMatNumber(type, id)

					table.insert(bagBoxList, {
						bagBox = true,
						matType = type,
						matId = id,
						matNum = hasNum,
						mo = v
					})
				end
			end
		end
	end

	table.sort(bagBoxList, function(a, b)
		return a.matNum > b.matNum
	end)
	self._bagScrollerList:reloadData(bagBoxList)

	return #bagBoxList > 0
end

function HolyStripeBagView:_checkUseContentMatch(content, type)
	local match = string.match(content, string.format("^%s:%%d+:%%d+", type))

	match = match or string.match(content, string.format("[%%D]%s:%%d+:%%d+", type))

	return match
end

return HolyStripeBagView
