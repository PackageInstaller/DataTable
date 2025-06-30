-- chunkname: @IQIGame\\UI\\RewardDetailUI.lua

local RewardDetailUI = {}

RewardDetailUI = Base:Extend("RewardDetailUI", "IQIGame.Onigao.UI.RewardDetailUI", RewardDetailUI)

function RewardDetailUI:OnInit()
	self.ItemList = {}
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
end

function RewardDetailUI:GetPreloadAssetPaths()
	return nil
end

function RewardDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RewardDetailUI:IsManualShowOnOpen(userData)
	return false
end

function RewardDetailUI:GetBGM(userData)
	return nil
end

function RewardDetailUI:OnOpen(userData)
	self.itemDatas = userData.itemDatas

	self:RefreshRewardItem()
end

function RewardDetailUI:OnClose(userData)
	return
end

function RewardDetailUI:OnAddListeners()
	return
end

function RewardDetailUI:OnRemoveListeners()
	return
end

function RewardDetailUI:OnPause()
	return
end

function RewardDetailUI:OnResume()
	return
end

function RewardDetailUI:OnCover()
	return
end

function RewardDetailUI:OnReveal()
	return
end

function RewardDetailUI:OnRefocus(userData)
	return
end

function RewardDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RewardDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RewardDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RewardDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RewardDetailUI:OnDestroy()
	for k, v in pairs(self.ItemList) do
		v:Dispose()
	end

	self.ItemList = nil

	self.commonReturnBtn:Dispose()
	AssetUtil.UnloadAsset(self)
end

function RewardDetailUI:RefreshRewardItem()
	for i = 1, #self.ItemList do
		if i > #self.ItemList then
			self.ItemList[i]:Hide()
		else
			self.ItemList[i]:Show()
		end
	end

	for i = 1, #self.itemDatas do
		if CfgItemTable[self.itemDatas[i].itemID].IsHide ~= 1 then
			local rewardItemCell = self:CreateRewardItem(i)

			self:UpdateCellInfo(rewardItemCell, self.itemDatas[i])
		end
	end
end

function RewardDetailUI:UpdateCellInfo(rewardItemCell, data)
	local rawItemData = data
	local itemData
	local tag = 0

	if rewardItemCell ~= nil then
		if rawItemData.itemID ~= Constant.ItemCid.NORMAL_MONEY then
			rawItemData.num = 0
		end

		itemData = ItemData.CreateByCIDAndNumber(rawItemData.itemID, rawItemData.num)
		tag = rawItemData.tag

		rewardItemCell:SetItem(itemData)
		rewardItemCell:SetTag(tag)

		if rawItemData.itemID == Constant.ItemCid.NORMAL_MONEY then
			rewardItemCell:SetNum(rawItemData.num)
		end
	end

	rewardItemCell:Show()
end

function RewardDetailUI:CreateRewardItem(index)
	local rewardItemCell = self.ItemList[index]

	if rewardItemCell == nil then
		local obj = UnityEngine.Object.Instantiate(self.CommonSlotUI)

		obj.transform:SetParent(self.rewardContent.transform, false)

		rewardItemCell = ItemCell.New(obj)
		self.ItemList[index] = rewardItemCell
	end

	return rewardItemCell
end

return RewardDetailUI
