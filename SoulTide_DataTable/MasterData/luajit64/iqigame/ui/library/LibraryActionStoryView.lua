-- chunkname: @IQIGame\\UI\\Library\\LibraryActionStoryView.lua

local m = {
	storyPlacePool = {}
}
local LibraryActionStoryPlaceCell = require("IQIGame.UI.Library.LibraryActionStoryPlaceCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:OnSelectedGridCell(cell)
	local storyData = self.storyDataTab[cell.index + 1]

	if storyData then
		UIModule.Open(Constant.UIControllerName.LibraryDialogInfoUI, Constant.UILayer.UI, storyData)
	end
end

function m:OnRenderGridCell(cell)
	local storyData = self.storyDataTab[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.storyPlacePool[instanceID]

	if renderCell == nil then
		renderCell = LibraryActionStoryPlaceCell.New(cell.gameObject)
		self.storyPlacePool[instanceID] = renderCell
	end

	renderCell:SetData(storyData)
end

function m:UpdateView()
	self.scrollList:Refresh(#self.storyDataTab)
end

function m:Open(type)
	self.type = type
	self.storyDataTab = TownLibraryModule.GetStoryDataByType(self.type)

	self.View:SetActive(true)
	self:UpdateView()
end

function m:Close()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.storyPlacePool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
