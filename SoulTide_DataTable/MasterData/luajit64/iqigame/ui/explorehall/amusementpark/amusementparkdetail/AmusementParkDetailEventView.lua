-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkDetail\\AmusementParkDetailEventView.lua

local m = {
	eventRenders = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local AmusementParkDetailEventRender = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkDetail.AmusementParkDetailEventRender")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnClose()
		self:OnBtnClose()
	end

	self.EventMould:SetActive(false)

	self.eventRenderPool = UIObjectPool.New(50, function()
		return AmusementParkDetailEventRender.New(UnityEngine.Object.Instantiate(self.EventMould))
	end, function(cell)
		cell:Dispose()
	end)
end

function m:AddListener()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateBtnClose)
end

function m:RemoveListener()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnClose)
end

function m:UpdateView()
	for i, v in pairs(self.eventRenders) do
		self.eventRenderPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
	end

	self.eventRenders = {}

	local events = {}

	if AmusementParkModule.DailyDupPOD.amusementParkPOD then
		events = AmusementParkModule.DailyDupPOD.amusementParkPOD.event or {}
	end

	table.sort(events, function(a, b)
		return a.date > b.date
	end)

	for i = 1, #events do
		local eventData = events[i]
		local render = self.eventRenderPool:Obtain()

		render.View:SetActive(true)
		render.View.transform:SetParent(self.EventSort.transform, false)
		render:SetData(eventData)
		table.insert(self.eventRenders, render)
	end
end

function m:OnBtnClose()
	self:Close()
end

function m:Open()
	self.View:SetActive(true)
	self:AddListener()
	self:UpdateView()
end

function m:Close()
	self.View:SetActive(false)
	self:RemoveListener()
end

function m:Dispose()
	for i, v in pairs(self.eventRenders) do
		self.eventRenderPool:Release(v)
	end

	self.eventRenders = {}

	self.eventRenderPool:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
