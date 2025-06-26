-- chunkname: @IQIGame\\Module\\Battle\\BattleDamageEffect\\BattleDamageEffectComponent.lua

BattleDamageEffectComponent = {}

function BattleDamageEffectComponent.New(view, battleUnitID)
	local obj = Clone(BattleDamageEffectComponent)

	obj:Init(view, battleUnitID)

	return obj
end

function BattleDamageEffectComponent:Init(view, battleUnitID)
	self.isInitialized = true
	self.gameObject = view
	self.battleUnitID = battleUnitID

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:InitProperties()
	self:AddListeners()
end

function BattleDamageEffectComponent:InitProperties()
	self.currentShowingList = {}
	self.currentRunningTimerList = {}
	self.battleDamageTMPMaterials = {}
end

function BattleDamageEffectComponent:AddListeners()
	return
end

function BattleDamageEffectComponent:RemoveListeners()
	return
end

function BattleDamageEffectComponent:Dispose()
	self.isInitialized = false

	self:RemoveListeners()
	self:HideAllBattleDamageEffect()
	self:RemoveAllBattleDamageTMPMaterial()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function BattleDamageEffectComponent:AddBattleDamageTMPMaterial(materialID, material)
	if self.battleDamageTMPMaterials[materialID] == nil then
		self.battleDamageTMPMaterials[materialID] = material
	else
		warning("BattleDamageEffectComponent.AddBattleDamageTMPMaterial:  materialID={0} is already existing.", materialID)
	end
end

function BattleDamageEffectComponent:RemoveAllBattleDamageTMPMaterial()
	for key, _ in pairs(self.battleDamageTMPMaterials) do
		self.battleDamageTMPMaterials[key] = nil
	end

	self.battleDamageTMPMaterials = {}
end

function BattleDamageEffectComponent:HideAllBattleDamageEffect()
	for entityId, timer in pairs(self.currentRunningTimerList) do
		timer:Stop()
	end

	self.currentRunningTimerList = nil

	for entityId, battleDamage in pairs(self.currentShowingList) do
		battleDamage:Hide()
		EntityUtility.HideEntityByEntityID(entityId)
	end

	self.currentShowingList = nil
end

function BattleDamageEffectComponent:HideBattleDamageEffect(entityId)
	if self.currentRunningTimerList[entityId] ~= nil then
		local timer = self.currentRunningTimerList[entityId]

		if timer ~= nil then
			timer:Stop()
		end

		self.currentRunningTimerList[entityId] = nil
	end

	if self.currentShowingList[entityId] ~= nil then
		local battleDamage = self.currentShowingList[entityId]

		if battleDamage ~= nil then
			battleDamage:Hide()
		end

		EntityUtility.HideEntityByEntityID(entityId)

		self.currentShowingList[entityId] = nil
	end
end

function BattleDamageEffectComponent:__ShowPopupEffect(damageEffectInfoData, text, advantage, prepareShowFunc)
	local path = BattleApi:GetDamageEffectUrl(damageEffectInfoData.PrefabName)

	if not GameEntry.Resource:HasAsset(path) then
		logError("战斗伤害数字组件 - ShowBattleDamageEffect：无法在路径={0}  下找到特效预制体资源.", path)

		return
	end

	local lifeTime = 0
	local uniqueEntityID = EntityUtility.CreateEffectEntity(path, function(entityComponent)
		local marMaterial = BattleScatteredResModule.GetBattleDamageTMPMaterial(damageEffectInfoData.MaterialId)
		local battleDamageItem = BaseBattleDamageEffect(entityComponent.gameObject, marMaterial)

		if battleDamageItem == nil then
			logError("战斗伤害数字组件 - ShowBattleDamageEffect：创建伤害数字实例错误，错误类型")
			EntityUtility.HideEntity(entityComponent)

			return
		end

		entityComponent.transform:SetAsLastSibling()
		LuaUtility.SetGameObjectShow(entityComponent.gameObject, true)

		if prepareShowFunc ~= nil and not prepareShowFunc(entityComponent.gameObject) then
			EntityUtility.HideEntity(entityComponent)

			return
		end

		if type(text) == "number" then
			if text < 0 then
				battleDamageItem:SetAdvantageTagInfo(0)
			else
				battleDamageItem:SetAdvantageTagInfo(advantage)
			end
		else
			battleDamageItem:SetAdvantageTagInfo(0)
		end

		battleDamageItem:SetShowInfo(text)

		if not battleDamageItem:Show() then
			EntityUtility.HideEntity(entityComponent)

			return
		end

		local animTime = battleDamageItem:GetAnimationDuration()

		if animTime > 0 and lifeTime == 0 then
			lifeTime = animTime
		else
			lifeTime = 1
		end

		local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Battle, function()
			self:HideBattleDamageEffect(entityComponent.Id)
		end, lifeTime, -1)

		timer:Start()

		self.currentShowingList[entityComponent.Id] = battleDamageItem
		self.currentRunningTimerList[entityComponent.Id] = timer
	end, nil, self.ShowEffectRoot.transform)

	return uniqueEntityID
end

function BattleDamageEffectComponent:ShowBattleDamageEffect(battleDamageData)
	local damageEffectInfoData = BattleDamageEffectComponent.GetBattleDamageShowPrefab(battleDamageData)

	return self:__ShowPopupEffect(damageEffectInfoData, battleDamageData.damage, battleDamageData.advantage)
end

function BattleDamageEffectComponent.GetBattleDamageShowPrefab(battleDamageData)
	if battleDamageData.isShield then
		return BattleDamageEffectComponent.__GetShieldDamageEffectPrefab(battleDamageData)
	end

	if battleDamageData.damage < 0 then
		return BattleDamageEffectComponent.__GetCureEffectPrefab(battleDamageData)
	end

	if battleDamageData.damageType == Constant.DamageType.TYPE_DMG_DOT then
		return BattleDamageEffectComponent.__GetDotDamageEffectPrefab(battleDamageData)
	end

	if battleDamageData.elementType == Constant.ElementType.ELEMENT_TYPE_PHYSICS then
		return BattleDamageEffectComponent.__GetPhysicsDamageEffectPrefab(battleDamageData)
	end

	local result = {}

	if battleDamageData.isSerialHit then
		result.PrefabName = battleDamageData.isCritical and "BattleDamageEffect_CriticalInSerialHit" or "BattleDamageEffect_Combo"
	else
		result.PrefabName = battleDamageData.isCritical and "BattleDamageEffect_Critical" or "BattleDamageEffect_Normal"
	end

	local elementType = battleDamageData.elementType > 10 and battleDamageData.elementType - 10 or battleDamageData.elementType

	if elementType == Constant.ElementType.ELEMENT_TYPE_WIND then
		result.MaterialId = Constant.BattleDamageTMPMaterialID.Wind
	elseif elementType == Constant.ElementType.ELEMENT_TYPE_FIRE then
		result.MaterialId = Constant.BattleDamageTMPMaterialID.Fire
	elseif elementType == Constant.ElementType.ELEMENT_TYPE_THUNDER then
		result.MaterialId = Constant.BattleDamageTMPMaterialID.Thunder
	elseif elementType == Constant.ElementType.ELEMENT_TYPE_WATER then
		result.MaterialId = Constant.BattleDamageTMPMaterialID.Water
	else
		result.MaterialId = Constant.BattleDamageTMPMaterialID.RANGE_MIN

		logError("战斗伤害类型 elementType 错误: {0}", tostring(battleDamageData.elementType))
	end

	return result
end

function BattleDamageEffectComponent.__GetShieldDamageEffectPrefab(battleDamageData)
	local result = {}

	if battleDamageData.isCritical then
		result.PrefabName = battleDamageData.isSerialHit and "BattleDamageEffect_CriticalInSerialHit" or "BattleDamageEffect_Critical"
	else
		result.PrefabName = battleDamageData.isSerialHit and "BattleDamageEffect_Combo" or "BattleDamageEffect_Normal"
	end

	result.MaterialId = Constant.BattleDamageTMPMaterialID.ShieldReduce

	return result
end

function BattleDamageEffectComponent.__GetCureEffectPrefab(battleDamageData)
	local result = {}

	if battleDamageData.isSerialHit then
		result.PrefabName = battleDamageData.isCritical and "BattleDamageEffect_CriticalInSerialHit" or "BattleDamageEffect_Combo"
	else
		result.PrefabName = battleDamageData.isCritical and "BattleDamageEffect_Critical" or "BattleDamageEffect_Normal"
	end

	result.MaterialId = Constant.BattleDamageTMPMaterialID.Cure

	return result
end

function BattleDamageEffectComponent.__GetDotDamageEffectPrefab(battleDamageData)
	local result = {}

	if battleDamageData.isSerialHit then
		result.PrefabName = battleDamageData.isCritical and "BattleDamageEffect_CriticalInSerialHit" or "BattleDamageEffect_Combo_Dot"
	else
		result.PrefabName = battleDamageData.isCritical and "BattleDamageEffect_Critical" or "BattleDamageEffect_Normal_Dot"
	end

	result.MaterialId = Constant.BattleDamageTMPMaterialID.DOT

	return result
end

function BattleDamageEffectComponent.__GetPhysicsDamageEffectPrefab(battleDamageData)
	local result = {}

	if battleDamageData.isSerialHit then
		result.PrefabName = battleDamageData.isCritical and "BattleDamageEffect_CriticalInSerialHit" or "BattleDamageEffect_Combo"
	else
		result.PrefabName = battleDamageData.isCritical and "BattleDamageEffect_Critical" or "BattleDamageEffect_Normal"
	end

	result.MaterialId = Constant.BattleDamageTMPMaterialID.Physical

	return result
end

function BattleDamageEffectComponent:ShowEnergyNumber(energyNumber)
	if energyNumber <= 0 then
		return
	end

	local damageEffectInfoData = {}

	damageEffectInfoData.PrefabName = "BattleDamageEffect_Normal"
	damageEffectInfoData.MaterialId = Constant.BattleDamageTMPMaterialID.Water

	return self:__ShowPopupEffect(damageEffectInfoData, energyNumber, 0)
end

function BattleDamageEffectComponent:ShowTotalDamage(damageNumber, prepareShowFunc)
	if damageNumber <= 0 then
		return
	end

	local damageEffectInfoData = {}

	damageEffectInfoData.PrefabName = "BattleDamageEffect_Total"
	damageEffectInfoData.MaterialId = Constant.BattleDamageTMPMaterialID.Others

	return self:__ShowPopupEffect(damageEffectInfoData, damageNumber, 0, prepareShowFunc)
end

function BattleDamageEffectComponent:ShowOtherText(text, prepareShowFunc)
	local damageEffectInfoData = {}

	damageEffectInfoData.PrefabName = "BattleDamageEffect_Normal"
	damageEffectInfoData.MaterialId = Constant.BattleDamageTMPMaterialID.Others

	return self:__ShowPopupEffect(damageEffectInfoData, text, 0, prepareShowFunc)
end
