-- chunkname: @IQIGame\\UI\\Library\\LibrarySoulCGView.lua

local LibrarySoulCGView = {}
local LibrarySoulCGCell = require("IQIGame.UI.Library.LibrarySoulCGCell")

function LibrarySoulCGView.New(view)
	local obj = Clone(LibrarySoulCGView)

	obj:Init(view)

	return obj
end

function LibrarySoulCGView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.scrollList = self.View:GetComponent("ScrollAreaList")

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	self:AddListener()
end

function LibrarySoulCGView:AddListener()
	return
end

function LibrarySoulCGView:RemoveListener()
	return
end

function LibrarySoulCGView:OnSelectedGridCell(cell)
	local bookData = self.soulBookData[cell.index + 1]

	if bookData.open == false then
		NoticeModule.ShowNotice(21040128)

		return
	end

	local cfgCGInfo = CfgCGTable[bookData.cfgInfo.CGCVId]
	local pathTab = {}

	table.insert(pathTab, UIGlobalApi.GetHarmoniousImagePath(cfgCGInfo.CgLink))

	if #cfgCGInfo.CgGroup > 0 then
		for i = 1, #cfgCGInfo.CgGroup do
			local str = cfgCGInfo.CgGroup[i]

			if str ~= nil and str ~= "" then
				table.insert(pathTab, UIGlobalApi.GetHarmoniousImagePath(str))
			end
		end
	end

	UIModule.Open(Constant.UIControllerName.SoulCgShowUI, Constant.UILayer.UI, {
		pathTab,
		cfgCGInfo.CgPicturePosition
	})
end

function LibrarySoulCGView:OnRenderGridCell(cell)
	local bookData = self.soulBookData[cell.index + 1]

	if bookData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local soulBookCGCell = LibrarySoulCGCell.PackageOrReuseView(self, cell.gameObject)

	soulBookCGCell:SetData(bookData)
end

function LibrarySoulCGView:Update(data)
	self.librarySoulData = data
	self.soulBookData = self.librarySoulData:GetSoulBookDataByType(Constant.BookType.BookTypeCG)

	self.scrollList:Refresh(#self.soulBookData)
end

function LibrarySoulCGView:Open()
	self.View:SetActive(true)
end

function LibrarySoulCGView:Close()
	self.View:SetActive(false)
end

function LibrarySoulCGView:Dispose()
	self:RemoveListener()
	LibrarySoulCGCell.DisposeIn(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibrarySoulCGView
