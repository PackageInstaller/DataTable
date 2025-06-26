-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkDetail\\AmusementParkDetailStoryView.lua

local m = {
	storyData = {},
	storyRenderPool = {}
}
local AmusementParkDetailStoryRender = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkDetail.AmusementParkDetailStoryRender")

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

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderCell(cell)
	end
	self.ScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectedCell(cell)
	end
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
	self.storyData = AmusementParkModule.AmusementParkInfoPOD.plot or {}

	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.storyData)
end

function m:OnRenderCell(cell)
	local data = self.storyData[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.storyRenderPool[instanceID]

	if renderCell == nil then
		renderCell = AmusementParkDetailStoryRender.New(cell.gameObject)
		self.storyRenderPool[instanceID] = renderCell
	end

	renderCell:SetData(data)
end

function m:OnSelectedCell(cell)
	local data = self.storyData[cell.index + 1]

	DialogModule.OpenDialog(CfgAmusementParkEventControlTable[data].Parameter, false, false)
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
	for i, v in pairs(self.storyRenderPool) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
