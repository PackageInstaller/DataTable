-- chunkname: @IQIGame\\UI\\FormationUI\\FormationChooseSoulTabBtn.lua

local m = {
	IsCurrent = false,
	PrefabIndex = false
}
local FormationChooseSoulSubTabBtn = require("IQIGame.UI.FormationUI.FormationChooseSoulSubTabBtn")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.SubViewController1 = FormationChooseSoulSubTabBtn.New(self.OffView)
	self.SubViewController2 = FormationChooseSoulSubTabBtn.New(self.OnView)
end

function m:SetData(soulData, formationIndex, currentPrefabId)
	self.SoulData = soulData

	local curPrefab = SoulPrefabModule.GetPrefab(currentPrefabId)

	self.IsCurrent = curPrefab.soulCid == soulData.soulCid
	self.PrefabIndex = 0

	local formationPOD = FormationModule.GetFormationByIndex(formationIndex)

	for prefabId, prefabIndex in pairs(formationPOD.formation) do
		local soulPrefabData = SoulPrefabModule.GetPrefab(prefabId)

		if soulPrefabData.soulCid == soulData.soulCid then
			self.PrefabIndex = prefabIndex

			break
		end
	end

	self.SubViewController1:SetData(soulData, self.IsCurrent, self.PrefabIndex ~= 0)
	self.SubViewController2:SetData(soulData, self.IsCurrent, self.PrefabIndex ~= 0)
end

function m:SetSelect(value)
	self.View:GetComponent("Toggle").isOn = value
end

function m:Dispose()
	self.SubViewController1:Dispose()
	self.SubViewController2:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
