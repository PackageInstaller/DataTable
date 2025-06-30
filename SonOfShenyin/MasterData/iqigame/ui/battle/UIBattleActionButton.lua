-- chunkname: @IQIGame\\UI\\Battle\\UIBattleActionButton.lua

local ActionButton = {
	interactable = true,
	battleUnitID = 0,
	battleSkillCid = 0
}

function ActionButton:__Init(view, skillType, owner)
	self.View = view
	self.Owner = owner
	self.skillType = skillType

	LuaCodeInterface.BindOutlet(self.View, self)

	self.longButton = self.buttonGo:GetComponent(typeof(LongButton))
	self.longButton.repeatCall = false
	self.longButtonGrayComponent = self.buttonGo:GetComponent("GrayComponent")

	self:PrepareEventProxy()

	if self.InitEx ~= nil then
		self.InitEx(self)
	end

	self.elementEffectTable = {}

	ForTransformChild(self.selectTag.transform, function(_trans, _index)
		local elemType = TryToNumber(_trans.gameObject.name, 0)

		self.elementEffectTable[elemType] = _trans.gameObject

		_trans.gameObject:SetActive(false)
	end)
end

function ActionButton:PrepareEventProxy()
	function self.delegateOnLongButtonClick()
		self:OnLongButtonClick()
	end

	function self.delegateOnLongDownClick()
		self:OnLongDownClick()
	end

	function self.delegateOnLongDownEnd()
		self:OnLongDownEnd()
	end

	if self.PrepareEventProxyEx ~= nil then
		self.PrepareEventProxyEx(self)
	end
end

function ActionButton:AddListeners()
	self.longButton.onClick:AddListener(self.delegateOnLongButtonClick)
	self.longButton.onLongDownClick:AddListener(self.delegateOnLongDownClick)

	self.longButton.onLongDownEnd = self.delegateOnLongDownEnd

	if self.AddListenersEx ~= nil then
		self.AddListenersEx(self)
	end
end

function ActionButton:RemoveListeners()
	self.longButton.onClick:RemoveListener(self.delegateOnLongButtonClick)
	self.longButton.onLongDownClick:RemoveListener(self.delegateOnLongDownClick)

	self.longButton.onLongDownEnd = nil

	if self.RemoveListenersEx ~= nil then
		self.RemoveListenersEx(self)
	end
end

function ActionButton:Dispose()
	self.elementEffectTable = nil

	if self.DisposeEx ~= nil then
		self.DisposeEx(self)
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.longButton = nil
	self.longButtonGrayComponent = nil
	self.battleSkillData = nil
	self.View = nil
	self.Owner = nil
end

function ActionButton:SetVisible(isVisible)
	self.View:SetActive(isVisible)
end

function ActionButton:SetShowInfo(battleUnitID, skillCid)
	self:SetVisible(true)

	self.battleSkillCid = skillCid
	self.battleUnitID = battleUnitID

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(self.battleUnitID)
	local battleSkillData = battleUnitData:GetSkillData(self.battleSkillCid)
	local skillConfig = CfgSkillTable[self.battleSkillCid]

	AssetUtil.LoadImage(self.Owner, UIGlobalApi.GetIconPath(skillConfig.Icon), self.buttonGo:GetComponent("Image"))
	LuaUtility.SetText(self.nameText, skillConfig.SkillTag)
	self:__RefreshSelectEffect(battleSkillData.elementType)
	self:__SetCost(battleSkillData.apCost)
	self:__SetCDShow(battleSkillData.sustainCD)
	self:__RefreshSealedState()

	local cdNum = battleUnitData:GetSkillRealCD(skillCid, true)

	self:__SetCoolDown(cdNum)

	if self.SetShowInfoEx ~= nil then
		self.SetShowInfoEx(self, battleUnitData, battleSkillData)
	end
end

function ActionButton:__RefreshSelectEffect(elementType)
	ForPairs(self.elementEffectTable, function(_elemType, _effectRoot)
		local active = elementType == _elemType

		_effectRoot.gameObject:SetActive(active)
	end)
end

function ActionButton:OnLongButtonClick()
	local args = {}

	args.skillCid = self.battleSkillCid

	BattleTeamActionModule.SetManualSkill(self.battleUnitID, self.skillType, self.battleSkillCid)
end

function ActionButton:OnLongDownClick()
	return
end

function ActionButton:OnLongDownEnd()
	return
end

function ActionButton:ShowTips()
	EventDispatcher.Dispatch(EventID.BattleOpenSkillInfoPanel, self.battleUnitID, self.battleSkillCid)
end

function ActionButton:HideTips()
	EventDispatcher.Dispatch(EventID.BattleCloseSkillInfoPanel, self.battleUnitID, self.battleSkillCid)
end

function ActionButton:UpdateSelectShow(isSelect)
	if self.selectTag == nil then
		return
	end

	self.selectTag.gameObject:SetActive(isSelect)
end

function ActionButton:__SetCDShow(cd)
	if cd == nil then
		cd = 0
	end

	if cd <= 0 then
		self.cdRoot.gameObject:SetActive(false)

		return
	end

	self.cdText:GetComponent("Text").text = tostring(cd)

	self.cdRoot.gameObject:SetActive(true)
end

function ActionButton:__SetCost(cost)
	if cost == nil then
		cost = 0
	end

	if cost <= 0 then
		self.costRoot.gameObject:SetActive(false)

		return
	end

	self.costRoot.gameObject:SetActive(true)
	ForTransformChild(self.costRoot.transform, function(_trans, _index)
		local active = _index < cost

		_trans.gameObject:SetActive(active)
	end)
end

function ActionButton:__SetCoolDown(coolDown)
	if coolDown == nil then
		coolDown = 0
	end

	if coolDown <= 0 then
		self.coolDownTag.gameObject:SetActive(false)

		return
	end

	self.coolDownText:GetComponent("Text").text = tostring(coolDown)

	self.coolDownTag.gameObject:SetActive(true)
end

function ActionButton:__RefreshSealedState()
	local state = BattleSkillModule.CheckCanCastSkill(self.battleUnitID, self.battleSkillCid)

	LuaUtility.SetGameObjectShow(self.sealedRoot, state == BattleConstant.CastSkillCheckResult.Sealed)
end

function ActionButton:InitEx()
	return
end

function ActionButton:PrepareEventProxyEx()
	return
end

function ActionButton:AddListenersEx()
	return
end

function ActionButton:RemoveListenersEx()
	return
end

function ActionButton:DisposeEx()
	return
end

function ActionButton:SetShowInfoEx(battleUnitData, battleSkillData)
	return
end

local NormalSkillButton = Clone(ActionButton)

function NormalSkillButton.New(view, skillType, owner)
	local obj = Clone(NormalSkillButton)

	obj:__Init(view, skillType, owner)

	return obj
end

local UltimateSkillButton = Clone(ActionButton)

UltimateSkillButton.spriteUVMapping = "_UVMapping"

function UltimateSkillButton.New(view, skillType, owner)
	local obj = Clone(UltimateSkillButton)

	obj:__Init(view, skillType, owner)

	return obj
end

function UltimateSkillButton:SetShowInfoEx(battleUnitData, battleSkillData)
	local img = self.fillImg.gameObject:GetComponent("Image")
	local material = img.material

	material:SetVector(self.spriteUVMapping, UGUIUtil.GetSpriteNormalizedUV(img))

	local color = BattleUIApi:GetUltimateSkillShaderColor(battleSkillData.elementType)

	material:SetColor("_InsidesideColor", color)

	local totalEnergy, _ = BattleSkillModule.GetCommonEnergyData()
	local amount = battleSkillData.apCost > 0 and totalEnergy / battleSkillData.apCost or 1

	if amount >= 1 then
		material:SetFloat("_BloodChange", 1)
	else
		local maxAmount = BattleUIApi:GetUltimateSkillEffectMaxFillAmount()

		amount = maxAmount < amount and maxAmount or amount

		material:SetFloat("_BloodChange", amount)
	end

	local state = BattleSkillModule.CheckCanCastSkillWithData(battleUnitData, battleSkillData)

	if state == BattleConstant.CastSkillCheckResult.Legal then
		local obj = BattleScatteredResModule.GetSkillUltimateUIEffectObj(battleSkillData.elementType)

		if obj ~= nil then
			LuaCodeInterface.SetGameObjectShow(obj, true)
			obj.transform:SetParent(self.View.transform, false)
			LuaCodeInterface.SetAnchoredPosition3DWithRectTransform(obj:GetComponent(typeof(UnityEngine.RectTransform)), self.buttonGo.gameObject.transform.localPosition.x, self.buttonGo.gameObject.transform.localPosition.y, self.buttonGo.gameObject.transform.localPosition.z)
		end
	end
end

local DisplacementSkillButton = Clone(ActionButton)

function DisplacementSkillButton.New(view, skillType, owner)
	local obj = Clone(DisplacementSkillButton)

	obj:__Init(view, skillType, owner)

	return obj
end

local UIBattleActionButton = {}

function UIBattleActionButton.New(view, skillType, owner)
	if skillType == Constant.SkillType.TYPE_NORMAL then
		return NormalSkillButton.New(view, skillType, owner)
	elseif skillType == Constant.SkillType.TYPE_ULTIMATE then
		return UltimateSkillButton.New(view, skillType, owner)
	elseif skillType == Constant.SkillType.TYPE_DISPLACEMENT then
		return DisplacementSkillButton.New(view, skillType, owner)
	else
		logError("UIBattleActionButton 未实现技能类型为【" .. tostring(skillType) .. "】的技能逻辑")
	end

	return nil
end

return UIBattleActionButton
