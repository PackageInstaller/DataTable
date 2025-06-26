-- chunkname: @IQIGame\\Module\\Battle\\BattleTimelineModule.lua

local BattleTimelineViewManager = require("IQIGame/Scene/Battle/BattleTimelineViewManager")

BattleTimelineModule = {}

function BattleTimelineModule.Init(battleScene)
	BattleTimelineModule.battleScene = battleScene
	BattleTimelineModule.timelineManager = battleScene.timelineManager:GetComponent(typeof(Battle.BattleTimelineManager))
	BattleTimelineModule.timelineManager.AudioSource.volume = SettingModule.currentMusicVolume * SettingModule.AllAudioVolume
	BattleTimelineModule.viewManager = BattleTimelineViewManager.New()
end

function BattleTimelineModule.Revert()
	BattleTimelineModule.viewManager:Clear(BattleTimelineModule.timelineManager)
end

function BattleTimelineModule.Dispose()
	BattleTimelineModule.battleScene = nil

	BattleTimelineModule.viewManager:Dispose(BattleTimelineModule.timelineManager)

	BattleTimelineModule.timelineManager = nil
end

function BattleTimelineModule.AddSkillTimeline(battleUnitID, skillCid, timelineCid)
	if timelineCid == 0 or timelineCid == nil then
		log("加载 战斗单位 {0}， 技能 {1} Timeline 错误，TimelineCid {2}", battleUnitID, skillCid, timelineCid)

		return
	end

	BattleTimelineModule.viewManager:AddSkillTimeline(battleUnitID, skillCid, timelineCid, BattleTimelineModule.__AddTimelineToCSharp)
end

function BattleTimelineModule.AddStateTimeline(battleUnitID, stateType, timelineCid)
	if timelineCid == 0 or timelineCid == nil then
		log("加载 战斗单位 {0}， 状态 {1} Timeline 错误，TimelineCid {2}", battleUnitID, stateType, timelineCid)

		return
	end

	BattleTimelineModule.viewManager:AddStateTimeline(battleUnitID, stateType, timelineCid, BattleTimelineModule.__AddTimelineToCSharp)
end

function BattleTimelineModule.RemoveTimeline(battleUnitID)
	BattleTimelineModule.viewManager:RemoveBattleUnitTimeline(battleUnitID, BattleTimelineModule.timelineManager)
end

function BattleTimelineModule.__AddTimelineToCSharp(timelineInsID, timelineAsset)
	local timelineData = BattleTimelineModule.timelineManager:AddTimeline(timelineInsID, timelineAsset)

	local function _initEffectFunc(_timelineInsID, _key, _particleGroupData)
		if _particleGroupData.EffectEntityID ~= 0 then
			BattleTimelineModule.viewManager:InitTimelineEffect(_timelineInsID, _key, _particleGroupData.InstanceID, _particleGroupData.EffectEntityID)
		end
	end

	for i = 0, timelineData.NormalParticleGroupData.Count - 1 do
		_initEffectFunc(timelineInsID, 0, timelineData.NormalParticleGroupData[i])
	end

	timelineData:ForeachHitParticleGroupData(function(key, lst)
		for i = 0, lst.Count - 1 do
			_initEffectFunc(timelineInsID, key, lst[i])
		end
	end)
end

function BattleTimelineModule.PlayStateTimeline(battleUnitId, state, callback)
	local timelineViewData = BattleTimelineModule.viewManager:GetStateTimeline(battleUnitId, state)

	if timelineViewData == nil then
		if callback ~= nil then
			callback()
		end

		return
	end

	local function preFunc(timelineCfg, timelineViewData, unitData, unitView)
		BattleTimelineModule.__CommonPrepareTimelineHandler(timelineCfg, timelineViewData, unitData, unitView)
	end

	local function callbackEvent(_isSuccess)
		if not _isSuccess then
			logError("play battleUnit {0} state {1} Timeline Fail.", battleUnitId, state)
		end

		if timelineViewData ~= nil then
			timelineViewData:OnRest()
		end

		BattleTimelineModule.__CommonTimelineCompleteHandler()

		if callback ~= nil then
			callback()
		end
	end

	BattleTimelineModule.__PlayTimeline(battleUnitId, timelineViewData, nil, nil, preFunc, callbackEvent)

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitId)

	if battleUnitData.troopType == BattleModule.playerBattleTroop and state == BattleConstant.BattleStateTimelineType.Die then
		CVModule.PlayCV(Constant.CVActionType.FightRoleDead, battleUnitData:GetHeroCid())
	end
end

function BattleTimelineModule.PlaySkillTimeline(casterUnitID, skillCid, hitUnitIDs, callback)
	local timelineViewData = BattleTimelineModule.viewManager:GetSkillTimeline(casterUnitID, skillCid)
	local casterView

	local function bindingDataExFunc(bindingData, timelineCfg, casterUnitData, casterUnitView)
		BattleTimelineModule.__SkillBindingDataEx(skillCid, hitUnitIDs, bindingData, timelineCfg, casterUnitData, casterUnitView)
	end

	local function preFunc(timelineCfg, timelineViewData, unitData, unitView)
		casterView = unitView

		BattleTimelineModule.__CommonPrepareTimelineHandler(timelineCfg, timelineViewData, unitData, unitView)
		BattleTimelineModule.__HideBattleUnisByTimelineConfig(timelineCfg, unitData, unitView, hitUnitIDs)
	end

	local function callbackEvent(_isSuccess)
		if not _isSuccess then
			logError("play battleUnit {0} skill {1} Timeline Fail.", casterUnitID, skillCid)
		end

		if timelineViewData ~= nil then
			timelineViewData:OnRest()
		else
			logError("----->>这里要卡死了")
		end

		BattleTimelineModule.__CommonTimelineCompleteHandler()

		if callback ~= nil then
			callback()
		end
	end

	BattleTimelineModule.__PlayTimeline(casterUnitID, timelineViewData, nil, bindingDataExFunc, preFunc, callbackEvent)

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(casterUnitID)

	if battleUnitData.troopType == BattleModule.attackBattleTroopType then
		local skillData = battleUnitData:GetSkillData(skillCid)

		if skillData.skillType == Constant.SkillType.TYPE_NORMAL then
			CVModule.PlayCV(Constant.CVActionType.FightAttackFire, battleUnitData:GetHeroCid())
		elseif skillData.skillType == Constant.SkillType.TYPE_ULTIMATE then
			CVModule.PlayCV(Constant.CVActionType.FightSkillFire, battleUnitData:GetHeroCid())
		elseif skillData.skillType == Constant.SkillType.TYPE_DISPLACEMENT then
			CVModule.PlayCV(Constant.CVActionType.FightDIYFire, battleUnitData:GetHeroCid())
		end
	end

	if casterView == nil then
		return 0
	end

	return casterView.playableDirector.gameObject:GetInstanceID()
end

function BattleTimelineModule.__CommonPrepareTimelineHandler(timelineCfg, timelineViewData, casterUnitData, casterUnitView)
	local function foreachBattleUnitFunc(_unitID, _unitView)
		local unitData = BattleModule.GetBattleUnitDataByUnitID(_unitID)

		if unitData:IsDead() then
			return
		end

		if timelineCfg.CloseRoleEffect then
			_unitView:SetRoleEffectEnable(false)
		end
	end

	BattleTimelineModule.battleScene:ForeachBattleUnitView(foreachBattleUnitFunc)
end

function BattleTimelineModule.__CommonTimelineCompleteHandler()
	local function resetBattleUnitFunc(_unitID, _unitView)
		local unitData = BattleModule.GetBattleUnitDataByUnitID(_unitID)

		if unitData:IsDead() then
			return
		end

		_unitView:SetVisible(true)
		_unitView:SetHeroPropertyActive(true)
		_unitView:SetRoleEffectEnable(true)
	end

	BattleTimelineModule.battleScene:ForeachBattleUnitView(resetBattleUnitFunc)
	BattleTimelineModule.battleScene:ForeachBattleTileView(function(_unitID, _tileView)
		if _tileView:GetHasBuff() then
			_tileView:SetEffectVisiable(true)
		end
	end)
end

function BattleTimelineModule.__SkillBindingDataEx(skillCid, hitUnitIDs, bindingData, timelineCfg, casterUnitData, casterUnitView)
	local battleSkillData = casterUnitData:GetSkillData(skillCid)
	local casterDirection = casterUnitData.troopType == BattleModule.attackBattleTroopType and BattleConstant.BattlePosDirection.Left or BattleConstant.BattlePosDirection.Right
	local skillDirection = BattleConstant.BattlePosDirection.Left

	if battleSkillData.selectCamp == 2 or battleSkillData.selectCamp == 3 then
		if casterUnitData.troopType == BattleModule.attackBattleTroopType then
			skillDirection = BattleConstant.BattlePosDirection.Left
		else
			skillDirection = BattleConstant.BattlePosDirection.Right
		end
	elseif casterUnitData.troopType == BattleModule.attackBattleTroopType then
		skillDirection = BattleConstant.BattlePosDirection.Right
	else
		skillDirection = BattleConstant.BattlePosDirection.Left
	end

	local firstAttackUnitTileIndex = -1
	local hitViews = {}

	for hitUnitID, _ in pairs(hitUnitIDs) do
		local hitUnitData = BattleModule.GetBattleUnitDataByUnitID(hitUnitID)

		if hitUnitData ~= nil then
			local hitUnitView = BattleTimelineModule.battleScene:GetBattleUnitViewByID(hitUnitID)

			hitViews[hitUnitData.battlePos] = hitUnitView

			if firstAttackUnitTileIndex == -1 then
				firstAttackUnitTileIndex = hitUnitData.battlePos
			end
		else
			logError("SkillHit 目标找不到对应数据 {0}", hitUnitID)
		end
	end

	bindingData:SetSkillColAndRow(skillDirection, casterDirection, firstAttackUnitTileIndex)

	for battlePos, hitView in pairs(hitViews) do
		bindingData:AddTarget(battlePos, hitView.skinEntityGo)
	end
end

function BattleTimelineModule.__PlayTimeline(casterUnitID, timelineViewData, conditionExFunc, bindingDataExFunc, preEvent, callback)
	if timelineViewData == nil or timelineViewData ~= nil and timelineViewData.timelineAsset == nil then
		callback(false)

		return
	end

	local timelineCfg = CfgTimelineTable[timelineViewData.Cid]

	if conditionExFunc ~= nil and not conditionExFunc(timelineViewData, timelineCfg) then
		callback(false)

		return
	end

	local casterUnitView = BattleTimelineModule.battleScene:GetBattleUnitViewByID(casterUnitID)

	casterUnitView.playableDirector.playableAsset = timelineViewData.timelineAsset

	function casterUnitView.OnTimelineCompletedEvent()
		callback(true)
	end

	BattleTimelineModule.__BindingTimelineParticle(casterUnitView.playableDirector, timelineViewData)

	local casterUnitData = BattleModule.GetBattleUnitDataByUnitID(casterUnitID)
	local bindingData = BattleTimelineModule.timelineManager:CreateTimelineBindingData(casterUnitView.skinEntityGo, timelineCfg.HitBindingType)

	bindingData:SetUnitFlip(casterUnitData.isUnitFlip)

	if timelineCfg.HitType == 5 then
		local view = BattleTimelineModule.battleScene:GetBattleUnitSkinView(casterUnitID)

		bindingData:SetCustomCaster(view.skinEntityGo)
	elseif timelineViewData.customCaster ~= nil then
		bindingData:SetCustomCaster(timelineViewData.customCaster)
	end

	if timelineViewData.cinemachinePrefab ~= nil then
		bindingData:SetVirtualCameraRoot(timelineViewData.cinemachinePrefab)
	end

	if bindingDataExFunc ~= nil then
		bindingDataExFunc(bindingData, timelineCfg, casterUnitData, casterUnitView)
	end

	if preEvent ~= nil then
		preEvent(timelineCfg, timelineViewData, casterUnitData, casterUnitView)
	end

	BattleTimelineModule.timelineManager:PlayTimeline(timelineViewData.instanceID, casterUnitView.playableDirector, bindingData)
end

function BattleTimelineModule.__BindingTimelineParticle(playableDirector, timelineViewData)
	local function __bindingParticleFunc(_effectEntityID, _trackIndex, _hitIndex)
		local effectEntity = GameEntry.Entity:GetEntity(_effectEntityID)

		if effectEntity ~= nil then
			BattleTimelineModule.timelineManager:BindingTimelineParticleByInstanceID(playableDirector, timelineViewData.instanceID, _trackIndex, _hitIndex, effectEntity.gameObject)
		end
	end

	for _trackIndex, _effectEntityID in pairs(timelineViewData.effectTable) do
		__bindingParticleFunc(_effectEntityID, _trackIndex, 0)
	end

	for _hitIndex, _effectTable in pairs(timelineViewData.hitEffectTable) do
		for _trackIndex, _effectEntityID in pairs(_effectTable) do
			__bindingParticleFunc(_effectEntityID, _trackIndex, _hitIndex)
		end
	end
end

function BattleTimelineModule.__HideBattleUnisByTimelineConfig(timelineCfg, casterUnitData, casterUnitView, hitUnitIDs)
	if timelineCfg.MaskType == 0 then
		return
	end

	casterUnitView:SetVisible(true)
	casterUnitView:SetHeroPropertyActive(false)

	local function _hideLogicFunc(_maskType, _unitID, _unitView)
		if _unitID == casterUnitData.battleUnitID then
			return
		end

		local unitData = BattleModule.GetBattleUnitDataByUnitID(_unitID)

		if unitData:IsDead() then
			return
		end

		if _maskType == 4 then
			local visible = hitUnitIDs[_unitID] ~= nil

			_unitView:SetVisible(visible)
			_unitView:SetHeroPropertyActive(false)
		elseif _maskType == 3 then
			if casterUnitData.troopType ~= unitData.troopType then
				_unitView:SetVisible(false)
				_unitView:SetHeroPropertyActive(false)
			end
		elseif _maskType == 2 then
			if casterUnitData.troopType == unitData.troopType then
				_unitView:SetVisible(false)
				_unitView:SetHeroPropertyActive(false)
			end
		elseif _maskType == 1 then
			_unitView:SetVisible(false)
			_unitView:SetHeroPropertyActive(false)
		end
	end

	BattleTimelineModule.battleScene:ForeachBattleUnitView(function(_unitID, _unitView)
		_hideLogicFunc(timelineCfg.MaskType, _unitID, _unitView)
	end)
	BattleTimelineModule.battleScene:ForeachBattleTileView(function(_unitID, _tileView)
		if _tileView:GetHasBuff() then
			_tileView:SetEffectVisiable(false)
		end
	end)
end

function BattleTimelineModule.CheckBattleUnitTimelineIsReady(battleUnitID)
	return BattleTimelineModule.viewManager:CheckBattleUnitTimelineIsReady(battleUnitID)
end

function BattleTimelineModule.OnSoundVolumeChanged(value)
	if BattleTimelineModule.timelineManager == nil then
		return
	end

	BattleTimelineModule.timelineManager.AudioSource.volume = value
end
