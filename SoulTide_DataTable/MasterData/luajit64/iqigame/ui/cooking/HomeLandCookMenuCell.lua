-- chunkname: @IQIGame\\UI\\Cooking\\HomeLandCookMenuCell.lua

HomeLandCookMenuCell = {}

function HomeLandCookMenuCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_MenuCell == nil then
		ui.__SUB_UI_MAP_MenuCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_MenuCell
	local queueRender

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		queueRender = HomeLandCookMenuCell:__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = queueRender
	else
		queueRender = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return queueRender
end

function HomeLandCookMenuCell:__New(itemCellView)
	local itemCell = Clone(HomeLandCookMenuCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandCookMenuCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function HomeLandCookMenuCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_MenuCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_MenuCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_MenuCell = nil
end

function HomeLandCookMenuCell:AddListener()
	return
end

function HomeLandCookMenuCell:RemoveListener()
	return
end

function HomeLandCookMenuCell:SetDate(data)
	self.cookingMenuData = data

	self.Check:SetActive(false)
	self.Could:SetActive(false)

	if self.cookingMenuData then
		local unlockStr = HomeLandCookingUIApi:GetString("TextUnLock", self.cookingMenuData.cfgInfo.UnlockLevel)

		UGUIUtil.SetText(self.TextUnLock, HomeLandCookingUIApi:GetString("TextMenuName", false, unlockStr))
		self.Normal:SetActive(true)
		self.UnKnow:SetActive(not self.cookingMenuData.unlock)
		self.Slot:SetActive(self.cookingMenuData.unlock)

		if self.cookingMenuData.unlock then
			local isCan = self.cookingMenuData:IsAmple()

			self.Could:SetActive(isCan)

			local itemCell = ItemCell.PackageOrReuseView(self, self.ItemSlot, false)
			local itemData = CfgItemTable[self.cookingMenuData.cfgInfo.ItemId[1]]

			if itemData ~= nil then
				itemCell:SetItem(itemData)
				UGUIUtil.SetText(self.TextName, HomeLandCookingUIApi:GetString("TextMenuName", false, itemData.Name))
			else
				logError(self.cookingMenuData.cfgInfo.ItemId[1] .. "没有指定物品")
			end
		else
			UGUIUtil.SetText(self.TextName, "")
		end
	else
		self.Normal:SetActive(false)
		self.Slot:SetActive(false)
	end
end

function HomeLandCookMenuCell:SetSelect(isSelect)
	if self.cookingMenuData then
		self.Normal:SetActive(not isSelect)
		self.Check:SetActive(isSelect)

		local str = self.TextName:GetComponent("Text").text

		UGUIUtil.SetText(self.TextName, HomeLandCookingUIApi:GetString("TextMenuName", isSelect, str))
	end
end

function HomeLandCookMenuCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return HomeLandCookMenuCell
