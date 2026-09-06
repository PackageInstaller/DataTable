-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraidedescView.lua

module("logic.extensions.treasureraider.view.TreasureraidedescView", package.seeall)

local TreasureraidedescView = class("TreasureraidedescView", ViewComponent)

function TreasureraidedescView:ctor()
	TreasureraidedescView.super.ctor(self)
end

function TreasureraidedescView:unbindEvents()
	TreasureraidedescView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function TreasureraidedescView:bindEvents()
	TreasureraidedescView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function TreasureraidedescView:buildUI()
	TreasureraidedescView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtName = self:getTxt("txtName")
	self._txtExp = self:getTxt("txtExp")
	self._txtLevel = self:getTxt("txtLevel")
	self._buildingChange = goutil.findChildComponent(self.mainGO, "building", "UIImageSpriteChange")
	self._normalGo = self:getGo("normal")
	self._txtDesc = self:getTxt("normal/txtDesc/Viewport/Content")
	self._buffGo = self:getGo("buff")
	self._cell = self:getGo("buff/cell")
	self._tableView = self:getGo("buff/tableview")
	self._buffList = ScrollerList.create(self._tableView, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function TreasureraidedescView:onExit()
	TreasureraidedescView.super.onExit(self)
	self._buffList:dispose()
end

function TreasureraidedescView:onEnter()
	TreasureraidedescView.super.onEnter(self)

	local params = self:getFirstParam()

	self._curGridId = params.id
	self._activityId = params.activityId
	self._curMapBuildingMo = params.buildingMo
	self._curSceneMo = params.sceneMo
	self._buildingConfig = TreasureRaiderConfig.instance:getBuildingConfig(self._curMapBuildingMo.buildingId)

	GameUtil.SetActive(self._normalGo, false)
	GameUtil.SetActive(self._buffGo, false)
	GameUtil.SetActive(self._txtLevel, false)

	if self._buildingConfig.type == TreasureRaiderConst.BuildingType_MainCamp then
		GameUtil.SetActive(self._txtExp, true)

		local mainCampConfig, mainCampLevel, mainCampExp

		if self._curSceneMo:isMyScene() then
			mainCampExp = self._curSceneMo.myPlayerMo.mainCampExp
			mainCampLevel = self._curSceneMo.myPlayerMo.mainCampLevel
		else
			mainCampExp = self._curSceneMo.opPlayerMo.mainCampExp
			mainCampLevel = self._curSceneMo.opPlayerMo.mainCampLevel
		end

		self._txtExp.text = mainCampExp ~= nil and langPara("经验值：%s/%s", mainCampExp, TreasureRaiderConfig.instance:getMainCampConfig(mainCampLevel).exp) or ""
	else
		GameUtil.SetActive(self._txtExp, false)
	end

	if self._buildingConfig.type == TreasureRaiderConst.BuildingType_MainCamp or self._buildingConfig.type == TreasureRaiderConst.BuildingType_Effect then
		self:_updateAsNormal()
	else
		self:_updateAsBuff()
	end

	self._txtName.text = self._buildingConfig.name

	self._buildingChange:ChangeSprite(self._buildingConfig.viewPath)
end

function TreasureraidedescView:_updateAsNormal()
	GameUtil.SetActive(self._normalGo, true)
	GameUtil.SetActive(self._txtDesc, true)

	local descStr = self._buildingConfig.desc
	local sceneMo = TreasureRaiderModel.instance:getCurSceneMo()
	local isMyScene = sceneMo:isMyScene()
	local myPlayerMo = TreasureRaiderModel.instance.myPlayerMo

	if isMyScene and self._buildingConfig.trigger == "AttackAwardAddition" and myPlayerMo:isBuffActive(TreasureRaiderConst.BuffType_AttackPercent) then
		local value = myPlayerMo:getBuffValue(TreasureRaiderConst.BuffType_AttackPercent) / 100

		descStr = string.format("%s\n\n<color=#C54949>下次入侵的额外资源收益：%s%%</color>", self._buildingConfig.desc, value)
	end

	self._txtDesc.text = descStr

	GameUtil.SetActive(self._txtLevel, self._buildingConfig.type == TreasureRaiderConst.BuildingType_MainCamp)

	self._txtLevel.text = langPara("Lv.%s", math.max(self._curMapBuildingMo.buildingLevel))
end

function TreasureraidedescView:_updateAsBuff()
	GameUtil.SetActive(self._buffGo, true)
	GameUtil.SetActive(self._txtLevel, true)

	self._txtLevel.text = langPara("Lv.%s", self._curMapBuildingMo.buildingLevel or 0)

	local buffPlanId = self._buildingConfig.buffPlanId
	local configsT = TreasureRaiderConfig.instance:getBuildingBuffByPlanId(buffPlanId)
	local configs = {}

	for _, v in pairs(configsT) do
		if not string.nilorempty(v.buildingLevDesc) then
			table.insert(configs, v)
		end
	end

	ArraySort.sortOn(configs, "level")

	if not self._curMapBuildingMo.buildingLevel then
		local index = 0

		for i, v in pairs(configs) do
			if self._curMapBuildingMo.buildingLevel >= v.level then
				index = i - 1
			end
		end

		self._buffList:reloadData(configs)
		self._buffList:MoveCellInView(index, false)
	end
end

function TreasureraidedescView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local isActive = self._curMapBuildingMo.buildingLevel >= data.level

	txtDesc.text = langPara("<color=%s>等级%d祝福：%s</color>", (isActive or nil) and "#aa3c40", data.level, data.buildingLevDesc)
end

function TreasureraidedescView:_clearCell(cell)
	return
end

return TreasureraidedescView
