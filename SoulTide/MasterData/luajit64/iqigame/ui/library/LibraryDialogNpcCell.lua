-- chunkname: @IQIGame\\UI\\Library\\LibraryDialogNpcCell.lua

local LibraryDialogNpcCell = {}

function LibraryDialogNpcCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_LibraryDialogNpcCell == nil then
		ui.__SUB_UI_MAP_LibraryDialogNpcCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_LibraryDialogNpcCell
	local eventCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		eventCell = LibraryDialogNpcCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = eventCell
	else
		eventCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return eventCell
end

function LibraryDialogNpcCell.__New(itemCellView)
	local itemCell = Clone(LibraryDialogNpcCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function LibraryDialogNpcCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function LibraryDialogNpcCell:AddListener()
	return
end

function LibraryDialogNpcCell:RemoveListener()
	return
end

function LibraryDialogNpcCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_LibraryDialogNpcCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_LibraryDialogNpcCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_LibraryDialogNpcCell = nil
end

function LibraryDialogNpcCell:SetData(data)
	self.townLibraryStoryData = data

	if data == nil then
		self:Clear()
	else
		self:Update()
	end
end

function LibraryDialogNpcCell:Update()
	local isLock = self.townLibraryStoryData:IsLock()

	self.Lock:SetActive(not isLock)

	local cfgStoryBook = CfgTownNpcBookTable[self.townLibraryStoryData.cfgID]
	local iconPath = UIGlobalApi.GetImagePath(cfgStoryBook.Image01)

	AssetUtil.LoadImage(self, iconPath, self.ImgIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.TextName, cfgStoryBook.Name)
end

function LibraryDialogNpcCell:Clear()
	self.goView:SetActive(false)
end

function LibraryDialogNpcCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return LibraryDialogNpcCell
