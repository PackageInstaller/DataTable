-- chunkname: @IQIGame\\UI\\ExploreHall\\FishingActivity\\FishingActivitySkill\\FishingActivitySkillListView.lua

local m = {
	SkillCellPool = {},
	SkillActionList = {},
	SkillActionDataList = {}
}
local FishingActivitySkillActionCell = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivitySkill.FishingActivitySkillActionCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.SkillScrollList = self.SkillList:GetComponent("ScrollAreaList")

	function self.SkillScrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:UpdateView(isRefreshPos)
	self.SkillActionDataList = FishingActivityModule.fishSkillActionDataList

	table.sort(self.SkillActionDataList, function(a, b)
		return a.cid < b.cid
	end)

	if isRefreshPos then
		self.SkillScrollList:Refresh(#self.SkillActionDataList)
	else
		self.SkillScrollList:RenderCellsDynamic(#self.SkillActionDataList)
	end
end

function m:OnRenderGridCell(cell)
	local data = self.SkillActionDataList[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.SkillCellPool[instanceID]

	if renderCell == nil then
		renderCell = FishingActivitySkillActionCell.New(cell.gameObject)
		self.SkillCellPool[instanceID] = renderCell
	end

	renderCell:SetData(data)
end

function m:Open()
	self.View:SetActive(true)
	self:AddListener()
	self:UpdateView(true)
end

function m:Close()
	self.View:SetActive(false)
	self:RemoveListener()
end

function m:Dispose()
	self:Close()

	for i, v in pairs(self.SkillCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
