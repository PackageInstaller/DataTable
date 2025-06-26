-- chunkname: @IQIGame\\UI\\Formation\\ItemCell\\FormationAgentSkillSelectCell.lua

local FormationAgentSkillSelectCell = {}

function FormationAgentSkillSelectCell.New(gameObject, mainUIController)
	local obj = Clone(FormationAgentSkillSelectCell)

	obj:Init(gameObject, mainUIController)

	return obj
end

function FormationAgentSkillSelectCell:Init(gameObject, mainUIController)
	self.gameObject = gameObject
	self.MainUIController = mainUIController

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:InitDelegates()
	self:AddListeners()
end

function FormationAgentSkillSelectCell:InitDelegates()
	function self.DelegateOnClickAgentSkill()
		self:OnSelectSkill()
	end
end

function FormationAgentSkillSelectCell:AddListeners()
	self.skillImg.gameObject:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAgentSkill)
end

function FormationAgentSkillSelectCell:RemoveListeners()
	self.skillImg.gameObject:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAgentSkill)
end

function FormationAgentSkillSelectCell:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function FormationAgentSkillSelectCell:Refresh(skillData)
	self.skillData = skillData

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.skillData:GetCfg().Icon), self.skillImg:GetComponent("Image"))
	UGUIUtil.SetText(self.skillNameText, self.skillData:GetCfg().Name)
	UGUIUtil.SetText(self.skillLevelNumText, self.skillData.lv)
	LuaUtility.SetGameObjectShow(self.EquippedIcon.gameObject, false)
	LuaUtility.SetGameObjectShow(self.selectImg.gameObject, false)
	self.EquippedIcon:SetActive(FormationModule.IsAgentSkillCharged(skillData.id))
	self.selectImg:SetActive(false)
end

function FormationAgentSkillSelectCell:OnSelectSkill()
	self.MainUIController.DelegateOnSelectSkill(self)
end

function FormationAgentSkillSelectCell:SetSelect(isSelect)
	self.selectImg:SetActive(isSelect)
end

return FormationAgentSkillSelectCell
