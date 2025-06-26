-- chunkname: @IQIGame\\UI\\Activity\\DollBingo\\NumRewardCell.lua

local NumRewardCell = {
	itemCellPool = {}
}

function NumRewardCell.New(view)
	local obj = Clone(NumRewardCell)

	obj:Init(view)

	return obj
end

function NumRewardCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfName = self.goName:GetComponent("Text")
	self.tfProb = self.goProb:GetComponent("Text")
	self.icon = self.goIcon:GetComponent("Image")
	self.itemCellPool[1] = ItemCell.PackageOrReuseView(self, self.goRewardRoot.transform:Find("CommonSlotUI").gameObject)
end

function NumRewardCell:Refresh(cfgNumData)
	self.cfgNumData = cfgNumData

	self:RefreshMisc()
	self:RefreshReward()
end

function NumRewardCell:OnHide()
	return
end

function NumRewardCell:OnDestroy()
	for i, v in pairs(self.itemCellPool) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function NumRewardCell:RefreshMisc()
	self.tfName.text = ActivityNewDollBingoUIApi:GetString("rewardNumName", self.cfgNumData.Clue)
	self.tfProb.text = ActivityNewDollBingoUIApi:GetString("rewardNumProb", self.cfgNumData.Probability)

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.cfgNumData.IconImage), self.icon)
end

function NumRewardCell:RefreshReward()
	local rewardInfos = self.cfgNumData.Reward
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

function NumRewardCell:GetCell(index)
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

return NumRewardCell
