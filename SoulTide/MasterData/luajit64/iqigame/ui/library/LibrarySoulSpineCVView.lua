-- chunkname: @IQIGame\\UI\\Library\\LibrarySoulSpineCVView.lua

local LibrarySoulSpineCVView = {}
local LibrarySoulSpineCVCell = require("IQIGame.UI.Library.LibrarySoulSpineCVCell")

function LibrarySoulSpineCVView.New(view, rootUI)
	local obj = Clone(LibrarySoulSpineCVView)

	obj:Init(view, rootUI)

	return obj
end

function LibrarySoulSpineCVView:Init(view, rootUI)
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

function LibrarySoulSpineCVView:AddListener()
	return
end

function LibrarySoulSpineCVView:RemoveListener()
	return
end

function LibrarySoulSpineCVView:OnSelectedGridCell(cell)
	local bookData = self.soulBookData[cell.index + 1]

	if bookData.open == false then
		NoticeModule.ShowNotice(21040128)

		return
	end

	local actionId = bookData.cfgInfo.CGCVId

	if actionId > 0 then
		self.rootUI.spineCell:PlayActionCustom(CfgSoulSpineActionTable[actionId])
	end
end

function LibrarySoulSpineCVView:OnRenderGridCell(cell)
	local bookData = self.soulBookData[cell.index + 1]

	if bookData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local soulBookCVCell = LibrarySoulSpineCVCell.PackageOrReuseView(self, cell.gameObject)

	soulBookCVCell:SetData(bookData)
end

function LibrarySoulSpineCVView:Update(data)
	self.librarySoulData = data
	self.soulBookData = {}

	local bookData = self.librarySoulData:GetSoulBookDataByType(Constant.BookType.BookTypeSpineCV)

	for i = 1, #bookData do
		local data = bookData[i]
		local dressCid = SoulModule.GetSoulData(data.cfgInfo.SoulId).dressCid2D

		if data.cfgInfo.NeedUnlockDress > 0 then
			if dressCid == data.cfgInfo.NeedUnlockDress then
				table.insert(self.soulBookData, data)
			end
		else
			table.insert(self.soulBookData, data)
		end
	end

	self.scrollList:Refresh(#self.soulBookData)
end

function LibrarySoulSpineCVView:Open()
	self.View:SetActive(true)
end

function LibrarySoulSpineCVView:Close()
	self.View:SetActive(false)
end

function LibrarySoulSpineCVView:Dispose()
	self:RemoveListener()
	LibrarySoulSpineCVCell.DisposeIn(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibrarySoulSpineCVView
