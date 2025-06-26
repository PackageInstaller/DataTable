-- chunkname: @IQIGame\\UI\\Memory\\MemoryNewStoryScrollItem.lua

local MemoryNewStoryScrollItem = {
	state = 3
}

function MemoryNewStoryScrollItem.PackageOrReuseView(ui, memoryNewStoryView)
	if ui == nil or memoryNewStoryView == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_StoryScrollItemCell == nil then
		ui.__SUB_UI_MAP_StoryScrollItemCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_StoryScrollItemCell
	local storyScrollItem

	if subUIMap[memoryNewStoryView:GetInstanceID()] == nil then
		storyScrollItem = MemoryNewStoryScrollItem:__New(memoryNewStoryView)
		subUIMap[memoryNewStoryView:GetInstanceID()] = storyScrollItem
	else
		storyScrollItem = subUIMap[memoryNewStoryView:GetInstanceID()]
	end

	return storyScrollItem
end

function MemoryNewStoryScrollItem:__New(memoryNewStoryView)
	local itemCell = Clone(self)

	itemCell:InitView(memoryNewStoryView)

	return itemCell
end

function MemoryNewStoryScrollItem:InitView(memoryNewStoryView)
	self.goView = memoryNewStoryView

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.btnSelf = self.goView:GetComponent("Button")

	function self.delegateClickBtnSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function MemoryNewStoryScrollItem.DisposeIn(ui)
	if ui.__SUB_UI_MAP_StoryScrollItemCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_StoryScrollItemCell) do
		itemCell:DisPose()
	end

	ui.__SUB_UI_MAP_StoryScrollItemCell = nil
end

function MemoryNewStoryScrollItem:AddListener()
	self.btnSelf.onClick:AddListener(self.delegateClickBtnSelf)
end

function MemoryNewStoryScrollItem:RemoveListener()
	self.btnSelf.onClick:RemoveListener(self.delegateClickBtnSelf)
end

function MemoryNewStoryScrollItem:OnBtnSelf()
	local soulData = SoulModule.GetSoulData(self.newStoryInfo.cfgSoulNewStory.SoulId)

	if soulData.favorLv < self.newStoryInfo.cfgSoulNewStory.UnlockFavorDegreeLevel then
		NoticeModule.ShowNoticeByType(1, self.newStoryInfo.cfgSoulNewStory.UnlockFavorDescribe)

		return
	end

	if not self.newStoryInfo.isUnlocked then
		NoticeModule.ShowNoticeByType(1, self.newStoryInfo.cfgSoulNewStory.UnlockDescribe)

		return
	end

	if self.newStoryInfo.cfgSoulNewStory.Type == 3 then
		EventDispatcher.Dispatch(EventID.OpenNewMemoryChildPanel, self.newStoryInfo)
	else
		local isLook = self.newStoryInfo:IsLook(1)

		if self.clickCallBack then
			self.clickCallBack(self.newStoryInfo, isLook)
		end
	end
end

function MemoryNewStoryScrollItem:RefreshUI(storyInfo)
	self.newStoryInfo = storyInfo

	self.Effect:SetActive(false)

	if self.newStoryInfo then
		UGUIUtil.SetText(self.TextLock, NewMemoryUIApi:GetString("TextLock"))
		self.goView:SetActive(true)
		self.goView:GetComponent("ImageGroupGrayComponent"):EnableGray(not self.newStoryInfo.isUnlocked)

		self.TextLv:GetComponent("Text").text = tostring(storyInfo.cfgSoulNewStory.UnlockFavorDegreeLevel)

		local path = UIGlobalApi.ImagePath .. storyInfo.cfgSoulNewStory.Icon

		AssetUtil.LoadImage(self, path, self.Img:GetComponent("Image"))

		local isLook = self.newStoryInfo:IsLook(1)

		self.NewOpen:SetActive(false)
		self.ImgSpend:SetActive(isLook)

		local isClose = not self.newStoryInfo.isUnlocked or isLook

		self.Tag:SetActive(not isClose)
		self.Locked:SetActive(isClose)

		if isClose then
			self.state = 3
		else
			self.state = 1
		end

		local storyState = self.newStoryInfo:StoryState()

		if storyState == 2 and MemoryNewModule.isCurrentOpen == false then
			MemoryNewModule.isCurrentOpen = true

			self.Effect:SetActive(true)
			self.Tag:SetActive(false)
			self.Locked:SetActive(false)
		end
	else
		self:Clear()
	end
end

function MemoryNewStoryScrollItem:Clear()
	self.goView:SetActive(false)
end

function MemoryNewStoryScrollItem:DisPose()
	self:RemoveListener()

	self.clickCallBack = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.testCallBack = nil

	UnityEngine.Object.Destroy(self.goView)

	self.goView = nil
end

return MemoryNewStoryScrollItem
