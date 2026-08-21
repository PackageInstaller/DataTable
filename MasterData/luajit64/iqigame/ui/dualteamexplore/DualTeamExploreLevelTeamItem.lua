-- chunkname: @IQIGame\\UI\\DualTeamExplore\\DualTeamExploreLevelTeamItem.lua

local DualTeamExploreLevelUIDollCell = require("IQIGame.UI.DualTeamExplore.DualTeamExploreLevelUIDollCell")
local m = {
	Index = 0,
	IsActive = false,
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

	function self.DelegateOnClickSelectBtn()
		self:OnClickSelectBtn()
	end

	for cellIndex = 1, 5 do
		local teamIndex = index
		local cell = DualTeamExploreLevelUIDollCell.New(UnityEngine.Object.Instantiate(cellPrefab), teamIndex, cellIndex)

		cell.View.transform:SetParent(self.DollCellGrid.transform, false)

		self.DollCells[cellIndex] = cell
	end

	UGUIUtil.SetText(self.TitleText, DualTeamExploreUICommonApi:GetString("TeamToggle_TitleText", index))

	local toggleHelper = self.View:GetComponent(typeof(IQIGame.Onigao.Game.ToggleHelperComponent))

	toggleHelper.text = DualTeamExploreUICommonApi:GetString("TeamToggle_OrderText", index)

	UGUIUtil.SetTextInChildren(self.InActiveFlag, DualTeamExploreUICommonApi:GetString("TeamToggle_InActiveFlagText", index))
	self:AddListeners()
end

function m:AddListeners()
	self.SelectBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelectBtn)
end

function m:RemoveListeners()
	self.SelectBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelectBtn)
end

function m:SetData(currentTeamIndex, isActive)
	self.IsActive = isActive

	local toggleCom = self.View:GetComponent("Toggle")

	toggleCom.isOn = self.Index == currentTeamIndex

	self.InActiveFlag:SetActive(not isActive)

	toggleCom.interactable = isActive

	local teamPOD = DualTeamExploreModule.GetTeam(self.Index)

	for i = 1, #self.DollCells do
		local cell = self.DollCells[i]

		cell:SetData(teamPOD.formationInfo.soulPrefabs[i])
	end
end

function m:OnClickSelectBtn()
	if not self.IsActive then
		return
	end

	local toggleCom = self.View:GetComponent("Toggle")

	if not toggleCom.isOn then
		toggleCom.isOn = true
	end
end

function m:IsSelect()
	local toggleCom = self.View:GetComponent("Toggle")

	return toggleCom.isOn
end

function m:Dispose()
	self:RemoveListeners()

	for i = 1, #self.DollCells do
		local cell = self.DollCells[i]

		cell:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
