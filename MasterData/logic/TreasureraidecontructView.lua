-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraidecontructView.lua

module("logic.extensions.treasureraider.view.TreasureraidecontructView", package.seeall)

local TreasureraidecontructView = class("TreasureraidecontructView", ViewComponent)

function TreasureraidecontructView:ctor()
	TreasureraidecontructView.super.ctor(self)
end

function TreasureraidecontructView:unbindEvents()
	TreasureraidecontructView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function TreasureraidecontructView:bindEvents()
	TreasureraidecontructView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function TreasureraidecontructView:buildUI()
	TreasureraidecontructView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtTitle = self:getTxt("txtTitle")
	self._btnSure = self:getGo("btnSure")
	self._tabCell = self:getGo("tabCell")
	self._tabTableView = self:getGo("tabTableView")
	self._buildingCell = self:getGo("buildingCell")
	self._buildingTableView = self:getGo("buildingTableView")

	GameUtil.SetActive(self._buildingCell, false)
	GameUtil.SetActive(self._tabCell, false)

	self._tabList = ScrollerList.create(self._tabTableView, self._tabCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._buildingList = ScrollerList.create(self._buildingTableView, self._buildingCell, GameUtil.handler(self._updateBuildingCell, self), GameUtil.handler(self._clearBuildingCell, self))
end

function TreasureraidecontructView:onExit()
	TreasureraidecontructView.super.onExit(self)
	self._tabList:dispose()
	self._buildingList:dispose()

	self._tabId2Configs = nil
end

function TreasureraidecontructView:onEnter()
	TreasureraidecontructView.super.onEnter(self)

	local tabConfigs = TreasureRaiderConfig.instance:getBuildingTab()
	local params = self:getFirstParam()

	self._curGridId = params.id
	self._activityId = params.activityId
	self._curMapBuildingMo = params.buildingMo

	if self._curMapBuildingMo then
		self._txtTitle.text = lang("建筑改建")
		self._curSelectBuildingId = self._curMapBuildingMo.buildingId
	else
		self._txtTitle.text = lang("建筑部署")
		self._curSelectBuildingId = nil
	end

	self:_initBuildingList()

	self._curTabData = tabConfigs[1]

	self._tabList:reloadData(tabConfigs)
	self:_updateBuildingList()
end

function TreasureraidecontructView:_initBuildingList()
	local mySceneMo = TreasureRaiderModel.instance.mySceneMo

	self._buildingId2MoArrayTempMap, self._buildingType2MoArrayTempMap = mySceneMo:getBuildingId2MoArrayTempMap()
end

function TreasureraidecontructView:_isBuildingFull(config)
	local has, limit = self:_getBuildingHas(config)

	return limit <= has
end

function TreasureraidecontructView:_isBuildingTypeFull(config)
	if config.type == TreasureRaiderConst.BuildingType_Resource then
		local maxValue = TreasureRaiderConfig.instance:getCommonValue("MaxResourceBuilding", true)
		local currentValue = #(self._buildingType2MoArrayTempMap[config.type] or {})

		return maxValue <= currentValue
	end

	return false
end

function TreasureraidecontructView:_getBuildingHas(config)
	return #(self._buildingId2MoArrayTempMap[config.bid] or {}), config.limit
end

function TreasureraidecontructView:_updateBuildingList()
	self._tabId2Configs = self._tabId2Configs or {}

	if not self._tabId2Configs[self._curTabData.tabId] then
		local configs = TreasureRaiderConfig.instance:getBuildingConfigByTypes(self._curTabData.types, self._activityId)

		table.sort(configs, function(a, b)
			local isFullA = self:_isBuildingFull(a)
			local isFullB = self:_isBuildingFull(b)

			if isFullA == isFullB then
				return a.bid < b.bid
			elseif isFullA then
				return false
			else
				return true
			end
		end)

		self._tabId2Configs[self._curTabData.tabId] = configs
	end

	self._buildingList:reloadData(self._tabId2Configs[self._curTabData.tabId])
end

function TreasureraidecontructView:_updateTabCell(view, cell, data, tag)
	local txt1 = goutil.findChildTextComponent(cell, "txt")
	local txt2 = goutil.findChildTextComponent(cell, "selected/txt")
	local selected = goutil.findChild(cell, "selected")
	local dot = goutil.findChild(cell, "dot")

	txt1.text = data.name
	txt2.text = data.name

	GameUtil.SetActive(dot, false)
	GameUtil.SetActive(selected, self._curTabData.tabId == data.tabId)
	GameUtil.addClickHandler(cell.gameObject, function()
		self._curTabData = data

		self._tabList:refresh()
		self:_updateBuildingList()
	end)
end

function TreasureraidecontructView:_clearTabCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function TreasureraidecontructView:_updateBuildingCell(view, cell, data, tag)
	local fullGo = goutil.findChild(cell, "full")
	local selected = goutil.findChild(cell, "selected")
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtCount = goutil.findChildTextComponent(cell, "txtCount")
	local buildingChange = goutil.findChildComponent(cell, "building", "UIImageSpriteChange")
	local isFull = self:_isBuildingFull(data)

	txtTitle.text = data.name
	txtDesc.text = data.desc

	local has, limit = self:_getBuildingHas(data)

	txtCount.text = langPara("(%d/%d)", has, limit)

	GameUtil.SetActive(fullGo, isFull)
	GameUtil.SetActive(selected, self._curSelectBuildingId == data.bid)
	buildingChange:ChangeSprite(data.viewPath)
	GameUtil.addClickHandler(cell.gameObject, function()
		if isFull then
			FloatWordMgr.instance:show(lang("该建筑数量已达到上限"))
		elseif self:_isBuildingTypeFull(data) then
			FloatWordMgr.instance:show(lang("资源类建筑数量已达到上限"))
		else
			self._curSelectBuildingId = data.bid

			self._buildingList:refresh()
		end
	end)
end

function TreasureraidecontructView:_clearBuildingCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function TreasureraidecontructView:_onClickSure()
	if not self._curSelectBuildingId then
		FloatWordMgr.instance:show(lang("未选中"))

		return
	end

	if self._curMapBuildingMo and self._curMapBuildingMo.buildingId == self._curSelectBuildingId then
		FloatWordMgr.instance:show(lang("相同的建筑"))

		return
	end

	local data = TreasureRaiderConfig.instance:getBuildingConfig(self._curSelectBuildingId, nil, self._activityId)

	if self:_isBuildingFull(data) then
		FloatWordMgr.instance:show(lang("该建筑数量已达到上限"))
	elseif self:_isBuildingTypeFull(data) then
		FloatWordMgr.instance:show(lang("资源类建筑数量已达到上限"))
	else
		local action

		TreasureRaiderController.instance:reqRichManAction(self._activityId, self._curGridId, self._curMapBuildingMo and TreasureRaiderConst.ServerAction_Reconstruct or TreasureRaiderConst.ServerAction_Construct, self._curSelectBuildingId)
		self:close()
	end
end

return TreasureraidecontructView
