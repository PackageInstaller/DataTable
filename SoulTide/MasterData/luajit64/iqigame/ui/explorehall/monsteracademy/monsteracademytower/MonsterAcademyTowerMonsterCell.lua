-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyTower\\MonsterAcademyTowerMonsterCell.lua

local m = {
	layer = 0,
	monsterTowerID = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateClickSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateClickSelf)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateClickSelf)
end

function m:SetData(data, layer)
	self.monsterTowerID = data
	self.layer = layer

	local monsterID = CfgGalgameMonstertowerTable[self.monsterTowerID].Monster
	local cfgMonsterMonster = CfgGalgameMonsterMonsterTable[monsterID]
	local path = UIGlobalApi.GetImagePath(cfgMonsterMonster.HeadIcon)

	AssetUtil.LoadImage(self, path, self.imgIcon:GetComponent("Image"))
end

function m:OnBtnSelf()
	UIModule.Open(Constant.UIControllerName.MonsterAcademyChallengeDetailUI, Constant.UILayer.UI, {
		TowerID = self.monsterTowerID,
		Layer = self.layer
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
