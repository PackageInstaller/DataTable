-- chunkname: @IQIGame\\UI\\Library\\LibraryDialogView.lua

local LibraryDialogView = {}
local LibraryDialogPlaceCell = require("IQIGame.UI.Library.LibraryDialogPlaceCell")

function LibraryDialogView.New(view)
	local obj = Clone(LibraryDialogView)

	obj:Init(view)

	return obj
end

function LibraryDialogView:Init(view)
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

function LibraryDialogView:AddListener()
	return
end

function LibraryDialogView:RemoveListener()
	return
end

function LibraryDialogView:OnSelectedGridCell(cell)
	local storyData = self.storyDataTab[cell.index + 1]

	if storyData then
		UIModule.Open(Constant.UIControllerName.LibraryDialogInfoUI, Constant.UILayer.UI, storyData)
	end
end

function LibraryDialogView:OnRenderGridCell(cell)
	local storyData = self.storyDataTab[cell.index + 1]

	if storyData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local item = cell.gameObject

	item:SetActive(true)

	local dialogPlace = LibraryDialogPlaceCell.PackageOrReuseView(self, item)

	dialogPlace:SetData(storyData)
end

function LibraryDialogView:UpdateView()
	self.scrollList:Refresh(#self.storyDataTab)
end

function LibraryDialogView:Open(type)
	self.type = type
	self.storyDataTab = TownLibraryModule.GetStoryDataByType(self.type)

	self.View:SetActive(true)
	self:UpdateView()
end

function LibraryDialogView:Close()
	self.View:SetActive(false)
end

function LibraryDialogView:Dispose()
	LibraryDialogPlaceCell.DisposeIn(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibraryDialogView
