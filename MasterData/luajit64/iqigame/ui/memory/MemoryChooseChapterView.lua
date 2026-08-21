-- chunkname: @IQIGame\\UI\\Memory\\MemoryChooseChapterView.lua

local MemoryChooseChapterView = {}
local MemoryChapterCell = require("IQIGame.UI.Memory.MemoryChapterCell")

function MemoryChooseChapterView.__New(ui, parent)
	local o = Clone(MemoryChooseChapterView)

	o:OnInit(ui, parent)

	return o
end

function MemoryChooseChapterView:OnInit(uiObj, parent)
	self.parent = parent
	self.goView = uiObj

	LuaCodeInterface.BindOutlet(uiObj, self)

	self.scrollPageList = uiObj:GetComponent("ScrollAreaListPage")

	function self.scrollPageList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.scrollPageList.onPageReachedMainPos(page)
		self:OnPageReachedMain(page)
	end

	self:OnAddListeners()
end

function MemoryChooseChapterView:OnAddListeners()
	return
end

function MemoryChooseChapterView:OnRemoveListeners()
	return
end

function MemoryChooseChapterView:UpdateView()
	self.chapterList = {}

	for i, v in pairsCfg(CfgSoulMemoryChapterTable) do
		if v.SoulId == MemoryModule.currentSoulID then
			table.insert(self.chapterList, v)
		end
	end

	table.sort(self.chapterList, function(tb1, tb2)
		return tb1.Id < tb2.Id
	end)

	local startIndex = 0

	for i = 1, #self.chapterList do
		local cfgData = self.chapterList[i]

		if MemoryModule.currentSoulChapterInfo.cid == cfgData.Id then
			startIndex = i - 1
		end
	end

	local endIndex = 0
	local haveList = MemoryModule.arrMemoryChapterInfoList

	for i, v in pairs(haveList) do
		if v.isGetReward then
			endIndex = endIndex + 1
		end
	end

	if endIndex < startIndex then
		endIndex = startIndex
	end

	local num = #MemoryModule.arrMemoryChapterInfoList

	if num <= endIndex and num > 0 then
		endIndex = num - 1
	end

	self.scrollPageList.startIndex = startIndex
	self.scrollPageList.stopIndex = endIndex

	self.scrollPageList:Refresh(#self.chapterList)
end

function MemoryChooseChapterView:OnRenderGridCell(cell)
	local item = cell.gameObject
	local itemCell = MemoryChapterCell.PackageOrReuseView(self, item)
	local cfgMemoryChapter = self.chapterList[cell.index + 1]
	local isOpen = #MemoryModule.arrMemoryChapterInfoList >= cell.index + 1

	itemCell:SetData(cfgMemoryChapter, isOpen)

	if MemoryModule.currentSoulChapterInfo.cid == cfgMemoryChapter.Id then
		itemCell:SelectType(true)
		UGUIUtil.SetText(self.parent.TextLvNow, cfgMemoryChapter.Order)
		UGUIUtil.SetText(self.parent.TextNameNow, cfgMemoryChapter.Name)
	else
		itemCell:SelectType(false)
	end
end

function MemoryChooseChapterView:OnPageReachedMain(page)
	local item = page.gameObject
	local itemCell = MemoryChapterCell.PackageOrReuseView(self, item)
	local cfgMemoryChapter = self.chapterList[page.index + 1]
	local isOpen = #MemoryModule.arrMemoryChapterInfoList >= page.index + 1

	if isOpen then
		if MemoryModule.currentSoulChapterInfo.cid ~= cfgMemoryChapter.Id then
			self:UnselectedHeadCells()
			itemCell:SelectType(true)

			MemoryModule.currentSouldChapterIndex = page.index + 1
			MemoryModule.currentSoulChapterInfo = MemoryModule.arrMemoryChapterInfoList[page.index + 1]

			EventDispatcher.Dispatch(EventID.MemoryCurrentChapterChangedEvent)
		end
	else
		local nextIndex = page.index + 1

		if nextIndex >= #self.chapterList then
			nextIndex = #self.chapterList
		end
	end

	UGUIUtil.SetText(self.parent.TextLvNow, cfgMemoryChapter.Order)
	UGUIUtil.SetText(self.parent.TextNameNow, cfgMemoryChapter.Name)
	self.parent:SetMemoryChapterMsg(cfgMemoryChapter)
end

function MemoryChooseChapterView:UnselectedHeadCells()
	if self.__SUB_UI_MAP_MemoryChapterCell then
		for i, v in pairs(self.__SUB_UI_MAP_MemoryChapterCell) do
			v:SelectType(false)
		end
	end
end

function MemoryChooseChapterView:OnDestroy()
	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return MemoryChooseChapterView
