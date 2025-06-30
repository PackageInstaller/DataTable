-- chunkname: @IQIGame\\UI\\Memory\\MemoryNewStoryChapterView.lua

local MemoryNewStoryChapterView = {
	isOpen = false
}
local MemoryNewStoryChapterItem = require("IQIGame.UI.Memory.MemoryNewStoryChapterItem")

function MemoryNewStoryChapterView.__New(parent, ui)
	local o = Clone(MemoryNewStoryChapterView)

	o:InitView(parent, ui)

	return o
end

function MemoryNewStoryChapterView:InitView(parent, ui)
	self.parentUI = parent
	self.rootUI = ui

	self.rootUI:SetActive(false)
	LuaCodeInterface.BindOutlet(self.rootUI, self)

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateOnMemoryLockReady()
		self:OnMemoryLockReady()
	end
end

function MemoryNewStoryChapterView:AddEventListener()
	self.BtnCloseBack:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	EventDispatcher.AddEventListener(EventID.MemoryStoryChapterDataRefreshEvent, self.delegateOnMemoryLockReady)
end

function MemoryNewStoryChapterView:RemoveEventListener()
	self.BtnCloseBack:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	EventDispatcher.RemoveEventListener(EventID.MemoryStoryChapterDataRefreshEvent, self.delegateOnMemoryLockReady)
end

function MemoryNewStoryChapterView:Dispose()
	AssetUtil.UnloadAsset(self)

	if self.chapterItems then
		for i, v in pairs(self.chapterItems) do
			v:DisPose()
		end
	end

	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function MemoryNewStoryChapterView:OnMemoryLockReady()
	if self.newStoryInfo then
		local storyInfo = MemoryNewModule.dictMemoryStoryInfo[self.newStoryInfo.cid]

		self:UpDateView(storyInfo)
	end
end

function MemoryNewStoryChapterView:UpDateView(newStoryInfo)
	self.newStoryInfo = newStoryInfo

	if self.newStoryInfo then
		self.chapterName:GetComponent("Text").text = self.newStoryInfo.cfgSoulNewStory.Name

		local imgPath = UIGlobalApi.GetImagePath(self.newStoryInfo.cfgSoulNewStory.InsideImage)

		AssetUtil.LoadImage(self, imgPath, self.chapterInIcon:GetComponent("Image"))

		self.chapterInIcon.transform.anchoredPosition = Vector2(self.newStoryInfo.cfgSoulNewStory.InsideImagePosition[1], self.newStoryInfo.cfgSoulNewStory.InsideImagePosition[2])
		self.chapterInIcon.transform.sizeDelta = Vector2.New(self.newStoryInfo.cfgSoulNewStory.InsideImageSize[1], self.newStoryInfo.cfgSoulNewStory.InsideImageSize[2])

		if self.chapterItems then
			for i, v in pairs(self.chapterItems) do
				v:DisPose()
				UnityEngine.GameObject.DestroyImmediate(v.goView)
			end
		end

		self.chapterItems = {}

		local parentTransform = self.chapterContent.transform
		local num, totalNum = self.newStoryInfo:GetChapterData()

		for i = 1, totalNum do
			local obj = UnityEngine.Object.Instantiate(self.Mould)

			obj:SetActive(true)
			obj.transform:SetParent(parentTransform, false)

			local chapterItem = MemoryNewStoryChapterItem:__New(obj)

			chapterItem:RefreshUI(self.newStoryInfo, i)
			table.insert(self.chapterItems, chapterItem)
		end
	end
end

function MemoryNewStoryChapterView:OnBtnClose()
	self.parentUI.ScrollArea:SetActive(true)
	self:Close()
end

function MemoryNewStoryChapterView:Open()
	self.rootUI:SetActive(true)
	self:AddEventListener()

	self.isOpen = true
end

function MemoryNewStoryChapterView:Close()
	self.rootUI:SetActive(false)
	self:RemoveEventListener()

	self.selectObj = nil
	self.isOpen = false
end

return MemoryNewStoryChapterView
