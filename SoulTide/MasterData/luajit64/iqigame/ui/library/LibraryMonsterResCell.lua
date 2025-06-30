-- chunkname: @IQIGame\\UI\\Library\\LibraryMonsterResCell.lua

local LibraryMonsterResCell = {}

function LibraryMonsterResCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_LibraryMonsterResCell == nil then
		ui.__SUB_UI_MAP_LibraryMonsterResCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_LibraryMonsterResCell
	local eventCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		eventCell = LibraryMonsterResCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = eventCell
	else
		eventCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return eventCell
end

function LibraryMonsterResCell.__New(itemCellView)
	local itemCell = Clone(LibraryMonsterResCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function LibraryMonsterResCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function LibraryMonsterResCell:AddListener()
	return
end

function LibraryMonsterResCell:RemoveListener()
	return
end

function LibraryMonsterResCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_LibraryMonsterResCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_LibraryMonsterResCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_LibraryMonsterResCell = nil
end

function LibraryMonsterResCell:SetData(data)
	self.TownLibraryMonsterResData = data

	if data == nil then
		self:Clear()
	else
		self:Update()
	end
end

function LibraryMonsterResCell:Update()
	self.ImgLock:SetActive(not self.TownLibraryMonsterResData.isLock)
	UGUIUtil.SetText(self.TextName, self.TownLibraryMonsterResData.cfgInfo.TabName)

	local iconPath = UIGlobalApi.GetImagePath(self.TownLibraryMonsterResData.cfgInfo.MonsterImage)

	AssetUtil.LoadImage(self, iconPath, self.ImgIcon:GetComponent("Image"))
	self.goView:GetComponent("ImageGroupGrayComponent"):EnableGray(not self.TownLibraryMonsterResData.isLock)
end

function LibraryMonsterResCell:Clear()
	self.goView:SetActive(false)
end

function LibraryMonsterResCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.goView, self)
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)

	self.goView = nil
end

return LibraryMonsterResCell
