-- chunkname: @IQIGame\\UI\\Battle\\BattleSkillView.lua

local UIBattleActionButton = require("IQIGame.UI.Battle.UIBattleActionButton")
local BattleSkillUI = {
	lastSelectIndex = 0
}

function BattleSkillUI.New(view)
	local obj = Clone(BattleSkillUI)

	obj:Init(view)

	return obj
end

function BattleSkillUI:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.CommonSkillButtonNodes = {
		[Constant.SkillType.TYPE_DISPLACEMENT] = UIBattleActionButton.New(self.displacementBtn, Constant.SkillType.TYPE_DISPLACEMENT, self),
		[Constant.SkillType.TYPE_NORMAL] = UIBattleActionButton.New(self.normalBtn, Constant.SkillType.TYPE_NORMAL, self),
		[Constant.SkillType.TYPE_ULTIMATE] = UIBattleActionButton.New(self.ultimateBtn, Constant.SkillType.TYPE_ULTIMATE, self)
	}

	function self.__delegateOnCastSkillButtonClick()
		BattleTeamActionModule.OnSendCastSkillOrder()
	end

	self.castSkillBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnCastSkillButtonClick)
	self.View.gameObject:SetActive(false)
end

function BattleSkillUI:AddListeners()
	self:AddActionButtonsListeners()
end

function BattleSkillUI:RemoveListeners()
	self:RemoveActionButtonsListeners()
end

function BattleSkillUI:OnOpen()
	self:RemoveListeners()
	self:AddListeners()
	self.View.gameObject:SetActive(false)
end

function BattleSkillUI:OnClose()
	self:RemoveListeners()
	self.View.gameObject:SetActive(false)
end

function BattleSkillUI:Hide()
	self.View.gameObject:SetActive(false)
end

function BattleSkillUI:OnDestroy()
	self.castSkillBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnCastSkillButtonClick)

	if self.CommonSkillButtonNodes ~= nil then
		for actionType, actionButton in pairs(self.CommonSkillButtonNodes) do
			actionButton:Dispose()
		end

		self.CommonSkillButtonNodes = nil
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function BattleSkillUI:ShowSkills(battleUnitID)
	self.View.gameObject:SetActive(true)
	BattleScatteredResModule.HideAllSkillUltimateUIEffectObjs()

	local hasDiySkill = false
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)

	ForPairs(self.CommonSkillButtonNodes, function(actionType, skillButtonNode)
		skillButtonNode:UpdateSelectShow(false)

		local battleSkillData = battleUnitData:GetSkillBySkillType(actionType, true)

		if battleSkillData == nil then
			skillButtonNode:SetVisible(false)

			return
		end

		skillButtonNode:SetVisible(true)
		skillButtonNode:SetShowInfo(battleUnitID, battleSkillData.configID)
	end)
end

function BattleSkillUI:AddActionButtonsListeners()
	for actionType, actionButton in pairs(self.CommonSkillButtonNodes) do
		actionButton:AddListeners()
	end
end

function BattleSkillUI:RemoveActionButtonsListeners()
	for actionType, actionButton in pairs(self.CommonSkillButtonNodes) do
		actionButton:RemoveListeners()
	end
end

function BattleSkillUI:RefreshSkillSelect(skillType, skillCid)
	ForPairs(self.CommonSkillButtonNodes, function(actionType, skillButtonNode)
		local isSelect = actionType == skillType

		skillButtonNode:UpdateSelectShow(isSelect)
	end)
end

return BattleSkillUI
