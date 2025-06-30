-- chunkname: @IQIGame\\UI\\Memory\\MemoryNewAlertView.lua

local MemoryNewAlertView = {
	ItemCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function MemoryNewAlertView.New(view)
	local obj = Clone(MemoryNewAlertView)

	obj:Init(view)

	return obj
end

function MemoryNewAlertView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.CommonSlot:SetActive(false)

	self.ItemCellPool = UIObjectPool.New(10, function()
		return ItemCell.New(UnityEngine.Object.Instantiate(self.CommonSlot))
	end, function(cell)
		local view = cell.ViewGo

		cell:Dispose()
		UnityEngine.Object.Destroy(view)
	end)

	UGUIUtil.SetText(self.TextReward, NewMemoryUIApi:GetString("TextReward"))
	UGUIUtil.SetText(self.TextClose, NewMemoryUIApi:GetString("TextClose"))
	UGUIUtil.SetText(self.TextBtnReview, NewMemoryUIApi:GetString("TextBtnReview"))
	UGUIUtil.SetText(self.TextBtnLock, NewMemoryUIApi:GetString("TextBtnLock"))

	self.btnClose = self.BtnClose:GetComponent("Button")
	self.btnLock = self.BtnLock:GetComponent("Button")
	self.btnReview = self.BtnReview:GetComponent("Button")

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnLock()
		self:OnBtnLock()
	end

	function self.delegateBtnReview()
		self:OnBtnReview()
	end

	self:AddListener()
end

function MemoryNewAlertView:AddListener()
	self.btnClose.onClick:AddListener(self.delegateBtnClose)
	self.btnLock.onClick:AddListener(self.delegateBtnLock)
	self.btnReview.onClick:AddListener(self.delegateBtnReview)
end

function MemoryNewAlertView:RemoveListener()
	self.btnClose.onClick:RemoveListener(self.delegateBtnClose)
	self.btnLock.onClick:RemoveListener(self.delegateBtnLock)
	self.btnReview.onClick:RemoveListener(self.delegateBtnReview)
end

function MemoryNewAlertView:UpdateView(data, isLock)
	self.newStoryInfo = data

	if self.newStoryInfo then
		UGUIUtil.SetText(self.TextNum, tostring(self.newStoryInfo.cfgSoulNewStory.UnlockFavorDegreeLevel))
		UGUIUtil.SetText(self.TextName, tostring(self.newStoryInfo.cfgSoulNewStory.Name))

		local soulData = SoulModule.GetSoulData(self.newStoryInfo.cfgSoulNewStory.SoulId)
		local isLv = soulData.favorLv >= self.newStoryInfo.cfgSoulNewStory.UnlockFavorDegreeLevel

		UGUIUtil.SetText(self.TextFavorLv, NewMemoryUIApi:GetString("TextFavorLv", self.newStoryInfo.cfgSoulNewStory.UnlockFavorDescribe, isLv))
		self.BtnLock:SetActive(isLock)
		self.BtnReview:SetActive(not isLock)

		local reward = self:GetReward()

		for i, v in pairs(self.ItemCells) do
			v.ViewGo:SetActive(false)
			v.ViewGo.transform:SetParent(self.View.transform, false)
			self.ItemCellPool:Release(v)
		end

		self.ItemCells = {}

		for k, num in pairs(reward) do
			local itemCell = self.ItemCellPool:Obtain()

			itemCell.ViewGo:SetActive(true)
			itemCell.ViewGo.transform:SetParent(self.RewardGrid.transform, false)
			itemCell:SetItemByCID(k, num)
			table.insert(self.ItemCells, itemCell)
		end
	end
end

function MemoryNewAlertView:GetReward()
	local rewards = {}

	for k, v in pairs(self.newStoryInfo.cfgSoulNewStory.ChapterReward) do
		for i = 1, #v, 2 do
			local id = v[i]
			local num = v[i + 1]

			if rewards[id] == nil then
				rewards[id] = num
			else
				rewards[id] = rewards[id] + num
			end
		end
	end

	local showRewards = {}

	for k, v in pairs(rewards) do
		showRewards[#showRewards + 1] = {
			id = k,
			num = v
		}
	end

	return rewards
end

function MemoryNewAlertView:OnBtnLock()
	MemoryNewModule.ExperienceNewStoryChapter(self.newStoryInfo.cid, 1)
	self:CloseUI()
end

function MemoryNewAlertView:OnBtnReview()
	MemoryNewModule.ExperienceNewStoryChapter(self.newStoryInfo.cid, 1)
	self:CloseUI()
end

function MemoryNewAlertView:OnBtnClose()
	self:CloseUI()
end

function MemoryNewAlertView:CloseUI()
	self.View:SetActive(false)
end

function MemoryNewAlertView:OpenUI()
	self.View:SetActive(true)
end

function MemoryNewAlertView:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.ItemCells) do
		self.ItemCellPool:Release(v)
	end

	self.ItemCells = {}

	self.ItemCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return MemoryNewAlertView
