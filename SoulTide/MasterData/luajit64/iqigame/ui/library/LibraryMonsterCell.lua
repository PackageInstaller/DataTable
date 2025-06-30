-- chunkname: @IQIGame\\UI\\Library\\LibraryMonsterCell.lua

local LibraryMonsterCell = {}

function LibraryMonsterCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_LibraryMonsterCell == nil then
		ui.__SUB_UI_MAP_LibraryMonsterCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_LibraryMonsterCell
	local eventCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		eventCell = LibraryMonsterCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = eventCell
	else
		eventCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return eventCell
end

function LibraryMonsterCell.__New(itemCellView)
	local itemCell = Clone(LibraryMonsterCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function LibraryMonsterCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function LibraryMonsterCell:AddListener()
	return
end

function LibraryMonsterCell:RemoveListener()
	return
end

function LibraryMonsterCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_LibraryMonsterCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_LibraryMonsterCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_LibraryMonsterCell = nil
end

function LibraryMonsterCell:SetData(data)
	self.townLibraryMonsterData = data

	if data == nil then
		self:Clear()
	else
		self:Update()
	end
end

function LibraryMonsterCell:Update()
	if self.townLibraryMonsterData then
		UGUIUtil.SetText(self.TextDown, self.townLibraryMonsterData.cfgInfo.Name)
		UGUIUtil.SetText(self.TextUp, self.townLibraryMonsterData.cfgInfo.Name)
	end
end

function LibraryMonsterCell:Select(top)
	self.Down:SetActive(not top)
	self.Up:SetActive(top)
end

function LibraryMonsterCell:Clear()
	self.goView:SetActive(false)
end

function LibraryMonsterCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return LibraryMonsterCell
