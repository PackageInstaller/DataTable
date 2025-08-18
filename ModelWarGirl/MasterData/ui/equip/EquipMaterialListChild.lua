-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\EquipMaterialListChild.lua

local ResEquipReturn = require("ClientData/ResEquipReturn")
local ResClientConfirm = require("ClientData/ResClientConfirm")
local EquipUpgradeGridContainer = Class("EquipUpgradeGridContainer", UIControls.GridMultiContainerLoop)

function EquipUpgradeGridContainer:ctor()
	return
end

function EquipUpgradeGridContainer:setObj(clientItem)
	EquipUpgradeGridContainer.super.setObj(self, clientItem)

	local isEquip = self.grid.object.itemType == Const.ITEM_TYPE_EQUIP

	self.panelRec:setVisible(not isEquip)
end

function EquipUpgradeGridContainer:selectItem(sender)
	local isEquip = self.grid.object.itemType == Const.ITEM_TYPE_EQUIP
	local materialPanel = self.mWindow.upgradePanel.upgradeMaterialPanel
	local preLv = materialPanel.predictLevel or materialPanel.equip.enhanceLevel
	local isAdd = isEquip and not self.grid.imgSelect:getVisible() or not isEquip

	if isEquip and self.grid.imgSelect:getVisible() or self.mWindow:getAddMaterialCount() < 5 or self.mWindow.upgradePanel.upgradeMaterialPanel:isCanAddItemMaterial(self.grid.object) then
		if isAdd and materialPanel.equip.enhanceLevel >= materialPanel.equip:getMaxLevel() then
			MsgManager.clientNotice(248)

			return
		end

		if isAdd and preLv >= materialPanel.equip:getMaxLevel() then
			MsgManager.clientNotice(135)

			return
		end

		if self.grid.object.itemType ~= Const.ITEM_TYPE_EQUIP then
			EquipUpgradeGridContainer.super.selectItem(self, sender)
		elseif not self.grid.imgSelect:getVisible() then
			if sender.object.evolve and sender.object.evolve > 0 then
				local function yesFunc()
					self:_realSelectMaterial()
				end

				local consumeEquipTipsDlg = UIManager.getUI("consumeEquipTipsDlg", true)
				local msgContent = ResClientConfirm[1062].content

				consumeEquipTipsDlg:setData(sender, msgContent, yesFunc, true)
			elseif sender.object.enhanceLevel >= 3 then
				local function yesFunc()
					self:_realSelectMaterial()
				end

				local consumeEquipTipsDlg = UIManager.getUI("consumeEquipTipsDlg", true)
				local msgContent = ResClientConfirm[1063].content

				consumeEquipTipsDlg:setData(sender, msgContent, yesFunc, false)
			elseif sender.object.quality >= materialPanel.equip.quality then
				local function yesFunc()
					self:_realSelectMaterial()
				end

				local msgContent = Lang.get(30294)

				UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, nil, msgContent, yesFunc, nil, -1)
			else
				self:_realSelectMaterial()
			end
		else
			self:_realSelectMaterial()
		end
	else
		MsgManager.clientNotice(133)
	end
end

function EquipUpgradeGridContainer:_realSelectMaterial()
	self.grid.imgSelect:setVisible(not self.grid.imgSelect:getVisible())
	self:playCallBack(self.grid.imgSelect:getVisible())
end

local strClassName = "EquipMaterialListChild"
local EquipMaterialListChild = Class(strClassName, UIControls.Child)

function EquipMaterialListChild:ctor()
	self:initUI()
end

function EquipMaterialListChild:initUI()
	self.view = UIControls.ScrollViewLoopV(self, "", 0, self._initItem)
	self.panelContentNone = UIControls.Panel(self, "NoContent")
	self.cells = {}
end

function EquipMaterialListChild:_initItem(sender, targetCell, newIdx)
	targetCell = targetCell or EquipUpgradeGridContainer(sender, "System/Common/Grid/GridMultiContainer", 0, 0, newIdx)

	if not self.data or #self.data == 0 then
		return
	end

	if self.data[newIdx] ~= nil then
		targetCell:setObj(self.data[newIdx])
		targetCell:setSelectCallback(Slot(self.selectMaterial, self))

		if targetCell.grid.panelAttr then
			targetCell.grid.panelAttr:setVisible(true)
		end

		self:initSelectState(targetCell, newIdx)
	end

	self.cells[newIdx] = targetCell
end

function EquipMaterialListChild:initSelectState(targetCell, newIdx)
	if self.data[newIdx].itemType == Const.ITEM_TYPE_EQUIP and self.beAddedToUpPanel[self.data[newIdx].gid] then
		targetCell.grid.imgSelect:setVisible(true)
	elseif self.data[newIdx].itemType == Const.ITEM_TYPE_ITEM and self.beAddedToUpPanel[self.data[newIdx].id] then
		targetCell.selectNum = self.beAddedToUpPanel[self.data[newIdx].id][2]

		targetCell:refreshSelectShow()
	elseif self.data[newIdx].itemType == Const.ITEM_TYPE_EQUIP then
		targetCell.grid.imgSelect:setVisible(false)

		targetCell.selectNum = 0

		targetCell:refreshSelectShow()
	elseif self.data[newIdx].itemType == Const.ITEM_TYPE_ITEM then
		targetCell.selectNum = 0

		targetCell:refreshSelectShow()
	end
end

function EquipMaterialListChild:selectMaterial(sender, isAdd)
	self:addToUpPanel(sender.grid.object, isAdd)
	self.mWindow:updateMaterial(sender.grid.object, isAdd)
end

function EquipMaterialListChild:giveBackMaterial(materialItem)
	if materialItem.itemType == Const.ITEM_TYPE_EQUIP then
		self.beAddedToUpPanel[materialItem.gid] = nil
	else
		self.beAddedToUpPanel[materialItem.id] = nil
	end

	self.mWindow:updateMaterial(materialItem, false)
	self.view:setTotalCount(#self.data)
end

function EquipMaterialListChild:setData(data)
	self.data = data
	self.addIndex = 1
	self.beAddedToUpPanel = {}
	self.cells = {}

	self.view:setTotalCount(#self.data)
end

local function _sortFastAddMaterials(a, b)
	if a.isLowLevelFlag ~= b.isLowLevelFlag then
		return a.isLowLevelFlag > b.isLowLevelFlag
	elseif a.typeScore ~= b.typeScore then
		return a.typeScore > b.typeScore
	elseif a.itemType == Const.ITEM_TYPE_EQUIP then
		if a.level ~= b.level then
			return a.level < b.level
		elseif a.enhanceLevel ~= b.enhanceLevel then
			return a.enhanceLevel < b.enhanceLevel
		else
			return a.id > b.id
		end
	elseif a.quality ~= b.quality then
		return a.quality < b.quality
	else
		return a.id > b.id
	end
end

function EquipMaterialListChild:fastToAddMaterial()
	local materialPanel = self.mWindow.upgradePanel.upgradeMaterialPanel
	local preLv = materialPanel.predictLevel or materialPanel.equip.enhanceLevel
	local preExp = materialPanel.predictExp or materialPanel.equip.enhanceExp
	local nextLevelNeedExp = CurAvatar:getEquipExpNeed(materialPanel.equip, preLv + 1)

	if materialPanel.equip.enhanceLevel >= materialPanel.equip:getMaxLevel() then
		MsgManager.clientNotice(248)

		return
	end

	if preLv >= materialPanel.equip:getMaxLevel() then
		MsgManager.clientNotice(135)

		return
	end

	local canFastAddMaterialList = {}

	for _, material in ipairs(self.data) do
		material.isLowLevelFlag = 0

		if material.itemType == Const.ITEM_TYPE_EQUIP then
			if material.level < materialPanel.equip.level and not self.beAddedToUpPanel[material.gid] then
				if materialPanel.equip.level - material.level >= 2 then
					material.isLowLevelFlag = 1
				end

				material.typeScore = 10

				if not material.enhanceLevel or not (material.enhanceLevel >= 3) then
					table.insert(canFastAddMaterialList, material)
				end
			end
		else
			local canAddNum = material.num

			if self.beAddedToUpPanel[material.id] then
				canAddNum = material.num - self.beAddedToUpPanel[material.id][2]
			end

			if canAddNum > 0 then
				if material.resData.extend_args1 == 0 then
					material.typeScore = 100
				else
					material.typeScore = 1000
				end

				table.insert(canFastAddMaterialList, material)
			end
		end
	end

	if #canFastAddMaterialList == 0 then
		MsgManager.clientNotice(331)

		return
	end

	table.sort(canFastAddMaterialList, _sortFastAddMaterials)

	local lackExp = nextLevelNeedExp - preExp
	local fastToAddMaterialList = {}
	local willAddExp = 0
	local extraAddMaterialCount = 0
	local expEnough = false

	for _, material in ipairs(canFastAddMaterialList) do
		if material.itemType == Const.ITEM_TYPE_EQUIP then
			if self.mWindow:getAddMaterialCount() + extraAddMaterialCount < 5 then
				willAddExp = willAddExp + CurAvatar:getHaveExpByEquip(material)

				table.insert(fastToAddMaterialList, {
					material,
					1
				})

				extraAddMaterialCount = extraAddMaterialCount + 1
			end
		else
			local canAddNum = 0
			local addNum = 0

			if self.beAddedToUpPanel[material.id] then
				canAddNum = material.num - self.beAddedToUpPanel[material.id][2]
			elseif self.mWindow:getAddMaterialCount() + extraAddMaterialCount >= 5 then
				break
			else
				canAddNum = material.num
				extraAddMaterialCount = extraAddMaterialCount + 1
			end

			if canAddNum > 0 then
				local onceExp = CurAvatar:getHaveExpByItem(material)
				local remainLackExp = lackExp - willAddExp
				local lackNum = math.ceil(remainLackExp / onceExp)

				if lackNum <= canAddNum then
					addNum = lackNum
					expEnough = true
				else
					addNum = canAddNum
				end

				willAddExp = willAddExp + onceExp * addNum

				table.insert(fastToAddMaterialList, {
					material,
					addNum
				})
			end
		end

		if expEnough or lackExp <= willAddExp then
			break
		end
	end

	if #fastToAddMaterialList == 0 and self.mWindow:getAddMaterialCount() >= 5 then
		MsgManager.clientNotice(133)

		return
	end

	for _, materialInfo in ipairs(fastToAddMaterialList) do
		local material = materialInfo[1]
		local addNum = materialInfo[2]

		for i = 1, addNum do
			self:addToUpPanel(material, true)
		end
	end

	self.mWindow:updateMaterial()
	materialPanel.btnAdd:setText(Lang.get(30290))
	self.view:setTotalCount(#self.data)
end

function EquipMaterialListChild:sortConfigRefresh(data)
	self.data = data

	if not self.addIndex then
		self.addIndex = 1
	end

	if not self.beAddedToUpPanel then
		self.beAddedToUpPanel = {}
	end

	self.cells = {}

	self.view:setTotalCount(#self.data)
end

local function _sortSelMaterial(itemInfoA, itemInfoB)
	return itemInfoA.addIndex < itemInfoB.addIndex
end

function EquipMaterialListChild:getAddedMaterialList()
	local materialList = {}

	for _, mtInfo in pairs(self.beAddedToUpPanel) do
		local materialInfo = {}

		materialInfo.item = mtInfo[1]
		materialInfo.num = mtInfo[2]
		materialInfo.addIndex = mtInfo[3]

		table.insert(materialList, materialInfo)
	end

	table.sort(materialList, _sortSelMaterial)

	return materialList
end

function EquipMaterialListChild:addToUpPanel(material, isAdd)
	if material.itemType == Const.ITEM_TYPE_EQUIP then
		if isAdd then
			self.beAddedToUpPanel[material.gid] = {
				material,
				1,
				self.addIndex
			}
			self.addIndex = self.addIndex + 1
		else
			self.beAddedToUpPanel[material.gid] = nil
		end
	elseif isAdd == true then
		if not self.beAddedToUpPanel[material.id] then
			self.beAddedToUpPanel[material.id] = {
				material,
				1,
				self.addIndex
			}
			self.addIndex = self.addIndex + 1
		else
			self.beAddedToUpPanel[material.id][2] = self.beAddedToUpPanel[material.id][2] + 1
		end
	elseif self.beAddedToUpPanel[material.id][2] > 1 then
		self.beAddedToUpPanel[material.id][2] = self.beAddedToUpPanel[material.id][2] - 1
	else
		self.beAddedToUpPanel[material.id] = nil
	end
end

return EquipMaterialListChild
