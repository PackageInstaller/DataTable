-- chunkname: @IQIGame\\UI\\Formation\\FormationAgentSkillView.lua

local FormationAgentSkillView = {
	agentSkillCellList = {},
	agentSkillDataList = {}
}
local FormationAgentSkillCell = require("IQIGame.UI.Formation.ItemCell.FormationAgentSkillCell")

function FormationAgentSkillView.New(view)
	local obj = Clone(FormationAgentSkillView)

	obj:Init(view)

	return obj
end

function FormationAgentSkillView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListeners()
end

function FormationAgentSkillView:AddListeners()
	return
end

function FormationAgentSkillView:RemoveListeners()
	return
end

function FormationAgentSkillView:Refresh()
	self.agentSkillDataList = FormationModule:GetChargedAgentSkillDataList()

	local unlockConditionIDs = CfgFormationTable[FormationModule.TeamIndex].UnlockCondition

	for index, unlockConditionID in pairs(unlockConditionIDs) do
		if ConditionModule.Check(unlockConditionID) then
			local cell = self.agentSkillCellList[index]

			if not cell then
				local gameObject = UnityEngine.Object.Instantiate(self.AgentSkillPrefab, self.AgentSkillScrollView.transform)

				cell = FormationAgentSkillCell.New(gameObject, self, 1)
				self.agentSkillCellList[index] = cell

				gameObject:SetActive(true)
			end

			cell:Refresh(self.agentSkillDataList[index])
		end
	end
end

function FormationAgentSkillView:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil

	for i, v in ipairs(self.agentSkillCellList) do
		v:Dispose()
	end
end

return FormationAgentSkillView
