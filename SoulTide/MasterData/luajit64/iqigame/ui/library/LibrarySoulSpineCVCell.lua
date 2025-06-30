-- chunkname: @IQIGame\\UI\\Library\\LibrarySoulSpineCVCell.lua

local LibrarySoulSpineCVCell = {}

function LibrarySoulSpineCVCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_LibrarySoulSpineCGCell == nil then
		ui.__SUB_UI_MAP_LibrarySoulSpineCGCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_LibrarySoulSpineCGCell
	local eventCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		eventCell = LibrarySoulSpineCVCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = eventCell
	else
		eventCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return eventCell
end

function LibrarySoulSpineCVCell.__New(itemCellView)
	local itemCell = Clone(LibrarySoulSpineCVCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function LibrarySoulSpineCVCell:Init(goView)
	self.goView = goView

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()
end

function LibrarySoulSpineCVCell:AddListener()
	return
end

function LibrarySoulSpineCVCell:RemoveListener()
	return
end

function LibrarySoulSpineCVCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_LibrarySoulSpineCGCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_LibrarySoulSpineCGCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_LibrarySoulSpineCGCell = nil
end

function LibrarySoulSpineCVCell:SetData(data)
	self.townLibrarySoulBookData = data

	if data == nil then
		self:Clear()
	else
		self:Update()
	end
end

function LibrarySoulSpineCVCell:Update()
	if self.townLibrarySoulBookData then
		self.Lock:SetActive(not self.townLibrarySoulBookData.open)

		local cfgSoulAction = CfgSoulSpineActionTable[self.townLibrarySoulBookData.cfgInfo.CGCVId]
		local soulData = SoulModule.GetSoulData(self.townLibrarySoulBookData.cfgInfo.SoulId)
		local isFullLv = soulData.favorLv >= self.townLibrarySoulBookData.cfgInfo.NeedSoulFavorLv

		self.TextCondition:GetComponent("Text").text = LibrarySoulApi:GetString("TextCondition", "", self.townLibrarySoulBookData.cfgInfo.NeedSoulFavorLv, isFullLv)
		self.TextName:GetComponent("Text").text = LibrarySoulApi:GetString("HandBookName", cfgSoulAction.ActionName, self.townLibrarySoulBookData.open)
	end
end

function LibrarySoulSpineCVCell:Clear()
	self.goView:SetActive(false)
end

function LibrarySoulSpineCVCell:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return LibrarySoulSpineCVCell
