-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\EquipUpGradeMaterialPanel.lua

local ResEquipMisc = require("ClientData/ResEquipMisc")
local ResEquipLevelTemplete = require("ClientData/ResEquipLevelTemplete")
local strClassName = "EquipUpGradeMaterialPanel"
local EquipUpGradeMaterialPanel = Class(strClassName, UIControls.Panel)

function EquipUpGradeMaterialPanel:ctor()
	self:initUI()
end

function EquipUpGradeMaterialPanel:initUI()
	self.btnUpgrade = UIControls.Button(self, self.mPath .. "/BtnUpgrade", "TextNum")

	self.btnUpgrade:addEventClick(self.OnBtnUpgradeClick)

	self.btnAdd = UIControls.Button(self, self.mPath .. "/BtnAdd", "Text")

	self.btnAdd:addEventClick(self.onBtnAddClick)

	self.predictSlider = UIControls.Slider(self, self.mPath .. "/ExpPanel/ExpSlider1")
	self.expSlider = UIControls.Slider(self, self.mPath .. "/ExpPanel/ExpSlider2")
	self.txtExp = UIControls.Label(self, self.mPath .. "/ExpPanel/ExpText")
	self.txtLevel = UIControls.Label(self, self.mPath .. "/ExpPanel/BgUpgrade/Text")
	self.imgBgUpgrade = UIControls.Panel(self, self.mPath .. "/ExpPanel/BgUpgrade")
	self.textCurLv = UIControls.Label(self, self.mPath .. "/ExpPanel/BgUpgradeBefore/Text")
	self.efxUpgrade = UIControls.LazyEffectPlayer(self, self.mPath .. "/GridPanel/EfxUpgrade")
	self.isMaxLevel = false
	self.needGold = 0
	self.materials = {}
end

function EquipUpGradeMaterialPanel:setEquip(equip)
	self.equip = equip

	self.btnUpgrade:setText(0)
	self.imgBgUpgrade:setVisible(false)
	self.textCurLv:setVisible(equip.enhanceLevel ~= 0)

	local curLevel = self.equip.enhanceLevel
	local curExp = self.equip.enhanceExp

	self.textCurLv:setText("+" .. curLevel)

	self.predictLevel = self.equip.enhanceLevel

	if curLevel < self.equip:getMaxLevel() then
		local nextLevelNeedExp = CurAvatar:getEquipExpNeed(self.equip, self.equip.enhanceLevel + 1)

		self.txtExp:setText(curExp .. "/" .. nextLevelNeedExp)

		local lastLevelNeedExp = CurAvatar:getEquipExpNeed(self.equip, self.equip.enhanceLevel)

		self.expSlider:setValue((curExp - lastLevelNeedExp) / (nextLevelNeedExp - lastLevelNeedExp))
	else
		self:showMaxLevelPanel()
	end
end

function EquipUpGradeMaterialPanel:updateMaterial(materialItem, isAdd)
	self.beAddedMaterial = self.mWindow.materialListPanel:getAddedMaterialList()

	for idx, materialInfo in ipairs(self.beAddedMaterial) do
		if not self.materials[idx] then
			local nodePath = self.mPath .. "/GridMaterial" .. idx .. "/EquipItemNode"

			self.materials[idx] = UIControls.getGridContainer(self, nodePath)
		end

		local materialGrid = {}

		if materialInfo.item.itemType == Const.ITEM_TYPE_EQUIP then
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

function EquipUpGradeMaterialPanel:refreshPreExpPanel()
	local curLevel = self.equip.enhanceLevel
	local curExp = self.equip.enhanceExp

	if curLevel < self.equip:getMaxLevel() then
		local totalExp = 0
		local haveMaterial = false

		for _, materialGrid in pairs(self.materials) do
			haveMaterial = true

			if materialGrid.object.itemType == Const.ITEM_TYPE_EQUIP then
				totalExp = totalExp + CurAvatar:getHaveExpByEquip(materialGrid.object)
			else
				totalExp = totalExp + CurAvatar:getHaveExpByItem(materialGrid.object) * materialGrid.object.num
			end
		end

		self.predictSlider:setVisible(haveMaterial)

		self.predictExp = curExp + totalExp
		self.predictLevel = CurAvatar:getEquipLevelByExp(self.equip, self.predictExp)

		local nextLevelNeedExp = CurAvatar:getEquipExpNeed(self.equip, self.predictLevel + 1)
		local curLevelNextNeedExp = CurAvatar:getEquipExpNeed(self.equip, curLevel + 1)

		self.txtExp:setText(self.predictExp .. "/" .. curLevelNextNeedExp)

		local lastLevelNeedExp = CurAvatar:getEquipExpNeed(self.equip, curLevel)

		self.predictSlider:setValue(math.min((self.predictExp - lastLevelNeedExp) / (curLevelNextNeedExp - lastLevelNeedExp), 1))
		self.imgBgUpgrade:setVisible(curLevel < self.predictLevel)
		self.txtLevel:setText("+" .. self.predictLevel - curLevel)

		if self.predictLevel - curLevel > 0 then
			self.mParent.txtMainPropChange:setVisible(true)

			local curMainPropValue = self.equip.mainPropValue
			local predictMainPropValue = utils.getEquipMainPropValue(self.equip, self.predictLevel)
			local zhName, zhValue = ClientUtils.getRolePropZhNameByType(self.equip.mainProp, predictMainPropValue)

			self.mParent.txtMainPropChange:setText(zhValue)
		else
			self.mParent.txtMainPropChange:setVisible(false)
		end

		local levelTempleteData = ResEquipLevelTemplete[self.equip.resData.templete_id]

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
					nextLevelNeedExp = CurAvatar:getEquipExpNeed(self.equip, level + 1)
				elseif curLevel < level and level < self.predictLevel then
					lastLevelHaveExp = CurAvatar:getEquipExpNeed(self.equip, level)
					nextLevelNeedExp = CurAvatar:getEquipExpNeed(self.equip, level + 1)
				else
					lastLevelHaveExp = CurAvatar:getEquipExpNeed(self.equip, level)
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

function EquipUpGradeMaterialPanel:showMaxLevelPanel()
	self.isMaxLevel = true

	self.predictSlider:setVisible(false)
	self.expSlider:setValue(1)

	local curLevelNeedExp = CurAvatar:getEquipExpNeed(self.equip, self.equip.enhanceLevel)

	self.txtExp:setText(self.equip.enhanceExp .. "/" .. curLevelNeedExp)
	self.mParent.txtMainPropChange:setVisible(false)
end

function EquipUpGradeMaterialPanel:getAddMaterialCount()
	local materialCount = 0

	for k, v in pairs(self.materials) do
		materialCount = materialCount + 1
	end

	return materialCount
end

function EquipUpGradeMaterialPanel:isCanAddItemMaterial(material)
	for _, materialGrid in pairs(self.materials) do
		local item = materialGrid.object

		if item.itemType == Const.ITEM_TYPE_ITEM and item.id == material.id then
			return true
		end
	end

	return false
end

function EquipUpGradeMaterialPanel:removeMaterial(sender)
	self.removeUpgradePos = sender.upgradePos

	self.mWindow:giveBackMaterial(sender.object)
end

function EquipUpGradeMaterialPanel:clearMaterial()
	for pos, materialGrid in pairs(self.materials) do
		self.materials[pos]:destroy()

		self.materials[pos] = nil
	end

	self:refreshPreExpPanel()
	self.btnAdd:setText(Lang.get(455))
end

function EquipUpGradeMaterialPanel:onBtnAddClick()
	self.mWindow.materialListPanel:fastToAddMaterial()
end

function EquipUpGradeMaterialPanel:OnBtnUpgradeClick()
	if self:getAddMaterialCount() < 1 then
		MsgManager.clientNotice(137)

		return
	end

	if CurAvatar:getMoneyByType(Const.MONEY_TYPE_GOLD) < self.needGold then
		MsgManager.clientNotice(180)

		return
	end

	local equipGids = {}
	local items = {}

	for _, materialGrid in pairs(self.materials) do
		local material = materialGrid.object

		if material.itemType == Const.ITEM_TYPE_EQUIP then
			table.insert(equipGids, material.gid)
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

	for k, v in pairs(equipGids) do
		-- block empty
	end

	for k, v in pairs(itemIds) do
		-- block empty
	end

	for k, v in pairs(itemCounts) do
		-- block empty
	end

	RPC.equipLevelUp(self.equip.gid, equipGids, itemIds, itemCounts, self.equip.enhanceExp)
end

return EquipUpGradeMaterialPanel
