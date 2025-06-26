-- chunkname: @IQIGame\\UI\\DualTeamExplore\\DualTeamExploreLevelEntryBossCell.lua

local m = {
	WeakCells = {}
}

function m.New(view, refBossPool)
	local obj = Clone(m)

	obj:Init(view, refBossPool)

	return obj
end

function m:Init(view, refBossPool)
	self.View = view
	self.RefBossPool = refBossPool

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.MainWeakLabel, DualTeamExploreLevelEntryUIApi:GetString("LevelCell_BossView_MainWeakLabel"))
end

function m:SetData(bossCid, weakTypes)
	self.View:SetActive(bossCid ~= 0)

	if bossCid == 0 then
		return
	end

	local cfgDualTeamExploreBossData = CfgDualTeamExploreBossTable[bossCid]

	UGUIUtil.SetText(self.MonsterNameText, cfgDualTeamExploreBossData.Describe)

	local bossCfgData = CfgMonsterTable[cfgDualTeamExploreBossData.Monster]

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(bossCfgData.HeadIcon), self.MonsterIcon:GetComponent("Image"))
	self:ClearWeakCells()

	for i = 1, #weakTypes do
		local weakType = weakTypes[i]
		local cell = self.RefBossPool:Obtain()

		cell:SetActive(true)
		cell.transform:SetParent(self.WeakGrid.transform, false)
		AssetUtil.LoadImage(self, MiscApi:GetString("SoulDamageTypeIcon", weakType, true), cell:GetComponentInChildren(typeof(UnityEngine.UI.Image)))

		self.WeakCells[i] = cell
	end
end

function m:ClearWeakCells()
	for i = 1, #self.WeakCells do
		local cell = self.WeakCells[i]

		cell.transform:SetParent(self.View.transform, false)
		cell:SetActive(false)
		self.RefBossPool:Release(cell)
	end

	self.WeakCells = {}
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:ClearWeakCells()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.RefBossPool = nil
end

return m
