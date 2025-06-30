-- chunkname: @IQIGame\\UI\\Common\\MoneyCellsBuilder.lua

MoneyCellsBuilder = {
	currencyCells = {}
}
MoneyCellsBuilder.Area = {
	Maze = 2,
	Normal = 1
}

function MoneyCellsBuilder:OnLoadSucceed(assetName, asset, duration, userData)
	if self.currencyCidList == nil then
		return
	end

	self.cellAsset = asset

	for i, v in ipairs(self.currencyCidList) do
		self:AddMoneyCell(v)
	end
end

function MoneyCellsBuilder.New(goParent)
	local o = Clone(MoneyCellsBuilder)

	o:Init(goParent)

	return o
end

function MoneyCellsBuilder:Init(goParent)
	self.trfParent = goParent.transform
end

function MoneyCellsBuilder:RefreshView(currencyCidList, showPosition)
	self.currencyCidList = currencyCidList
	self.area = showPosition

	if self.cellAsset == nil then
		local path = UIGlobalApi.GetMoneyCellAssetPath()

		AssetUtil.LoadAsset(self, path, self.OnLoadSucceed)
	else
		for i, v in pairs(self.currencyCells) do
			v.ViewGo:SetActive(false)
		end

		for i, v in ipairs(self.currencyCidList) do
			local cell = self.currencyCells[v]

			if cell == nil then
				cell = self:AddMoneyCell(v)
			end

			cell.ViewGo:SetActive(true)
			cell:UpdateView()
		end
	end
end

function MoneyCellsBuilder:AddMoneyCell(currencyCid)
	if self.currencyCells[currencyCid] ~= nil then
		return
	end

	local goCell = UnityEngine.Object.Instantiate(self.cellAsset)

	goCell.transform:SetParent(self.trfParent, false)

	local cell

	if self.area == nil or self.area == MoneyCellsBuilder.Area.Maze then
		cell = CurrencyCell.New(goCell, currencyCid)
	else
		cell = MazeCurrencyCell.New(goCell, currencyCid)
	end

	self.currencyCells[currencyCid] = cell

	return cell
end

function MoneyCellsBuilder:Dispose()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.currencyCells) do
		v:Dispose()
	end

	self.cellAsset = nil
	self.currencyCidList = nil
end
