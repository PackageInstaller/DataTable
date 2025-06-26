-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameEvent\\PlaceGameEventItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnExecutable()
		self:OnBtnExecutable()
	end

	function self.DelegateBtnReview()
		self:OnBtnReview()
	end

	self:AddListener()
end

function m:AddListener()
	self.Executable:GetComponent("Button").onClick:AddListener(self.DelegateBtnExecutable)
	self.Review:GetComponent("Button").onClick:AddListener(self.DelegateBtnReview)
end

function m:RemoveListener()
	self.Executable:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnExecutable)
	self.Review:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnReview)
end

function m:SetData(eventData)
	self.eventData = eventData

	UGUIUtil.SetText(self.TextLock1, self.eventData:GetCfgData().Title)
	UGUIUtil.SetText(self.TextUnLock1, self.eventData:GetCfgData().Title)
	UGUIUtil.SetText(self.TextLock2, self.eventData:GetCfgData().Name)
	UGUIUtil.SetText(self.TextUnLock2, self.eventData:GetCfgData().Name)

	local completePre = self.eventData:IsCompletePrePlot()

	self.Lock:SetActive(not completePre)
	self.Unlock:SetActive(completePre)

	local eventState = self.eventData:GetEventState()

	self.RedPoint:SetActive(eventState == 1)
	self.Executable:SetActive(eventState == 1)
	self.Review:SetActive(eventState == 3)
end

function m:OnBtnExecutable()
	PlaceGameModule.OpenDialog(self.eventData.cid, false)
end

function m:OnBtnReview()
	PlaceGameModule.OpenDialog(self.eventData.cid, true)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
