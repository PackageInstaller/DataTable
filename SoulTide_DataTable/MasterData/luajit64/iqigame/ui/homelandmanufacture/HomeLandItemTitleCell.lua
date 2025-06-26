-- chunkname: @IQIGame\\UI\\HomeLandManufacture\\HomeLandItemTitleCell.lua

HomeLandItemTitleCell = {}

function HomeLandItemTitleCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_ItemTitleCell == nil then
		ui.__SUB_UI_MAP_ItemTitleCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_ItemTitleCell
	local queueRender

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		queueRender = HomeLandItemTitleCell:__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = queueRender
	else
		queueRender = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return queueRender
end

function HomeLandItemTitleCell:__New(itemCellView)
	local itemCell = Clone(HomeLandItemTitleCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandItemTitleCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function HomeLandItemTitleCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_ItemTitleCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_ItemTitleCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_ItemTitleCell = nil
end

function HomeLandItemTitleCell:AddListener()
	return
end

function HomeLandItemTitleCell:RemoveListener()
	return
end

function HomeLandItemTitleCell:SetDate(data)
	self.cfgDecorateTheme = data

	if self.cfgDecorateTheme then
		local path = UIGlobalApi.GetImagePath("/Home" .. self.cfgDecorateTheme.Icon)

		AssetUtil.LoadImage(self, path, self.ImgDown:GetComponent("Image"))
		AssetUtil.LoadImage(self, path, self.ImgUp:GetComponent("Image"))

		local num, totalNum = HomeLandManufactureMould.GetCompleteThemeNumber(self.cfgDecorateTheme.Id)

		UGUIUtil.SetText(self.TextDown1, "")
		UGUIUtil.SetText(self.TextUp1, "")
		UGUIUtil.SetText(self.TextDown2, self.cfgDecorateTheme.Name)
		UGUIUtil.SetText(self.TextUp2, self.cfgDecorateTheme.Name)
	end
end

function HomeLandItemTitleCell:SetSelect(select)
	self.ToggleDown:SetActive(not select)
	self.ToggleUp:SetActive(select)
end

function HomeLandItemTitleCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.GameObject.Destroy(self.goView)

	self.goView = nil
end

return HomeLandItemTitleCell
