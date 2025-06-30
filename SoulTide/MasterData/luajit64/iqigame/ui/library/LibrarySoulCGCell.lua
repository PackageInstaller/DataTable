-- chunkname: @IQIGame\\UI\\Library\\LibrarySoulCGCell.lua

local LibrarySoulCGCell = {}

function LibrarySoulCGCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_LibrarySoulCGCell == nil then
		ui.__SUB_UI_MAP_LibrarySoulCGCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_LibrarySoulCGCell
	local eventCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		eventCell = LibrarySoulCGCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = eventCell
	else
		eventCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return eventCell
end

function LibrarySoulCGCell.__New(itemCellView)
	local itemCell = Clone(LibrarySoulCGCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function LibrarySoulCGCell:Init(goView)
	self.goView = goView

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function LibrarySoulCGCell:AddListener()
	return
end

function LibrarySoulCGCell:RemoveListener()
	return
end

function LibrarySoulCGCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_LibrarySoulCGCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_LibrarySoulCGCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_LibrarySoulCGCell = nil
end

function LibrarySoulCGCell:SetData(data)
	self.townLibrarySoulBookData = data

	if data == nil then
		self:Clear()
	else
		self:Update()
	end
end

function LibrarySoulCGCell:Update()
	if self.townLibrarySoulBookData then
		self.Lock:SetActive(not self.townLibrarySoulBookData.open)

		local cfgCGInfo = CfgCGTable[self.townLibrarySoulBookData.cfgInfo.CGCVId]
		local soulData = SoulModule.GetSoulData(self.townLibrarySoulBookData.cfgInfo.SoulId)
		local isFullLv = soulData.favorLv >= self.townLibrarySoulBookData.cfgInfo.NeedSoulFavorLv

		self.TextCondition:GetComponent("Text").text = LibrarySoulApi:GetString("TextCondition", self.townLibrarySoulBookData.cfgInfo.LockingDescribe, self.townLibrarySoulBookData.cfgInfo.NeedSoulFavorLv, isFullLv)
		self.TextName:GetComponent("Text").text = LibrarySoulApi:GetString("HandBookName", cfgCGInfo.CGName, self.townLibrarySoulBookData.open)

		local path = UIGlobalApi.GetHarmoniousImagePath(cfgCGInfo.CGPicture)

		AssetUtil.LoadImage(self, path, self.ImgBG:GetComponent("Image"))
		self.goView:GetComponent("ImageGroupGrayComponent"):EnableGray(not self.townLibrarySoulBookData.open)
	end
end

function LibrarySoulCGCell:Clear()
	self.goView:SetActive(false)
end

function LibrarySoulCGCell:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return LibrarySoulCGCell
