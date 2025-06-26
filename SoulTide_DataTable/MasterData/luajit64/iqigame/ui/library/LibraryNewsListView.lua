-- chunkname: @IQIGame\\UI\\Library\\LibraryNewsListView.lua

local LibraryNewsListView = {}
local LibraryNewsPaperCell = require("IQIGame.UI.Library.LibraryNewsPaperCell")

function LibraryNewsListView.New(view, parent)
	local obj = Clone(LibraryNewsListView)

	obj:Init(view, parent)

	return obj
end

function LibraryNewsListView:Init(view, parent)
	self.View = view
	self.rootParent = parent

	LuaCodeInterface.BindOutlet(self.View, self)

	self.scrollNewsList = self.NewsScroll:GetComponent("ScrollAreaList")

	function self.scrollNewsList.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function self.scrollNewsList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	self:AddListener()
end

function LibraryNewsListView:AddListener()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
end

function LibraryNewsListView:RemoveListener()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
end

function LibraryNewsListView:UpdateView(type)
	if type == 1 then
		UGUIUtil.SetText(self.TextTitle, LibraryNewsUIApi:GetString("NewsType1"))
	else
		UGUIUtil.SetText(self.TextTitle, LibraryNewsUIApi:GetString("NewsType2"))
	end

	self.libraryNews = {}

	for i, v in pairs(TownLibraryModule.newsTab) do
		if v.isLock and v.cfgInfo.PaperType == type then
			table.insert(self.libraryNews, v)
		end
	end

	table.sort(self.libraryNews, function(a, b)
		return a.cfgID < b.cfgID
	end)
	self.scrollNewsList:Refresh(#self.libraryNews)
end

function LibraryNewsListView:OnRenderGridCell(cell)
	local item = cell.gameObject
	local itemCell = LibraryNewsPaperCell.PackageOrReuseView(self, item)
	local libraryNewData = self.libraryNews[cell.index + 1]

	itemCell:SetData(libraryNewData)
end

function LibraryNewsListView:OnSelectedGridCell(cell)
	local libraryNewData = self.libraryNews[cell.index + 1]

	if not libraryNewData.isLock then
		NoticeModule.ShowNoticeByType(1, LibraryNewsUIApi:GetString("TextUnLockError"))

		return
	end

	self.rootParent:OpenNewsView(libraryNewData)
end

function LibraryNewsListView:OnClickBtnClose()
	self.rootParent:OnCloseListView()
end

function LibraryNewsListView:Open()
	self.View:SetActive(true)
end

function LibraryNewsListView:Close()
	self.View:SetActive(false)
end

function LibraryNewsListView:Dispose()
	self:RemoveListener()
	LibraryNewsPaperCell.DisposeIn(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibraryNewsListView
