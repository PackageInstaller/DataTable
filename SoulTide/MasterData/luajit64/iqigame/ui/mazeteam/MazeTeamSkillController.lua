-- chunkname: @IQIGame\\UI\\MazeTeam\\MazeTeamSkillController.lua

local m = {
	SkillGroupItems = {},
	ChangedGroupSkills = {}
}
local FormationSkillGroupItem = require("IQIGame.UI.FormationUI.FormationSkillGroupItem")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnSwitchSingleSkill(skillGroupCid, skillCids, soulData)
		self:OnSwitchSingleSkill(skillGroupCid, skillCids, soulData)
	end

	for i = 1, 3 do
		local skillGroupItem = FormationSkillGroupItem.New(UnityEngine.Object.Instantiate(self.SkillGroupPrefab), i, self.DelegateOnSwitchSingleSkill)

		skillGroupItem.View.transform:SetParent(self.SkillGroupGrid.transform, false)

		self.SkillGroupItems[i] = skillGroupItem
	end
end

function m:AddListeners()
	for i = 1, #self.SkillGroupItems do
		local item = self.SkillGroupItems[i]

		item:AddListeners()
	end
end

function m:RemoveListeners()
	for i = 1, #self.SkillGroupItems do
		local item = self.SkillGroupItems[i]

		item:RemoveListeners()
	end
end

function m:SetData(dollPOD)
	self.DollPOD = dollPOD

	local soulData = MazeDataModule.GetSoulData(dollPOD.soulCid)
	local defaultSkillGroups = soulData:GetCfgSoul().DefaultSkill
	local skillGroupIndex = table.indexOf(defaultSkillGroups, dollPOD.skillGroupId)

	if skillGroupIndex == -1 then
		logError("技能系配置错误。SoulCid: " .. dollPOD.soulCid .. " SkillGroupCid: " .. dollPOD.skillGroupId)

		skillGroupIndex = 1
	end

	for i = 1, #self.SkillGroupItems do
		local skillGroupItem = self.SkillGroupItems[i]

		skillGroupItem:SetToggleOn(i == skillGroupIndex, true)
	end

	local customSkills = self.ChangedGroupSkills[defaultSkillGroups[3]]

	if customSkills == nil and skillGroupIndex == 3 then
		customSkills = SkillModule.FilterSkillsByShowType(dollPOD.initSkills, Constant.Skill.SHOW_TYPE_OPTIONAL_SP_SKILL, true)
	end

	for i = 1, #self.SkillGroupItems do
		local item = self.SkillGroupItems[i]

		item:SetData(soulData, defaultSkillGroups[i], customSkills)
	end
end

function m:Save()
	local selectedIndex, selectedSkillGroupCid

	for i = 1, #self.SkillGroupItems do
		local item = self.SkillGroupItems[i]

		if item.IsSelected then
			selectedIndex = i
			selectedSkillGroupCid = item.SkillGroupCid

			break
		end
	end

	local changedSkillGroupId, changedSkillCids
	local soulData = MazeDataModule.GetSoulData(self.DollPOD.soulCid)
	local defaultSkillGroups = soulData:GetCfgSoul().DefaultSkill
	local originalGroup3Skills

	if self.DollPOD.skillGroupId == defaultSkillGroups[3] then
		originalGroup3Skills = SkillModule.FilterSkillsByShowType(self.DollPOD.initSkills, Constant.Skill.SHOW_TYPE_OPTIONAL_SP_SKILL, true)
	else
		local cfgSkillGroupData = CfgSkillGroupTable[defaultSkillGroups[1]]

		originalGroup3Skills = cfgSkillGroupData.GroupSkills
	end

	for skillGroupCid, skillCids in pairs(self.ChangedGroupSkills) do
		if skillGroupCid ~= defaultSkillGroups[3] then
			logError("改变的技能不属于第三系")
		else
			for i = 1, #skillCids do
				local skillCid = skillCids[i]

				if table.indexOf(originalGroup3Skills, skillCid) == -1 then
					changedSkillGroupId = skillGroupCid
					changedSkillCids = skillCids

					break
				end
			end
		end
	end

	if changedSkillGroupId ~= nil then
		MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_CHANGE_DOLL_SKILL, {
			DollId = self.DollPOD.id,
			SkillGroupId = changedSkillGroupId,
			Skills = changedSkillCids
		})
	end

	if selectedSkillGroupCid ~= self.DollPOD.skillGroupId and (changedSkillGroupId == nil or selectedSkillGroupCid ~= changedSkillGroupId) then
		local skills

		if selectedSkillGroupCid == defaultSkillGroups[3] then
			skills = originalGroup3Skills
		end

		MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_CHANGE_DOLL_SKILL, {
			DollId = self.DollPOD.id,
			SkillGroupId = selectedSkillGroupCid,
			Skills = skills
		})
	end

	self.ChangedGroupSkills = {}
end

function m:OnSwitchSingleSkill(skillGroupCid, skillCids, soulData)
	self.ChangedGroupSkills[skillGroupCid] = skillCids

	for i = 1, #self.SkillGroupItems do
		local item = self.SkillGroupItems[i]

		if item.SkillGroupCid == skillGroupCid then
			local skillStrengthens

			if soulData ~= nil then
				skillStrengthens = soulData.activationSkillStrengthen
			end

			item:SetSkills(skillCids, skillStrengthens)

			break
		end
	end
end

function m:Dispose()
	for i = 1, #self.SkillGroupItems do
		local item = self.SkillGroupItems[i]

		item:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
