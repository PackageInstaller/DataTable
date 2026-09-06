-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalfarm/view/EternalFarmShopView.lua

module("logic.extensions.eternalfarm.view.EternalFarmShopView", package.seeall)

local EternalFarmShopView = class("EternalFarmShopView", ViewComponent)

function EternalFarmShopView:ctor()
	EternalFarmShopView.super.ctor(self)
end

function EternalFarmShopView:unbindEvents()
	EternalFarmShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBuy)
	GameUtil.rmClickHandler(self._btnSell)
	GameUtil.rmClickHandler(self._btnPlant)
	GameUtil.rmClickHandler(self._btnOneKeyPlant)
	GameUtil.rmClickHandler(self._btnOneKeySold)
end

function EternalFarmShopView:bindEvents()
	EternalFarmShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
	GameUtil.addClickHandler(self._btnSell, self._onClickSell, self)
	GameUtil.addClickHandler(self._btnPlant, self._onClickPlantTab, self)
	GameUtil.addClickHandler(self._btnOneKeyPlant, self._onClickOneKeyPlant, self)
	GameUtil.addClickHandler(self._btnOneKeySold, self._onClickOneKeySold, self)
end

function EternalFarmShopView:buildUI()
	EternalFarmShopView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnClose = self:getBtn("btnClose")
	self._btnBuy = self:getBtn("btnBuy")
	self._btnSell = self:getBtn("btnSell")
	self._redPointSell = self:getGo("btnSell/redpoint")
	self._scroll = self:getScrollRect("tableview")
	self._tableview = ScrollerList.create(self._tableviewGo, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tableviewGo = self:getGo("tableview")
	self._buyChange = self._btnBuy.gameObject:GetComponent(typeof(UIChangeGroup))
	self._sellChange = self._btnSell.gameObject:GetComponent(typeof(UIChangeGroup))
	self._btnPlant = self:getGo("btnPlant")
	self._plantChange = self._btnPlant.gameObject:GetComponent(typeof(UIChangeGroup))
	self._btnOneKeyPlant = self:getGo("btnOneKeyPlant")
	self._btnOneKeySold = self:getGo("btnOneKeySold")
	self._plantCell = self:getGo("plantCell")
	self._tablePlantview = self:getGo("tablePlantview")
	self._scrollPlantList = ScrollerList.create(self._tablePlantview, self._plantCell, GameUtil.handler(self._updatePlantCell, self), GameUtil.handler(self._clearPlantCell, self))
end

function EternalFarmShopView:onExit()
	EternalFarmShopView.super.onExit(self)
	self._tableview:dispose()
	self._scrollPlantList:dispose()

	self._inputNums = nil
	self._inputPlantNums = nil

	RedPointController.instance:unregRedPoint(self._redPointSell)
end

function EternalFarmShopView:onEnter()
	EternalFarmShopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._openPlantView = params[1]
	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.EternalFarm)
	self._actCfg = EternalFarmConfig.instance:getActCfgById(self._activityId)
	self._curYardId = EternalFarmController.instance:getYardId()
	self._multipleZoneId = EternalFarmController.instance:getMultipleZoneId(self._activityId)

	self.addGEvent(self, GlobalNotify.EternalFarmShopRes, self._sendGetInfoReq, self)
	self.addGEvent(self, GlobalNotify.EternalFarmGetInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.PM_EternalFarmOneKeySowRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.PM_EternalFarmOneKeySellRes, self._refresh, self)
	self:_onClickBuy()

	self._curSelectId = 1

	self:_refresh()
	self:showGlodBar()
	self:_enterOpenPlantView()
	RedPointController.instance:regRedPoint(self._redPointSell, RedPointModel.ID_ETERNAL_FARM_SELL)
end

function EternalFarmShopView:_enterOpenPlantView()
	if checknumber(self._openPlantView) > 0 then
		self:_onClickPlantTab()
	end
end

function EternalFarmShopView:showGlodBar()
	local costItemCfg = self._actCfg.costIcon
	local costList = {}

	if costItemCfg then
		local accounts = string.split(costItemCfg, "#")

		for _, v in ipairs(accounts) do
			local matType, matId, matNum = MaterialMgr.getMatParams(v)

			if v == GameEnum.GoldType.Diamond then
				local function callback()
					self:close()
					FuncOpenController.instance:openFunc(95, GameEnum.PayShopEasyJump.Recharge)
					SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickDiamondChargeButton)
				end

				table.insert(costList, {
					showAdd = true,
					id = v,
					showAddCallBack = callback
				})
			else
				table.insert(costList, {
					showAdd = false,
					id = v
				})
			end
		end
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, costList)
end

function EternalFarmShopView:_sendGetInfoReq()
	EternalFarmController.instance:sendPM_EternalFarmInfoReq(self._activityId)
end

function EternalFarmShopView:_refresh()
	self._shopCfg = EternalFarmConfig.instance:getShopCfgByTypeAndYardId(self._activityId, self._curSelectId, self._curYardId)
	self._sortPlantCfg = self:_getSortPlantCfgs()

	if self._curSelectId == 2 then
		table.sort(self._shopCfg, function(a, b)
			local matTypeA, matIdA, matNumA = MaterialMgr.getMatParams(a.cost)
			local matTypeB, matIdB, matNumB = MaterialMgr.getMatParams(b.cost)
			local hasNumA = MaterialModel.instance:getMaterialsNumber(matTypeA, matIdA)
			local hasNumB = MaterialModel.instance:getMaterialsNumber(matTypeB, matIdB)

			return hasNumB < hasNumA
		end)
	end

	self._inputNums = {}

	for i = 1, #self._shopCfg do
		self._inputNums[i] = 1
	end

	self._inputPlantNums = {}

	for i = 1, #self._sortPlantCfg do
		self._inputPlantNums[i] = 0
	end

	self._plantDic = {}

	self._tableview:reloadData(self._shopCfg)
	self._scrollPlantList:reloadData(self._sortPlantCfg)
end

function EternalFarmShopView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local hasItem = goutil.findChild(cell, "txtHasNum/icon")
	local sellOut = goutil.findChild(cell, "sellOut")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtEffect = goutil.findChildTextComponent(cell, "txtEffect")
	local txtHasNum = goutil.findChildTextComponent(cell, "txtHasNum")
	local txtCost = MaterialMgr.findGraphicText(cell, "txtCost")
	local txtCount = goutil.findChildTextComponent(cell, "num/count/txtCount")
	local txtLimit = goutil.findChildTextComponent(cell, "txtLimit")
	local txtBtn = goutil.findChildTextComponent(cell, "btnShop/Text")
	local btnShop = goutil.findChildButtonComponent(cell, "btnShop")
	local btnReduce = goutil.findChildButtonComponent(cell, "num/btnReduce")
	local btnAdd = goutil.findChildButtonComponent(cell, "num/btnAdd")
	local btnReduceTen = goutil.findChildButtonComponent(cell, "num/btnReduceTen")
	local btnAddTen = goutil.findChildButtonComponent(cell, "num/btnAddTen")
	local doubleGetTag = goutil.findChild(cell, "doubleGetTag")
	local matType, matId, matNum, itemType, itemId, itemNum
	local hasCount = 0
	local maxNum = 0
	local prizeList
	local isMultiple = false

	if data.type == 2 then
		txtBtn.text = "出售"
		prizeList = string.split(data.prize, "#")
		itemType, itemId, itemNum = MaterialMgr.getMatParams(data.cost)
		hasCount = MaterialModel.instance:getMaterialsNumber(itemType, itemId)
		maxNum = Mathf.Clamp(hasCount, 1, 99)
	else
		txtBtn.text = "购买"
		prizeList = string.split(data.cost, "#")
		matType, matId, matNum = MaterialMgr.getMatParams(data.cost)
		itemType, itemId, itemNum = MaterialMgr.getMatParams(data.prize)
		hasCount = MaterialModel.instance:getMaterialsNumber(matType, matId)

		local remainCount = EternalFarmController.instance:shopRemainCount(data)
		local max = remainCount > 99 and 99 or remainCount

		maxNum = Mathf.Clamp(Mathf.Floor(hasCount / matNum), 1, max)
		txtLimit.text = EternalFarmController.instance:limitDesc(self._activityId, data.shopId)

		local cropId = data.cropId

		if cropId > 0 then
			local cropCfg = EternalFarmConfig.instance:getCropCfgByCropId(self._activityId, cropId)
			local zoneId = cropCfg.zoneId

			isMultiple = table.indexof(self._multipleZoneId, zoneId)
		end
	end

	local isSellOut = EternalFarmController.instance:isSellOut(data)

	GameUtil.SetActive(sellOut, isSellOut)
	GameUtil.SetActive(txtLimit.gameObject, data.type == 1)
	GameUtil.SetActive(doubleGetTag, isMultiple)
	MaterialMgr.setIcon(item, itemType, itemId)
	MaterialMgr.setIcon(hasItem, itemType, itemId)

	txtHasNum.text = MaterialModel.instance:getMaterialsNumber(itemType, itemId)
	txtDesc.text = data.desc
	txtEffect.text = data.effect

	local id = cell.index + 1
	local num = self._inputNums[id]

	txtCount.text = num

	local costDesc = ""

	for _, v in ipairs(prizeList) do
		local costType, costId, costNum = MaterialMgr.getMatParams(v)

		costDesc = costDesc .. string.format("<quad name=%d:%d|icon size=30 width=1 offsetY=-5/>%d", costType, costId, num * costNum)
	end

	txtCost.text = costDesc

	GameUtil.addClickHandler(btnShop, GameUtil.handler(self._onClickShop, self, data.shopId, num, hasCount, isSellOut))
	GameUtil.addClickHandler(btnReduce, GameUtil.handler(self._onClickReduce, self, id, maxNum, cell))
	GameUtil.addClickHandler(btnAdd, GameUtil.handler(self._onClickAdd, self, id, maxNum, cell))
	GameUtil.addClickHandler(btnReduceTen, GameUtil.handler(self._onClickReduceTen, self, id, maxNum, cell))
	GameUtil.addClickHandler(btnAddTen, GameUtil.handler(self._onClickAddTen, self, id, maxNum, cell))
end

function EternalFarmShopView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local hasItem = goutil.findChild(cell, "txtHasNum/icon")

	MaterialMgr.clearIcon(item)
	MaterialMgr.clearIcon(hasItem)
end

function EternalFarmShopView:_updatePlantCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local doubleGetTag = goutil.findChild(cell, "doubleGetTag")
	local btnPlant = goutil.findChild(cell, "btnPlant")
	local btnReduce = goutil.findChild(cell, "num/btnReduce")
	local btnAdd = goutil.findChild(cell, "num/btnAdd")
	local btnReduceTen = goutil.findChild(cell, "num/btnReduceTen")
	local btnAddTen = goutil.findChild(cell, "num/btnAddTen")
	local txtHasNum = goutil.findChildTextComponent(cell, "txtHasNum")
	local txtCount = goutil.findChildTextComponent(cell, "num/count/txtCount")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtCost = goutil.findChildTextComponent(cell, "txtCost")
	local seedMatStr = data.seed
	local matType, matId, matNum = MaterialMgr.getMatParams(seedMatStr)
	local hasSeedCount = MaterialModel.instance:getMaterialsNumber(matType, matId)
	local isMultiple = table.indexof(self._multipleZoneId, data.zoneId)
	local shopId = data.shopId
	local leftFieldNum = EternalFarmController.instance:getFieldCanPlantNum(data.zoneId)
	local id = cell.index + 1
	local plantNum = self._inputPlantNums[id]
	local maxNum = math.min(leftFieldNum, hasSeedCount)

	if shopId > 0 then
		local shopCfg = EternalFarmConfig.instance:getShopCfgById(self._activityId, shopId)

		if shopCfg then
			txtDesc.text = shopCfg.desc or ""
		end
	end

	txtHasNum.text = hasSeedCount
	txtCost.text = string.format("(牧场空位：%d)", leftFieldNum)
	txtCount.text = plantNum

	GameUtil.SetActive(doubleGetTag, isMultiple)
	GameUtil.SetActive(txtDesc.gameObject, shopId > 0)
	GameUtil.SetGray(btnPlant, hasSeedCount == 0)
	MaterialMgr.setIcon(item, matType, matId)
	GameUtil.addClickHandler(btnPlant, GameUtil.handler(self._onClickPlant, self, data.zoneId, plantNum, data.cropId))
	GameUtil.addClickHandler(btnReduce, GameUtil.handler(self._onClickPlantReduce, self, id, maxNum, cell))
	GameUtil.addClickHandler(btnAdd, GameUtil.handler(self._onClickPlantAdd, self, id, maxNum, cell))
	GameUtil.addClickHandler(btnReduceTen, GameUtil.handler(self._onClickPlantReduceTen, self, id, maxNum, cell))
	GameUtil.addClickHandler(btnAddTen, GameUtil.handler(self._onClickPlantAddTen, self, id, maxNum, cell))
end

function EternalFarmShopView:_clearPlantCell(cell)
	local item = goutil.findChild(cell, "item")
	local btnPlant = goutil.findChild(cell, "btnPlant")
	local btnReduce = goutil.findChild(cell, "btnReduce")
	local btnAdd = goutil.findChild(cell, "btnAdd")
	local btnReduceTen = goutil.findChild(cell, "btnReduceTen")
	local btnAddTen = goutil.findChild(cell, "btnAddTen")

	MaterialMgr.clearIcon(item)
	GameUtil.rmClickHandler(btnPlant)
	GameUtil.rmClickHandler(btnReduce)
	GameUtil.rmClickHandler(btnAdd)
	GameUtil.rmClickHandler(btnReduceTen)
	GameUtil.rmClickHandler(btnAddTen)
end

function EternalFarmShopView:_getSortPlantCfgs()
	local cropsCfgs = EternalFarmConfig.instance:getCropCfgByYardId(self._activityId, self._curYardId)
	local dontHasSeedList = {}
	local sortCfgs = {}
	local multipleCfg = {}
	local hasMultipleNum = false

	for i, cfg in ipairs(cropsCfgs) do
		local seedMatStr = cfg.seed
		local matType, matId, matNum = MaterialMgr.getMatParams(seedMatStr)
		local hasSeedNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
		local isMultiple = table.indexof(self._multipleZoneId, cfg.zoneId)

		if hasSeedNum > 0 then
			if isMultiple then
				table.insert(multipleCfg, cfg)

				hasMultipleNum = true
			else
				table.insert(sortCfgs, cfg)
			end
		elseif isMultiple then
			table.insert(multipleCfg, cfg)
		else
			table.insert(dontHasSeedList, cfg)
		end
	end

	if hasMultipleNum then
		table.insertto(multipleCfg, sortCfgs)
		table.insertto(multipleCfg, dontHasSeedList)

		return multipleCfg
	else
		table.insertto(sortCfgs, multipleCfg)
		table.insertto(sortCfgs, dontHasSeedList)

		return sortCfgs
	end
end

function EternalFarmShopView:_onClickBuy()
	self._curSelectId = 1

	self:_refresh()
	self._buyChange:SetState(1)
	self._sellChange:SetState(0)
	self._plantChange:SetState(0)

	self._scroll.scrollRect.horizontalNormalizedPosition = 0

	GameUtil.SetActive(self._tablePlantview, false)
	GameUtil.SetActive(self._tableviewGo, true)
	GameUtil.SetActive(self._btnOneKeyPlant, false)
	GameUtil.SetActive(self._btnOneKeySold, false)
end

function EternalFarmShopView:_onClickSell()
	self._curSelectId = 2

	self:_refresh()
	self._buyChange:SetState(0)
	self._sellChange:SetState(1)
	self._plantChange:SetState(0)

	self._scroll.scrollRect.horizontalNormalizedPosition = 0

	GameUtil.SetActive(self._tablePlantview, false)
	GameUtil.SetActive(self._tableviewGo, true)
	GameUtil.SetActive(self._btnOneKeyPlant, false)
	GameUtil.SetActive(self._btnOneKeySold, true)
end

function EternalFarmShopView:_onClickPlantTab()
	self._curSelectId = 3

	self:_refresh()
	self._buyChange:SetState(0)
	self._sellChange:SetState(0)
	self._plantChange:SetState(1)

	self._scroll.scrollRect.horizontalNormalizedPosition = 0

	GameUtil.SetActive(self._tablePlantview, true)
	GameUtil.SetActive(self._tableviewGo, false)
	GameUtil.SetActive(self._btnOneKeyPlant, true)
	GameUtil.SetActive(self._btnOneKeySold, false)
end

function EternalFarmShopView:_onClickShop(shopId, num, hasCount, isSellOut)
	if isSellOut then
		FloatWordMgr.instance:show("已售罄")

		return
	end

	if hasCount < 1 then
		if self._curSelectId == 1 then
			FloatWordMgr.instance:show("道具不足,无法购买哦~")
		elseif self._curSelectId == 2 then
			FloatWordMgr.instance:show("您还没有收获此商品哦~")
		end

		return
	end

	local cfg = EternalFarmConfig.instance:getShopCfgById(self._activityId, shopId)

	if cfg.type == 1 then
		local costType, costId, costNum = MaterialMgr.getMatParams(cfg.cost)
		local prizeType, prizeId, prizeNum = MaterialMgr.getMatParams(cfg.prize)
		local costName = MaterialMgr.getMaterialsName(costType, costId)
		local prizeName = MaterialMgr.getMaterialsName(prizeType, prizeId)
		local tips = string.format("确定消耗%d%s购买%s*%d吗？", num * costNum, costName, prizeName, num)

		local function okFunc()
			EternalFarmController.instance:sendPM_EternalFarmShopReq(self._activityId, shopId, num)
		end

		local function cencelFunc()
			return
		end

		TipsFacade.instance:openPopupWindow(lang("text_buy_tips"), tips, okFunc, cencelFunc, lang("confirm"), lang("cancel"), nil)

		return
	else
		EternalFarmController.instance:sendPM_EternalFarmShopReq(self._activityId, shopId, num)
	end
end

function EternalFarmShopView:_onClickPlant(zoneId, plantNum, cropId)
	if plantNum <= 0 then
		FloatWordMgr.instance:show("请放入种子")

		return
	end

	local zoneFields = EternalFarmController.instance:getFields(zoneId)
	local cropCfg = EternalFarmConfig.instance:getCropCfgByCropId(self._activityId, cropId)
	local matName = MaterialMgr.getMaterialsNameByCfg(cropCfg.commonPrize)
	local sowItemList = {}

	if zoneFields then
		for i, field in ipairs(zoneFields) do
			if field:fieldGrowpState() == EternalFarmModel.FieldState.Empty and plantNum > 0 then
				local item = {}

				item.zoneId = zoneId
				item.indexId = field:getIndexId()
				item.cropId = cropId
				plantNum = plantNum - 1

				table.insert(sowItemList, item)
			end
		end

		EternalFarmController.instance:sendPM_EternalFarmOneKeySowReq(self._activityId, sowItemList)
		FloatWordMgr.instance:show(string.format("一键种植%s成功！", matName))
	end
end

function EternalFarmShopView:_onClickOneKeyPlant()
	local oneKeyPlantList, canPlanList = self:_getOneKeyPlantList()

	if #oneKeyPlantList <= 0 then
		FloatWordMgr.instance:show("暂无可种植的作物")

		return
	end

	local preMatName = ""
	local cropStr = "是否种植"

	for i, item in ipairs(oneKeyPlantList) do
		local cropId = item.cropId
		local canSowNum = self._plantDic[cropId]
		local cropCfg = EternalFarmConfig.instance:getCropCfgByCropId(self._activityId, cropId)
		local matName = MaterialMgr.getMaterialsNameByCfg(cropCfg.commonPrize)

		if preMatName ~= matName then
			if i ~= #oneKeyPlantList then
				local str = string.format("[%s×%d]、", matName, canSowNum)

				cropStr = cropStr .. str
			else
				local str = string.format("[%s×%d]?", matName, canSowNum)

				cropStr = cropStr .. str
			end

			preMatName = matName
		end
	end

	local function okFunc()
		EternalFarmController.instance:sendPM_EternalFarmOneKeySowReq(self._activityId, canPlanList)
		FloatWordMgr.instance:show("一键种植成功！")
	end

	TipsFacade.instance:openPopupWindow("提示", cropStr, okFunc, nil, "确定", "取消")
end

function EternalFarmShopView:_onClickOneKeySold()
	local soldShopNum = self:_getSoldShopNum()

	if soldShopNum <= 0 then
		FloatWordMgr.instance:show("暂无可出售商品")

		return
	end

	local soldStr = "是否出售"
	local soldCfgList = {}
	local soldItemList = {}

	for i, cfg in ipairs(self._shopCfg) do
		local matType, matId, matNum = MaterialMgr.getMatParams(cfg.cost)
		local matName = MaterialMgr.getMaterialsNameByCfg(cfg.cost)
		local hasMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

		if soldShopNum > 0 and hasMatNum > 0 then
			if soldShopNum ~= 1 then
				local str = string.format("[%s×%d]、", matName, hasMatNum)

				soldStr = soldStr .. str
			else
				local str = string.format("[%s×%d]?", matName, hasMatNum)

				soldStr = soldStr .. str
			end

			local soldItem = {}

			soldItem.shopId = cfg.shopId
			soldItem.num = hasMatNum

			table.insert(soldCfgList, cfg)
			table.insert(soldItemList, soldItem)

			soldShopNum = soldShopNum - 1
		end
	end

	local soldRewardStr = self:_getOneKeySoldRewardStr(soldCfgList)

	soldStr = soldStr .. "\n" .. soldRewardStr

	local function okFunc()
		EternalFarmController.instance:sendPM_EternalFarmOneKeySellReq(self._activityId, soldItemList)
	end

	TipsFacade.instance:openPopupWindow("提示", soldStr, okFunc, nil, "确定", "取消")
end

function EternalFarmShopView:_getOneKeyPlantList()
	local cropsCfgs = EternalFarmConfig.instance:getCropCfgByYardId(self._activityId, self._curYardId)
	local dontMultipleList = {}
	local sortCfgs = {}
	local planList = {}

	for i, cfg in ipairs(cropsCfgs) do
		local seedMatStr = cfg.seed
		local matType, matId, matNum = MaterialMgr.getMatParams(seedMatStr)
		local hasSeedNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
		local canSeedFieldList = EternalFarmController.instance:getFieldCanPlantList(cfg.zoneId)

		if hasSeedNum > 0 and #canSeedFieldList > 0 then
			local isMultiple = table.indexof(self._multipleZoneId, cfg.zoneId)

			if isMultiple then
				local canSowNum = math.min(hasSeedNum, #canSeedFieldList)

				for i = 1, canSowNum do
					local field = canSeedFieldList[i]
					local item = {}

					item.zoneId = cfg.zoneId
					item.indexId = field:getIndexId()
					item.cropId = cfg.cropId

					table.insert(planList, item)

					if i == 1 then
						table.insert(sortCfgs, item)
					end
				end

				self._plantDic[cfg.cropId] = canSowNum
			else
				local canSowNum = math.min(hasSeedNum, #canSeedFieldList)

				for i = 1, canSowNum do
					local field = canSeedFieldList[i]
					local item = {}

					item.zoneId = cfg.zoneId
					item.indexId = field:getIndexId()
					item.cropId = cfg.cropId

					table.insert(planList, item)

					if i == 1 then
						table.insert(dontMultipleList, item)
					end
				end

				self._plantDic[cfg.cropId] = canSowNum
			end
		end
	end

	table.insertto(sortCfgs, dontMultipleList)

	return sortCfgs, planList
end

function EternalFarmShopView:_getSoldShopNum()
	local soldShopNum = 0

	for i, cfg in ipairs(self._shopCfg) do
		if cfg.type == 2 then
			local matType, matId, matNum = MaterialMgr.getMatParams(cfg.cost)
			local hasMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

			if hasMatNum > 0 then
				soldShopNum = soldShopNum + 1
			end
		end
	end

	return soldShopNum
end

function EternalFarmShopView:_getOneKeySoldRewardStr(soldCfgList)
	local soldStr = "<color=#CE1B1BFF>本次售卖可获得："
	local soldDic = {}
	local soldShopNum = self:_getSoldShopNum()
	local diffRewardNum = 0

	for i, cfg in ipairs(soldCfgList) do
		local matType, matId, matNum = MaterialMgr.getMatParams(cfg.prize)
		local matCostType, matCostId, matCostNum = MaterialMgr.getMatParams(cfg.cost)
		local matName = MaterialMgr.getMaterialsNameByCfg(cfg.prize)
		local hasMatNum = MaterialModel.instance:getMaterialsNumber(matCostType, matCostId)

		if soldDic[matName] == nil then
			soldDic[matName] = 0
			diffRewardNum = diffRewardNum + 1
		end

		soldDic[matName] = soldDic[matName] + matNum * hasMatNum
	end

	for matName, matNum in pairs(soldDic) do
		if diffRewardNum <= 1 then
			local str = string.format("%s×%d</color>", matName, matNum)

			soldStr = soldStr .. str
		else
			local str = string.format("%s×%d、", matName, matNum)

			soldStr = soldStr .. str
		end

		diffRewardNum = diffRewardNum - 1
	end

	return soldStr
end

function EternalFarmShopView:_onClickReduce(id, maxNum, cell)
	local num = self._inputNums[id] - 1

	self:_chargeNum(id, num, maxNum, cell)
end

function EternalFarmShopView:_onClickAdd(id, maxNum, cell)
	local num = self._inputNums[id] + 1

	self:_chargeNum(id, num, maxNum, cell)
end

function EternalFarmShopView:_onClickReduceTen(id, maxNum, cell)
	local num = self._inputNums[id] - 10

	self:_chargeNum(id, num, maxNum, cell)
end

function EternalFarmShopView:_onClickAddTen(id, maxNum, cell)
	local num = self._inputNums[id] + 10

	self:_chargeNum(id, num, maxNum, cell)
end

function EternalFarmShopView:_chargeNum(id, inputNum, maxNum, cell)
	local newNum = checkint(inputNum)

	newNum = Mathf.Clamp(newNum, 1, maxNum)

	if newNum ~= self._inputNums[id] then
		self._inputNums[id] = newNum

		self._tableview:_onCellUpdate(self, cell)
	end
end

function EternalFarmShopView:_onClickPlantReduce(id, maxNum, cell)
	local num = self._inputPlantNums[id] - 1

	self:_chargePlantNum(id, num, maxNum, cell)
end

function EternalFarmShopView:_onClickPlantAdd(id, maxNum, cell)
	local num = self._inputPlantNums[id] + 1

	self:_chargePlantNum(id, num, maxNum, cell)
end

function EternalFarmShopView:_onClickPlantReduceTen(id, maxNum, cell)
	local num = self._inputPlantNums[id] - 10

	self:_chargePlantNum(id, num, maxNum, cell)
end

function EternalFarmShopView:_onClickPlantAddTen(id, maxNum, cell)
	local num = self._inputPlantNums[id] + 10

	self:_chargePlantNum(id, num, maxNum, cell)
end

function EternalFarmShopView:_chargePlantNum(id, inputNum, maxNum, cell)
	local newNum = checkint(inputNum)

	newNum = Mathf.Clamp(newNum, 0, maxNum)

	if newNum ~= self._inputPlantNums[id] then
		self._inputPlantNums[id] = newNum

		self._scrollPlantList:_onCellUpdate(self, cell)
	end
end

return EternalFarmShopView
