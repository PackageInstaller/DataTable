-- chunkname: @IQIGame\\UI\\Activity\\DollBingo\\BingoRewardCell.lua

local BingoRewardCell = {
	itemCellPool = {},
	iconPool = {}
}

function BingoRewardCell.New(view)
	local obj = Clone(BingoRewardCell)

	obj:Init(view)

	return obj
end

function BingoRewardCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	for i = 1, 8 do
		self.iconPool[i] = self.goIconRoot.transform:Find("Image_0" .. i):GetComponent("Image")
	end

	self.tfDesc = self.goDesc:GetComponent("Text")
	self.itemCellPool[1] = ItemCell.PackageOrReuseView(self, self.goRewardRoot.transform:Find("CommonSlotUI").gameObject)
end

function BingoRewardCell:Refresh(cfgBingoData, type)
	self.cfgBingoData = cfgBingoData
	self.type = type

	self:RefreshMisc()
	self:RefreshReward()
	self:RefreshIcons()
end

function BingoRewardCell:OnHide()
	return
end

function BingoRewardCell:OnDestroy()
	for i, v in pairs(self.itemCellPool) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function BingoRewardCell:RefreshMisc()
	self.tfDesc.text = ActivityNewDollBingoUIApi:GetString("rewardBingoCellDesc", self.cfgBingoData.Record)
end

function BingoRewardCell:RefreshIcons()
	for i, v in pairs(self.iconPool) do
		v.gameObject:SetActive(false)
	end

	for i, v in ipairs(self.cfgBingoData.Combina) do
		local icon = self.iconPool[i]
		local path = UIGlobalApi.GetImagePath(CfgNewCharacterBingoNumTable[v].IconImage)

		icon.gameObject:SetActive(true)
		AssetUtil.LoadImage(self, path, icon)
	end
end

function BingoRewardCell:RefreshReward()
	local rewardInfos = self.cfgBingoData.Reward[self.type]
	local rewardCount = #rewardInfos / 2

	for i, v in ipairs(self.itemCellPool) do
		v.ViewGo.transform.parent.gameObject:SetActive(i <= rewardCount)
	end

	local index = 0

	for i, v in ipairs(rewardInfos) do
		if i % 2 ~= 0 then
			index = index + 1

			local id = v
			local num = rewardInfos[i + 1]
			local cell = self:GetCell(index)

			cell:SetItemByCID(id, num)
		end
	end
end

function BingoRewardCell:GetCell(index)
	local cell = self.itemCellPool[index]

	if cell == nil then
		local cloneParent = UnityEngine.Object.Instantiate(self.goRewardRoot)

		cloneParent.transform:SetParent(self.goRewardRoot.transform.parent, false)

		cell = ItemCell.PackageOrReuseView(self, cloneParent.transform:Find("CommonSlotUI").gameObject)
		self.itemCellPool[index] = cell
	end

	cell.ViewGo.transform.parent.gameObject:SetActive(true)

	return cell
end

return BingoRewardCell
