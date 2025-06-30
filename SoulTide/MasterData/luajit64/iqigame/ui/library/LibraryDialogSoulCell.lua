-- chunkname: @IQIGame\\UI\\Library\\LibraryDialogSoulCell.lua

local LibraryDialogSoulCell = {}

function LibraryDialogSoulCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_LibraryDialogSoulCell == nil then
		ui.__SUB_UI_MAP_LibraryDialogSoulCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_LibraryDialogSoulCell
	local eventCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		eventCell = LibraryDialogSoulCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = eventCell
	else
		eventCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return eventCell
end

function LibraryDialogSoulCell.__New(itemCellView)
	local itemCell = Clone(LibraryDialogSoulCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function LibraryDialogSoulCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function LibraryDialogSoulCell:AddListener()
	return
end

function LibraryDialogSoulCell:RemoveListener()
	return
end

function LibraryDialogSoulCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_LibraryDialogSoulCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_LibraryDialogSoulCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_LibraryDialogSoulCell = nil
end

function LibraryDialogSoulCell:SetData(data)
	self.townLibraryStoryData = data

	if data == nil then
		self:Clear()
	else
		self:Update()
	end
end

function LibraryDialogSoulCell:Update()
	local isLock = self.townLibraryStoryData:IsLock()

	self.Lock:SetActive(not isLock)

	local cfgStoryBook = CfgSoulTable[self.townLibraryStoryData.cfgID]
	local iconPath = UIGlobalApi.GetImagePath(cfgStoryBook.SoulHead)

	AssetUtil.LoadImage(self, iconPath, self.ImgIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.TextName, cfgStoryBook.Name)
end

function LibraryDialogSoulCell:Clear()
	self.goView:SetActive(false)
end

function LibraryDialogSoulCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return LibraryDialogSoulCell
