-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationFoodBookView.lua

module("logic.extensions.islandstation.view.IslandStationFoodBookView", package.seeall)

local TITLE = 1
local CONTENT = 2
local CELL_HORIZONTAL_NUM = 7
local CELL_WIDTH = 100
local CELL_HEIGHT = 140
local CELL_INTERVAL = 10
local TITLE_WIDTH = 183
local TITLE_HEIGHT = 60
local IslandStationFoodBookView = class("IslandStationFoodBookView", ViewComponent)

function IslandStationFoodBookView:ctor()
	IslandStationFoodBookView.super.ctor(self)
end

function IslandStationFoodBookView:unbindEvents()
	IslandStationFoodBookView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCloseDescribe)
	GameUtil.rmClickHandler(self._storeTab1)
	GameUtil.rmClickHandler(self._storeTab2)
end

function IslandStationFoodBookView:bindEvents()
	IslandStationFoodBookView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCloseDescribe, self._onClickBtnDescribe, self)
	GameUtil.addClickHandler(self._storeTab1, GameUtil.handler(self._onClickBtnStoreTab, self, 1))
	GameUtil.addClickHandler(self._storeTab2, GameUtil.handler(self._onClickBtnStoreTab, self, 2))
end

function IslandStationFoodBookView:buildUI()
	IslandStationFoodBookView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._container = self:getGo("container")
	self._storeTab1 = self:getGo("storeTab1/btnClick")
	self._storeTab2 = self:getGo("storeTab2/btnClick")
	self._imgBgChangeComp = self:getGo("storeTab1/imgBg"):GetComponent("UIImageSpriteChange")
	self._imgBgChangeComp2 = self:getGo("storeTab2/imgBg"):GetComponent("UIImageSpriteChange")
	self._tabName = self:getGo("storeTab1/txtName")
	self._tabName2 = self:getGo("storeTab1/txtName2")
	self._tab2Name = self:getGo("storeTab2/txtName")
	self._tab2Name2 = self:getGo("storeTab2/txtName2")
	self._btnCloseDescribe = self:getGo("btnCloseDescribe")
	self._foodDescribe = self:getGo("foodDescribe")
	self._txtDescribe = self:getTxt("foodDescribe/txtDescribe")
	self._foodTableview = self:getGo("foodTableview")
	self._foodTablecell = self:getGo("foodTableview/tablecell")
	self._foodScrollList = ScrollerList.create(self._foodTableview, self._foodTablecell, GameUtil.handler(self._updateFoodCell, self), GameUtil.handler(self._clearFoodCell, self))
	self._cloneShopCell = self:getGo("cloneShopCell")
	self._contentTableCell = self:getGo("grilFoodTableview/contentTableCell")
	self._titleTableCell = self:getGo("grilFoodTableview/titleTableCell")
	self._grilFoodTableview = self:getGo("grilFoodTableview")
	self._grilFoodScrollList = ScrollerList.create(self._grilFoodTableview, {
		self._titleTableCell,
		self._contentTableCell
	}, GameUtil.handler(self._updateGrilFoodCell, self), GameUtil.handler(self._clearGrilFoodCell, self))

	self._grilFoodScrollList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._grilFoodScrollList:regGetCellSize(GameUtil.handler(self._getCellSizeCallBack, self))
end

function IslandStationFoodBookView:onExit()
	IslandStationFoodBookView.super.onExit(self)
	self._grilFoodScrollList:dispose()
end

function IslandStationFoodBookView:onEnter()
	IslandStationFoodBookView.super.onEnter(self)

	local params = self:getOpenParam()

	if params == nil then
		params = {}
	end

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 487001
	end

	self._tabIdx = 1
	self._girlFoodGoDic = {}
	self._storeTabChangeCompList = {
		self._imgBgChangeComp,
		self._imgBgChangeComp2
	}
	self._girlFoodCfgDic = IslandStationConfig.instance:getGirlFoodDic(self._activityId)
	self._girlNameList = IslandStationConfig.instance:getGirlNameList(self._activityId)
	self._shopLvList = IslandStationController.instance:getShopLvList(self._activityId)

	local foodBookData = self:_getFoodBookData()
	local foodData = IslandStationConfig.instance:getFoodNoGirlList(self._activityId)

	self._foodScrollList:reloadData(foodData)
	GameUtil.SetActive(self._cloneShopCell, false)
	GameUtil.SetActive(self._foodTableview, true)
	GameUtil.SetActive(self._grilFoodTableview, false)
	self:_updateTabUI()
end

function IslandStationFoodBookView:_getTagByIdx(data, idx)
	if not data.isTitle then
		return CONTENT
	else
		return TITLE
	end
end

function IslandStationFoodBookView:_getCellSizeCallBack(view, idx)
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

function IslandStationFoodBookView:_getGrilFoodData()
	local scrollData = {}
	local localFoodList, grilFoodList = IslandStationController.instance:getUnLockFoodList(self._activityId, self._tabIdx)
	local nameList = IslandStationConfig.instance:getGirlNameList(self._activityId)

	for i, girlName in ipairs(nameList) do
		local grilFoodCfgList = self._girlFoodCfgDic[i]
		local localTitleData = {}

		localTitleData.isTitle = true
		localTitleData.titleStr = girlName
		localTitleData.goodsDataList = nil

		table.insert(scrollData, localTitleData)

		local localData = {}

		localData.isTitle = false
		localData.titleStr = nil
		localData.goodsDataList = grilFoodCfgList or {}

		table.insert(scrollData, localData)
	end

	return scrollData
end

function IslandStationFoodBookView:_getFoodBookData()
	local scrollData = {}
	local foodBookData = {}

	foodBookData.name = "祖传食谱"
	foodBookData.shopId = 1

	table.insert(scrollData, foodBookData)

	local foodBookData2 = {}

	foodBookData2.name = "女神食谱"
	foodBookData2.shopId = 2

	table.insert(scrollData, foodBookData2)

	return scrollData
end

function IslandStationFoodBookView:_onClickBtnStoreTab(shopId)
	self._tabIdx = shopId

	self:_updateContent()

	for i, changeComp in ipairs(self._storeTabChangeCompList) do
		changeComp:SetState(i == self._tabIdx and 0 or 1)
	end
end

function IslandStationFoodBookView:_updateTabUI()
	for i, changeComp in ipairs(self._storeTabChangeCompList) do
		changeComp:SetState(i == self._tabIdx and 0 or 1)
	end

	if self._tabIdx == 1 then
		GameUtil.SetActive(self._tabName, true)
		GameUtil.SetActive(self._tabName2, false)
		GameUtil.SetActive(self._tab2Name, false)
		GameUtil.SetActive(self._tab2Name2, true)
	else
		GameUtil.SetActive(self._tabName, false)
		GameUtil.SetActive(self._tabName2, true)
		GameUtil.SetActive(self._tab2Name, true)
		GameUtil.SetActive(self._tab2Name2, false)
	end
end

function IslandStationFoodBookView:_updateFoodCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local imgLock = goutil.findChild(cell, "imgLock")
	local btnClick = goutil.findChild(cell, "btnClick")
	local txtPrize = goutil.findChildTextComponent(cell, "txtPrize")
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	txtName.text = data.name
	txtPrize.text = string.format("%d奥币/份", data.price)

	local shopLvList = IslandStationController.instance:getShopLvList(self._activityId)
	local curLv = shopLvList[data.shopId]
	local isUnLock = curLv >= data.shopLvUnlock
	local curShopCfg = IslandStationConfig.instance:getShopCfgByShopId(self._activityId, data.shopId)
	local shopName = curShopCfg.shopName

	GameUtil.SetActive(imgLock, not isUnLock)
	MaterialMgr.setCellByCfg(data.materialStr, item)
	GameUtil.addClickHandler(btnClick, function()
		if not isUnLock then
			FloatWordMgr.instance:show(string.format("%s等级达到%d即可解锁", shopName, data.shopLvUnlock))

			return
		end

		self._txtDescribe.text = data.describeStr
		self._foodDescribe.gameObject.transform.position = uGuiUtil.GetTouchWorldPosition()

		self:showTabAt(self._container, ViewName.IslandStationDescribeView, data.describeStr)

		self._container.transform.position = uGuiUtil.GetTouchWorldPosition()
	end, self)
end

function IslandStationFoodBookView:_clearFoodCell(cell)
	local btnClick = goutil.findChild(cell, "btnClick")
	local item = goutil.findChild(cell, "item")

	GameUtil.rmClickHandler(btnClick)
	MaterialMgr.resetAll(item)
end

function IslandStationFoodBookView:_updateGrilFoodCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local imgChoose = goutil.findChild(cell, "imgChoose")
	local btnClick = goutil.findChild(cell, "btnClick")

	if data.isTitle then
		local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
		local txtTitle2 = goutil.findChildTextComponent(cell, "txtTitle2")

		txtTitle.text = data.titleStr
		txtTitle2.text = data.titleStr

		GameUtil.setWidth(cell, TITLE_WIDTH)
		GameUtil.setHeight(cell, TITLE_HEIGHT)
		GameUtil.SetActive(txtTitle.gameObject, data.isTitle)
	else
		if self._girlFoodGoDic[cell] == nil then
			self._girlFoodGoDic[cell] = {}

			for i, v in ipairs(data.goodsDataList) do
				local foodCell = goutil.cloneAndSetParent(self._cloneShopCell, cell.transform, "grilFood" .. i)
				local x = (i - 1) % CELL_HORIZONTAL_NUM * CELL_WIDTH + (i - 1) * CELL_INTERVAL
				local y = -math.floor(i / CELL_HORIZONTAL_NUM) * CELL_WIDTH - CELL_WIDTH / 2
				local z = 0

				GameUtil.setLocalPos(foodCell, x, y, z)
				GameUtil.SetActive(foodCell, true)
				table.insert(self._girlFoodGoDic[cell], foodCell)
			end
		else
			if #data.goodsDataList > #self._girlFoodGoDic[cell] then
				for i = #self._girlFoodGoDic[cell] + 1, #data.goodsDataList do
					local foodCell = goutil.cloneAndSetParent(self._cloneShopCell, cell.transform, "grilFood" .. i)
					local x = (i - 1) % CELL_HORIZONTAL_NUM * CELL_WIDTH + (i - 1) * CELL_INTERVAL
					local y = -math.floor(i / CELL_HORIZONTAL_NUM) * CELL_WIDTH - CELL_WIDTH / 2
					local z = 0

					GameUtil.setLocalPos(foodCell, x, y, z)
					GameUtil.SetActive(foodCell, true)
					table.insert(self._girlFoodGoDic[cell], foodCell)
				end
			end

			for i, foodCell in ipairs(self._girlFoodGoDic[cell]) do
				GameUtil.SetActive(foodCell, i <= #data.goodsDataList)
			end
		end

		local num = #data.goodsDataList
		local rowNum = math.ceil(num / CELL_HORIZONTAL_NUM)
		local totalWidth = num * CELL_WIDTH + (num - 1) * CELL_INTERVAL
		local totalHeight = rowNum * CELL_HEIGHT + (rowNum - 1) * CELL_INTERVAL

		GameUtil.setWidth(cell, totalWidth)
		GameUtil.setHeight(cell, totalHeight)

		local grilFoodCellGoList = self._girlFoodGoDic[cell]

		for i, foodCellGo in ipairs(grilFoodCellGoList) do
			local item = goutil.findChild(foodCellGo, "item")
			local imgLock = goutil.findChild(foodCellGo, "imgLock")
			local btnClick = goutil.findChild(foodCellGo, "btnClick")
			local txtPrize = goutil.findChildTextComponent(foodCellGo, "txtPrize")
			local txtName = goutil.findChildTextComponent(foodCellGo, "txtName")
			local curData = data.goodsDataList[i]

			if curData then
				local girlId = curData.girlId
				local girlFetter = IslandStationModel.instance:getGirlFetter(self._activityId, girlId)
				local isUnLock = girlFetter >= curData.fetterUnlock

				txtName.text = curData.name
				txtPrize.text = string.format("%d奥币/份", curData.price)

				GameUtil.SetActive(imgLock, not isUnLock)
				MaterialMgr.setCellByCfg(curData.materialStr, item)
				GameUtil.addClickHandler(btnClick, function()
					if not isUnLock then
						local curGirlName = self._girlNameList[girlId]

						FloatWordMgr.instance:show(string.format("%s好感度达到%d即可解锁", curGirlName, curData.fetterUnlock))

						return
					end

					local cellPos = GameUtil.getLocalPos(foodCellGo)
					local foodCookList = IslandStationConfig.instance:getFoodCookList(self._activityId, curData.foodId)

					self._txtDescribe.text = curData.describeStr
					self._foodDescribe.gameObject.transform.position = uGuiUtil.GetTouchWorldPosition()

					self:showTabAt(self._container, ViewName.IslandStationDescribeView, curData.describeStr, foodCookList)

					self._container.transform.position = uGuiUtil.GetTouchWorldPosition()
				end, self)
			end
		end
	end
end

function IslandStationFoodBookView:_clearGrilFoodCell(cell)
	local grilFoodList = self._girlFoodGoDic[cell]

	if grilFoodList then
		for i, foodCell in ipairs(grilFoodList) do
			local item = goutil.findChild(foodCell, "item")

			MaterialMgr.resetAll(item)
			goutil.destroy(foodCell)
		end
	end

	self._girlFoodGoDic[cell] = nil
end

function IslandStationFoodBookView:_updateContent()
	GameUtil.SetActive(self._grilFoodTableview, self._tabIdx == 2)

	if self._tabIdx == 2 then
		local grilFoodData = self:_getGrilFoodData()

		self._grilFoodScrollList:reloadData(grilFoodData)
		GameUtil.SetActive(self._foodTableview, false)
		GameUtil.SetActive(self._grilFoodTableview, true)
	else
		local foodData = IslandStationConfig.instance:getFoodNoGirlList(self._activityId)

		GameUtil.SetActive(self._foodTableview, true)
		GameUtil.SetActive(self._grilFoodTableview, false)
		self._foodScrollList:reloadData(foodData)
	end

	local foodBookData = self:_getFoodBookData()

	self:_updateTabUI()
end

function IslandStationFoodBookView:_onClickBtnDescribe()
	GameUtil.SetActive(self._foodDescribe, false)
	GameUtil.SetActive(self._btnCloseDescribe, false)
end

function IslandStationFoodBookView:_updatDescribePos()
	local position = uGuiUtil.GetTouchWorldPosition()

	self._describePos.x = position.x
	self._describePos.y = position.y
	self._describePos.z = position.z
end

return IslandStationFoodBookView
