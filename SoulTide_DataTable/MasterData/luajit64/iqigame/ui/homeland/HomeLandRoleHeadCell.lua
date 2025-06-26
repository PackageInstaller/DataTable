-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandRoleHeadCell.lua

local HomeLandRoleHeadCell = {}

function HomeLandRoleHeadCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_TownLibraryStoryCell == nil then
		ui.__SUB_UI_MAP_TownLibraryStoryCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_TownLibraryStoryCell
	local areaCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		areaCell = HomeLandRoleHeadCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = areaCell
	else
		areaCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return areaCell
end

function HomeLandRoleHeadCell.__New(itemCellView)
	local itemCell = Clone(HomeLandRoleHeadCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandRoleHeadCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function HomeLandRoleHeadCell:AddListener()
	return
end

function HomeLandRoleHeadCell:RemoveListener()
	return
end

function HomeLandRoleHeadCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_TownLibraryStoryCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_TownLibraryStoryCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_TownLibraryStoryCell = nil
end

function HomeLandRoleHeadCell:SetData(data)
	self.cfgHomeLandRole = data

	self:Update()
end

function HomeLandRoleHeadCell:Update()
	local isIn = self.cfgHomeLandRole ~= nil

	self.Lock:SetActive(isIn)
	self.UnLock:SetActive(not isIn)

	if isIn then
		local path = UIGlobalApi.GetImagePath(self.cfgHomeLandRole.HeadIcon)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	end
end

function HomeLandRoleHeadCell:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.GameObject.Destroy(self.goView)

	self.goView = nil
end

return HomeLandRoleHeadCell
