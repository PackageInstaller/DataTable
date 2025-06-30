-- chunkname: @IQIGame\\UI\\Formation\\ItemCell\\FormationAgentSkillCell.lua

local FormationAgentSkillCell = {
	tableIndex
}

function FormationAgentSkillCell.New(gameObject, mainUIController, type, tableIndex)
	local obj = Clone(FormationAgentSkillCell)

	obj:Init(gameObject, mainUIController, type, tableIndex)

	return obj
end

function FormationAgentSkillCell:Init(gameObject, mainUIController, type, tableIndex)
	self.gameObject = gameObject
	self.MainUIController = mainUIController
	self.type = type
	self.tableIndex = tableIndex

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:InitDelegates()
	self:AddListeners()
	self.gameObject:SetActive(true)
end

function FormationAgentSkillCell:InitDelegates()
	function self.DelegateOnClickShowAgentSkillPanel()
		self:OnClickShowAgentSkillPanel()
	end

	function self.DelegateOnSelectOne()
		self:OnSelectOne()
	end
end

function FormationAgentSkillCell:AddListeners()
	if self.type == 1 then
		self.gameObject:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShowAgentSkillPanel)
	elseif self.type == 2 then
		self.gameObject:GetComponent("Button").onClick:AddListener(self.DelegateOnSelectOne)
	end
end

function FormationAgentSkillCell:RemoveListeners()
	if self.type == 1 then
		self.gameObject:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShowAgentSkillPanel)
	elseif self.type == 2 then
		self.gameObject:GetComponent("Button").onClick:RemoveListener(self.DelegateOnSelectOne)
	end
end

function FormationAgentSkillCell:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function FormationAgentSkillCell:Refresh(skillData)
	self.skillData = skillData

	if skillData then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.skillData:GetCfg().Icon), self.Icon:GetComponent("Image"))
		self.Icon:SetActive(true)
	else
		self.Icon:SetActive(false)
	end

	if self.type == 1 then
		-- block empty
	elseif self.type == 2 then
		self.selectImg:SetActive(false)
	end
end

function FormationAgentSkillCell:OnClickShowAgentSkillPanel()
	UIModule.Open(Constant.UIControllerName.FormationAgentSkillSelectUI, Constant.UILayer.UI)
end

function FormationAgentSkillCell:OnSelectOne()
	self.MainUIController.DelegateOnSelectGrid(self)
end

function FormationAgentSkillCell:SetSelect(isSelect)
	self.selectImg:SetActive(isSelect)
end

return FormationAgentSkillCell
