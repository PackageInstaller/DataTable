-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityBuildShopBuyView.lua

module("logic.extensions.eternalcity.view.EternalCityBuildShopBuyView", package.seeall)

local EternalCityBuildShopBuyView = class("EternalCityBuildShopBuyView", ViewComponent)

function EternalCityBuildShopBuyView:buildUI()
	EternalCityBuildShopBuyView.super.buildUI(self)

	local buildScrCell = self:getGo("buildCol/scrCell")
	local buildScrView = self:getGo("buildCol/scrView")

	self._buildScrollerList = ScrollerList.create(buildScrView, buildScrCell, GameUtil.handler(self._updateBuildCell, self), GameUtil.handler(self._clearBuildCell, self))
	self._goldBarCon = self:getGo("goldBarCon")
end

function EternalCityBuildShopBuyView:bindEvents()
	EternalCityBuildShopBuyView.super.bindEvents(self)
end

function EternalCityBuildShopBuyView:unbindEvents()
	EternalCityBuildShopBuyView.super.unbindEvents(self)
end

function EternalCityBuildShopBuyView:onEnter()
	EternalCityBuildShopBuyView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._subMo = EternalCityController.instance:getSubMo(self._activityId)
	self._buildDataList = {}
	self._preOrders = self._preOrders or {}

	local goldMats = {}
	local datass = EternalCityConfig.instance:getBuildingDatass(self._activityId) or {}

	for _, datas in ipairs(datass) do
		local data = datas[1]

		table.insert(self._buildDataList, data)

		self._preOrders[data.buildingId] = self._preOrders[data.buildingId] or 1

		local mat = self._subMo:getBuildBuyCostMat(data.buildingId)

		goldMats[mat.matType .. ":" .. mat.matId] = true
	end

	local list = {}

	for matStr, bool in pairs(goldMats) do
		local tab = {
			showAdd = true,
			id = matStr
		}

		table.insert(list, tab)
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityBuyBuildingRes, self._handlePM_EternalCityBuyBuildingRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_EternalCitySaleBuildingRes, self._handlePM_EternalCitySaleBuildingRes, self)
	self:_onUpdate()
end

function EternalCityBuildShopBuyView:onExit()
	EternalCityBuildShopBuyView.super.onExit(self)
	self:_onClearBuildCol()
end

function EternalCityBuildShopBuyView:_handlePM_EternalCityBuyBuildingRes(msg)
	local buildingId = msg.buildingId
	local num = msg.num

	self._preOrders[buildingId] = Mathf.Max(1, self._preOrders[buildingId] - num)

	self:_updateBuildCellByBuildingId(buildingId)
	FloatWordMgr.instance:show("购买成功！")
end

function EternalCityBuildShopBuyView:_handlePM_EternalCitySaleBuildingRes(msg)
	self:_updateBuildCellByBuildingId(msg.buildingId)
end

function EternalCityBuildShopBuyView:_onUpdate()
	self:_onUpdateBuildColUI()
end

function EternalCityBuildShopBuyView:_onUpdateBuildColUI()
	self._buildScrollerList:reloadData(self._buildDataList)
end

function EternalCityBuildShopBuyView:_onClearBuildCol()
	self._buildScrollerList:dispose()
end

function EternalCityBuildShopBuyView:_updateBuildCellByBuildingId(buildingId)
	self._buildScrollerList:refresh()
end

function EternalCityBuildShopBuyView:_updateBuildCell(view, cell, data, tag)
	local buildingId = data.buildingId
	local buyCostMat = self._subMo:getBuildBuyCostMat(buildingId)
	local preOrder = self._preOrders[buildingId]
	local withNum = self._subMo:getBuildingNum(buildingId)
	local buyResult = self:_getTryBuyBuildResultAndTips(false, buildingId, preOrder)
	local mainGo = cell.gameObject
	local buildIcon = goutil.findChild(mainGo, "buildIcon")
	local txtLevel = goutil.findChildTextComponent(mainGo, "level/txt")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local txtWith = goutil.findChildTextComponent(mainGo, "txtWith")
	local txtCount = goutil.findChildTextComponent(mainGo, "count/txt")
	local txtCost = goutil.findChildTextComponent(mainGo, "txtCost")
	local iconCost = goutil.findChild(mainGo, "txtCost/icon")
	local btnBuy = goutil.findChild(mainGo, "btnBuy")
	local btnLess = goutil.findChild(mainGo, "adjust/btnLess")
	local btnAdd = goutil.findChild(mainGo, "adjust/btnAdd")
	local btnLessTen = goutil.findChild(mainGo, "adjust/btnLessTen")
	local btnAddTen = goutil.findChild(mainGo, "adjust/btnAddTen")
	local partView = goutil.findChild(mainGo, "partView")
	local partCell = goutil.findChild(mainGo, "partCell")
	local iconUrl = string.format("ui/bigbg/%s.png", data.iconUrl)

	uGuiUtil.setSpriteToImage(buildIcon, uGuiUtil.SpriteType.BigBg, iconUrl, function()
		return
	end)

	txtLevel.text = string.format("%s级", data.level)
	txtDesc.text = data.desc
	txtWith.text = string.format("当前拥有：%s", withNum)
	txtCount.text = preOrder

	MaterialMgr.setIcon(iconCost, buyCostMat.matType, buyCostMat.matId, nil, nil)

	local buyCost = preOrder * buyCostMat.matNum

	txtCost.text = buyResult == GameEnum.ResultCode.Success and buyCost or string.format("<color=#eb4624>%s</color>", buyCost)

	GameUtil.SetGray(btnBuy, buyResult ~= GameEnum.ResultCode.Success)
	GameUtil.addClickHandler(btnAdd, GameUtil.handler(self._trySetBuildBuyCount, self, buildingId, 1))
	GameUtil.addClickHandler(btnAddTen, GameUtil.handler(self._trySetBuildBuyCount, self, buildingId, 10))
	GameUtil.addClickHandler(btnLess, GameUtil.handler(self._trySetBuildBuyCount, self, buildingId, -1))
	GameUtil.addClickHandler(btnLessTen, GameUtil.handler(self._trySetBuildBuyCount, self, buildingId, -10))
	GameUtil.addClickHandler(btnBuy, GameUtil.handler(self._onClickBtnBuy, self, buildingId))

	local col, row = data.length, data.width
	local partCount = col * row
	local childCount = partView.transform.childCount
	local length = Mathf.Max(partCount, childCount)

	for idx = 1, length do
		if childCount < idx then
			goutil.cloneAndSetParent(partCell, partView.transform)
		end

		local go = partView.transform:GetChild(idx - 1).gameObject

		GameUtil.SetActive(go, idx <= partCount)
	end

	local partWidth, partHeight = GameUtil.getWidth(partCell), GameUtil.getHeight(partCell)

	GameUtil.setWidth(partView, partWidth * col)
	GameUtil.setHeight(partView, partHeight * row)
end

function EternalCityBuildShopBuyView:_clearBuildCell(cell)
	local mainGo = cell.gameObject
	local buildIcon = goutil.findChild(mainGo, "buildIcon")
	local iconCost = goutil.findChild(mainGo, "txtCost/icon")
	local btnBuy = goutil.findChild(mainGo, "btnBuy")
	local btnLess = goutil.findChild(mainGo, "adjust/btnLess")
	local btnAdd = goutil.findChild(mainGo, "adjust/btnAdd")
	local btnLessTen = goutil.findChild(mainGo, "adjust/btnLessTen")
	local btnAddTen = goutil.findChild(mainGo, "adjust/btnAddTen")

	uGuiUtil.clearImage(buildIcon)
	MaterialMgr.clearIcon(iconCost)
	GameUtil.rmClickHandler(btnBuy)
	GameUtil.rmClickHandler(btnLess)
	GameUtil.rmClickHandler(btnAdd)
	GameUtil.rmClickHandler(btnLessTen)
	GameUtil.rmClickHandler(btnAddTen)
	GameUtil.SetGray(btnBuy, false)
end

function EternalCityBuildShopBuyView:_trySetBuildBuyCount(buildingId, delta)
	local curBuildCount = self._subMo:getCurBuildCount()
	local maxBuildCount = self._subMo:getMaxBuildCount()
	local buyCostMat = self._subMo:getBuildBuyCostMat(buildingId)
	local costNum = buyCostMat.matNum
	local withNum = self._subMo:getBuildBuyCostMatWithNum(buildingId)
	local canNum = Mathf.Floor(withNum / costNum) - self._preOrders[buildingId]
	local offset = maxBuildCount - curBuildCount - self._preOrders[buildingId]

	delta = Mathf.Min(delta, offset)
	delta = Mathf.Min(delta, canNum)

	local newPreOrder = Mathf.Max(1, self._preOrders[buildingId] + delta)

	if newPreOrder > 0 then
		local result = self:_getTryBuyBuildResultAndTips(true, buildingId, newPreOrder)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	self._preOrders[buildingId] = newPreOrder

	self:_updateBuildCellByBuildingId(buildingId)
end

function EternalCityBuildShopBuyView:_onClickBtnBuy(buildingId)
	local preOrder = self._preOrders[buildingId]
	local result = self:_getTryBuyBuildResultAndTips(true, buildingId, preOrder)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local buyCostMat = self._subMo:getBuildBuyCostMat(buildingId)
	local costNum = preOrder * buyCostMat.matNum
	local buildingData = EternalCityConfig.instance:getBuildingData(self._activityId, buildingId, 1)
	local content = string.format("是否确定消耗【%s×%s】购买【1级%s×%s】？", buyCostMat.matName, costNum, buildingData.name, preOrder)

	local function successCallBack()
		EternalCityController.instance:sendPM_EternalCityBuyBuildingReq(self._activityId, buildingId, preOrder)
	end

	local toggleKey = string.format("EternalCityBuildShopBuyView_%s", self._activityId)

	TipsFacade.instance:openPopupCostMatViewWithToggleKey(buyCostMat.matType, buyCostMat.matId, costNum, content, successCallBack, toggleKey, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function EternalCityBuildShopBuyView:_getTryBuyBuildResultAndTips(isNeedTips, buildingId, preOrder)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success then
		local curBuildCount = self._subMo:getCurBuildCount()
		local maxBuildCount = self._subMo:getMaxBuildCount()

		if maxBuildCount < curBuildCount + preOrder then
			result = GameEnum.ResultCode.Error
			tips = "建筑数量不能超过上限"
		end
	end

	if result == GameEnum.ResultCode.Success and preOrder <= 0 then
		result = GameEnum.ResultCode.Error
		tips = "购买数量不能为0"
	end

	if result == GameEnum.ResultCode.Success and not self._subMo:isEnoughBuyBuildWithCost(buildingId, preOrder) then
		result = GameEnum.ResultCode.Error

		local mat = self._subMo:getBuildBuyCostMat(buildingId)

		tips = string.format("%s不足", mat.matName)
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

return EternalCityBuildShopBuyView
