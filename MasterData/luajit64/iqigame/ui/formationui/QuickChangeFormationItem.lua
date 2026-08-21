-- chunkname: @IQIGame\\UI\\FormationUI\\QuickChangeFormationItem.lua

local m = {
	Index = 0
}
local FormationSoulHeadCell = require("IQIGame.UI.FormationUI.FormationSoulHeadCell")

function m.New(view, onClick)
	local obj = Clone(m)

	obj:Init(view, onClick)

	return obj
end

function m:Init(view, onClick)
	self.View = view
	self.OnClickCallback = onClick

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClick()
		self:OnClick()
	end

	self.SoulHeadCells = {}

	for i = 1, 5 do
		local cell = FormationSoulHeadCell.New(UnityEngine.Object.Instantiate(self.SoulHeadPrefab))

		cell.View.transform:SetParent(self.SoulHeadGrid.transform, false)

		self.SoulHeadCells[i] = cell
	end

	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
end

function m:SetData(formationPOD, index, currentIndex)
	self.Index = index

	UGUIUtil.SetText(self.OrderText1, tostring(self.Index))
	UGUIUtil.SetText(self.OrderText2, tostring(self.Index))

	local name = FormationUIApi:GetString("DefaultFormationName", self.Index, formationPOD.name)

	UGUIUtil.SetText(self.NameText1, name)
	UGUIUtil.SetText(self.NameText2, name)

	local soulList = {}

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		soulList[prefabIndex] = prefabId
	end

	local power = 0

	for i = 1, #self.SoulHeadCells do
		local cell = self.SoulHeadCells[i]
		local prefabId = soulList[i]
		local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)
		local soulData

		if soulPrefabData.soulCid ~= nil then
			soulData = SoulModule.GetSoulData(soulPrefabData.soulCid)
		end

		cell:SetData(soulData)

		power = power + soulPrefabData.power
	end

	UGUIUtil.SetText(self.PowerText1, tostring(power))
	UGUIUtil.SetText(self.PowerText2, tostring(power))
	self:SetIsCurrent(self.Index == currentIndex)
end

function m:OnClick()
	if self.OnClickCallback ~= nil then
		self.OnClickCallback(self.Index)
	end
end

function m:SetIsCurrent(value)
	self.NormalView:SetActive(not value)
	self.CurrentView:SetActive(value)

	local position = self.SoulHeadGrid.transform.anchoredPosition

	if value then
		position.x = 194
	else
		position.x = 220
	end

	self.SoulHeadGrid.transform.anchoredPosition = position
end

function m:Dispose()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)

	for i = 1, #self.SoulHeadCells do
		local item = self.SoulHeadCells[i]

		item:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
