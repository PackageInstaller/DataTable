-- chunkname: @IQIGame\\UI\\Memory\\MemoryNewStoryChapterItem.lua

local MemoryNewStoryChapterItem = {}

function MemoryNewStoryChapterItem.PackageOrReuseView(ui, memoryNewStoryView)
	if ui == nil or memoryNewStoryView == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_NewStoryChapterItemCell == nil then
		ui.__SUB_UI_MAP_NewStoryChapterItemCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_NewStoryChapterItemCell
	local storyScrollItem

	if subUIMap[memoryNewStoryView:GetInstanceID()] == nil then
		storyScrollItem = MemoryNewStoryChapterItem:__New(memoryNewStoryView)
		subUIMap[memoryNewStoryView:GetInstanceID()] = storyScrollItem
	else
		storyScrollItem = subUIMap[memoryNewStoryView:GetInstanceID()]
	end

	return storyScrollItem
end

function MemoryNewStoryChapterItem:__New(memoryNewStoryView)
	local itemCell = Clone(self)

	itemCell:InitView(memoryNewStoryView)

	return itemCell
end

function MemoryNewStoryChapterItem:InitView(memoryNewStoryView)
	self.goView = memoryNewStoryView

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.btnComponent = self.goView:GetComponent("Button")

	function self.delegateClickBtnSelf()
		self:OnBtnSelf()
	end

	function self.delegateAlertCall()
		self:ExperienceNewStoryChapter()
	end

	self:AddListener()
end

function MemoryNewStoryChapterItem.DisposeIn(ui)
	if ui.__SUB_UI_MAP_NewStoryChapterItemCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_NewStoryChapterItemCell) do
		itemCell:DisPose()
	end

	ui.__SUB_UI_MAP_NewStoryChapterItemCell = nil
end

function MemoryNewStoryChapterItem:AddListener()
	self.btnComponent.onClick:AddListener(self.delegateClickBtnSelf)
end

function MemoryNewStoryChapterItem:RemoveListener()
	self.btnComponent.onClick:RemoveListener(self.delegateClickBtnSelf)
end

function MemoryNewStoryChapterItem:OnBtnSelf()
	if self.state == 1 then
		NoticeModule.ShowNotice(21040114, self.delegateAlertCall, nil, self)
	elseif self.state == 2 then
		if not self.isOpenCost and self.needID ~= nil then
			NoticeModule.ShowNoticeByType(1, NewMemoryUIApi:GetString("NoticeMsg", CfgItemTable[self.needID].Name))

			return
		end

		NoticeModule.ShowNotice(21040113, self.delegateAlertCall, nil, self, self.needNum, CfgItemTable[self.needID].Name, self.newStoryInfo.cfgSoulNewStory.Name)
	elseif self.state == 3 then
		NoticeModule.ShowNoticeByType(1, NewMemoryUIApi:GetString("NoticeMsg1"))
	end
end

function MemoryNewStoryChapterItem:ExperienceNewStoryChapter()
	MemoryNewModule.ExperienceNewStoryChapter(self.newStoryInfo.cid, self.chapterIndex)
end

function MemoryNewStoryChapterItem:RefreshUI(storyInfo, index)
	self.newStoryInfo = storyInfo
	self.chapterIndex = index
	self.isOpenCost = nil
	self.state = nil

	if self.newStoryInfo then
		self.goView:SetActive(true)

		local num, totalNum = self.newStoryInfo:GetChapterData()
		local nextLook = num + 1

		if index < nextLook then
			self.state = 1

			self.lockNode:SetActive(false)
			self.unlockNode:SetActive(true)
			self.money:SetActive(false)

			self.unlockTile:GetComponent("Text").text = NewMemoryUIApi:GetString("GetChapterIndex", index)
		elseif index == nextLook then
			self.state = 2

			self.lockNode:SetActive(false)
			self.unlockNode:SetActive(true)
			self.money:SetActive(true)

			self.unlockTile:GetComponent("Text").text = NewMemoryUIApi:GetString("UnlockTile")
			self.needID = self.newStoryInfo.cfgSoulNewStory.ChapterCost[index][1]
			self.needNum = self.newStoryInfo.cfgSoulNewStory.ChapterCost[index][2]

			if self.needID ~= nil and self.needID ~= "" then
				local haveNum = WarehouseModule.GetItemNumByCfgID(self.needID)

				self.isOpenCost = haveNum >= self.needNum

				local iconPath = UIGlobalApi.GetIconPath(CfgItemTable[self.needID].Icon)

				AssetUtil.LoadImage(self, iconPath, self.moneyIcon:GetComponent("Image"))
			end

			self.moneyNum:GetComponent("Text").text = tostring(self.needNum)
		elseif nextLook < index then
			self.state = 3

			self.lockNode:SetActive(true)
			self.unlockNode:SetActive(false)
			self.money:SetActive(false)
		end

		local path = UIGlobalApi.GetImagePath(self.newStoryInfo.cfgSoulNewStory.InsideImageCg[index])

		AssetUtil.LoadImage(self, path, self.imgIcon:GetComponent("Image"))
	else
		self:Clear()
	end
end

function MemoryNewStoryChapterItem:Clear()
	self.goView:SetActive(false)
end

function MemoryNewStoryChapterItem:DisPose()
	self:RemoveListener()

	self.isOpenCost = nil
	self.needID = nil
	self.needNum = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return MemoryNewStoryChapterItem
