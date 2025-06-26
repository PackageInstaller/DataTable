-- chunkname: @IQIGame\\UI\\Library\\LibraryEventElementCell.lua

local LibraryEventElementCell = {}

function LibraryEventElementCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.SUB_UI_MAP_LibraryEventElementCell == nil then
		ui.SUB_UI_MAP_LibraryEventElementCell = {}
	end

	local subUIMap = ui.SUB_UI_MAP_LibraryEventElementCell
	local eventCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		eventCell = LibraryEventElementCell.New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = eventCell
	else
		eventCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return eventCell
end

function LibraryEventElementCell.New(itemCellView)
	local itemCell = Clone(LibraryEventElementCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function LibraryEventElementCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function LibraryEventElementCell:AddListener()
	return
end

function LibraryEventElementCell:RemoveListener()
	return
end

function LibraryEventElementCell.DisposeIn(ui)
	if ui.SUB_UI_MAP_LibraryEventElementCell == nil then
		return
	end

	for i, itemCell in pairs(ui.SUB_UI_MAP_LibraryEventElementCell) do
		itemCell:Dispose()
	end

	ui.SUB_UI_MAP_LibraryEventElementCell = nil
end

function LibraryEventElementCell:SetData(cfgTownAlienEventBookResData, isUnlock)
	self.goView:SetActive(cfgTownAlienEventBookResData ~= nil)

	if cfgTownAlienEventBookResData == nil then
		return
	end

	self:__SetData(cfgTownAlienEventBookResData, isUnlock)
end

function LibraryEventElementCell:__SetData(cfgTownAlienEventBookResData, isUnlock)
	self.Lock:SetActive(not isUnlock)
	self.ImgDown:SetActive(isUnlock)
	self.ImgUp:SetActive(isUnlock)

	if isUnlock then
		local iconPath = UIGlobalApi.GetImagePath(cfgTownAlienEventBookResData.ElementIcon)

		AssetUtil.LoadImage(self, iconPath, self.ImgDown:GetComponent("Image"))
		AssetUtil.LoadImage(self, iconPath, self.ImgUp:GetComponent("Image"))
	end
end

function LibraryEventElementCell:Select(value)
	self.goDown:SetActive(not value)
	self.goUp:SetActive(value)
end

function LibraryEventElementCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return LibraryEventElementCell
