-- chunkname: @IQIGame\\UI\\Memory\\MemoryChapterCell.lua

local MemoryChapterCell = {}

function MemoryChapterCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_MemoryChapterCell == nil then
		ui.__SUB_UI_MAP_MemoryChapterCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_MemoryChapterCell
	local chapterCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		chapterCell = MemoryChapterCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = chapterCell
	else
		chapterCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return chapterCell
end

function MemoryChapterCell.__New(itemCellView)
	local itemCell = Clone(MemoryChapterCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function MemoryChapterCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function MemoryChapterCell:AddListener()
	return
end

function MemoryChapterCell:RemoveListener()
	return
end

function MemoryChapterCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_MemoryChapterCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_MemoryChapterCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_MemoryChapterCell = nil
end

function MemoryChapterCell:SetData(data, isOpen)
	self.cfgMemoryChapterInfo = data
	self.isOpen = isOpen

	if data == nil then
		self:Clear()
	else
		self:Update()
	end
end

function MemoryChapterCell:Update()
	if self.isOpen then
		self.TextName:GetComponent("Text").text = self.cfgMemoryChapterInfo.Name
	else
		self.TextName:GetComponent("Text").text = MemoryUIApi:GetString("TextName")
	end

	self.ImgRed:SetActive(false)
end

function MemoryChapterCell:SelectType(top)
	self.isSelect = top
end

function MemoryChapterCell:Clear()
	self.goView:SetActive(false)
end

function MemoryChapterCell:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return MemoryChapterCell
