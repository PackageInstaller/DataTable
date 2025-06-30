-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameFormation\\PlaceGameQuickFormationItemCell.lua

local m = {
	Index = 0
}
local PlaceGameFormationSoulHeadCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormation.PlaceGameFormationSoulHeadCell")

function m.New(view, onClick)
	local obj = Clone(m)

	obj:Init(view, onClick)

	return obj
end

function m:Init(view, onclick)
	self.View = view
	self.OnClickCallback = onclick

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClick()
		self:OnClick()
	end

	self.SoulHeadCells = {}

	for i = 1, 5 do
		local cell = PlaceGameFormationSoulHeadCell.New(UnityEngine.Object.Instantiate(self.SoulHeadPrefab))

		cell:ShowFrameBG(false, false)
		cell.placeGameSoulHeadCell:SetMouseEnabled(false)
		cell.View.transform:SetParent(self.SoulHeadGrid.transform, false)

		self.SoulHeadCells[i] = cell
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
end

function m:SetData(formationPOD, index, currentIndex)
	self.Index = index

	UGUIUtil.SetText(self.OrderText1, tostring(self.Index))
	UGUIUtil.SetText(self.OrderText2, tostring(self.Index))

	local name = PlaceGameChallengeDetailUIApi:GetString("DefaultFormationName", self.Index, formationPOD.name)

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
		local soulPrefabData = PlaceGameModule.GetPlaceGameSoulPrefabDataByID(prefabId)
		local soulData

		if tonumber(soulPrefabData.placeGameSoulPrefabPOD.soulCid) > 0 then
			soulData = PlaceGameModule.GetPlaceGameSoulDataByCid(soulPrefabData.placeGameSoulPrefabPOD.soulCid)
		end

		cell:SetData(soulData)

		power = power + soulPrefabData.placeGameSoulPrefabPOD.power
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
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.SoulHeadCells) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
