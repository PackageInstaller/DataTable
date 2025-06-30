-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyTask\\MonsterAcademyTaskItem.lua

local m = {
	rewardCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local monsterAcademyItemCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyBag.MonsterAcademyItemCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.RewardCellPrefab:SetActive(false)

	self.rewardCellPool = UIObjectPool.New(5, function()
		return monsterAcademyItemCell.New(UnityEngine.Object.Instantiate(self.RewardCellPrefab))
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
	self.monsterTaskData = data

	UGUIUtil.SetText(self.TitleText, self.monsterTaskData.cfgInfo.Name)
	UGUIUtil.SetText(self.NameText, self.monsterTaskData.cfgInfo.Desc)
	UGUIUtil.SetText(self.StateText, MonsterAcademyMissionUIApi:GetString("StateText", self.monsterTaskData.state))

	local path = MonsterAcademyMissionUIApi:GetString("ImgStatePath", self.monsterTaskData.state)

	AssetUtil.LoadImage(self, path, self.StateImg:GetComponent("Image"))

	for i, v in pairs(self.rewardCells) do
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		v.View:SetActive(false)
		self.rewardCellPool:Release(v)
	end

	self.rewardCells = {}

	for i = 1, #self.monsterTaskData.cfgInfo.Reward, 2 do
		local id = self.monsterTaskData.cfgInfo.Reward[i]
		local num = self.monsterTaskData.cfgInfo.Reward[i + 1]
		local cell = self.rewardCellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.RewardGrid.transform, false)
		cell:SetMonsterItemDataByID(id, num)
		cell:ShowNum(true)
		table.insert(self.rewardCells, cell)
	end
end

function m:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.rewardCells) do
		v:Dispose()
	end

	self.rewardCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
