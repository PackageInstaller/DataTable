-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationFillShopView.lua

module("logic.extensions.islandstation.view.IslandStationFillShopView", package.seeall)

local IslandStationFillShopView = class("IslandStationFillShopView", ViewComponent)

function IslandStationFillShopView:ctor()
	IslandStationFillShopView.super.ctor(self)
end

function IslandStationFillShopView:unbindEvents()
	IslandStationFillShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnFillShop)
	GameUtil.rmClickHandler(self._btnChangeStore)
	GameUtil.rmClickHandler(self._btnChangeStore2)
	self._btnChange:RemoveClickListener()
end

function IslandStationFillShopView:bindEvents()
	IslandStationFillShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnFillShop, self._onClickBtnFillShop, self)
	GameUtil.addClickHandler(self._btnChangeStore, GameUtil.handler(self._onClickStore, self, 1))
	GameUtil.addClickHandler(self._btnChangeStore2, GameUtil.handler(self._onClickStore, self, 2))
	self._btnChange:AddClickListener(self._onClickbtnChange, self)
end

function IslandStationFillShopView:buildUI()
	IslandStationFillShopView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnFillShop = self:getGo("btnFillShop")
	self._cellName = self:getGo("stroecell/txtName")
	self._cellName2 = self:getGo("stroecell/txtName2")
	self._cell2Name = self:getGo("stroecell2/txtName")
	self._cell2Name2 = self:getGo("stroecell2/txtName2")
	self._imgChangeComp = self:getGo("stroecell/img"):GetComponent("UIImageSpriteChange")
	self._imgChangeComp2 = self:getGo("stroecell2/img"):GetComponent("UIImageSpriteChange")
	self._btnChangeStore = self:getGo("stroecell/btnChange")
	self._btnChangeStore2 = self:getGo("stroecell2/btnChange")
	self._tablecellShop = self:getGo("tableviewShop/tablecell")
	self._tableviewShop = self:getGo("tableviewShop")
	self._scrollShopList = ScrollerList.create(self._tableviewShop, self._tablecellShop, GameUtil.handler(self._updateShopCell, self), GameUtil.handler(self._clearShopCell, self))
	self._btnChange = self:getBtn("btnChange")
	self._imgLock = self:getGo("stroecell/imgLock")
	self._imgLock2 = self:getGo("stroecell2/imgLock")
end

function IslandStationFillShopView:onExit()
	IslandStationFillShopView.super.onExit(self)
	self._scrollShopList:dispose()
end

function IslandStationFillShopView:onEnter()
	IslandStationFillShopView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_IslandStationPutOrChangeFoodRes, self.close, self)
	self.addGEvent(self, GlobalNotify.PM_IslandStationOneKeyFullFillRes, self._onOneKeyFullFillRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._curShopId = checknumber(params[2])
	self._shopCfgs = IslandStationConfig.instance:getShopCfg(self._activityId)

	IslandStationModel.instance:getSellingFoodIdList(self._activityId, self._curShopId)

	self._storeChangeCompList = {
		self._imgChangeComp,
		self._imgChangeComp2
	}
	self._info = IslandStationModel.instance:getInfo(self._activityId)

	local shopInfos = IslandStationModel.instance:getShopInfo(self._activityId)

	self._curShopInfo = shopInfos[self._curShopId]
	self._curShopLv = IslandStationConfig.instance:getShopLevel(self._activityId, self._curShopId, self._curShopInfo.profit)
	self._unLockShelfNum = IslandStationController.instance:getUnLockShelfNum(self._activityId, self._curShopId, self._curShopLv)

	self:_updateShopList()
	self:_updateTabUI()
end

function IslandStationFillShopView:_updateShopList()
	local shopCfg = IslandStationConfig.instance:getShopCfgByShopId(self._activityId, self._curShopId)
	local shopLvPlanId = shopCfg.shopLvPlanId
	local shopShelfs = {}
	local shelfNum = IslandStationConfig.instance:getShelfNum(shopLvPlanId)

	for i = 1, shelfNum do
		table.insert(shopShelfs, i)
	end

	self._curViewDatas = shopShelfs

	self._scrollShopList:reloadData(shopShelfs)
end

function IslandStationFillShopView:_onClickStore(idx)
	local isLock = self:_isLock(idx)

	if isLock then
		local curShopCfg = IslandStationConfig.instance:getShopCfgByShopId(self._activityId, idx)
		local timeArr = string.split(curShopCfg.startTime, "T")

		FloatWordMgr.instance:show(string.format("该店铺于%s %s后解锁", timeArr[1], timeArr[2]))

		return
	end

	self._curShopId = idx

	self:_updateShopList()
	self:_updateTabUI()
end

function IslandStationFillShopView:_updateTabUI()
	for i, comp in ipairs(self._storeChangeCompList) do
		comp:SetState(i == self._curShopId and 0 or 1)
	end

	if self._curShopId == 1 then
		GameUtil.SetActive(self._cellName, true)
		GameUtil.SetActive(self._cellName2, false)
		GameUtil.SetActive(self._cell2Name, false)
		GameUtil.SetActive(self._cell2Name2, true)
	else
		GameUtil.SetActive(self._cellName, false)
		GameUtil.SetActive(self._cellName2, true)
		GameUtil.SetActive(self._cell2Name, true)
		GameUtil.SetActive(self._cell2Name2, false)
	end

	local isLock = self:_isLock(1)
	local isLock2 = self:_isLock(2)

	GameUtil.SetActive(self._imgLock, isLock)
	GameUtil.SetActive(self._imgLock2, isLock2)
end

function IslandStationFillShopView:_updateShopCell(view, cell, data)
	local item = goutil.findChild(cell, "sell/item")
	local lock = goutil.findChild(cell, "lock")
	local imgAdd = goutil.findChild(cell, "imgAdd")
	local imgBg2 = goutil.findChild(cell, "sell/imgBg2")
	local sell = goutil.findChild(cell, "sell")
	local btnClick = goutil.findChild(cell, "btnClick")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtPrice = goutil.findChildTextComponent(cell, "sell/txtPrice")
	local txtNum = goutil.findChildTextComponent(cell, "sell/txtNum")
	local txtLevel = goutil.findChildTextComponent(cell, "lock/txtLevel")
	local shelfInfo = IslandStationModel.instance:getShelfInfo(self._activityId, self._curShopId, data)

	if shelfInfo then
		if not shelfInfo.foodId then
			local foodId = 0
			local shopCfg = IslandStationConfig.instance:getShopCfgByShopId(self._activityId, self._curShopId)
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
				local leftNum = shelfInfo.leftNum

				txtPrice.text = string.format("%d奥币/份", foodCfg.price)
				txtNum.text = string.format("剩余：%d/%d", leftNum, shopCfg.shelfPosMaxFoodCount)

				local isCommonFood = IslandStationConfig.instance:isCommonFood(self._activityId, foodId)

				if not isCommonFood then
					txtNum.text = string.format("剩余：%d/%d", leftNum, shopCfg.shelfPosMaxFoodCount)
				end

				GameUtil.SetActive(imgBg2, not isCommonFood)
				GameUtil.SetActive(txtNum.gameObject, not isCommonFood)
				MaterialMgr.setCellByCfg(foodCfg.materialStr, item)
			end

			if isLock then
				txtLevel.text = string.format("店铺%d级解锁", curLevel)
			end

			GameUtil.SetActive(lock, isLock)
			GameUtil.SetActive(imgAdd, isEmpty and not isLock)
			GameUtil.SetActive(sell, not isEmpty)
			GameUtil.addClickHandler(btnClick, function()
				if isLock then
					FloatWordMgr.instance:show(string.format("该商品栏将在店铺达到%d级后解锁", curLevel))

					return
				end

				if isEmpty and not isLock then
					UIStateManager.instance:push(ViewName.IslandStationWareHouseView, self._activityId, self._curShopId)

					return
				end

				local foodCfg = IslandStationConfig.instance:getFoodCfgByFoodId(self._activityId, foodId)

				TipsFacade.instance:openItemSourceView(foodCfg.materialStr)
			end, self)
		end
	end
end

function IslandStationFillShopView:_clearShopCell(cell)
	local item = goutil.findChild(cell, "item")
	local btnClick = goutil.findChild(cell, "btnClick")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnClick)
end

function IslandStationFillShopView:_onClickBtnFillShop()
	local shopInfos = IslandStationModel.instance:getShopInfo(self._activityId)

	self._curShopInfo = shopInfos[self._curShopId]

	local hasSellingShelfNum = 0

	for i = 1, self._unLockShelfNum do
		local shelfInfo = self._curShopInfo.shelfPosInfo[i]

		if shelfInfo then
			hasSellingShelfNum = hasSellingShelfNum + 1
		end
	end

	IslandStationController.instance:sendPM_IslandStationOneKeyFullFillReq(self._activityId, self._curShopId)
end

function IslandStationFillShopView:_onOneKeyFullFillRes()
	FloatWordMgr.instance:show("补货成功")
	self:close()
end

function IslandStationFillShopView:_onClickbtnChange()
	if self._curViewDatas then
		local allIsLock = true

		for i, num in ipairs(self._curViewDatas) do
			local isLock = num > self._unLockShelfNum

			if not isLock then
				allIsLock = false

				break
			end
		end

		if not allIsLock then
			UIStateManager.instance:push(ViewName.IslandStationWareHouseView, self._activityId, self._curShopId)
		else
			FloatWordMgr.instance:show("暂时不可更换")
		end
	end
end

function IslandStationFillShopView:_isLock(shopId)
	local curShopCfg = IslandStationConfig.instance:getShopCfgByShopId(self._activityId, shopId)
	local startTimeStr = curShopCfg.startTime
	local timeStamp = GameUtil.string2time(startTimeStr)

	return timeStamp > ServerTime.now()
end

return IslandStationFillShopView
