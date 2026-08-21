-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\ArtifactUpGradeMaterialPanel.lua

local ResArtifactMisc = require("ClientData/ResArtifactMisc")
local ResArtifactXP = require("ClientData/ResArtifactXP")
local ResArtifactLevelUp = require("ClientData/ResArtifactLevelUp")
local strClassName = "ArtifactUpGradeMaterialPanel"
local ArtifactUpGradeMaterialPanel = Class(strClassName, UIControls.Panel)

function ArtifactUpGradeMaterialPanel:ctor()
	self:initUI()
end

function ArtifactUpGradeMaterialPanel:initUI()
	self.gridArtifact = UIControls.ArtifactGridChild(self, "GridPanel", "System/Common/Grid/GridBadgeItem", 0, 0, true)
	self.gridArtifact.mEnableTips = false
	self.btnUpgrade = UIControls.Button(self, self.mPath .. "/BtnUpgrade", "TextNum")

	self.btnUpgrade:addEventClick(self.onBtnUpgradeClick)

	self.btnAdd = UIControls.Button(self, self.mPath .. "/BtnAdd", "Text")

	self.btnAdd:addEventClick(self.onBtnAddClick)

	self.txtUpgradeType = UIControls.Label(self, self.mPath .. "/BtnUpgrade/Text")
	self.predictSlider = UIControls.Slider(self, self.mPath .. "/ExpPanel/ExpSlider1")
	self.expSlider = UIControls.Slider(self, self.mPath .. "/ExpPanel/ExpSlider2")
	self.txtExp = UIControls.Label(self, self.mPath .. "/ExpPanel/ExpText")
	self.txtLevel = UIControls.Label(self, self.mPath .. "/ExpPanel/BgUpgrade/Text")
	self.imgBgUpgrade = UIControls.Panel(self, self.mPath .. "/ExpPanel/BgUpgrade")
	self.textCurLv = UIControls.Label(self, self.mPath .. "/ExpPanel/BgUpgradeBefore/Text")
	self.txtAttention = UIControls.Label(self, self.mPath .. "/ExpPanel/TextAttention")
	self.efxUpgrade = UIControls.LazyEffectPlayer(self, self.mPath .. "/GridPanel/EfxUpgrade")
	self.previewIconList = {}

	for i = 1, 6 do
		local previewIcon = UIControls.Image(self, self.mPath .. "/StarPreviewPanel/Icon" .. i)

		self.previewIconList[i] = previewIcon
	end

	self.txtPreviewText = UIControls.Image(self, self.mPath .. "/StarPreviewPanel/Text")
	self.isMaxLevel = false
	self.materials = {}
end

function ArtifactUpGradeMaterialPanel:setArtifact(artifact)
	self.artifact = artifact

	self.btnUpgrade:setText(0)
	self.imgBgUpgrade:setVisible(false)

	local curLevel = self.artifact.enhanceLevel
	local curExp = self.artifact.enhanceExp

	self.textCurLv:setVisible(self.artifact.enhanceLevel ~= 0)
	self.textCurLv:setText("+" .. curLevel)

	self.expLevel = CurAvatar:getArtifactLevelByExp(self.artifact, curExp)
	self.limitLevel = self.artifact:getCurLimitLv()

	if curLevel > self.artifact:getMaxEnhanceLv() then
		self:showMaxLevelPanel()

		return
	end

	if curLevel < self.limitLevel then
		local nextLevelNeedExp = CurAvatar:getArtifactExpNeed(self.artifact, self.artifact.enhanceLevel + 1)

		self.txtExp:setText(curExp .. "/" .. nextLevelNeedExp)

		local lastLevelNeedExp = CurAvatar:getArtifactExpNeed(self.artifact, self.artifact.enhanceLevel)

		self.expSlider:setValue(math.min((curExp - lastLevelNeedExp) / (nextLevelNeedExp - lastLevelNeedExp), 1))
		self:changeStatus(false)
	else
		self:changeStatus(true)
	end
end

function ArtifactUpGradeMaterialPanel:clearMaterial()
	for pos, materialGrid in pairs(self.materials) do
		self.materials[pos]:destroy()

		self.materials[pos] = nil
	end

	self:refreshPreExpPanel()
	self.btnAdd:setText(Lang.get(455))
end

function ArtifactUpGradeMaterialPanel:changeStatus(isBreak, refreshList)
	self.isBreak = isBreak

	local upgradeTxt = self.isBreak == true and Lang.get(1833) or Lang.get(920)

	self.txtUpgradeType:setText(upgradeTxt)

	if self.isBreak then
		local nextLevelNeedExp = CurAvatar:getArtifactExpNeed(self.artifact, self.artifact.enhanceLevel + 1)

		self.txtExp:setText(self.artifact.enhanceExp .. "/" .. nextLevelNeedExp)

		local lastLevelNeedExp = CurAvatar:getArtifactExpNeed(self.artifact, self.artifact.enhanceLevel)

		self.expSlider:setValue(math.min((self.artifact.enhanceExp - lastLevelNeedExp) / (nextLevelNeedExp - lastLevelNeedExp), 1))
		self.imgBgUpgrade:setVisible(self.expLevel > self.artifact.enhanceLevel)
		self.txtAttention:setVisible(self.expLevel > self.artifact.enhanceLevel)
		self.txtLevel:setText("+" .. self.expLevel - self.artifact.enhanceLevel)
		self.mParent:showPropChange(self.expLevel, self.artifact.breakLevel)
		self:refreshPreExpPanel()
	end

	if refreshList then
		-- block empty
	end
end

function ArtifactUpGradeMaterialPanel:updateMaterial(materialItem, isAdd)
	self.beAddedMaterial = self.mWindow.materialListPanel:getAddedMaterialList()

	for idx, materialInfo in ipairs(self.beAddedMaterial) do
		if not self.materials[idx] then
			local nodePath = self.mPath .. "/GridMaterial" .. idx

			self.materials[idx] = UIControls.getGridContainer(self, nodePath)
		end

		local materialGrid = {}

		if materialInfo.item.itemType == Const.ITEM_TYPE_ARTIFACT then
			self.materials[idx]:setObj(materialInfo.item)

			materialGrid = self.materials[idx].grid

			materialGrid.textNum:setVisible(false)
		else
			local fakeItem = BaseObject.GetObject(materialInfo.item.id, materialInfo.num)

			self.materials[idx]:setObj(fakeItem)

			materialGrid = self.materials[idx].grid

			materialGrid.textNum:setVisible(true)
			materialGrid.textNum:setText(fakeItem.num)
		end

		self.materials[idx]:setVisible(true)

		materialGrid.mEnableTips = false
		materialGrid.mEventClick = Slot(self.removeMaterial, self)
	end

	for i = #self.beAddedMaterial + 1, #self.materials do
		self.materials[i]:destroy()

		self.materials[i] = nil
	end

	self:refreshPreExpPanel()

	if self:getAddMaterialCount() == 0 then
		self.btnAdd:setText(Lang.get(455))
	end
end

function ArtifactUpGradeMaterialPanel:refreshPreExpPanel()
	local curLevel = self.artifact.enhanceLevel
	local curExp = self.artifact.enhanceExp

	if curLevel < self.artifact:getMaxEnhanceLv() then
		local totalExp = 0
		local haveMaterial = false

		for _, materialGrid in pairs(self.materials) do
			haveMaterial = true

			if materialGrid.object.itemType == Const.ITEM_TYPE_ARTIFACT then
				totalExp = totalExp + CurAvatar:getHaveExpByArtifact(materialGrid.object)
			else
				totalExp = totalExp + CurAvatar:getHaveExpByItem(materialGrid.object) * materialGrid.object.num
			end
		end

		self.predictSlider:setVisible(haveMaterial)

		self.predictExp = curExp + totalExp
		self.predictLevel = CurAvatar:getArtifactLevelByExp(self.artifact, self.predictExp)

		local curLevelNextNeedExp = CurAvatar:getArtifactExpNeed(self.artifact, curLevel + 1)

		self.txtExp:setText(self.predictExp .. "/" .. curLevelNextNeedExp)

		local lastLevelNeedExp = CurAvatar:getArtifactExpNeed(self.artifact, curLevel)

		self.predictSlider:setValue(math.min((self.predictExp - lastLevelNeedExp) / (curLevelNextNeedExp - lastLevelNeedExp), 1))
		self.imgBgUpgrade:setVisible(curLevel < self.predictLevel)
		self.txtLevel:setText("+" .. self.predictLevel - curLevel)

		local maxBreakLv = self.artifact:getMaxBreakLv()

		self.predictStar = math.min(self.artifact.breakLevel + self:getSameIdMaterialCount(), maxBreakLv)

		self.mParent:showPropChange(self.predictLevel, self.predictStar)
		self.mParent:showStarChange(self.predictStar, self.artifact.breakLevel)

		if self.predictStar ~= self.artifact.breakLevel then
			self.gridArtifact.imgStarTxt:setVisible(false)
			self.txtPreviewText:setImage("Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas", "BgLvNumbers" .. self.predictStar)
			self.txtPreviewText:setCanvasGroupAlpha(1)

			for _, iconStar in ipairs(self.previewIconList) do
				iconStar:setCanvasGroupAlpha(0)
			end

			for i = 1, maxBreakLv do
				local starLightPath = UIConst.ARTIFACT_STAR_LIGHT_PATH[maxBreakLv][i]

				self.previewIconList[i]:setImage(starLightPath[1], starLightPath[2])
			end

			for idx = self.artifact.breakLevel + 1, self.predictStar do
				self.previewIconList[idx]:setCanvasGroupAlpha(1)
			end
		else
			self.gridArtifact.imgStarTxt:setVisible(self.artifact.breakLevel > 0)

			for _, iconStar in ipairs(self.previewIconList) do
				iconStar:setCanvasGroupAlpha(0)
			end

			self.txtPreviewText:setCanvasGroupAlpha(0)
		end

		local levelTempleteData = ResArtifactXP[self.artifact.resData.templete_id]

		if curLevel == self.predictLevel then
			local levelData = levelTempleteData[curLevel + 1] ~= nil and levelTempleteData[curLevel + 1] or levelTempleteData[curLevel]

			self.needGold = levelData.coin_rate * totalExp
		else
			self.needGold = 0

			for level = curLevel, self.predictLevel do
				local nextLevelNeedExp = 0
				local lastLevelHaveExp = 0

				if level == curLevel then
					lastLevelHaveExp = curExp
					nextLevelNeedExp = CurAvatar:getArtifactExpNeed(self.artifact, level + 1)
				elseif curLevel < level and level < self.predictLevel then
					lastLevelHaveExp = CurAvatar:getArtifactExpNeed(self.artifact, level)
					nextLevelNeedExp = CurAvatar:getArtifactExpNeed(self.artifact, level + 1)
				else
					lastLevelHaveExp = CurAvatar:getArtifactExpNeed(self.artifact, level)
					nextLevelNeedExp = self.predictExp
				end

				local levelData = levelTempleteData[level + 1] ~= nil and levelTempleteData[level + 1] or levelTempleteData[level]

				self.needGold = self.needGold + levelData.coin_rate * (nextLevelNeedExp - lastLevelHaveExp)
			end
		end

		self.btnUpgrade:setText(ClientUtils.getNumShortStr(self.needGold))
	else
		self:showMaxLevelPanel()
	end
end

function ArtifactUpGradeMaterialPanel:showMaxLevelPanel()
	self.isMaxLevel = true

	self.predictSlider:setVisible(false)
	self.expSlider:setValue(1)

	local curLevelNeedExp = CurAvatar:getArtifactExpNeed(self.artifact, self.artifact.enhanceLevel)

	self.txtExp:setText(self.artifact.enhanceExp .. "/" .. curLevelNeedExp)
	self.gridArtifact.imgStarTxt:setVisible(self.artifact.breakLevel > 0)

	for _, iconStar in ipairs(self.previewIconList) do
		iconStar:setCanvasGroupAlpha(0)
	end

	self.txtPreviewText:setCanvasGroupAlpha(0)
end

function ArtifactUpGradeMaterialPanel:isCanAddItemMaterial(material)
	for _, materialGrid in pairs(self.materials) do
		local item = materialGrid.object

		if item.subType and item.subType == Const.ITEM_STYPE_ARTIFACT_UPGRADE_MATERIAL and item.id == material.id then
			return true
		end
	end

	return false
end

function ArtifactUpGradeMaterialPanel:getAddMaterialCount()
	local materialCount = 0

	for k, v in pairs(self.materials) do
		materialCount = materialCount + 1
	end

	return materialCount
end

function ArtifactUpGradeMaterialPanel:getSameIdMaterialCount()
	local materialCount = 0

	for _, materialGrid in pairs(self.materials) do
		local material = materialGrid.object

		if material.id == self.artifact.id then
			materialCount = materialCount + material.breakLevel + 1
		elseif material.subType and material.subType == Const.ITEM_STYPE_ARTIFACT_BREAK_MATERIAL then
			materialCount = materialCount + material.num
		end
	end

	return materialCount
end

function ArtifactUpGradeMaterialPanel:removeMaterial(sender)
	self.removeUpgradePos = sender.upgradePos

	self.mWindow:giveBackMaterial(sender.object)
end

function ArtifactUpGradeMaterialPanel:onBtnAddClick()
	self.mWindow.materialListPanel:fastToAddMaterial()
end

local function confirmToLevelUp(lvUpInfo)
	RPC.artifactLevelUp(lvUpInfo[1], lvUpInfo[2], lvUpInfo[3], lvUpInfo[4], lvUpInfo[5])
end

function ArtifactUpGradeMaterialPanel:onBtnUpgradeClick()
	if self:getAddMaterialCount() < 1 then
		MsgManager.clientNotice(137)

		return
	end

	if CurAvatar:getMoneyByType(Const.MONEY_TYPE_GOLD) < self.needGold then
		MsgManager.clientNotice(181)

		return
	end

	local artifactGids = {}
	local items = {}

	for _, materialGrid in pairs(self.materials) do
		local material = materialGrid.object

		if material.itemType == Const.ITEM_TYPE_ARTIFACT then
			table.insert(artifactGids, material.gid)
		elseif items[material.id] then
			items[material.id] = items[material.id] + material.num
		else
			items[material.id] = material.num
		end
	end

	local itemIds = {}
	local itemCounts = {}

	for id, num in pairs(items) do
		table.insert(itemIds, id)
		table.insert(itemCounts, num)
	end

	for k, v in pairs(artifactGids) do
		-- block empty
	end

	for k, v in pairs(itemIds) do
		-- block empty
	end

	for k, v in pairs(itemCounts) do
		-- block empty
	end

	if self.predictLevel > ResArtifactLevelUp[self.predictStar].limit_level then
		UIManager.showConfirmWithId(1017, Slot(confirmToLevelUp, {
			self.artifact.gid,
			artifactGids,
			itemIds,
			itemCounts,
			self.artifact.enhanceExp
		}))
	else
		RPC.artifactLevelUp(self.artifact.gid, artifactGids, itemIds, itemCounts, self.artifact.enhanceExp)
	end
end

return ArtifactUpGradeMaterialPanel
