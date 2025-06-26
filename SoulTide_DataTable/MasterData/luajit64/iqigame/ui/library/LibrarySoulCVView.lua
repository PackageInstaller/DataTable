-- chunkname: @IQIGame\\UI\\Library\\LibrarySoulCVView.lua

local LibrarySoulCVView = {}
local LibrarySoulCVCell = require("IQIGame.UI.Library.LibrarySoulCVCell")

function LibrarySoulCVView.New(view)
	local obj = Clone(LibrarySoulCVView)

	obj:Init(view)

	return obj
end

function LibrarySoulCVView:Init(view)
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

function LibrarySoulCVView:AddListener()
	return
end

function LibrarySoulCVView:RemoveListener()
	return
end

function LibrarySoulCVView:OnSelectedGridCell(cell)
	local bookData = self.soulBookData[cell.index + 1]

	if bookData.open == false then
		NoticeModule.ShowNotice(21040128)

		return
	end

	local soulData = SoulModule.GetSoulData(bookData.cfgInfo.SoulId)

	if bookData.cfgInfo.NeedUnlockDress > 0 and soulData.dressCid2D ~= bookData.cfgInfo.NeedUnlockDress then
		NoticeModule.ShowNotice(21042502)

		return
	end

	local actionId = bookData.cfgInfo.CGCVId

	if actionId > 0 then
		GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.LibraryAction, actionId))
	end
end

function LibrarySoulCVView:OnRenderGridCell(cell)
	local bookData = self.soulBookData[cell.index + 1]

	if bookData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local soulBookCVCell = LibrarySoulCVCell.PackageOrReuseView(self, cell.gameObject)

	soulBookCVCell:SetData(bookData)
end

function LibrarySoulCVView:Update(data)
	self.librarySoulData = data
	self.soulBookData = self.librarySoulData:GetSoulBookDataByType(Constant.BookType.BookTypeCV)

	self.scrollList:Refresh(#self.soulBookData)
end

function LibrarySoulCVView:Open()
	self.View:SetActive(true)
end

function LibrarySoulCVView:Close()
	self.View:SetActive(false)
end

function LibrarySoulCVView:Dispose()
	self:RemoveListener()
	LibrarySoulCVCell.DisposeIn(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibrarySoulCVView
