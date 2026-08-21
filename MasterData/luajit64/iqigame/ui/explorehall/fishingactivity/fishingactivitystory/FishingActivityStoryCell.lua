-- chunkname: @IQIGame\\UI\\ExploreHall\\FishingActivity\\FishingActivityStory\\FishingActivityStoryCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnStory()
		self:OnBtnStory()
	end

	function self.DelegateBtnReview()
		self:OnBtnStory()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnStory:GetComponent("Button").onClick:AddListener(self.DelegateBtnStory)
	self.BtnReview:GetComponent("Button").onClick:AddListener(self.DelegateBtnReview)
end

function m:RemoveListener()
	self.BtnStory:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnStory)
	self.BtnReview:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnReview)
end

function m:SetData(data)
	self.fishEventData = data

	self:RefreshView()
end

function m:RefreshView()
	if self.fishEventData then
		UGUIUtil.SetText(self.TextStoryTitle, self.fishEventData:GetCfgData().Name)
		self.UnlockNode:SetActive(self.fishEventData.isUnlock)
		self.LockNode:SetActive(not self.fishEventData.isUnlock)
		self.LookNode:SetActive(self.fishEventData:CanGetReward())
		self.ReviewNode:SetActive(not self.fishEventData:CanGetReward())
	end
end

function m:OnBtnStory()
	if self.fishEventData and self.fishEventData.isUnlock then
		FishingActivityModule.OpenFishingActivityStory(self.fishEventData)
	end
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
