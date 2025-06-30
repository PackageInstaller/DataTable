-- chunkname: @IQIGame\\UI\\Battle\\BattleUnitSettlementCell.lua

local BattleUnitSettlementCell = {
	RecordTweenDuration = 1,
	MaxSkillEnergy = 0
}

function BattleUnitSettlementCell.New(view)
	local obj = Clone(BattleUnitSettlementCell)

	obj:Init(view)

	return obj
end

function BattleUnitSettlementCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.GrayComponent = self.View:GetComponent("ImageGroupGrayComponent")
	self.MaxSkillEnergy = CfgDiscreteDataTable[6506027].Data[1]
	self.DeadText:GetComponent("Text").text = BattleSettlementUIApi:GetString("DeadText")
	self.UITweeners = self.View:GetComponentsInChildren(typeof(UITweener))
	self.DmgBarImage = self.DmgBar:GetComponent("Image")
	self.DmgPercentTextCom = self.DmgPercentText:GetComponent("Text")
	self.DmgValueTextCom = self.DmgValueText:GetComponent("Text")
	self.HurtBarImage = self.HurtBar:GetComponent("Image")
	self.HurtPercentTextCom = self.HurtPercentText:GetComponent("Text")
	self.HurtValueTextCom = self.HurtValueText:GetComponent("Text")
	self.HealBarImage = self.HealBar:GetComponent("Image")
	self.HealPercentTextCom = self.HealPercentText:GetComponent("Text")
	self.HealValueTextCom = self.HealValueText:GetComponent("Text")
	self.RecordTweenDuration = BattleSettlementUIApi:GetString("RecordTweenDuration")
end

function BattleUnitSettlementCell:SetItem(fightUnitPOD, dmgRecord, hurtRecord, healRecord, maxDmg, maxHurt, maxHeal, totalDmg, totalHurt, totalHeal, noMatterWinOrLose)
	self.FightUnitPOD = fightUnitPOD
	self.DmgRecord = dmgRecord
	self.HurtRecord = hurtRecord
	self.HealRecord = healRecord
	self.MaxDmg = maxDmg
	self.MaxHurt = maxHurt
	self.MaxHeal = maxHeal
	self.TotalDmg = totalDmg
	self.TotalHurt = totalHurt
	self.TotalHeal = totalHeal

	self.View:SetActive(fightUnitPOD ~= nil)

	if fightUnitPOD == nil then
		return
	end

	self.Content:SetActive(false)

	for i = 0, self.UITweeners.Length - 1 do
		local uiTweener = self.UITweeners[i]

		uiTweener:ResetToBeginning()

		uiTweener.enabled = true
	end

	local cfgMonsterData = CfgMonsterTable[fightUnitPOD.MonsterCfgId]

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgMonsterData.HeadIcon), self.Icon:GetComponent("Image"))

	self.battleUnitHpBg:GetComponent("Image").fillAmount = fightUnitPOD.Attributes[Constant.Attribute.TYPE_HP + 1] / fightUnitPOD.Attributes[Constant.Attribute.TYPE_HP_MAX + 1]

	local isCompanion = fightUnitPOD.TroopType == Constant.BattleTroopType.Attack

	self.SpNode:SetActive(isCompanion)

	if isCompanion then
		self.SpBar:GetComponent("Image").fillAmount = fightUnitPOD.Attributes[Constant.Attribute.TYPE_SKILL_ENERGY + 1] / self.MaxSkillEnergy
	end

	local isUnitDead = false

	for i = 1, #fightUnitPOD.SPStatus do
		if fightUnitPOD.SPStatus[4] then
			isUnitDead = true
		end
	end

	self.DeadNode:SetActive(isUnitDead and not noMatterWinOrLose)
	self.GrayComponent:EnableGray(isUnitDead and not noMatterWinOrLose)

	self.StartPlayRecordTime = UnityEngine.Time.realtimeSinceStartup
end

function BattleUnitSettlementCell:OnUpdate()
	if self.FightUnitPOD ~= nil and self.StartPlayRecordTime ~= nil then
		local elapsedTime = UnityEngine.Time.realtimeSinceStartup - self.StartPlayRecordTime
		local lerpValue = math.min(elapsedTime / self.RecordTweenDuration, 1)

		self:SetRecord(self.DmgRecord * lerpValue, self.HurtRecord * lerpValue, self.HealRecord * lerpValue)

		if lerpValue >= 1 then
			self.StartPlayRecordTime = nil
		end
	end
end

function BattleUnitSettlementCell:SetRecord(dmgRecord, hurtRecord, healRecord)
	self.DmgBarImage.fillAmount = BattleSettlementUIApi:GetString("RecordBarPercent", dmgRecord, self.MaxDmg, self.TotalDmg)
	self.DmgPercentTextCom.text = BattleSettlementUIApi:GetString("RecordPercentText", dmgRecord, self.MaxDmg, self.TotalDmg)
	self.DmgValueTextCom.text = BattleSettlementUIApi:GetString("RecordValueText", dmgRecord)
	self.HurtBarImage.fillAmount = BattleSettlementUIApi:GetString("RecordBarPercent", hurtRecord, self.MaxHurt, self.TotalHurt)
	self.HurtPercentTextCom.text = BattleSettlementUIApi:GetString("RecordPercentText", hurtRecord, self.MaxHurt, self.TotalHurt)
	self.HurtValueTextCom.text = BattleSettlementUIApi:GetString("RecordValueText", hurtRecord)
	self.HealBarImage.fillAmount = BattleSettlementUIApi:GetString("RecordBarPercent", healRecord, self.MaxHeal, self.TotalHeal)
	self.HealPercentTextCom.text = BattleSettlementUIApi:GetString("RecordPercentText", healRecord, self.MaxHeal, self.TotalHeal)
	self.HealValueTextCom.text = BattleSettlementUIApi:GetString("RecordValueText", healRecord)
end

function BattleUnitSettlementCell:DoTweenPlay()
	if self.FightUnitPOD == nil then
		return
	end

	self.Content:SetActive(true)
end

function BattleUnitSettlementCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.DmgBarImage = nil
	self.DmgPercentTextCom = nil
	self.DmgValueTextCom = nil
	self.HurtBarImage = nil
	self.HurtPercentTextCom = nil
	self.HurtValueTextCom = nil
	self.HealBarImage = nil
	self.HealPercentTextCom = nil
	self.HealValueTextCom = nil
	self.UITweeners = nil
	self.GrayComponent = nil
end

return BattleUnitSettlementCell
