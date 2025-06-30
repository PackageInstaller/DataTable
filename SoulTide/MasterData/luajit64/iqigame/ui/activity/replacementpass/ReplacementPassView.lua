-- chunkname: @IQIGame\\UI\\Activity\\ReplacementPass\\ReplacementPassView.lua

local m = {
	replacementPassDataTable = {},
	replacementPassCellPool = {}
}
local ReplacementPassCell = require("IQIGame.UI.Activity.ReplacementPass.ReplacementPassCell")

function m.New(view, root)
	local obj = Clone(m)

	obj:Init(view, root)

	return obj
end

function m:Init(view, root)
	self.View = view
	self.root = root

	LuaCodeInterface.BindOutlet(self.View, self)

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end
end

function m.GetPreloadAssetPaths()
	return
end

function m:Update(elapseSeconds, realElapseSeconds)
	return
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:UpDateView()
	self.replacementPassDataTable = ReplacementPassModule.GetDataList()

	table.sort(self.replacementPassDataTable, function(a, b)
		return a.Id < b.Id
	end)
	self.scrollList:Refresh(#self.replacementPassDataTable)
end

function m:OnRenderGridCell(cell)
	local data = self.replacementPassDataTable[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.replacementPassCellPool[instanceID]

	if renderCell == nil then
		renderCell = ReplacementPassCell.New(cell.gameObject)
		self.replacementPassCellPool[instanceID] = renderCell
	end

	renderCell:SetData(data)
end

function m:Open()
	self:AddListener()
	self.View:SetActive(true)
	self:UpDateView()
end

function m:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function m:OnHide()
	self:RemoveListener()
end

function m:OnDestroy()
	for i, v in pairs(self.replacementPassCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
