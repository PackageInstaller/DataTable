-- chunkname: @IQIGame\\UI\\RoleStarsUpgradeTipsUI.lua

local RoleStarsUpgradeTipsUI = {
	attrGrowupItemList = {},
	starItemList = {}
}

RoleStarsUpgradeTipsUI = Base:Extend("RoleStarsUpgradeTipsUI", "IQIGame.Onigao.UI.RoleStarsUpgradeTipsUI", RoleStarsUpgradeTipsUI)

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local PresentStarItem = require("IQIGame.UI.RoleDevelopment.RoleTraining.PresentStarItem")
local attrGrowupItemCell = require("IQIGame.UI.RoleDevelopment.ItemCell.AttrGrowupItemCell")

function RoleStarsUpgradeTipsUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.starItemPool = UIViewObjectPool.New(self.presentStarItemPrefab, nil, function(_view)
		return PresentStarItem.New(_view)
	end)
	self.closeBtnCom = self.CloseBtn:GetComponent("Button")
end

function RoleStarsUpgradeTipsUI:GetPreloadAssetPaths()
	return nil
end

function RoleStarsUpgradeTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RoleStarsUpgradeTipsUI:IsManualShowOnOpen(userData)
	return false
end

function RoleStarsUpgradeTipsUI:GetBGM(userData)
	return nil
end

function RoleStarsUpgradeTipsUI:OnOpen(userData)
	self.isClickClose = false

	self.attItemPrefab.gameObject:SetActive(false)

	self.closeBtnCom.interactable = false
	self.lastHeroData = userData.lastHeroData
	self.newHeroData = userData.newHeroData
	self.lastStarLevelCfg = userData.lastStarLevelCfg
	self.nextStarLevelCfg = userData.nextStarLevelCfg
	self.starTime = self.newHeroData.starTime
	self.starLevel = self.newHeroData.starLevel

	CoroutineUtility.StartCoroutine(function()
		self:SetConfirmBtnState(false)
		CoroutineUtility.Yield(CustomWaitForSeconds(0.5))
		self:SetStarItems(self.lastHeroData, true, 0, 1)
		CoroutineUtility.Yield(CustomWaitForSeconds(1))
		self:SetStarItems(self.newHeroData, false, 0.1, 2)
		self:SetConfirmBtnState(true)
	end)
end

function RoleStarsUpgradeTipsUI:OnClose(userData)
	self.starItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	for k, v in pairs(self.attrGrowupItemList) do
		v:Hide()
	end
end

function RoleStarsUpgradeTipsUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function RoleStarsUpgradeTipsUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function RoleStarsUpgradeTipsUI:OnPause()
	return
end

function RoleStarsUpgradeTipsUI:OnResume()
	return
end

function RoleStarsUpgradeTipsUI:OnCover()
	return
end

function RoleStarsUpgradeTipsUI:OnReveal()
	return
end

function RoleStarsUpgradeTipsUI:OnRefocus(userData)
	return
end

function RoleStarsUpgradeTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RoleStarsUpgradeTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RoleStarsUpgradeTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RoleStarsUpgradeTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RoleStarsUpgradeTipsUI:OnDestroy()
	for i = 1, #self.starItemList do
		self.starItemList[i]:Dispose()
	end

	for k, v in pairs(self.attrGrowupItemList) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
end

function RoleStarsUpgradeTipsUI:OnClickCloseBtn()
	if self.isClickClose then
		return
	end

	self.isClickClose = true

	for k, v in pairs(self.attrGrowupItemList) do
		v:Hide()
	end

	CoroutineUtility.StartCoroutine(function()
		for i = 1, #self.starItemList do
			self.starItemList[i]:PlayAnim(4)
			CoroutineUtility.Yield(CustomWaitForSeconds(0.05))
		end

		CoroutineUtility.Yield(CustomWaitForSeconds(0.5))
		UIModule.CloseSelf(self)
	end)
end

function RoleStarsUpgradeTipsUI:SetStarItems(heroData, isFirst, delayTime, animIndex)
	local starNum = math.max(self.starTime, self.starLevel)

	if isFirst then
		self.starItemPool:ForItems(function(_item)
			_item:Hide()
		end)

		for i = 1, starNum do
			local starItem = self.starItemPool:GetFree(function(_item)
				return not _item.View.activeSelf
			end)

			self.starItemList[i] = starItem

			self.starItemList[i]:Show()
		end

		for i = 1, #self.starItemList do
			self.starItemList[i]:SetData(4)
			self.starItemList[i]:Hide()
			self.starItemList[i]:Show()
			self.starItemList[i]:PlayAnim(animIndex)
		end
	else
		for i = 1, #self.starItemList do
			CoroutineUtility.Yield(CustomWaitForSeconds(delayTime))

			if i <= self.starTime then
				self.starItemList[i]:SetData(self.starLevel + 1)

				if i == self.starTime then
					self.starItemList[i]:PlayAnim(animIndex + 1, true)
				else
					self.starItemList[i]:PlayAnim(animIndex)
				end
			else
				self.starItemList[i]:SetData(self.starLevel)
			end
		end

		self:RefreshPromoteItem()
		CoroutineUtility.Yield(CustomWaitForSeconds(1))

		self.closeBtnCom.interactable = true
	end
end

function RoleStarsUpgradeTipsUI:RefreshPromoteItem()
	local changeDatas = {}
	local attrTypes = {
		Constant.Attribute.TYPE_HP,
		Constant.Attribute.TYPE_ATTACK,
		Constant.Attribute.TYPE_DEFENSE
	}

	for k, v in pairs(attrTypes) do
		local lastValue = self.lastStarLevelCfg.AttrValue[v]
		local newValue = self.nextStarLevelCfg.AttrValue[v]

		if lastValue ~= newValue then
			table.insert(changeDatas, {
				type = v,
				lastValue = lastValue,
				newValue = newValue,
				lastHeroData = self.lastHeroData,
				newHeroData = self.newHeroData
			})
		end
	end

	for i = 1, #changeDatas do
		CoroutineUtility.Yield(CustomWaitForSeconds(0.2))

		local itemCell = self:CreateAttrGrowupItem(i)

		itemCell:SetData(changeDatas[i])
		itemCell:Show()
	end
end

function RoleStarsUpgradeTipsUI:CreateAttrGrowupItem(index)
	local itemCell = self.attrGrowupItemList[index]

	if itemCell == nil then
		local obj = GameObject.Instantiate(self.attItemPrefab)

		obj.transform:SetParent(self.AttGrid.transform, false)

		itemCell = attrGrowupItemCell.New(obj)
		self.attrGrowupItemList[index] = itemCell
	end

	return itemCell
end

function RoleStarsUpgradeTipsUI:SetConfirmBtnState(state)
	self.CloseBtn:GetComponent("Button").interactable = state
end

return RoleStarsUpgradeTipsUI
