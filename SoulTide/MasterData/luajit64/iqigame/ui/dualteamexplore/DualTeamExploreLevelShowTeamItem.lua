-- chunkname: @IQIGame\\UI\\DualTeamExplore\\DualTeamExploreLevelShowTeamItem.lua

local DualTeamExploreLevelUIDollCell = require("IQIGame.UI.DualTeamExplore.DualTeamExploreLevelUIDollCell")
local m = {
	Index = 0,
	DollCells = {}
}

function m.New(view, index, cellPrefab)
	local obj = Clone(m)

	obj:Init(view, index, cellPrefab)

	return obj
end

function m:Init(view, index, cellPrefab)
	self.View = view
	self.Index = index

	LuaCodeInterface.BindOutlet(self.View, self)

	for cellIndex = 1, 5 do
		local teamIndex = index
		local cell = DualTeamExploreLevelUIDollCell.New(UnityEngine.Object.Instantiate(cellPrefab), teamIndex, cellIndex)

		cell.View.transform:SetParent(self.DollCellGrid.transform, false)

		self.DollCells[cellIndex] = cell
	end

	UGUIUtil.SetText(self.TitleText, DualTeamExploreUICommonApi:GetString("TeamToggle_TitleText", index))
	UGUIUtil.SetText(self.OrderText, DualTeamExploreUICommonApi:GetString("TeamToggle_OrderText", index))
end

function m:Refresh()
	local teamPOD = DualTeamExploreModule.GetTeam(self.Index)

	for i = 1, #self.DollCells do
		local cell = self.DollCells[i]

		cell:SetData(teamPOD.formationInfo.soulPrefabs[i])
	end
end

function m:Dispose()
	for i = 1, #self.DollCells do
		local cell = self.DollCells[i]

		cell:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
