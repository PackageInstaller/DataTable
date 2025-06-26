-- chunkname: @IQIGame\\UI\\Library\\LibraryDialogNpcView.lua

local LibraryDialogNpcView = {}
local LibraryDialogNpcCell = require("IQIGame.UI.Library.LibraryDialogNpcCell")

function LibraryDialogNpcView.New(view)
	local obj = Clone(LibraryDialogNpcView)

	obj:Init(view)

	return obj
end

function LibraryDialogNpcView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.scrollList = self.ScrollAreaNpc:GetComponent("ScrollAreaList")

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	self:AddListener()
end

function LibraryDialogNpcView:AddListener()
	return
end

function LibraryDialogNpcView:RemoveListener()
	return
end

function LibraryDialogNpcView:OnSelectedGridCell(cell)
	local storyData = self.storyDataTab[cell.index + 1]

	if storyData then
		UIModule.Open(Constant.UIControllerName.LibraryDialogInfoUI, Constant.UILayer.UI, storyData)
	end
end

function LibraryDialogNpcView:OnRenderGridCell(cell)
	local storyData = self.storyDataTab[cell.index + 1]

	if storyData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local item = cell.gameObject

	item:SetActive(true)

	local dialogSoul = LibraryDialogNpcCell.PackageOrReuseView(self, item)

	dialogSoul:SetData(storyData)
end

function LibraryDialogNpcView:UpdateView()
	self.scrollList:Refresh(#self.storyDataTab)
end

function LibraryDialogNpcView:Open(type)
	self.type = type
	self.storyDataTab = TownLibraryModule.GetStoryDataByType(self.type)

	self.View:SetActive(true)
	self:UpdateView()
end

function LibraryDialogNpcView:Close()
	self.View:SetActive(false)
end

function LibraryDialogNpcView:Dispose()
	self:RemoveListener()
	LibraryDialogNpcCell.DisposeIn(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibraryDialogNpcView
