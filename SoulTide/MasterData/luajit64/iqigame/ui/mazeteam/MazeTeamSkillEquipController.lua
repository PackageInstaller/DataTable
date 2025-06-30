-- chunkname: @IQIGame\\UI\\MazeTeam\\MazeTeamSkillEquipController.lua

local m = {}

function m.New(view, skillPrefab, equipPrefab)
	local obj = Clone(m)

	obj:Init(view, skillPrefab, equipPrefab)

	return obj
end

function m:Init(view, skillPrefab, equipPrefab)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.SkillCells = {}

	for i = 1, 4 do
		local skillCellView = UnityEngine.Object.Instantiate(skillPrefab)

		skillCellView.transform:SetParent(self.SkillGrid.transform, false)

		local skillCell = SkillCell.New(skillCellView)

		self.SkillCells[i] = skillCell
	end

	self.EquipCells = {}

	for i = 1, 3 do
		local equipCellView = UnityEngine.Object.Instantiate(equipPrefab)

		equipCellView.transform:SetParent(self.EquipGrid.transform, false)

		local equipCell = EquipCell.New(equipCellView)

		self.EquipCells[i] = equipCell
	end

	self:AddEventListeners()
end

function m:AddEventListeners()
	return
end

function m:RemoveEventListeners()
	return
end

function m:SetData(dollPOD)
	self.MazeDollPOD = dollPOD

	local filteredInitSkills = SkillModule.FilterSkillsByShowType(dollPOD.initSkills, Constant.Skill.SHOW_TYPE_OPTIONAL_SP_SKILL, true)

	for i = 1, #self.SkillCells do
		local skillCell = self.SkillCells[i]
		local skillCid = filteredInitSkills[i]

		if skillCid == nil then
			skillCid = 0
		end

		skillCell:SetSkill(skillCid, nil, dollPOD.allSkillStrengthens)
	end

	local equipMap = MazeDataModule.GetWearingEquipMap(dollPOD.soulCid)

	for i = 1, #self.EquipCells do
		local equipCell = self.EquipCells[i]
		local itemData = equipMap[i]

		equipCell:Refresh(itemData)
	end
end

function m:Dispose()
	self:RemoveEventListeners()

	for i = 1, #self.SkillCells do
		local skillCell = self.SkillCells[i]

		skillCell:Dispose()
	end

	for i = 1, #self.EquipCells do
		local equipCell = self.EquipCells[i]

		equipCell:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.MazeDollPOD = nil
end

return m
