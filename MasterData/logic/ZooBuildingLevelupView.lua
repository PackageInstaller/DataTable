-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooBuildingLevelupView.lua

module("logic.extensions.zoo.view.ZooBuildingLevelupView", package.seeall)

local ZooBuildingLevelupView = class("ZooBuildingLevelupView", ViewComponent)

function ZooBuildingLevelupView:buildUI()
	ZooBuildingLevelupView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._upBtn = self:getBtn("levelNode/upBtn")
	self._buildingIcon = self:getGo("buildingIcon")
	self._buildingDesc = self:getTxt("buildingDesc")
	self._buildingLevel = self:getTxt("levelNode/buildingLevel")
	self._costItem = self:getGo("levelNode/costItemNum")
	self._costItemNum = self:getTxt("levelNode/costItemNum/Text")
	self._currLevelAttrs = self:getGo("levelNode/currLevel"):GetComponent(ComponentType.UILayoutSingleLine)
	self._nextLevelAttrs = self:getGo("levelNode/nextLevel"):GetComponent(ComponentType.UILayoutSingleLine)
	self._buildingNextLevel = self:getTxt("levelNode/buildingNextLevel")

	local txtTitle = self:getTxt("txtTitle")
	local txtMaxLevel = self:getTxt("txtMaxLevel")

	txtTitle.text = lang("petzoo_building_lvup_title")
	txtMaxLevel.text = lang("petzoo_building_lvup_max")
	self._maxLevel = txtMaxLevel.gameObject
	self._levelNode = self:getGo("levelNode")
end

function ZooBuildingLevelupView:bindEvents()
	ZooBuildingLevelupView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._upBtn:AddClickListener(self._onClickLevelup, self)
end

function ZooBuildingLevelupView:unbindEvents()
	ZooBuildingLevelupView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._upBtn:RemoveClickListener()
end

function ZooBuildingLevelupView:onEnter()
	ZooBuildingLevelupView.super.onEnter(self)

	self._buildingMo = self:getFirstParam()
	self._buildingDesc.text = self._buildingMo:getBuildingInfo()
	self._buildingLevel.text = string.format(lang("text_curr_level_title"), self._buildingMo.buildingLevel)
	self._buildingNextLevel.text = string.format(lang("text_next_level_title"), self._buildingMo.buildingLevel + 1)

	Framework.ImageBigBG.Get(self._buildingIcon):SetImage(self._buildingMo:getBuildingIcon())
	self:_updateMaxLevel()
	self:_updateAttrDesc(self._currLevelAttrs, self._buildingMo.buildingLevel)
	self:_updateAttrDesc(self._nextLevelAttrs, self._buildingMo.buildingLevel + 1)
	self:_updateCostItem()
end

function ZooBuildingLevelupView:_updateMaxLevel()
	if self._buildingMo:isMaxLevel() then
		self._maxLevel:SetActive(true)
		self._levelNode:SetActive(false)
	else
		self._levelNode:SetActive(true)
		self._maxLevel:SetActive(false)
	end
end

function ZooBuildingLevelupView:_updateCostItem()
	if not self._buildingMo:isMaxLevel() then
		local upCost = self._buildingMo:getUpgradeCost()
		local items = self._buildingMo:toMaterials(upCost)

		MaterialMgr.setIcon(self._costItem, items[1][1], items[1][2])

		self._costItemNum.text = string.format("%d", items[1][3])
	end
end

function ZooBuildingLevelupView:_updateAttrDesc(node, level)
	local attrDescs = self._buildingMo:getBuildingAttrDescs(level)

	if not attrDescs then
		node.gameObject:SetActive(false)

		return
	end

	node.gameObject:SetActive(true)

	local descNum = #attrDescs
	local transform = node.transform
	local childCount = transform.childCount

	while childCount < descNum do
		childCount = childCount + 1

		UGUIToolHelper.AddChild(node.gameObject, transform:GetChild(0).gameObject)
	end

	for i = 1, descNum do
		local descMo = attrDescs[i]
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(true)

		local name = goutil.findChildTextComponent(go, "name")
		local content = goutil.findChildTextComponent(go, "content")

		name.text = descMo.attrName
		content.text = descMo.attrDesc
	end

	for i = descNum + 1, childCount do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	node:Layout()
end

function ZooBuildingLevelupView:onEnterFinished()
	ZooBuildingLevelupView.super.onEnterFinished(self)
end

function ZooBuildingLevelupView:onExit()
	ZooBuildingLevelupView.super.onExit(self)
end

function ZooBuildingLevelupView:onExitFinished()
	self._buildingMo = nil

	MaterialMgr.clearIcon(self._costItem)
	Framework.ImageBigBG.Get(self._buildingIcon):ClearImage()
	ZooBuildingLevelupView.super.onExitFinished(self)
end

function ZooBuildingLevelupView:_onClickClose()
	self:close()
end

function ZooBuildingLevelupView:_onClickLevelup()
	self._buildingMo:onLevelup()
	self:close()
end

return ZooBuildingLevelupView
