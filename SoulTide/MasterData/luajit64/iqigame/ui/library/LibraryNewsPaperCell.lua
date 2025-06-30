-- chunkname: @IQIGame\\UI\\Library\\LibraryNewsPaperCell.lua

local LibraryNewsPaperCell = {}

function LibraryNewsPaperCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_LibraryNewsPaperCell == nil then
		ui.__SUB_UI_MAP_LibraryNewsPaperCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_LibraryNewsPaperCell
	local eventCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		eventCell = LibraryNewsPaperCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = eventCell
	else
		eventCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return eventCell
end

function LibraryNewsPaperCell.__New(itemCellView)
	local itemCell = Clone(LibraryNewsPaperCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function LibraryNewsPaperCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)

	function self.delegateUpdateLibraryNews(newDate)
		self:OnUpdateLibraryNews(newDate)
	end

	self:AddListener()
end

function LibraryNewsPaperCell:AddListener()
	EventDispatcher.AddEventListener(EventID.UpdateLibraryNewsEvent, self.delegateUpdateLibraryNews)
end

function LibraryNewsPaperCell:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.UpdateLibraryNewsEvent, self.delegateUpdateLibraryNews)
end

function LibraryNewsPaperCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_LibraryNewsPaperCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_LibraryNewsPaperCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_LibraryNewsPaperCell = nil
end

function LibraryNewsPaperCell:SetData(data)
	self.libraryNewsData = data

	if data == nil then
		self:Clear()
	else
		self:Update()
	end
end

function LibraryNewsPaperCell:Update()
	UGUIUtil.SetText(self.TextDate, self.libraryNewsData.cfgInfo.PaperData)
	UGUIUtil.SetText(self.TextName, self.libraryNewsData.cfgInfo.Name)

	if self.libraryNewsData.cfgInfo.ButtonImage ~= nil and self.libraryNewsData.cfgInfo.ButtonImage ~= "" then
		local iconPath = UIGlobalApi.GetImagePath(self.libraryNewsData.cfgInfo.ButtonImage)

		AssetUtil.LoadImage(self, iconPath, self.ImgIcon:GetComponent("Image"))
	end

	local typePath = LibraryNewsUIApi:GetString("NewsTypePath", self.libraryNewsData.cfgInfo.PaperType)

	AssetUtil.LoadImage(self, typePath, self.ImgType:GetComponent("Image"))

	local isRed = self.libraryNewsData:IsGetReward()

	self.RedPoint:SetActive(isRed)
end

function LibraryNewsPaperCell:OnUpdateLibraryNews(newDate)
	if self.libraryNewsData and self.libraryNewsData.cfgID == newDate.cfgID then
		self.libraryNewsData = newDate

		self:Update()
	end
end

function LibraryNewsPaperCell:Clear()
	self.goView:SetActive(false)
end

function LibraryNewsPaperCell:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return LibraryNewsPaperCell
