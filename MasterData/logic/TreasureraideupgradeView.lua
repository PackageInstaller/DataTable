-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraideupgradeView.lua

module("logic.extensions.treasureraider.view.TreasureraideupgradeView", package.seeall)

local TreasureraideupgradeView = class("TreasureraideupgradeView", ViewComponent)

function TreasureraideupgradeView:ctor()
	TreasureraideupgradeView.super.ctor(self)
end

function TreasureraideupgradeView:unbindEvents()
	TreasureraideupgradeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function TreasureraideupgradeView:bindEvents()
	TreasureraideupgradeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function TreasureraideupgradeView:buildUI()
	TreasureraideupgradeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtLevel = self:getTxt("txtLevel")
	self._btnSure = self:getGo("btnSure")
	self._txtName = self:getTxt("txtName")
	self._buildingChange = goutil.findChildComponent(self.mainGO, "building", "UIImageSpriteChange")
	self._txtLevelUpgrade = self:getTxt("txtLevelGroup")
	self._txtLevelUpgradeV1 = self:getTxt("txtLevelGroup/txt1")
	self._txtLevelUpgradeV2 = self:getTxt("txtLevelGroup/txt2")
	self._txtOtherUpgrade = self:getTxt("txtOtherGroup")
	self._txtOtherUpgradeV1 = self:getTxt("txtOtherGroup/txt1")
	self._txtOtherUpgradeV2 = self:getTxt("txtOtherGroup/txt2")
	self._cell = self:getGo("cell")
	self._tableView = self:getGo("tableview")
	self._buffList = ScrollerList.create(self._tableView, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function TreasureraideupgradeView:onExit()
	TreasureraideupgradeView.super.onExit(self)
	self._buffList:dispose()
end

function TreasureraideupgradeView:onEnter()
	TreasureraideupgradeView.super.onEnter(self)

	local params = self:getFirstParam()

	self._curGridId = params.id
	self._activityId = params.activityId
	self._curMapBuildingMo = params.buildingMo
	self._myPlayerMo = TreasureRaiderModel.instance.myPlayerMo
	self._buildingConfig = TreasureRaiderConfig.instance:getBuildingConfig(self._curMapBuildingMo.buildingId)

	self:_updateBuilding()
end

function TreasureraideupgradeView:_updateBuilding()
	if TreasureRaiderConst.BuildingType_Resource == self._buildingConfig.type then
		self:_updateResourceUpgrade()
	else
		self:_updateNotResourceUpgrade()
	end
end

function TreasureraideupgradeView:getLevels(upgradeConfigs)
	if not self._curMapBuildingMo.buildingLevel then
		local currentLevel = 0
		local maxLevel = #upgradeConfigs
		local nextLevel = math.min(currentLevel + 1, maxLevel)
		local buffAddLevel = 0

		if self._myPlayerMo:isBuffActive(TreasureRaiderConst.BuffType_UpgradePercent) then
			buffAddLevel = checknumber(self._myPlayerMo:getBuffValue(TreasureRaiderConst.BuffType_UpgradePercent))
			nextLevel = math.min(nextLevel + buffAddLevel, maxLevel)
		end

		return currentLevel, nextLevel, maxLevel, buffAddLevel
	end
end

function TreasureraideupgradeView:_updateSame(upgradeConfigs)
	local currentLevel, nextLevel, maxLevel, buffAddLevel = self:getLevels(upgradeConfigs)

	self._txtName.text = self._buildingConfig.name

	self._buildingChange:ChangeSprite(self._buildingConfig.viewPath)

	self._txtLevel.text = langPara("Lv.%s", self._curMapBuildingMo.buildingLevel or 0)

	GameUtil.SetActive(self._txtLevel, false)

	local buffStr = ""

	if self._myPlayerMo:isBuffActive(TreasureRaiderConst.BuffType_UpgradePercent) then
		buffStr = langPara("(祝福+%d)", buffAddLevel)
	end

	self._txtLevelUpgradeV1.text = tostring(currentLevel)
	self._txtLevelUpgradeV2.text = langPara("%s%s", nextLevel, buffStr)

	self:_updateBuff(upgradeConfigs)
end

function TreasureraideupgradeView:_updateResourceUpgrade()
	local upgradeConfigs = TreasureRaiderConfig.instance:getResourcePlanConfigs(self._buildingConfig.srcPlanId)

	self:_updateSame(upgradeConfigs)

	local currentLevel, nextLevel, maxLevel, buffAddLevel = self:getLevels(upgradeConfigs)
	local currentConfig = upgradeConfigs[currentLevel]
	local nextConfig = upgradeConfigs[nextLevel]

	self._txtOtherUpgradeV1.text = langPara("%s", checknumber(currentConfig.product))
	self._txtOtherUpgradeV2.text = langPara("%s", checknumber(nextConfig.product))
	self._txtOtherUpgrade.text = TreasureRaiderConst.BuildingUpgradeBuffNameMap[self._buildingConfig.type]
end

function TreasureraideupgradeView:_updateNotResourceUpgrade()
	local upgradeConfigs = TreasureRaiderConfig.instance:getBuildingBuffByPlanId(self._buildingConfig.buffPlanId)

	self:_updateSame(upgradeConfigs)

	local currentLevel, nextLevel, maxLevel, buffAddLevel = self:getLevels(upgradeConfigs)
	local currentConfig = upgradeConfigs[currentLevel]
	local nextConfig = upgradeConfigs[nextLevel]

	self._txtOtherUpgradeV1.text = string.format("%s", currentConfig.otherValue)
	self._txtOtherUpgradeV2.text = string.format("%s", nextConfig.otherValue)
	self._txtOtherUpgrade.text = currentConfig.otherTxt
end

function TreasureraideupgradeView:_updateBuff(upgradeConfigs)
	local configsT = upgradeConfigs
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

function TreasureraideupgradeView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")

	if not self._curMapBuildingMo.buildingLevel then
		local currentLevel = 0
		local isActive = currentLevel >= data.level

		txtDesc.text = langPara("<color=%s>等级%d祝福：%s</color>", (isActive or nil) and "#aa3c40", data.level, data.buildingLevDesc)
	end
end

function TreasureraideupgradeView:_clearCell(cell)
	return
end

function TreasureraideupgradeView:_onClickSure()
	TreasureRaiderController.instance:reqRichManAction(self._activityId, self._curGridId, TreasureRaiderConst.ServerAction_Upgrade, self._curMapBuildingMo.buildingId)
	self:close()
end

return TreasureraideupgradeView
