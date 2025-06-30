-- chunkname: @IQIGame\\Module\\Util\\EntityUtility.lua

EntityUtility = {
	DEBUG_LOG = false,
	callbackList = {}
}

function EntityUtility.Init()
	GameEntry.LuaEvent:Subscribe(ShowEntitySuccessEventArgs.EventId, EntityUtility.OnShowEntitySucess)
end

function EntityUtility.CreateEffectEntity(path, callback, parentEntityID, parent)
	local uniqueEntityID = GameEntry.Entity:GenerateEntityID()

	if path == "" or not GameEntry.Resource:HasAsset(path) then
		logError("EntityUtility.CreateEffectEntity: 显示 路径={0} 的Entity失败，请检查该路径下是否存在该资源，或 EffectEntity.csv 内是否正确配置资源的路径", path)

		return uniqueEntityID
	end

	EntityUtility.callbackList[tostring(uniqueEntityID)] = callback

	GameEntry.Entity:ShowCommonEntity_Effect(uniqueEntityID, path, type(parentEntityID) == "number" and parentEntityID or 0, parent, Vector3.zero)

	if EntityUtility.DEBUG_LOG then
		log("DEBUG_EntityUtility.CreateEffectEntity:  path={0}, uniqueEntityID={1}, parentEntityID={2}", path, uniqueEntityID, parentEntityID)
	end

	return uniqueEntityID
end

function EntityUtility.OnShowEntitySucess(sender, args)
	local uniqueEntityId = tostring(args.Entity.Id)
	local callback = EntityUtility.callbackList[uniqueEntityId]

	if callback then
		callback(args.Entity)

		EntityUtility.callbackList[uniqueEntityId] = nil

		if EntityUtility.DEBUG_LOG then
			log("DEBUG_EntityUtility.OnShowEntitySucess:  uniqueEntityId={0}", uniqueEntityId)
		end
	end
end

function EntityUtility.HideEntityByEntityID(uniqueEntityID)
	GameEntry.Entity:HideEntity(uniqueEntityID)

	if EntityUtility.DEBUG_LOG then
		log("DEBUG_EntityUtility.HideEntityByEntityID:  uniqueEntityID={0}", uniqueEntityID)
	end
end

function EntityUtility.HideEntity(entityComponent)
	GameEntry.Entity:HideEntity(entityComponent)

	if EntityUtility.DEBUG_LOG then
		log("DEBUG_EntityUtility.HideEntity:  uniqueEntityID={0}", entityComponent ~= nil and entityComponent.Id or nil)
	end
end

function EntityUtility.HideEntitySafelyByEntityID(uniqueEntityID)
	GameEntry.Entity:HideEntitySafely(uniqueEntityID)

	if EntityUtility.DEBUG_LOG then
		log("DEBUG_EntityUtility.HideEntitySafelyByEntityID:  uniqueEntityID={0}", uniqueEntityID)
	end
end

function EntityUtility.SetEntityVisibleByEntityID(uniqueEntityID, isVisible)
	GameEntry.Entity:SetEntityVisible(uniqueEntityID, isVisible)

	if EntityUtility.DEBUG_LOG then
		log("DEBUG_EntityUtility.SetEntityVisibleByEntityID:  uniqueEntityID={0} isVisible={1}", uniqueEntityID, isVisible)
	end
end

function EntityUtility.HideAllEntities()
	GameEntry.Entity:HideAllLoadingEntities()
	GameEntry.Entity:HideAllLoadedEntities()

	if EntityUtility.DEBUG_LOG then
		log("DEBUG_EntityUtility.HideAllEntities")
	end
end

function EntityUtility.Dispose()
	GameEntry.LuaEvent:Unsubscribe(ShowEntitySuccessEventArgs.EventId, EntityUtility.OnShowEntitySucess)

	EntityUtility.callbackList = nil
end

function EntityUtility.ReleaseAllNPCEntities()
	GameEntry.Entity:ReleaseAllNPCEntities()

	if EntityUtility.DEBUG_LOG then
		log("DEBUG_EntityUtility.ReleaseAllNPCEntities")
	end
end

function EntityUtility.HideAllBattleEntities()
	GameEntry.Entity:HideAllLoadingEntities()
	GameEntry.Entity:HideAllBattleLoadedEntities()
end

function EntityUtility.GetElementAssetPath(assetPath)
	return EntityUtility.GetPrefabAssetPath(assetPath, "prefab")
end

function EntityUtility.GetPrefabAssetPath(assetPath, suffix)
	if LuaUtility.StrIsNullOrEmpty(suffix) then
		return string.format("Assets/03_Prefabs/%s", assetPath)
	else
		return string.format("Assets/03_Prefabs/%s.%s", assetPath, suffix)
	end
end

function EntityUtility.GetBattleTimelineAsset(owner, assetPath, success, fail)
	local path = EntityUtility.GetPrefabAssetPath(assetPath, "playable")

	AssetUtil.LoadAsset(owner, path, function(_, _assetUrl, _asset, _duration, _userData)
		success(_asset)
	end, function(_assetName, _status, _errorMessage, _userData)
		logError("加载战斗Timeline资产失败 {0},检查 Timeline.csv timeline 字段是否配置正确", path)

		if fail ~= nil then
			fail()
		end
	end)
end

function EntityUtility.GetBattleCinemachineAsset(owner, assetPath, success, fail)
	local path = EntityUtility.GetElementAssetPath(assetPath)

	AssetUtil.LoadAsset(owner, path, function(_, _assetUrl, _asset, _duration, _userData)
		success(_asset)
	end, function(_assetName, _status, _errorMessage, _userData)
		logError("加载战斗Cinemachine资产失败 {0},检查 Timeline.csv Cinemachine 字段是否配置正确", path)

		if fail ~= nil then
			fail()
		end
	end)
end

function EntityUtility.GetBattleEntityPath(entityConfigID)
	local entityCfg = CfgElementEntityTable[entityConfigID]

	if entityCfg == nil then
		logError("获取战斗实体 {0} 资源失败，查看 ElementEntity.csv 表 PrefabName 字段是否配置正确.", entityConfigID)

		return ""
	end

	return AssetPath.Get(GlobalKey.ElementAssetPath, entityCfg.PrefabName)
end

function EntityUtility.GetBattleEntity(entityConfigID, parentTrans, position, callback)
	local uniqueEntityID = GameEntry.Entity:GenerateEntityID()

	EntityUtility.callbackList[tostring(uniqueEntityID)] = callback

	GameEntry.Entity:ShowBattleElement(uniqueEntityID, entityConfigID, 0, parentTrans, position)

	return uniqueEntityID
end

function EntityUtility.GetBattleEntityByAssetUtil(owner, entityConfigID, onSuccess, onFail, userData)
	local path = EntityUtility.GetBattleEntityPath(entityConfigID)

	if LuaUtility.StrIsNullOrEmpty(path) then
		return
	end

	AssetUtil.LoadAsset(owner, path, onSuccess, onFail, userData)
end

function EntityUtility.GetBattleUnitEntitySpineParentRoot(entityGo)
	return entityGo.transform:Find(Battle.BattleTimelineManager.SPINE_ROOT_PATH).gameObject
end

function EntityUtility.GetBattleUnitEntitySpineRoot(entityGo)
	return entityGo.transform:Find(Battle.BattleTimelineManager.SPINE_PATH).gameObject
end

function EntityUtility.GetBattleUnitEntityEffectRoot(entityGo)
	return entityGo.transform:Find(Battle.BattleTimelineManager.EFFECT_PATH).gameObject
end

function EntityUtility.GetBattleUnitEntityUIRoot(entityGo)
	return entityGo.transform:Find("Ui/hud").gameObject
end

function EntityUtility.GetBattleUnitEntityTransferFeatureRoot(entityGo)
	return entityGo.transform:Find(Battle.BattleTimelineManager.SPINE_PATH).gameObject
end

function EntityUtility.BattleSpineToUIShow(spineEntityGo, sortingOrder, isUnitFlip, monsterCid, animName)
	local spineGo = EntityUtility.GetBattleUnitEntitySpineRoot(spineEntityGo)
	local roleEffect = LuaCodeInterface.GameObjectGetOrAddComponent(spineGo, typeof(RoleEffect))

	roleEffect:SetEnable(false)

	local meshRenderer = spineGo:GetComponent("MeshRenderer")

	meshRenderer.sortingOrder = sortingOrder

	if monsterCid ~= nil and monsterCid ~= 0 then
		local monsterData = CfgMonsterTable[monsterCid]

		if monsterData ~= nil then
			meshRenderer.enabled = not monsterData.IsVisiable
			spineGo.transform.localScale = Vector3.one * monsterData.MonsterScale
		end
	end

	local flipRoot = EntityUtility.GetBattleUnitEntitySpineParentRoot(spineEntityGo)

	flipRoot.transform.localScale = isUnitFlip and Vector3(-1, 1, 1) or Vector3.one

	local setSkeleton = spineEntityGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation), true)

	setSkeleton:Initialize(true)

	if not LuaUtility.StrIsNullOrEmpty(animName) then
		setSkeleton.state:SetAnimation(0, animName, true)
	end

	setGameObjectLayers(spineEntityGo.transform, "UI")
end

function EntityUtility.GetStoryEntityPath(entityConfigID)
	local entityCfg = CfgElementEntityTable[entityConfigID]

	if entityCfg == nil then
		logError("获取剧情实体 {0} 资源失败，查看 ElementEntity.csv 表 PrefabName 字段是否配置正确.", entityConfigID)

		return ""
	end

	return AssetPath.Get(GlobalKey.ElementAssetPath, entityCfg.PrefabName)
end

function EntityUtility.GetStoryEntity(entityConfigID, parentTrans, position, callback)
	local uniqueEntityID = GameEntry.Entity:GenerateEntityID()

	EntityUtility.callbackList[tostring(uniqueEntityID)] = callback

	GameEntry.Entity:ShowNPCEntity(uniqueEntityID, entityConfigID, 0, parentTrans, position)

	return uniqueEntityID
end

function EntityUtility.GetStoryEntityByAssetUtil(owner, entityConfigID, onSuccess, onFail, userData)
	local path = EntityUtility.GetStoryEntityPath(entityConfigID)

	if LuaUtility.StrIsNullOrEmpty(path) then
		return
	end

	AssetUtil.LoadAsset(owner, path, onSuccess, onFail, userData)
end

function EntityUtility.GetUIEntitySpineByCid(uiEntityCid, parentTrans, position, callback)
	local uniqueEntityID = GameEntry.Entity:GenerateEntityID()

	EntityUtility.callbackList[tostring(uniqueEntityID)] = function(_entityComponent)
		EntityUtility.__CommonLoadUIEntitySpinePostProcess(_entityComponent, callback)
	end

	GameEntry.Entity:ShowBattleElement(uniqueEntityID, uiEntityCid, 0, parentTrans, position)

	return uniqueEntityID
end

function EntityUtility.__CommonLoadUIEntitySpinePostProcess(_entityComponent, callBack)
	if callBack == nil then
		return
	end

	callBack(_entityComponent)
end

function EntityUtility.GetHeroUIEntityByUIEntityCid(uiEntityCid, parentTrans, position, callback)
	return EntityUtility.GetUIEntitySpineByCid(uiEntityCid, parentTrans, position, callback)
end

function EntityUtility.GetHeroUIEntityBySkinConfig(skinCfg, parentTrans, position, callback)
	return EntityUtility.GetUIEntitySpineByCid(skinCfg.UIEntityID, parentTrans, position, callback)
end

function EntityUtility.GetHeroUIEntity_NormalSkin(heroCid, parentTrans, position, callback)
	local skinCfg = SkinModule.GetHeroDefaultSkinCfg(heroCid)

	return EntityUtility.GetUIEntitySpineByCid(skinCfg.UIEntityID, parentTrans, position, callback)
end

function EntityUtility.GetHeroUIEntity_CurrentSkin(heroCid, parentTrans, position, callback)
	local skinCfg = SkinModule.GetHeroCurrentSkinConfig(heroCid)

	return EntityUtility.GetUIEntitySpineByCid(skinCfg.UIEntityID, parentTrans, position, callback)
end

function EntityUtility.GetHeroUIEntityByDynamicPrefabCid(uiEntityCid, parentTrans, position, callback)
	local uniqueEntityID = GameEntry.Entity:GenerateEntityID()

	EntityUtility.callbackList[tostring(uniqueEntityID)] = callback

	GameEntry.Entity:ShowBattleElement(uniqueEntityID, uiEntityCid, 0, parentTrans, position)

	return uniqueEntityID
end

function EntityUtility.GetHeroUIDynamicPrefabBySkinConfig(skinCfg, parentTrans, position, callback)
	return EntityUtility.GetHeroUIEntityByDynamicPrefabCid(skinCfg.UIDynamicEntityID, parentTrans, position, callback)
end

function EntityUtility.GetHeroUIDynamicPrefab_NormalSkin(heroCid, parentTrans, position, callback)
	local skinCfg = SkinModule.GetHeroDefaultSkinCfg(heroCid)

	return EntityUtility.GetHeroUIEntityByDynamicPrefabCid(skinCfg.UIDynamicEntityID, parentTrans, position, callback)
end

function EntityUtility.GetHeroUIDynamicPrefab_CurrentSkin(heroCid, parentTrans, position, callback)
	local skinCfg = SkinModule.GetHeroCurrentSkinConfig(heroCid)

	return EntityUtility.GetHeroUIEntityByDynamicPrefabCid(skinCfg.UIDynamicEntityID, parentTrans, position, callback)
end
