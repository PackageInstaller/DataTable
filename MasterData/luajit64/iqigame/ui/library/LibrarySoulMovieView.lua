-- chunkname: @IQIGame\\UI\\Library\\LibrarySoulMovieView.lua

local LibrarySoulMovieView = {}
local LibrarySoulMovieCell = require("IQIGame.UI.Library.LibrarySoulMovieCell")

function LibrarySoulMovieView.New(view, rootUI)
	local obj = Clone(LibrarySoulMovieView)

	obj:Init(view, rootUI)

	return obj
end

function LibrarySoulMovieView:Init(view, rootUI)
	self.View = view
	self.rootUI = rootUI

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

function LibrarySoulMovieView:AddListener()
	return
end

function LibrarySoulMovieView:RemoveListener()
	return
end

function LibrarySoulMovieView:OnSelectedGridCell(cell)
	local bookData = self.soulBookData[cell.index + 1]

	if bookData.open == false then
		NoticeModule.ShowNotice(21040128)

		return
	end

	self.rootUI:PlayMovie(CfgCGTable[bookData.cfgInfo.CGCVId])
end

function LibrarySoulMovieView:OnRenderGridCell(cell)
	local bookData = self.soulBookData[cell.index + 1]

	if bookData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local soulBookMovieCell = LibrarySoulMovieCell.PackageOrReuseView(self, cell.gameObject)

	soulBookMovieCell:SetData(bookData)
end

function LibrarySoulMovieView:Update(data)
	self.librarySoulData = data
	self.soulBookData = self.librarySoulData:GetSoulBookDataByType(Constant.BookType.BookTypeMovie)

	self.scrollList:Refresh(#self.soulBookData)
end

function LibrarySoulMovieView:Open()
	self.View:SetActive(true)
end

function LibrarySoulMovieView:Close()
	self.View:SetActive(false)
end

function LibrarySoulMovieView:Dispose()
	self:RemoveListener()
	LibrarySoulMovieCell.DisposeIn(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibrarySoulMovieView
