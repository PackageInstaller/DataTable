-- chunkname: @IQIGame\\Module\\Battle\\BattleScatteredResModule.lua

BattleScatteredResModule = {
	damageTMPMaterialTable = {},
	skillUltimateUIEffectObjs = {},
	screenEffectTable = {}
}

function BattleScatteredResModule.GetScatteredResPaths()
	BattleScatteredResModule.preloadUltimateEffectPaths = {}
	BattleScatteredResModule.preloadBattleDamageTMPMaterialPaths = {}
	BattleScatteredResModule.preloadScreenEffectPathsTable = {}

	local paths = {}

	for _, battlePreloadConfig in pairs(CfgBattlePreloadTable) do
		if battlePreloadConfig.Id >= 110 and battlePreloadConfig.Id <= 115 then
			local elementType = battlePreloadConfig.Id - 110

			BattleScatteredResModule.preloadUltimateEffectPaths[elementType] = battlePreloadConfig.Path

			table.insert(paths, battlePreloadConfig.Path)
		end

		if battlePreloadConfig.Id >= Constant.BattleDamageTMPMaterialID.RANGE_MIN and battlePreloadConfig.Id <= Constant.BattleDamageTMPMaterialID.RANGE_MAX then
			BattleScatteredResModule.preloadBattleDamageTMPMaterialPaths[battlePreloadConfig.Id] = battlePreloadConfig.Path

			table.insert(paths, battlePreloadConfig.Path)
		end

		if battlePreloadConfig.Id >= 300 and battlePreloadConfig.Id <= 310 then
			BattleScatteredResModule.preloadScreenEffectPathsTable[battlePreloadConfig.Id] = battlePreloadConfig.Path

			table.insert(paths, battlePreloadConfig.Path)
		end
	end

	return paths
end

function BattleScatteredResModule.LoadScatteredRes(uiController, parentTrans)
	BattleScatteredResModule.tempParentTrans = parentTrans

	local function createEffectPrefab(prefab)
		local instance = UnityEngine.Object.Instantiate(prefab)
		local rectTransform = instance:AddComponent(typeof(UnityEngine.RectTransform))

		rectTransform:SetParent(parentTrans)

		rectTransform.localScale = Vector3.one

		local uiParticle = instance:AddComponent(typeof(Coffee.UIExtensions.UIParticle))

		uiParticle.maskable = false
		uiParticle.ignoreCanvasScaler = false
		uiParticle.scale = 1

		uiParticle:RefreshParticles()

		return instance
	end

	BattleScatteredResModule.skillUltimateUIEffectObjs = {}

	for elementType, path in pairs(BattleScatteredResModule.preloadUltimateEffectPaths) do
		local effectObj = createEffectPrefab(uiController:GetPreloadedAsset(path))

		effectObj.gameObject:SetActive(false)

		BattleScatteredResModule.skillUltimateUIEffectObjs[elementType] = effectObj
	end

	BattleScatteredResModule.damageTMPMaterialTable = {}

	for materialID, path in pairs(BattleScatteredResModule.preloadBattleDamageTMPMaterialPaths) do
		local material = uiController:GetPreloadedAsset(path)

		BattleScatteredResModule.AddBattleDamageTMPMaterial(materialID, material)
	end

	BattleScatteredResModule.screenEffectTable = {}

	for screenEffectID, path in pairs(BattleScatteredResModule.preloadScreenEffectPathsTable) do
		local prefab = uiController:GetPreloadedAsset(path)
		local effectObj = UnityEngine.Object.Instantiate(prefab)

		effectObj.gameObject:SetActive(false)
		effectObj.gameObject.transform:SetParent(parentTrans, false)

		BattleScatteredResModule.screenEffectTable[screenEffectID] = effectObj
	end
end

function BattleScatteredResModule.ClearAllRes()
	BattleScatteredResModule.tempParentTrans = nil

	BattleScatteredResModule.DisposeBattleDamageTMPMaterials()
	BattleScatteredResModule.DisposeAllSkillUltimateUIEffectObjs()
	BattleScatteredResModule.DisposeAllScreenEffectObjs()
end

function BattleScatteredResModule.AddBattleDamageTMPMaterial(materialId, material)
	BattleScatteredResModule.damageTMPMaterialTable[materialId] = material
end

function BattleScatteredResModule.GetBattleDamageTMPMaterial(materialId)
	return BattleScatteredResModule.damageTMPMaterialTable[materialId]
end

function BattleScatteredResModule.DisposeBattleDamageTMPMaterials()
	for materialId, material in pairs(BattleScatteredResModule.damageTMPMaterialTable) do
		-- block empty
	end

	BattleScatteredResModule.damageTMPMaterialTable = nil
end

function BattleScatteredResModule.HideAllSkillUltimateUIEffectObjs()
	for elementType, effectObj in pairs(BattleScatteredResModule.skillUltimateUIEffectObjs) do
		effectObj.gameObject:SetActive(false)
	end
end

function BattleScatteredResModule.GetSkillUltimateUIEffectObj(elementType)
	return BattleScatteredResModule.skillUltimateUIEffectObjs[elementType]
end

function BattleScatteredResModule.DisposeAllSkillUltimateUIEffectObjs()
	for elementType, effectObj in pairs(BattleScatteredResModule.skillUltimateUIEffectObjs) do
		GameObject.Destroy(effectObj)
	end

	BattleScatteredResModule.skillUltimateUIEffectObjs = nil
end

function BattleScatteredResModule.GetScreenEffectObj(effectID)
	return BattleScatteredResModule.screenEffectTable[effectID]
end

function BattleScatteredResModule.RecoveryScreenEffect(effectID)
	local obj = BattleScatteredResModule.screenEffectTable[effectID]

	if obj == nil then
		return
	end

	obj.gameObject.transform:SetParent(BattleScatteredResModule.tempParentTrans)
	obj.gameObject:SetActive(false)
end

function BattleScatteredResModule.DisposeAllScreenEffectObjs()
	for _, effectObj in pairs(BattleScatteredResModule.screenEffectTable) do
		GameObject.Destroy(effectObj)
	end

	BattleScatteredResModule.screenEffectTable = nil
end
