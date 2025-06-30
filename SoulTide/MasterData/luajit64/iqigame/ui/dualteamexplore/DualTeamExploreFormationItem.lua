-- chunkname: @IQIGame\\UI\\DualTeamExplore\\DualTeamExploreFormationItem.lua

local DualTeamExploreFormationSoulHeadCell = require("IQIGame.UI.DualTeamExplore.DualTeamExploreFormationSoulHeadCell")
local m = {
	Index = 0,
	FormationIndex = 0,
	SoulCells = {}
}

function m.New(view, index, cellPrefab, onClickFormation, onClickQuickFormation)
	local obj = Clone(m)

	obj:Init(view, index, cellPrefab, onClickFormation, onClickQuickFormation)

	return obj
end

function m:Init(view, index, cellPrefab, onClickFormation, onClickQuickFormation)
	self.View = view
	self.Index = index
	self.OnClickFormationCallback = onClickFormation
	self.OnClickQuickFormationCallback = onClickQuickFormation

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickFormationUIBtn()
		self:OnClickFormationUIBtn()
	end

	function self.DelegateOnClickQuickChangeFormationUIBtn()
		self:OnClickQuickChangeFormationUIBtn()
	end

	for i = 1, 5 do
		local cell = DualTeamExploreFormationSoulHeadCell.New(UnityEngine.Object.Instantiate(cellPrefab))

		cell.View.transform:SetParent(self.SoulHeadGrid.transform, false)
		table.insert(self.SoulCells, cell)
	end

	UGUIUtil.SetText(self.FormationLabel, DualTeamExploreLevelFormationUIApi:GetString("FormationItem_FormationLabel"))
	UGUIUtil.SetText(self.OrderText, DualTeamExploreLevelFormationUIApi:GetString("FormationItem_OrderText", self.Index))
	UGUIUtil.SetTextInChildren(self.QuickChangeFormationUIBtn, DualTeamExploreLevelFormationUIApi:GetString("FormationItem_QuickBtnText", self.Index))
	self:AddListeners()
end

function m:AddListeners()
	self.FormationUIBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFormationUIBtn)
	self.QuickChangeFormationUIBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickQuickChangeFormationUIBtn)
end

function m:RemoveListeners()
	self.FormationUIBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFormationUIBtn)
	self.QuickChangeFormationUIBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickQuickChangeFormationUIBtn)
end

function m:SetData(formationIndex, otherTeamFormationIndex)
	if formationIndex == nil or formationIndex == 0 then
		self.FormationIndex = 0

		for i = 1, #self.SoulCells do
			local soulCell = self.SoulCells[i]

			soulCell:SetData(nil)
		end

		return
	end

	self.FormationIndex = formationIndex

	self:Refresh(otherTeamFormationIndex)
end

function m:Refresh(otherTeamFormationIndex)
	if self.FormationIndex == 0 then
		return
	end

	local formationPOD = FormationModule.GetFormationByIndex(self.FormationIndex)
	local prefabList = {}

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		prefabList[prefabIndex] = prefabId
	end

	local otherSoulList = {}

	if otherTeamFormationIndex ~= 0 then
		local otherFormationPOD = FormationModule.GetFormationByIndex(otherTeamFormationIndex)

		for prefabId, prefabIndex in pairs(otherFormationPOD.formation) do
			local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

			if soulPrefabData.soulCid ~= nil then
				table.insert(otherSoulList, soulPrefabData.soulCid)
			end
		end
	end

	for i = 1, #self.SoulCells do
		local soulCell = self.SoulCells[i]
		local prefabId = prefabList[i]
		local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)
		local soulData
		local isRepetitive = false

		if soulPrefabData.soulCid ~= nil then
			soulData = SoulModule.GetSoulData(soulPrefabData.soulCid)
			isRepetitive = table.indexOf(otherSoulList, soulPrefabData.soulCid) ~= -1
		end

		soulCell:SetData(soulData, isRepetitive)
	end
end

function m:OnClickFormationUIBtn()
	self.OnClickFormationCallback(self.Index)
end

function m:OnClickQuickChangeFormationUIBtn()
	self.OnClickQuickFormationCallback(self.Index)
end

function m:HasRepeat()
	for i = 1, #self.SoulCells do
		local soulCell = self.SoulCells[i]

		if soulCell:IsRepetitive() then
			return true
		end
	end

	return false
end

function m:Dispose()
	self:RemoveListeners()

	for i = 1, #self.SoulCells do
		local cell = self.SoulCells[i]

		cell:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
