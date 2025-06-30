-- chunkname: @IQIGame\\UI\\Memory\\MemoryNewStoryScrollPage.lua

local MemoryNewStoryScrollPage = {}
local MemoryNewStoryScrollItem = require("IQIGame.UI.Memory.MemoryNewStoryScrollItem")

function MemoryNewStoryScrollPage.PackageOrReuseView(ui, memoryNewStoryView)
	if ui == nil or memoryNewStoryView == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_StoryScrollPageCell == nil then
		ui.__SUB_UI_MAP_StoryScrollPageCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_StoryScrollPageCell
	local storyScrollItem

	if subUIMap[memoryNewStoryView:GetInstanceID()] == nil then
		storyScrollItem = MemoryNewStoryScrollPage:__New(ui, memoryNewStoryView)
		subUIMap[memoryNewStoryView:GetInstanceID()] = storyScrollItem
	else
		storyScrollItem = subUIMap[memoryNewStoryView:GetInstanceID()]
	end

	return storyScrollItem
end

function MemoryNewStoryScrollPage:__New(ui, memoryNewStoryView)
	local itemCell = Clone(self)

	itemCell:InitView(ui, memoryNewStoryView)

	return itemCell
end

function MemoryNewStoryScrollPage:InitView(ui, memoryNewStoryView)
	self.goView = memoryNewStoryView
	self.parentUI = ui

	LuaCodeInterface.BindOutlet(self.goView, self)
end

function MemoryNewStoryScrollPage.DisposeIn(ui)
	if ui.__SUB_UI_MAP_StoryScrollPageCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_StoryScrollPageCell) do
		itemCell:DisPose()
	end

	ui.__SUB_UI_MAP_StoryScrollPageCell = nil
end

function MemoryNewStoryScrollPage:RefreshUI(storyInfoTab)
	self.newStoryInfoPageTab = storyInfoTab
	self.ImgPre:GetComponent("Image").fillAmount = 0

	if self.newStoryInfoPageTab then
		local parentTransform = self.Module.transform

		for j = 1, parentTransform.childCount do
			local obj = parentTransform:GetChild(j - 1).gameObject

			obj:SetActive(false)
		end

		for i = 1, #self.newStoryInfoPageTab do
			local storyInfo = self.newStoryInfoPageTab[i]
			local soulData = SoulModule.GetSoulData(storyInfo.cfgSoulNewStory.SoulId)

			if soulData.favorLv >= storyInfo.cfgSoulNewStory.UnlockFavorDegreeLevel then
				if i == #self.newStoryInfoPageTab then
					self.ImgPre:GetComponent("Image").fillAmount = 1
				else
					self.ImgPre:GetComponent("Image").fillAmount = storyInfo.cfgSoulNewStory.ProgressPosition
				end
			end

			local mould

			if storyInfo.cfgSoulNewStory.Type == 1 then
				mould = self.parentUI.Mould1
			elseif storyInfo.cfgSoulNewStory.Type == 2 then
				mould = self.parentUI.Mould2
			elseif storyInfo.cfgSoulNewStory.Type == 3 then
				mould = self.parentUI.Mould3
			end

			local goObj

			if i <= parentTransform.childCount then
				goObj = parentTransform:GetChild(i - 1).gameObject

				goObj:SetActive(true)
			end

			if goObj == nil then
				goObj = UnityEngine.Object.Instantiate(mould)

				goObj.transform:SetParent(parentTransform, false)
			end

			goObj.transform.anchoredPosition = Vector3.New(storyInfo.cfgSoulNewStory.ButtonPosition[1], storyInfo.cfgSoulNewStory.ButtonPosition[2], storyInfo.cfgSoulNewStory.ButtonPosition[3])

			local scrollItem = MemoryNewStoryScrollItem.PackageOrReuseView(self, goObj)

			scrollItem:RefreshUI(storyInfo)
		end
	else
		self:Clear()
	end
end

function MemoryNewStoryScrollPage:Clear()
	self.goView:SetActive(false)
end

function MemoryNewStoryScrollPage:DisPose()
	MemoryNewStoryScrollItem.DisposeIn(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return MemoryNewStoryScrollPage
