-- chunkname: @IQIGame\\UI\\Library\\LibraryDialogSoulView.lua

local LibraryDialogSoulView = {}
local LibraryDialogSoulCell = require("IQIGame.UI.Library.LibraryDialogSoulCell")

function LibraryDialogSoulView.New(view)
	local obj = Clone(LibraryDialogSoulView)

	obj:Init(view)

	return obj
end

function LibraryDialogSoulView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.scrollList = self.ScrollAreaSoul:GetComponent("ScrollAreaList")

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	self:AddListener()
end

function LibraryDialogSoulView:AddListener()
	return
end

function LibraryDialogSoulView:RemoveListener()
	return
end

function LibraryDialogSoulView:OnSelectedGridCell(cell)
	local storyData = self.storyDataTab[cell.index + 1]

	if storyData then
		UIModule.Open(Constant.UIControllerName.LibraryDialogInfoUI, Constant.UILayer.UI, storyData)
	end
end

function LibraryDialogSoulView:OnRenderGridCell(cell)
	local storyData = self.storyDataTab[cell.index + 1]

	if storyData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local item = cell.gameObject

	item:SetActive(true)

	local dialogSoul = LibraryDialogSoulCell.PackageOrReuseView(self, item)

	dialogSoul:SetData(storyData)
end

function LibraryDialogSoulView:UpdateView()
	self.scrollList:Refresh(#self.storyDataTab)
end

function LibraryDialogSoulView:Open(type)
	self.type = type
	self.storyDataTab = TownLibraryModule.GetStoryDataByType(self.type)

	self.View:SetActive(true)
	self:UpdateView()
end

function LibraryDialogSoulView:Close()
	self.View:SetActive(false)
end

function LibraryDialogSoulView:Dispose()
	self:RemoveListener()
	LibraryDialogSoulCell.DisposeIn(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibraryDialogSoulView
