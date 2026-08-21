-- chunkname: @IQIGame\\UI\\ExploreHall\\FishingActivity\\FishingActivityMain\\FishingActivityMainSkillActionShowCell.lua

local m = {
	SkillActionDirCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local FishingActivitySkillActionDirCell = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivitySkillActionDirCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.SkillActionMould:SetActive(false)

	self.SkillActionDirCellPool = UIObjectPool.New(10, function()
		return FishingActivitySkillActionDirCell.New(UnityEngine.Object.Instantiate(self.SkillActionMould))
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.SkillActionData = data

	self:UpdateView()
end

function m:UpdateView()
	if self.SkillActionData then
		UGUIUtil.SetText(self.TextSkillActionName, self.SkillActionData:GetCfgData().SkillName)

		local UIController = self.View:GetComponentInParent(typeof(UIController))

		for i, v in pairs(self.SkillActionDirCells) do
			v.View:SetActive(false)
			v.View.transform:SetParent(UIController.transform, false)
			self.SkillActionDirCellPool:Release(v)
		end

		self.SkillActionDirCells = {}

		for i = 1, #self.SkillActionData:GetCfgLvData().SkillAction do
			local dir = self.SkillActionData:GetCfgLvData().SkillAction[i]
			local dirCell = self.SkillActionDirCellPool:Obtain()

			dirCell.View:SetActive(true)
			dirCell.View.transform:SetParent(self.SkillActionListNode.transform, false)
			dirCell:SetData(dir)
			table.insert(self.SkillActionDirCells, dirCell)
		end
	end
end

function m:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.SkillActionDirCells) do
		self.SkillActionDirCellPool:Release(v)
	end

	self.SkillActionDirCells = {}

	self.SkillActionDirCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
