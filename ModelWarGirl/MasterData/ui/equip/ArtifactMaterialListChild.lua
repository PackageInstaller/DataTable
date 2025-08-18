-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\ArtifactMaterialListChild.lua

local ResArtifactLevelUp = require("ClientData/ResArtifactLevelUp")
local ArtifactUpgradeGridContainer = Class("ArtifactUpgradeGridContainer", UIControls.GridMultiContainerLoop)

function ArtifactUpgradeGridContainer:ctor()
	return
end

function ArtifactUpgradeGridContainer:setObj(clientItem, isFromBattle)
	ArtifactUpgradeGridContainer.super.setObj(self, clientItem)

	local isArtifact = clientItem.itemType == Const.ITEM_TYPE_ARTIFACT
	local materialPanel = self.mWindow.upgradePanel.upgradeMaterialPanel
	local maxBreak = materialPanel.artifact.breakLevel >= materialPanel.artifact:getMaxBreakLv()

	if isArtifact then
		self.grid:setIconGray(CurAvatar.bagArtifacts[clientItem.gid] == nil)
		self.panelRec:setVisible(false)
		self.panelArtifactBreak:setVisible(not maxBreak and materialPanel.artifact.id == clientItem.id and clientItem.breakLevel == 0)
	else
		self.panelRec:setVisible(clientItem.subType == Const.ITEM_STYPE_ARTIFACT_UPGRADE_MATERIAL)
		self.panelArtifactBreak:setVisible(not maxBreak and clientItem.subType == Const.ITEM_STYPE_ARTIFACT_BREAK_MATERIAL)

		if ClientUtils.getMoney(clientItem.id) == 0 then
			self.grid.mEnableTips = true

			if isFromBattle then
				self.grid.uiConfig = nil
				self.grid.mDisableWays = true
			else
				self.grid.uiConfig = {
					CloseSrcWindow = 1,
					AutoOpenGuide = 1
				}
			end

			self.grid.imgAdd:setVisible(true)
		else
			self.grid.mEnableTips = false

			self.grid.imgAdd:setVisible(false)
		end
	end
end

function ArtifactUpgradeGridContainer:selectItem(sender)
	local isArtifact = self.grid.object.itemType == Const.ITEM_TYPE_ARTIFACT

	if isArtifact and CurAvatar.bagArtifacts[self.grid.object.gid] == nil and self.grid.object.resData then
		MsgManager.notice(self.grid.object.resData.get_notice or "")

		return
	end

	if not isArtifact and ClientUtils.getMoney(self.grid.object.id) == 0 then
		self.grid:openTipsPanel()

		return
	end

	local materialPanel = self.mWindow.upgradePanel.upgradeMaterialPanel
	local isAdd = isArtifact and not self.grid.imgSelect:getVisible() or not isArtifact
	local preLv = materialPanel.predictLevel or materialPanel.artifact.enhanceLevel

	if isArtifact and self.grid.imgSelect:getVisible() or self.mWindow:getAddMaterialCount() < 5 or self.mWindow.upgradePanel.upgradeMaterialPanel:isCanAddItemMaterial(self.grid.object) then
		if isAdd and materialPanel.artifact.enhanceLevel >= materialPanel.artifact:getMaxEnhanceLv() and materialPanel.artifact.breakLevel >= materialPanel.artifact:getMaxBreakLv() then
			MsgManager.clientNotice(247)

			return
		end

		if isAdd and preLv >= materialPanel.artifact:getMaxEnhanceLv() and materialPanel.artifact.breakLevel >= materialPanel.artifact:getMaxBreakLv() then
			MsgManager.clientNotice(136)

			return
		end

		local predictStar = math.max(materialPanel.predictStar or 0, materialPanel.artifact.breakLevel)

		if self.grid.object.itemType ~= Const.ITEM_TYPE_ARTIFACT then
			if sender.object.subType and sender.object.subType == Const.ITEM_STYPE_ARTIFACT_BREAK_MATERIAL and predictStar >= materialPanel.artifact:getMaxBreakLv() then
				local function yesFunc()
					ArtifactUpgradeGridContainer.super.selectItem(self, sender)
				end

				UIManager.showConfirmWithId(1011, yesFunc)
			elseif preLv >= ResArtifactLevelUp[predictStar].limit_level and (not sender.object.subType or sender.object.subType ~= Const.ITEM_STYPE_ARTIFACT_BREAK_MATERIAL) then
				local function yesFunc()
					ArtifactUpgradeGridContainer.super.selectItem(self, sender)
				end

				UIManager.showConfirmWithId(1016, yesFunc)
			else
				ArtifactUpgradeGridContainer.super.selectItem(self, sender)
			end
		elseif not self.grid.imgSelect:getVisible() then
			if not self.mWindow.isAlreayConfirm and materialPanel.artifact.id == sender.object.id and predictStar >= materialPanel.artifact:getMaxBreakLv() then
				local function yesFunc()
					self.mWindow.isAlreayConfirm = true

					self:_realSelectMaterial()
				end

				UIManager.showConfirmWithId(1011, yesFunc)
			elseif sender.object.quality >= 4 then
				local function yesFunc()
					self:_realSelectMaterial()
				end

				local msgContent = Lang.get(30289)

				UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, nil, msgContent, yesFunc, nil, -1)
			elseif preLv >= ResArtifactLevelUp[predictStar].limit_level and materialPanel.artifact.id ~= sender.object.id then
				local function yesFunc()
					self:_realSelectMaterial()
				end

				UIManager.showConfirmWithId(1016, yesFunc)
			else
				self:_realSelectMaterial()
			end
		else
			self:_realSelectMaterial()
		end
	else
		MsgManager.clientNotice(134)
	end
end

function ArtifactUpgradeGridContainer:_realSelectMaterial()
	if not self.grid.imgSelect:getVisible() and self.grid.object.inWearing then
		local function yesFunc()
			RPC.artifactOff(self.grid.object.inWearing, self.grid.object.gid)
			self.grid.imgSelect:setVisible(not self.grid.imgSelect:getVisible())
			self:playCallBack(self.grid.imgSelect:getVisible())
		end

		local msgContent = string.format(Lang.get(32777), CurAvatar.heroDic[self.grid.object.inWearing].name)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, yesFunc)
	else
		self.grid.imgSelect:setVisible(not self.grid.imgSelect:getVisible())
		self:playCallBack(self.grid.imgSelect:getVisible())
	end
end

local strClassName = "ArtifactMaterialListChild"
local ArtifactMaterialListChild = Class(strClassName, UIControls.Child)

function ArtifactMaterialListChild:ctor()
	self:initUI()
end

function ArtifactMaterialListChild:initUI()
	self.view = UIControls.ScrollViewLoopV(self, "", 0, self._initItem)
	self.cells = {}
end

function ArtifactMaterialListChild:_initItem(sender, targetCell, newIdx)
	targetCell = targetCell or ArtifactUpgradeGridContainer(sender, "System/Common/Grid/GridMultiContainer", 0, 0, newIdx)

	if not self.data or #self.data == 0 then
		return
	end

	if self.data[newIdx] ~= nil then
		targetCell:setObj(self.data[newIdx], self.isFromBattle)
		targetCell:setSelectCallback(Slot(self.selectMaterial, self))
		self:initSelectState(targetCell, newIdx)
	end

	self.cells[newIdx] = targetCell
end

function ArtifactMaterialListChild:initSelectState(targetCell, newIdx)
	if self.data[newIdx].itemType == Const.ITEM_TYPE_ARTIFACT and self.beAddedToUpPanel[self.data[newIdx].gid] then
		targetCell.grid.imgSelect:setVisible(true)
	elseif self.data[newIdx].itemType == Const.ITEM_TYPE_ITEM and self.beAddedToUpPanel[self.data[newIdx].id] then
		targetCell.selectNum = self.beAddedToUpPanel[self.data[newIdx].id][2]

		targetCell:refreshSelectShow()
	elseif self.data[newIdx].itemType == Const.ITEM_TYPE_ARTIFACT then
		targetCell.grid.imgSelect:setVisible(false)

		targetCell.selectNum = 0

		targetCell:refreshSelectShow()
	elseif self.data[newIdx].itemType == Const.ITEM_TYPE_ITEM then
		targetCell.selectNum = 0

		targetCell:refreshSelectShow()
	end
end

function ArtifactMaterialListChild:selectMaterial(sender, isAdd)
	self:addToUpPanel(sender.grid.object, isAdd)
	self.mWindow:updateMaterial(sender.grid.object, isAdd)
end

function ArtifactMaterialListChild:giveBackMaterial(materialItem)
	if materialItem.subType and materialItem.subType == Const.ITEM_STYPE_ARTIFACT_UPGRADE_MATERIAL then
		self.beAddedToUpPanel[materialItem.id] = nil
	elseif materialItem.itemType == Const.ITEM_TYPE_ARTIFACT then
		self.beAddedToUpPanel[materialItem.gid] = nil
	else
		self:addToUpPanel(materialItem, false)
	end

	self.mWindow:updateMaterial(materialItem, false)
	self.view:setTotalCount(#self.data)
end

function ArtifactMaterialListChild:setData(data)
	self.data = data
	self.addIndex = 1
	self.beAddedToUpPanel = {}
	self.cells = {}

	self.view:setTotalCount(#self.data)
end

local function _sortFastAddMaterials(a, b)
	if a.typeScore ~= b.typeScore then
		return a.typeScore > b.typeScore
	elseif a.itemType == Const.ITEM_TYPE_ARTIFACT then
		if a.level ~= b.level then
			return a.level < b.level
		elseif a.enhanceLevel ~= b.enhanceLevel then
			return a.enhanceLevel < b.enhanceLevel
		elseif a.id ~= b.id then
			return a.id < b.id
		else
			return a.gid < b.gid
		end
	elseif a.quality ~= b.quality then
		return a.quality < b.quality
	else
		return a.id < b.id
	end
end

function ArtifactMaterialListChild:fastToAddMaterial()
	local materialPanel = self.mWindow.upgradePanel.upgradeMaterialPanel
	local preLv = materialPanel.predictLevel or materialPanel.artifact.enhanceLevel
	local preExp = materialPanel.predictExp or materialPanel.artifact.enhanceExp
	local predictStar = math.max(materialPanel.predictStar or 0, materialPanel.artifact.breakLevel)
	local nextLevelNeedExp = CurAvatar:getArtifactExpNeed(materialPanel.artifact, preLv + 1)

	if materialPanel.artifact.enhanceLevel >= materialPanel.artifact:getMaxEnhanceLv() and materialPanel.artifact.breakLevel >= materialPanel.artifact:getMaxBreakLv() then
		MsgManager.clientNotice(247)

		return
	end

	if preLv >= materialPanel.artifact:getMaxEnhanceLv() and materialPanel.artifact.breakLevel >= materialPanel.artifact:getMaxBreakLv() then
		MsgManager.clientNotice(136)

		return
	end

	if preLv >= ResArtifactLevelUp[predictStar].limit_level then
		MsgManager.clientNotice(332)

		return
	end

	local canFastAddMaterialList = {}

	for _, material in ipairs(self.data) do
		material.isLowLevelFlag = 0

		if material.itemType == Const.ITEM_TYPE_ARTIFACT then
			if material.quality < materialPanel.artifact.quality and not self.beAddedToUpPanel[material.gid] and material.quality < 4 and material.enhanceLevel == 0 and material.breakLevel == 0 then
				material.typeScore = 100

				table.insert(canFastAddMaterialList, material)
			end
		elseif material.subType == Const.ITEM_STYPE_ARTIFACT_UPGRADE_MATERIAL then
			local canAddNum = material.num

			if self.beAddedToUpPanel[material.id] then
				canAddNum = material.num - self.beAddedToUpPanel[material.id][2]
			end

			if canAddNum > 0 then
				material.typeScore = 10

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
		if material.itemType == Const.ITEM_TYPE_ARTIFACT then
			if self.mWindow:getAddMaterialCount() + extraAddMaterialCount < 5 then
				willAddExp = willAddExp + CurAvatar:getHaveExpByArtifact(material)

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

local function _sortSelMaterial(itemInfoA, itemInfoB)
	return itemInfoA.addIndex < itemInfoB.addIndex
end

function ArtifactMaterialListChild:getAddedMaterialList()
	local materialList = {}

	for _, mtInfo in pairs(self.beAddedToUpPanel) do
		local materialInfo = {}

		materialInfo.item = mtInfo[1]
		materialInfo.addIndex = mtInfo[3]

		if materialInfo.item.subType and materialInfo.item.subType == Const.ITEM_STYPE_ARTIFACT_BREAK_MATERIAL then
			for i = 1, mtInfo[2] do
				materialInfo.num = 1

				table.insert(materialList, materialInfo)
			end
		else
			materialInfo.num = mtInfo[2]

			table.insert(materialList, materialInfo)
		end
	end

	table.sort(materialList, _sortSelMaterial)

	return materialList
end

function ArtifactMaterialListChild:sortConfigRefresh(data)
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

function ArtifactMaterialListChild:addToUpPanel(material, isAdd)
	if material.itemType ~= Const.ITEM_TYPE_ARTIFACT then
		if isAdd == true then
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
	elseif isAdd then
		self.beAddedToUpPanel[material.gid] = {
			material,
			1,
			self.addIndex
		}
		self.addIndex = self.addIndex + 1
	else
		self.beAddedToUpPanel[material.gid] = nil
	end
end

return ArtifactMaterialListChild
