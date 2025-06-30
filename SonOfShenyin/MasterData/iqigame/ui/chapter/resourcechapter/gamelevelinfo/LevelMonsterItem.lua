-- chunkname: @IQIGame\\UI\\Chapter\\ResourceChapter\\GameLevelInfo\\LevelMonsterItem.lua

local m = {}

function m.PackageOrReuseView(ui, view)
	if ui == nil or view == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_SelectMonsterItemCell == nil then
		ui.__SUB_UI_MAP_SelectMonsterItemCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_SelectMonsterItemCell
	local itemCell

	if subUIMap[view:GetInstanceID()] == nil then
		itemCell = m.New(view)
		subUIMap[view:GetInstanceID()] = itemCell
	else
		itemCell = subUIMap[view:GetInstanceID()]
	end

	return itemCell
end

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(monsterID)
	self.MonsterCfg = CfgMonsterTable[monsterID]

	local path = BattleApi:GetMonsterHeadIconPath(self.MonsterCfg.HeadIcon)

	self:LoadImg(path, self.EnemyImg)

	if self.MonsterCfg.Elements == 0 or self.MonsterCfg.Elements == nil then
		self.ElementImg:SetActive(false)
	else
		self.ElementImg:SetActive(true)

		path = WarlockApi:GetElementIconPath(self.MonsterCfg.Elements)

		self:LoadImg(path, self.ElementImg)
	end

	path = WarlockApi:GetProfessionIconPath(self.MonsterCfg.Profession)

	self:LoadImg(path, self.ProfessionImg)
end

function m:LoadImg(path, obj)
	AssetUtil.LoadImage(self, path, obj:GetComponent("Image"))
end

function m:OnClickCell()
	self:OnSelected()
end

function m:OnSelected()
	self.SelectImg:SetActive(true)
end

function m:OnUnselected()
	self.SelectImg:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
