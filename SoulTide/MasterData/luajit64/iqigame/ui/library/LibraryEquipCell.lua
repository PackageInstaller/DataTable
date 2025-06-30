-- chunkname: @IQIGame\\UI\\Library\\LibraryEquipCell.lua

local LibraryEquipCell = {}

function LibraryEquipCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_LibraryEquipCell == nil then
		ui.__SUB_UI_MAP_LibraryEquipCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_LibraryEquipCell
	local eventCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		eventCell = LibraryEquipCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = eventCell
	else
		eventCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return eventCell
end

function LibraryEquipCell.__New(itemCellView)
	local itemCell = Clone(LibraryEquipCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function LibraryEquipCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function LibraryEquipCell:AddListener()
	return
end

function LibraryEquipCell:RemoveListener()
	return
end

function LibraryEquipCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_LibraryEquipCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_LibraryEquipCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_LibraryEquipCell = nil
end

function LibraryEquipCell:SetData(data)
	self.townLibraryEquipData = data

	if data == nil then
		self:Clear()
	else
		self:Update()
	end
end

function LibraryEquipCell:Update()
	self.Lock:SetActive(not self.townLibraryEquipData.isLock)
	self.ImgIcon:GetComponent("GrayComponent"):SetGray(not self.townLibraryEquipData.isLock)
	UGUIUtil.SetText(self.TextName, LibraryEquipApi:GetString("TextEquipName", self.townLibraryEquipData.cfgInfo.Name, self.townLibraryEquipData.isLock))

	local iconPath = UIGlobalApi.GetImagePath(self.townLibraryEquipData.cfgInfo.Drawing)

	AssetUtil.LoadImage(self, iconPath, self.ImgIcon:GetComponent("Image"))

	local iconPath = LibraryEquipApi:GetString("ImgTypePath", self.townLibraryEquipData.cfgInfo.Quality)

	AssetUtil.LoadImage(self, iconPath, self.ImgType:GetComponent("Image"))
end

function LibraryEquipCell:Select(top)
	self.Down:SetActive(not top)
	self.Up:SetActive(top)
end

function LibraryEquipCell:Clear()
	self.goView:SetActive(false)
end

function LibraryEquipCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return LibraryEquipCell
