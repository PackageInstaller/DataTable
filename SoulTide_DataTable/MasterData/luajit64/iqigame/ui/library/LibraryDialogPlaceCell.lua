-- chunkname: @IQIGame\\UI\\Library\\LibraryDialogPlaceCell.lua

local LibraryDialogPlaceCell = {}

function LibraryDialogPlaceCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_LibraryDialogPlaceCell == nil then
		ui.__SUB_UI_MAP_LibraryDialogPlaceCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_LibraryDialogPlaceCell
	local eventCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		eventCell = LibraryDialogPlaceCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = eventCell
	else
		eventCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return eventCell
end

function LibraryDialogPlaceCell.__New(itemCellView)
	local itemCell = Clone(LibraryDialogPlaceCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function LibraryDialogPlaceCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function LibraryDialogPlaceCell:AddListener()
	return
end

function LibraryDialogPlaceCell:RemoveListener()
	return
end

function LibraryDialogPlaceCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_LibraryDialogPlaceCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_LibraryDialogPlaceCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_LibraryDialogPlaceCell = nil
end

function LibraryDialogPlaceCell:SetData(data)
	self.townLibraryStoryData = data

	if data == nil then
		self:Clear()
	else
		self:Update()
	end
end

function LibraryDialogPlaceCell:Update()
	local isLock = self.townLibraryStoryData:IsLock()

	self.Lock:SetActive(not isLock)

	local cfgStoryBook = CfgTownStoryBookTable[self.townLibraryStoryData.cfgID]
	local path = UIGlobalApi.GetImagePath(cfgStoryBook.ButtonImage)

	AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.TextName, cfgStoryBook.Name)
	UGUIUtil.SetText(self.TextEngName, cfgStoryBook.EngName)
end

function LibraryDialogPlaceCell:Clear()
	self.goView:SetActive(false)
end

function LibraryDialogPlaceCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return LibraryDialogPlaceCell
