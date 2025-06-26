-- chunkname: @IQIGame\\Scene\\Battle\\BattleTimelineViewManager.lua

local TimelineViewData = {
	customCasterEntityId = 0,
	needUnitFlip = false,
	instanceID = 0,
	Cid = 0,
	effectTable = {},
	hitEffectTable = {}
}

function TimelineViewData.New(timelineCid, needUnitFlip, callback)
	local obj = Clone(TimelineViewData)

	obj:__Init(timelineCid, needUnitFlip, callback)

	return obj
end

function TimelineViewData:__Init(timelineCid, needUnitFlip, callback)
	self.Cid = timelineCid
	self.needUnitFlip = needUnitFlip
	self.effectTable = {}

	local timelineConfig = CfgTimelineTable[timelineCid]

	if timelineConfig == nil then
		logError("加载战斗单位的 Timeline资源错误：timelineCid={0} ", tostring(timelineCid))

		return
	end

	EntityUtility.GetBattleTimelineAsset(self, timelineConfig.timeline, function(_asset)
		self.timelineAsset = UnityEngine.GameObject.Instantiate(_asset)
		self.instanceID = self.timelineAsset:GetInstanceID()

		callback(self.instanceID, self.timelineAsset)
	end)

	if not LuaUtility.StrIsNullOrEmpty(timelineConfig.Cinemachine) then
		EntityUtility.GetBattleCinemachineAsset(self, timelineConfig.Cinemachine, function(_asset)
			self.cinemachinePrefab = UnityEngine.Object.Instantiate(_asset, BattleModule.battleScene.cinemachineRoot.transform)

			self.cinemachinePrefab.gameObject:SetActive(true)

			if self.needUnitFlip then
				Battle.BattleTimelineManager.ReversalCinemachinePrefab(self.cinemachinePrefab.gameObject)
			end
		end)
	end

	if timelineConfig.Caster ~= nil and timelineConfig.Caster > 0 then
		self.customCasterEntityId = EntityUtility.GetBattleEntity(timelineConfig.Caster, BattleModule.battleScene.tempSourceRoot.transform, Vector3.zero, function(entityComponent)
			self.customCaster = entityComponent.gameObject
		end)
	end
end

function TimelineViewData:AddEffect(hitID, trackInstanceID, effectEntityID)
	if hitID == 0 then
		self.effectTable[trackInstanceID] = effectEntityID
	else
		if self.hitEffectTable[hitID] == nil then
			self.hitEffectTable[hitID] = {}
		end

		self.hitEffectTable[hitID][trackInstanceID] = effectEntityID
	end
end

function TimelineViewData:IsReady()
	if self.timelineAsset == nil then
		return false
	end

	for _trackInstanceID, effectEntityID in pairs(self.effectTable) do
		if GameEntry.Entity:GetEntity(effectEntityID) == nil then
			return false
		end
	end

	return true
end

function TimelineViewData:Dispose()
	for _trackInstanceID, _effectEntityID in pairs(self.effectTable) do
		GameEntry.Entity:HideEntity(_effectEntityID)
	end

	for _hitIndex, _hitEffects in pairs(self.hitEffectTable) do
		for _trackInstanceID, _effectEntityID in pairs(_hitEffects) do
			GameEntry.Entity:HideEntity(_effectEntityID)
		end
	end

	self.customCaster = nil

	if self.customCasterEntityId ~= nil and self.customCasterEntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.customCasterEntityId)
	end

	self.timelineAsset = nil

	GameObject.Destroy(self.cinemachinePrefab)

	self.cinemachinePrefab = nil

	AssetUtil.UnloadAsset(self)
end

function TimelineViewData:OnRest()
	if self.customCaster ~= nil then
		local parent = BattleModule.battleScene.tempSourceRoot.transform

		self.customCaster.transform:SetParent(parent, false)
	end

	for _trackInstanceID, _effectEntityID in pairs(self.effectTable) do
		TimelineViewData.__ResetEffect(_effectEntityID)
	end

	for _hitIndex, _hitEffects in pairs(self.hitEffectTable) do
		for _trackInstanceID, _effectEntityID in pairs(_hitEffects) do
			TimelineViewData.__ResetEffect(_effectEntityID)
		end
	end
end

function TimelineViewData.__ResetEffect(effectEntityID)
	local effect = GameEntry.Entity:GetEntity(effectEntityID)

	if effect ~= nil then
		local parent = BattleModule.battleScene.tempSourceRoot.transform

		effect.gameObject.transform:SetParent(parent)
	end
end

local m = {
	unitTimelines = {},
	timelineInsIDTable = {}
}

function m.New()
	local obj = Clone(m)

	obj:__Init()

	return obj
end

function m:__Init()
	self.unitTimelines = {}
	self.timelineInsIDTable = {}

	BordlessFramework.PluginExtension.PlayableWatcher.SetIsWatching(true)
end

function m:Dispose(timelineManager)
	BordlessFramework.PluginExtension.PlayableWatcher.SetIsWatching(false)
	self:Clear(timelineManager)
end

function m:Clear(timelineManager)
	BordlessFramework.PluginExtension.PlayableWatcher.Reset()

	self.timelineInsIDTable = {}

	ForPairs(self.unitTimelines, function(k, v)
		self:__RemoveTimelineData(v, timelineManager)
	end)

	self.unitTimelines = {}
end

function m:AddSkillTimeline(battleUnitID, skillCid, timelineCid, callback)
	if timelineCid == 0 or timelineCid == nil then
		logError("加载 战斗单位 {0}， 技能 {1} Timeline 错误，TimelineCid {2}", battleUnitID, skillCid, timelineCid)

		return
	end

	local timelineData = self:__GetUnitTimeline(battleUnitID)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)

	if timelineData.skillTimeline[skillCid] ~= nil then
		return
	end

	timelineData.skillTimeline[skillCid] = TimelineViewData.New(timelineCid, battleUnitData.isUnitFlip, function(timelineInsID, timelineAsset)
		self.timelineInsIDTable[timelineInsID] = timelineData.skillTimeline[skillCid]

		callback(timelineInsID, timelineAsset)
	end)
end

function m:AddStateTimeline(battleUnitID, state, timelineCid, callback)
	if timelineCid == 0 or timelineCid == nil then
		logError("加载 战斗单位 {0}， 状态 {1} Timeline 错误，TimelineCid {2} 皮肤:", battleUnitID, state, timelineCid, skinCid)

		return
	end

	local timelineData = self:__GetUnitTimeline(battleUnitID)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
	local skinCid = battleUnitData.PODData.HeroSkinId

	if timelineData.stateTimeline[skinCid] == nil then
		timelineData.stateTimeline[skinCid] = {}
	end

	if timelineData.stateTimeline[skinCid][state] ~= nil then
		return
	end

	timelineData.stateTimeline[skinCid][state] = TimelineViewData.New(timelineCid, battleUnitData.isUnitFlip, function(timelineInsID, timelineAsset)
		self.timelineInsIDTable[timelineInsID] = timelineData.stateTimeline[skinCid][state]

		callback(timelineInsID, timelineAsset)
	end)
end

function m:InitTimelineEffect(timelineInsID, hitIndex, particleTrackInsID, effectEntityID)
	local effectEntityCfg = CfgEffectEntityTable[effectEntityID]

	if effectEntityCfg == nil then
		logError("Timeline 初始化特效错误，EffectEntity 找不到ID {0} 的配置", effectEntityID)

		return
	end

	local timelineData = self.timelineInsIDTable[timelineInsID]
	local entityId = GameEntry.Entity:GenerateEntityID()

	timelineData:AddEffect(hitIndex, particleTrackInsID, entityId)

	local path = EntityUtility.GetElementAssetPath(effectEntityCfg.PrefabName)
	local parent = BattleModule.battleScene.tempSourceRoot.transform

	GameEntry.Entity:ShowCommonEntity_Effect(entityId, path, 0, parent, Vector3.zero)
end

function m:__GetUnitTimeline(battleUnitID)
	if self.unitTimelines[battleUnitID] == nil then
		self.unitTimelines[battleUnitID] = {
			skillTimeline = {},
			stateTimeline = {}
		}
	end

	return self.unitTimelines[battleUnitID]
end

function m:CheckBattleUnitTimelineIsReady(battleUnitID)
	local timelineData = self:__GetUnitTimeline(battleUnitID)

	for _skilId, _timelineLuaData in pairs(timelineData.skillTimeline) do
		if not _timelineLuaData:IsReady() then
			return false
		end
	end

	local isStateTimelineReady = true

	ForPairs(timelineData.stateTimeline, function(_skinCid, _stateTimeLines)
		ForPairs(_stateTimeLines, function(_state, _timelineLuaData)
			if not _timelineLuaData:IsReady() then
				isStateTimelineReady = false

				return true
			end
		end)
	end)

	return isStateTimelineReady
end

function m:GetStateTimeline(battleUnitID, state)
	local timelineData = self:__GetUnitTimeline(battleUnitID)
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
	local skinCid = battleUnitData.PODData.HeroSkinId

	if timelineData.stateTimeline == nil then
		return nil
	end

	if timelineData.stateTimeline[skinCid] == nil then
		return nil
	end

	return timelineData.stateTimeline[skinCid][state]
end

function m:GetSkillTimeline(battleUnitID, skillCid)
	local timelineData = self:__GetUnitTimeline(battleUnitID)

	return timelineData.skillTimeline[skillCid]
end

function m:RemoveBattleUnitTimeline(battleUnitID, timelineManager)
	local timelineData = self.unitTimelines[battleUnitID]

	if timelineData == nil then
		return
	end

	self:__RemoveTimelineData(timelineData, timelineManager)

	self.unitTimelines[battleUnitID] = nil
end

function m:__RemoveTimelineData(timelineData, timelineManager)
	ForPairs(timelineData.stateTimeline, function(_skinCid, _stateTimeLines)
		ForPairs(_stateTimeLines, function(_state, _stateTimeline)
			self.timelineInsIDTable[_stateTimeline.instanceID] = nil

			timelineManager:RemoveTimeline(_stateTimeline.instanceID)
			_stateTimeline:Dispose()
		end)
	end)

	timelineData.stateTimeline = nil

	for _, _skillTimeline in pairs(timelineData.skillTimeline) do
		self.timelineInsIDTable[_skillTimeline.instanceID] = nil

		timelineManager:RemoveTimeline(_skillTimeline.instanceID)
		_skillTimeline:Dispose()
	end

	timelineData.skillTimeline = nil
end

return m
