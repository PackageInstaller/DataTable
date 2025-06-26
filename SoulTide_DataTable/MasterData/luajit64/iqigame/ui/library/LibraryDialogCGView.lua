-- chunkname: @IQIGame\\UI\\Library\\LibraryDialogCGView.lua

local m = {
	libraryCGCellPool = {}
}
local LibraryDialogCGCell = require("IQIGame.UI.Library.LibraryDialogCGCell")

function m.New(view, root)
	local obj = Clone(m)

	obj:Init(view, root)

	return obj
end

function m:Init(view, root)
	self.View = view
	self.rootParent = root

	LuaCodeInterface.BindOutlet(self.View, self)

	self.scrollList = self.View:GetComponent("ScrollAreaList")

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	self.townStoryCGRes = {}

	for i, v in pairsCfg(CfgTownStoryCGResTable) do
		table.insert(self.townStoryCGRes, v)
	end

	table.sort(self.townStoryCGRes, function(a, b)
		return a.Id < b.Id
	end)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:UpdateView()
	self.scrollList:Refresh(#self.townStoryCGRes)
end

function m:OnSelectedGridCell(cell)
	local cfgCGRes = self.townStoryCGRes[cell.index + 1]
	local isUnlock = false

	if TownLibraryModule.LibraryPOD.townStoryCG then
		isUnlock = TownLibraryModule.LibraryPOD.townStoryCG[cfgCGRes.Id] ~= nil
	end

	if not isUnlock then
		NoticeModule.ShowNotice(21040128)

		return
	end

	if cfgCGRes.Type == 2 then
		self.rootParent:PlayMovie(cfgCGRes)
	else
		UIModule.Open(Constant.UIControllerName.LibrarySoulCgShowUI, Constant.UILayer.UI, cfgCGRes)
	end
end

function m:OnRenderGridCell(cell)
	local cfgCGRes = self.townStoryCGRes[cell.index + 1]

	if cfgCGRes == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local cgCell = self.libraryCGCellPool[instanceID]

	if cgCell == nil then
		cgCell = LibraryDialogCGCell.New(cell.gameObject)
		self.libraryCGCellPool[instanceID] = cgCell
	end

	local isUnlock = false

	if TownLibraryModule.LibraryPOD.townStoryCG then
		isUnlock = TownLibraryModule.LibraryPOD.townStoryCG[cfgCGRes.Id] ~= nil
	end

	cgCell:SetDate(cfgCGRes, isUnlock)
end

function m:Open(type)
	self.type = type

	self.View:SetActive(true)
	self:UpdateView()
end

function m:Close()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.libraryCGCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
