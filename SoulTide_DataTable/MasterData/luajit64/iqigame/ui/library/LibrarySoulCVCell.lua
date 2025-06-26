-- chunkname: @IQIGame\\UI\\Library\\LibrarySoulCVCell.lua

local LibrarySoulCVCell = {}

function LibrarySoulCVCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_LibrarySoulCGCell == nil then
		ui.__SUB_UI_MAP_LibrarySoulCGCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_LibrarySoulCGCell
	local eventCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		eventCell = LibrarySoulCVCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = eventCell
	else
		eventCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return eventCell
end

function LibrarySoulCVCell.__New(itemCellView)
	local itemCell = Clone(LibrarySoulCVCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function LibrarySoulCVCell:Init(goView)
	self.goView = goView

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function LibrarySoulCVCell:AddListener()
	return
end

function LibrarySoulCVCell:RemoveListener()
	return
end

function LibrarySoulCVCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_LibrarySoulCGCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_LibrarySoulCGCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_LibrarySoulCGCell = nil
end

function LibrarySoulCVCell:SetData(data)
	self.townLibrarySoulBookData = data

	if data == nil then
		self:Clear()
	else
		self:Update()
	end
end

function LibrarySoulCVCell:Update()
	if self.townLibrarySoulBookData then
		self.Lock:SetActive(not self.townLibrarySoulBookData.open)

		local cfgSoulAction = CfgSoulActionTable[self.townLibrarySoulBookData.cfgInfo.CGCVId]
		local soulData = SoulModule.GetSoulData(self.townLibrarySoulBookData.cfgInfo.SoulId)
		local isFullLv = soulData.favorLv >= self.townLibrarySoulBookData.cfgInfo.NeedSoulFavorLv

		self.TextCondition:GetComponent("Text").text = LibrarySoulApi:GetString("TextCondition", self.townLibrarySoulBookData.cfgInfo.LockingDescribe, self.townLibrarySoulBookData.cfgInfo.NeedSoulFavorLv, isFullLv)
		self.TextName:GetComponent("Text").text = LibrarySoulApi:GetString("HandBookName", cfgSoulAction.ActionName, self.townLibrarySoulBookData.open)
	end
end

function LibrarySoulCVCell:Clear()
	self.goView:SetActive(false)
end

function LibrarySoulCVCell:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return LibrarySoulCVCell
