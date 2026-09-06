-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationWareHouseView.lua

module("logic.extensions.islandstation.view.IslandStationWareHouseView", package.seeall)

local IslandStationWareHouseView = class("IslandStationWareHouseView", ViewComponent)
local TITLE = 1
local CONTENT = 2
local CELL_HORIZONTAL_NUM = 9
local CELL_WIDTH = 100
local CELL_HEIGHT = 128
local CELL_TAIL_HEIGHT = 36
local CELL_INTERVAL = 10
local TITLE_WIDTH = 183
local TITLE_HEIGHT = 40

function IslandStationWareHouseView:ctor()
	IslandStationWareHouseView.super.ctor(self)
end

function IslandStationWareHouseView:unbindEvents()
	IslandStationWareHouseView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function IslandStationWareHouseView:bindEvents()
	IslandStationWareHouseView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function IslandStationWareHouseView:buildUI()
	IslandStationWareHouseView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._tableviewFood = self:getGo("tableviewFood")
	self._tablecellFood = self:getGo("tableviewFood/tablecell")
	self._foodScrollList = ScrollerList.create(self._tableviewFood, self._tablecellFood, GameUtil.handler(self._updateCellFood, self), GameUtil.handler(self._clearCellFood, self))
	self._cloneGoodsCell = self:getGo("cloneGoodsCell")
	self._contentTableCell = self:getGo("tableview/contentTableCell")
	self._titleTableCell = self:getGo("tableview/titleTableCell")
	self._tableview = self:getGo("tableview")
	self._goodScrollList = ScrollerList.create(self._tableview, {
		self._titleTableCell,
		self._contentTableCell
	}, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._goodScrollList:regGetCellSize(GameUtil.handler(self._getCellSizeCallBack, self))
	self._goodScrollList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
end

function IslandStationWareHouseView:onExit()
	IslandStationWareHouseView.super.onExit(self)
	self._goodScrollList:dispose()

	self._cloneGoodsCellDic = nil
end

function IslandStationWareHouseView:onEnter()
	IslandStationWareHouseView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_IslandStationPutOrChangeFoodRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._shopId = checknumber(params[2])
	self._shelfPosId = 1
	self._sellingFoodList = IslandStationModel.instance:getSellingFoodIdList(self._activityId, self._shopId)
	self._foodNumDic = IslandStationModel.instance:getFoodNumDic(self._activityId)
	self._cloneGoodsCellDic = {}
	self._goodScrollData = self:_setFoodData()

	self._goodScrollList:reloadData(self._goodScrollData)

	self._shopInfo = IslandStationModel.instance:getShopInfo(self._activityId)
	self._chooseFoodId = 0

	GameUtil.SetActive(self._cloneGoodsCell, false)
	self:_onUpdate()
end

function IslandStationWareHouseView:_onUpdate()
	self._sellingFoodList = IslandStationModel.instance:getSellingFoodIdList(self._activityId, self._shopId)
	self._foodNumDic = IslandStationModel.instance:getFoodNumDic(self._activityId)

	local shopInfos = IslandStationModel.instance:getShopInfo(self._activityId)

	self._curShopInfo = shopInfos[self._shopId]
	self._curShopLv = IslandStationConfig.instance:getShopLevel(self._activityId, self._shopId, self._curShopInfo.profit)
	self._unLockShelfNum = IslandStationController.instance:getUnLockShelfNum(self._activityId, self._shopId, self._curShopLv)

	local shopCfg = IslandStationConfig.instance:getShopCfgByShopId(self._activityId, self._shopId)
	local shopLvPlanId = shopCfg.shopLvPlanId
	local shopShelfs = {}
	local shelfNum = IslandStationConfig.instance:getShelfNum(shopLvPlanId)

	for i = 1, shelfNum do
		table.insert(shopShelfs, i)
	end

	self._foodScrollList:reloadData(shopShelfs)

	self._goodScrollData = self:_setFoodData()

	self._goodScrollList:reloadData(self._goodScrollData)
end

function IslandStationWareHouseView:_getTagByIdx(data, idx)
	if not data.isTitle then
		return CONTENT
	else
		return TITLE
	end
end

function IslandStationWareHouseView:_getCellSizeCallBack(view, idx)
	local data = self._grilFoodScrollList:getData()
	local curData = data[idx + 1]

	if not curData.isTitle then
		local num = #curData.goodsDataList
		local rowNum = math.ceil(num / CELL_HORIZONTAL_NUM)
		local totalWidth = num * CELL_WIDTH + (num - 1) * CELL_INTERVAL
		local totalHeight = rowNum * CELL_HEIGHT + (rowNum - 1) * CELL_INTERVAL

		return totalWidth, totalHeight
	else
		return TITLE_WIDTH, TITLE_HEIGHT
	end
end

function IslandStationWareHouseView:_onClickBtnSure()
	if self._chooseFoodId <= 0 then
		FloatWordMgr.instance:show("未选择美食")

		return
	end

	local shelfInfo = IslandStationModel.instance:getShelfInfo(self._activityId, self._shopId, self._shelfPosId)

	if shelfInfo and self._chooseFoodId == shelfInfo.foodId then
		FloatWordMgr.instance:show("不可上架重复商品")

		return
	end

	local curChooseIsCommonFood = IslandStationConfig.instance:isCommonFood(self._activityId, self._chooseFoodId)
	local curFoodNum = 0

	curFoodNum = curChooseIsCommonFood and 1 or checknumber(self._foodNumDic[self._chooseFoodId])

	if curFoodNum == 0 then
		FloatWordMgr.instance:show("剩余数量为0, 无法上架")

		return
	end

	IslandStationController.instance:sendPM_IslandStationPutOrChangeFoodReq(self._activityId, self._shopId, self._shelfPosId, self._chooseFoodId, curFoodNum)
end

function IslandStationWareHouseView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")

	if not data.isTitle then
		self:_updateContentCell(view, cell, data)
	else
		self:_updateTitleCell(view, cell, data)
	end
end

function IslandStationWareHouseView:_clearCell(cell)
	local goodsCellList = self._cloneGoodsCellDic[cell]
	local item = goutil.findChild(cell, "item")

	if item then
		MaterialMgr.resetAll(item)
	end

	if goodsCellList then
		for i, goodsCell in ipairs(goodsCellList) do
			goutil.destroy(goodsCell)
		end
	end

	self._cloneGoodsCellDic[cell] = nil
end

function IslandStationWareHouseView:_updateContentCell(view, cell, data)
	self._cloneGoodsCellDic[cell] = self._cloneGoodsCellDic[cell] or {}

	local cellNum = #data.goodsDataList
	local goodsCellList = self._cloneGoodsCellDic[cell]

	for i = #goodsCellList + 1, cellNum do
		local goodsCell = goutil.cloneAndSetParent(self._cloneGoodsCell, cell.transform, "goods" .. i)

		table.insert(goodsCellList, goodsCell)
	end

	for i = 1, #goodsCellList do
		goutil.setActive(goodsCellList[i], i <= cellNum)
	end

	local normalList = {}
	local downList = {}

	for i, goodsData in ipairs(data.goodsDataList) do
		local isSelling = table.indexof(self._sellingFoodList, goodsData.foodId)

		if isSelling then
			table.insert(downList, goodsData)
		else
			table.insert(normalList, goodsData)
		end
	end

	table.insertto(normalList, downList)

	for i, goodsData in ipairs(normalList) do
		local goodsCell = goodsCellList[i]
		local item = goutil.findChild(goodsCell, "item")
		local num = goutil.findChild(goodsCell, "num")
		local imgNumBg = goutil.findChild(goodsCell, "num/img")
		local imgChoose = goutil.findChild(goodsCell, "imgChoose")
		local btnChoose = goutil.findChild(goodsCell, "btnChoose")
		local txtPrize = goutil.findChildTextComponent(goodsCell, "txtPrize")
		local txtNum = goutil.findChildTextComponent(goodsCell, "num/txtNum")
		local matType, matId, matNum = MaterialMgr.getMatParams(goodsData.materialStr)
		local isSelling = table.indexof(self._sellingFoodList, goodsData.foodId)
		local verticalIdx = math.ceil(i / CELL_HORIZONTAL_NUM)

		if goodsData.grilId ~= 0 then
			local x = (i - 1) % CELL_HORIZONTAL_NUM * CELL_WIDTH + (i - 1) * CELL_INTERVAL
			local y = (-math.ceil(i / CELL_HORIZONTAL_NUM) + 1) * CELL_WIDTH
			local z = 0

			if isSelling then
				txtNum.text = "<color=#975018FF>已上架</color>"
			else
				local isCommonFood = IslandStationConfig.instance:isCommonFood(self._activityId, goodsData.foodId)

				if isCommonFood then
					txtNum.text = string.format("无限量")
				else
					local hasMatNum = checknumber(self._foodNumDic[goodsData.foodId])

					txtNum.text = string.format("剩余<color=#5792E6FF>%d</color>", hasMatNum)
				end
			end

			GameUtil.setLocalPos(goodsCell, x, y, z)
		else
			local x = (i - 1) % CELL_HORIZONTAL_NUM * CELL_WIDTH + (i - 1) * CELL_INTERVAL
			local y = (-math.ceil(i / CELL_HORIZONTAL_NUM) + 1) * CELL_WIDTH
			local z = 0

			GameUtil.setLocalPos(goodsCell, x, y, z)
		end

		txtPrize.text = string.format("%d奥币/份", goodsData.price)

		GameUtil.SetActive(imgChoose, goodsData.foodId == self._chooseFoodId)
		GameUtil.SetActive(num, goodsData.grilId ~= 0)
		GameUtil.SetActive(imgNumBg, isSelling)
		MaterialMgr.setCellByCfg(goodsData.materialStr, item)
		GameUtil.SetGray(item, isSelling)
		GameUtil.addClickHandler(btnChoose, function()
			if isSelling then
				FloatWordMgr.instance:show("已在货架上，不可重复上架")

				return
			end

			self._chooseFoodId = checknumber(goodsData.foodId)

			self._goodScrollList:reloadData(self._goodScrollData)
		end, self)
	end
end

function IslandStationWareHouseView:_updateTitleCell(view, cell, data)
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local txtTitle2 = goutil.findChildTextComponent(cell, "txtTitle2")

	txtTitle.text = data.titleStr
	txtTitle2.text = data.titleStr
end

function IslandStationWareHouseView:_updateCellFood(view, cell, data)
	local item = goutil.findChild(cell, "sell/item")
	local lock = goutil.findChild(cell, "lock")
	local imgAdd = goutil.findChild(cell, "imgAdd")
	local sell = goutil.findChild(cell, "sell")
	local btnClick = goutil.findChild(cell, "btnClick")
	local imgChoose = goutil.findChild(cell, "imgChoose")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtPrice = goutil.findChildTextComponent(cell, "sell/txtPrice")
	local txtNum = goutil.findChildTextComponent(cell, "sell/txtNum")
	local txtLock = goutil.findChildTextComponent(cell, "lock/txtLock")
	local shelfInfo = IslandStationModel.instance:getShelfInfo(self._activityId, self._shopId, data)

	if shelfInfo then
		if not shelfInfo.foodId then
			local foodId = 0
			local shopCfg = IslandStationConfig.instance:getShopCfgByShopId(self._activityId, self._shopId)
			local shopLvCfg = IslandStationConfig.instance:getShopLevelCfg(shopCfg.shopLvPlanId)
			local curLevel = IslandStationConfig.instance:getNextUnlockShelfLevel(shopCfg.shopLvPlanId, data)
			local isLock = data > self._unLockShelfNum
			local isEmpty = foodId == 0

			if not isEmpty then
				local shopNextLvCfg = IslandStationConfig.instance:getShopLevelCfgByLevel(shopCfg.shopLvPlanId, self._curShopLv + 1)
				local foodCfg = IslandStationConfig.instance:getFoodCfgByFoodId(self._activityId, foodId)
				local matType, matId, matNum = MaterialMgr.getMatParams(foodCfg.materialStr)
				local nowMs = ServerTime.nowMs()
				local leftSec = Mathf.Max(nowMs - checknumber(shelfInfo.lastRefreshTime), 0) / 1000

				txtPrice.text = string.format("%d奥币/份", foodCfg.price)

				local isCommonFood = IslandStationConfig.instance:isCommonFood(self._activityId, foodId)

				if not isCommonFood then
					local leftNum = shelfInfo.leftNum

					txtNum.text = string.format("剩余：%d/%d", leftNum, shopCfg.shelfPosMaxFoodCount)
				end

				GameUtil.SetActive(txtNum.gameObject, not isCommonFood)
				MaterialMgr.setCellByCfg(foodCfg.materialStr, item)
			end

			if isLock then
				txtLock.text = string.format("店铺%d级解锁", curLevel)
			end

			GameUtil.SetActive(lock, isLock)
			GameUtil.SetActive(imgAdd, isEmpty and not isLock)
			GameUtil.SetActive(sell, not isEmpty)
			GameUtil.SetActive(imgChoose, data == self._shelfPosId)
			GameUtil.addClickHandler(btnClick, function()
				if isLock then
					FloatWordMgr.instance:show(string.format("该商品栏将在店铺达到%d级后解锁", curLevel))

					return
				end

				if not isLock then
					self._shelfPosId = data

					self:_onUpdate()
				end
			end, self)
		end
	end
end

function IslandStationWareHouseView:_clearCellFood(cell)
	local item = goutil.findChild(cell, "item")
	local btnClick = goutil.findChild(cell, "btnClick")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnClick)
end

function IslandStationWareHouseView:_setFoodData()
	local scrollData = {}
	local localFoodList, grilFoodList = IslandStationController.instance:getUnLockFoodList(self._activityId, self._shopId)
	local localTitleData = {}

	localTitleData.isTitle = true
	localTitleData.titleStr = "祖传美食"
	localTitleData.goodsDataList = nil

	table.insert(scrollData, localTitleData)

	local localData = {}

	localData.isTitle = false
	localData.titleStr = nil
	localData.goodsDataList = localFoodList

	table.insert(scrollData, localData)

	local grilTitleData = {}

	grilTitleData.isTitle = true
	grilTitleData.titleStr = "女神美食"
	grilTitleData.goodsDataList = nil

	table.insert(scrollData, grilTitleData)

	local grilData = {}

	grilData.isTitle = false
	grilData.titleStr = nil
	grilData.goodsDataList = grilFoodList

	table.insert(scrollData, grilData)

	return scrollData
end

return IslandStationWareHouseView
