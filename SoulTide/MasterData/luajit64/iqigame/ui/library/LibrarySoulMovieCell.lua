-- chunkname: @IQIGame\\UI\\Library\\LibrarySoulMovieCell.lua

local LibrarySoulMovieCell = {}

function LibrarySoulMovieCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_LibrarySoulMovieCell == nil then
		ui.__SUB_UI_MAP_LibrarySoulMovieCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_LibrarySoulMovieCell
	local eventCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		eventCell = LibrarySoulMovieCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = eventCell
	else
		eventCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return eventCell
end

function LibrarySoulMovieCell.__New(itemCellView)
	local itemCell = Clone(LibrarySoulMovieCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function LibrarySoulMovieCell:Init(goView)
	self.goView = goView

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function LibrarySoulMovieCell:AddListener()
	return
end

function LibrarySoulMovieCell:RemoveListener()
	return
end

function LibrarySoulMovieCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_LibrarySoulMovieCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_LibrarySoulMovieCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_LibrarySoulMovieCell = nil
end

function LibrarySoulMovieCell:SetData(data)
	self.townLibrarySoulBookData = data

	if data == nil then
		self:Clear()
	else
		self:Update()
	end
end

function LibrarySoulMovieCell:Update()
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

function LibrarySoulMovieCell:Clear()
	self.goView:SetActive(false)
end

function LibrarySoulMovieCell:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return LibrarySoulMovieCell
