-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityBuildShopSalesView.lua

module("logic.extensions.eternalcity.view.EternalCityBuildShopSalesView", package.seeall)

local EternalCityBuildShopSalesView = class("EternalCityBuildShopSalesView", ViewComponent)

function EternalCityBuildShopSalesView:buildUI()
	EternalCityBuildShopSalesView.super.buildUI(self)

	local buildScrCell = self:getGo("buildCol/scrCell")
	local buildScrView = self:getGo("buildCol/scrView")

	self._buildScrollerList = ScrollerList.create(buildScrView, buildScrCell, GameUtil.handler(self._updateBuildCell, self), GameUtil.handler(self._clearBuildCell, self))
	self._goldBarCon = self:getGo("goldBarCon")
end

function EternalCityBuildShopSalesView:bindEvents()
	EternalCityBuildShopSalesView.super.bindEvents(self)
end

function EternalCityBuildShopSalesView:unbindEvents()
	EternalCityBuildShopSalesView.super.unbindEvents(self)
end

function EternalCityBuildShopSalesView:onEnter()
	EternalCityBuildShopSalesView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._subMo = EternalCityController.instance:getSubMo(self._activityId)
	self._preOrders = self._preOrders or {}

	local goldMats = {}
	local datass = EternalCityConfig.instance:getBuildingDatass(self._activityId) or {}

	for buildingId, v in ipairs(datass) do
		self._preOrders[buildingId] = self._preOrders[buildingId] or {}

		for level, data in ipairs(v) do
			self._preOrders[buildingId][level] = self._preOrders[buildingId][level] or 0

			local mat = self._subMo:getBuildSalePriceMat(buildingId, level)

			goldMats[mat.matType .. ":" .. mat.matId] = true
		end
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

function EternalCityBuildShopSalesView:onExit()
	EternalCityBuildShopSalesView.super.onExit(self)
	self:_onClearBuildCol()
end

function EternalCityBuildShopSalesView:_handlePM_EternalCityBuyBuildingRes(msg)
	self:_updateBuildCellOnly(msg.buildingId, msg.level)
end

function EternalCityBuildShopSalesView:_handlePM_EternalCitySaleBuildingRes(msg)
	local buildingId = msg.buildingId
	local level = msg.level
	local num = msg.num

	self._preOrders[buildingId][level] = self._preOrders[buildingId][level] - num

	self:_updateBuildCellOnly(buildingId, level)
	FloatWordMgr.instance:show("出售成功！")
end

function EternalCityBuildShopSalesView:_onUpdate()
	self:_onUpdateBuildColUI()
end

function EternalCityBuildShopSalesView:_onUpdateBuildColUI()
	self._buildDataList = {}

	local datass = EternalCityConfig.instance:getBuildingDatass(self._activityId) or {}

	for buildingId, v in ipairs(datass) do
		for level, data in ipairs(v) do
			local num = self._subMo:getBuildingNumByLevel(buildingId, level)

			if num > 0 then
				table.insert(self._buildDataList, data)
			end
		end
	end

	self._buildScrollerList:reloadData(self._buildDataList)
end

function EternalCityBuildShopSalesView:_onClearBuildCol()
	self._buildScrollerList:dispose()
end

function EternalCityBuildShopSalesView:_updateBuildCellOnly(buildingId, level)
	local list = self._buildScrollerList:getData()

	if list == nil then
		return
	end

	for i, v in ipairs(list) do
		if v.buildingId == buildingId and v.level == level then
			self._buildScrollerList:updateCellInViewByIndex(i - 1)

			break
		end
	end
end

function EternalCityBuildShopSalesView:_updateBuildCell(view, cell, data, tag)
	local buildingId = data.buildingId
	local level = data.level
	local salePriceMat = self._subMo:getBuildSalePriceMat(buildingId, level)
	local preOrder = self._preOrders[buildingId][level]
	local withNum = self._subMo:getBuildingNumByLevel(buildingId, level)
	local salesResult = self:_getTrySalesBuildResultAndTips(false, buildingId, level, preOrder)
	local buildingNumInPlace = self._subMo:getBuildingNumInPlace(buildingId, level)
	local mainGo = cell.gameObject
	local buildIcon = goutil.findChild(mainGo, "buildIcon")
	local txtLevel = goutil.findChildTextComponent(mainGo, "level/txt")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local txtWith = goutil.findChildTextComponent(mainGo, "txtWith")
	local txtCount = goutil.findChildTextComponent(mainGo, "count/txt")
	local txtCost = goutil.findChildTextComponent(mainGo, "txtCost")
	local iconCost = goutil.findChild(mainGo, "txtCost/icon")
	local btnSure = goutil.findChild(mainGo, "btnSure")
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
	txtWith.text = string.format("当前拥有：%s/%s", withNum - buildingNumInPlace, withNum)
	txtCost.text = preOrder * salePriceMat.matNum
	txtCount.text = preOrder

	MaterialMgr.setIcon(iconCost, salePriceMat.matType, salePriceMat.matId, nil, nil)
	GameUtil.SetGray(btnSure, salesResult ~= GameEnum.ResultCode.Success)
	GameUtil.addClickHandler(btnAdd, GameUtil.handler(self._trySetBuildSalesCount, self, buildingId, level, 1))
	GameUtil.addClickHandler(btnAddTen, GameUtil.handler(self._trySetBuildSalesCount, self, buildingId, level, 10))
	GameUtil.addClickHandler(btnLess, GameUtil.handler(self._trySetBuildSalesCount, self, buildingId, level, -1))
	GameUtil.addClickHandler(btnLessTen, GameUtil.handler(self._trySetBuildSalesCount, self, buildingId, level, -10))
	GameUtil.addClickHandler(btnSure, GameUtil.handler(self._onClickBtnSure, self, buildingId, level))

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

function EternalCityBuildShopSalesView:_clearBuildCell(cell)
	local mainGo = cell.gameObject
	local buildIcon = goutil.findChild(mainGo, "buildIcon")
	local iconCost = goutil.findChild(mainGo, "txtCost/icon")
	local btnSure = goutil.findChild(mainGo, "btnSure")
	local btnLess = goutil.findChild(mainGo, "adjust/btnLess")
	local btnAdd = goutil.findChild(mainGo, "adjust/btnAdd")
	local btnLessTen = goutil.findChild(mainGo, "adjust/btnLessTen")
	local btnAddTen = goutil.findChild(mainGo, "adjust/btnAddTen")

	uGuiUtil.clearImage(buildIcon)
	MaterialMgr.clearIcon(iconCost)
	GameUtil.rmClickHandler(btnSure)
	GameUtil.rmClickHandler(btnLess)
	GameUtil.rmClickHandler(btnAdd)
	GameUtil.rmClickHandler(btnLessTen)
	GameUtil.rmClickHandler(btnAddTen)
	GameUtil.SetGray(btnSure, false)
end

function EternalCityBuildShopSalesView:_trySetBuildSalesCount(buildingId, level, delta)
	local buildingNum = self._subMo:getBuildingNumByLevel(buildingId, level)
	local buildingNumInPlace = self._subMo:getBuildingNumInPlace(buildingId, level)

	delta = Mathf.Min(delta, buildingNum - buildingNumInPlace)

	local newPreOrder = Mathf.Max(0, self._preOrders[buildingId][level] + delta)

	if newPreOrder > 0 then
		local result = self:_getTrySalesBuildResultAndTips(true, buildingId, level, newPreOrder)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	self._preOrders[buildingId][level] = newPreOrder

	self:_updateBuildCellOnly(buildingId, level)
end

function EternalCityBuildShopSalesView:_onClickBtnSure(buildingId, level)
	local preOrder = self._preOrders[buildingId][level]
	local result = self:_getTrySalesBuildResultAndTips(true, buildingId, level, preOrder)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local function successFunc()
		EternalCityController.instance:sendPM_EternalCitySaleBuildingReq(self._activityId, buildingId, level, preOrder)
	end

	local key = string.format("EternalCityBuildShopSalesView_%s", self._activityId)

	if not GameUtil.getUserDayData(key) then
		local togText = lang("今日不再提示")
		local title = lang("提示")
		local salePriceMat = self._subMo:getBuildSalePriceMat(buildingId, level)
		local buildingData = EternalCityConfig.instance:getBuildingData(self._activityId, buildingId, level)
		local gainNum = salePriceMat.matNum * preOrder
		local text = string.format("是否确定出售【%s级%s×%s】？本次出售可获得【%s×%s】", level, buildingData.name, preOrder, salePriceMat.matName, gainNum)

		local function funcTog()
			GameUtil.saveUserDayData(key, true)
		end

		TipsFacade.instance:openPopupWindowNoCancelWithTog(title, text, successFunc, funcTog, nil, togText, UnityEngine.TextAnchor.MiddleCenter)
	else
		successFunc()
	end
end

function EternalCityBuildShopSalesView:_getTrySalesBuildResultAndTips(isNeedTips, buildingId, level, preOrder)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间范围内"
	end

	if result == GameEnum.ResultCode.Success and preOrder <= 0 then
		result = GameEnum.ResultCode.Error
		tips = "售卖数量不能为0"
	end

	if result == GameEnum.ResultCode.Success then
		local buildingNum = self._subMo:getBuildingNumByLevel(buildingId, level)
		local buildingNumInPlace = self._subMo:getBuildingNumInPlace(buildingId, level)

		if preOrder > buildingNum - buildingNumInPlace then
			result = GameEnum.ResultCode.Error
			tips = "已放置建筑不能售卖"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local buildingNum = self._subMo:getBuildingNumByLevel(buildingId, level)

		if buildingNum - preOrder < 0 then
			result = GameEnum.ResultCode.Error
			tips = "售卖建筑数量不能超过现有数量"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

return EternalCityBuildShopSalesView
