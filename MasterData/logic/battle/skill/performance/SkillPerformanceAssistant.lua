-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/SkillPerformanceAssistant.lua

module("logic.battle.skill.performance.SkillPerformanceAssistant", package.seeall)

local SkillPerformanceAssistant = class("SkillPerformanceAssistant")
local kSceneRoot = SceneMgr.instance:getSceneRoot()
local kBattleScene = SceneMgr.instance:getScene(SceneType.Battle)
local kMainCamera = CameraTargetMgr.instance:getMainCameraTarget()
local kMoveSpeed = 15
local kVictimXPositionDiff = {
	Vector3.New(0, 0, 0),
	Vector3.New(-1, 0, 0),
	Vector3.New(1, 0, 0),
	Vector3.New(0, 0, 1),
	Vector3.New(-1, 0, 1),
	Vector3.New(1, 0, 1),
	Vector3.New(0, 0, 2),
	Vector3.New(-1, 0, 2),
	Vector3.New(1, 0, 2),
	Vector3.New(0, 0, 3),
	Vector3.New(-1, 0, 3),
	Vector3.New(1, 0, 3)
}

function SkillPerformanceAssistant:getVictimPositionDiff(index)
	return kVictimXPositionDiff[index]
end

function SkillPerformanceAssistant:resetVSUnitsPosition(context)
	local skillVSInfo = context:getSkillVSInfo()
	local attacker = skillVSInfo:getAttacker()
	local victim = skillVSInfo:getVictim()

	BattleUnitGenerator.addUnitToRoot(attacker, kSceneRoot)
	BattleUnitGenerator.addUnitToRoot(victim, kSceneRoot)

	local isReversePosition = skillVSInfo:isReversePosition()
	local attackerInitPosition = context:judgeAttackerInitPosition(isReversePosition)
	local victimInitPosition = context:judgeVictimInitPosition(isReversePosition)

	attacker.mover:setPosDirectly(attackerInitPosition.x, attackerInitPosition.z)
	attacker.meshModel:lookAtDirVec3(isReversePosition and MeshModelDirection.Left or MeshModelDirection.Right)
	victim.mover:setPosDirectly(victimInitPosition.x, victimInitPosition.z)
	victim.meshModel:lookAtDirVec3(isReversePosition and MeshModelDirection.Right or MeshModelDirection.Left)
end

function SkillPerformanceAssistant:recordUnitOfContext(context)
	local skillVSInfo = context:getSkillVSInfo()

	context:recordUnit(skillVSInfo:getAttacker())
	context:recordUnit(skillVSInfo:getVictim())
end

function SkillPerformanceAssistant:prepareUnitOfContext(context)
	local skillVSInfo = context:getSkillVSInfo()

	context:prepareUnit(skillVSInfo:getAttacker())
	context:prepareUnit(skillVSInfo:getVictim())
end

function SkillPerformanceAssistant:recordUnitOfAttackInfo(context, attackInfo)
	context:recordUnit(attackInfo:getAttacker())
	context:recordUnits(attackInfo:getVictims())
end

function SkillPerformanceAssistant:prepareUnitOfAttackInfo(context, attackInfo)
	context:prepareUnit(attackInfo:getAttacker())
	context:prepareUnits(attackInfo:getVictims())
end

function SkillPerformanceAssistant:normalizeVirtualCamera()
	VirtualCameraMgr.instance:setCameraRotation(0, 0, 0)
	VirtualCameraMgr.instance:setLookAtPosition(0, 0, 0)
end

function SkillPerformanceAssistant:activeAttackTemporaryCamera(context, duration)
	VirtualCameraMgr.instance:setBlendDuration(duration)
end

function SkillPerformanceAssistant:activeAdditionScene(attackInfo)
	kBattleScene.stage:activeAdditionScene()
	kBattleScene.light:activePerformanceLight()
end

function SkillPerformanceAssistant:hideUIProperties()
	local namebarRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

	goutil.setActive(namebarRoot, false)
end

function SkillPerformanceAssistant:hideSceneObjectRoot()
	SkillPerformanceMgr.instance:setSpecificPerformanceVisible(false)
	BattleGameObjectRootUtil.setVisibleForPerformance(false)
end

function SkillPerformanceAssistant:resetFromFocusPosition(skillVSInfo)
	local attacker = skillVSInfo:getAttacker()
	local victim = skillVSInfo:getVictim()

	BattleUnitGenerator.addUnitToScene(attacker)
	BattleUnitGenerator.addUnitToScene(victim)
	SkillPerformanceAssistant:switchUnit2LowModel(attacker)
	SkillPerformanceAssistant:switchUnit2LowModel(victim)
end

function SkillPerformanceAssistant:inactiveAttackTemporaryCamera(context, duration)
	local attacker = context:getSkillVSInfo():getAttacker()
	local victim = context:getSkillVSInfo():getVictim()

	VirtualCameraMgr.instance:setBlendDuration(duration)

	local weakPointBrokenEntityId = context:getParam(SkillTimelineContext.Param_WeakPointBrokenEntityId)

	if weakPointBrokenEntityId then
		local x, y, z = BattleWeakPointStatusChangedCommand:calculateUnitFocusPosition(victim)

		VirtualCameraMgr.instance:doFollowPosition(x, y, z, duration)
	else
		local x, y, z = BattleAdjustFollowCenterCommand:calculateCenterPositionXYZ(attacker, victim)

		VirtualCameraMgr.instance:doFollowPosition(x, y, z, duration)
	end
end

function SkillPerformanceAssistant:setCameraBlendDuration(duration)
	VirtualCameraMgr.instance:setBlendDuration(duration)
end

function SkillPerformanceAssistant:resetCameraBlendDuration()
	VirtualCameraMgr.instance:resetBlendDuration()
end

function SkillPerformanceAssistant:activeMainScene()
	kBattleScene.stage:activeMainScene()
	kBattleScene.light:activeNormalLight()
end

function SkillPerformanceAssistant:resetCharacterLight()
	local goLight = kBattleScene.light:getAdditionLightGameObject()

	if goLight then
		local lightWrapper = SpaceX.LightWrapper.Get(goLight)

		if lightWrapper then
			lightWrapper:ApplyOriginalColorAndRotation()
		end
	end
end

function SkillPerformanceAssistant:showUIProperties()
	local namebarRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

	goutil.setActive(namebarRoot, true)
end

function SkillPerformanceAssistant:showSceneObjectRoot()
	SkillPerformanceMgr.instance:setSpecificPerformanceVisible(true)
	BattleGameObjectRootUtil.setVisibleForPerformance(true)
end

function SkillPerformanceAssistant:isUnitNeedHitAnimation(unit)
	return not unit.stateEffect:isFrozen()
end

function SkillPerformanceAssistant:setupTimelineBindings(directorSetter, goTimeline, attackInfo)
	local cinemachineBrain = VirtualCameraMgr.instance:getCinemachineBrain()

	directorSetter:SetGenericBinding(SkillTimelineContext.CinemachineBrainTrack, cinemachineBrain)

	local goVCamera = GameObjectUtils.FindChildRecursively(goTimeline, 10, SkillTimelineContext.VCamera)

	if goVCamera then
		CinemachineLensAdapter.Get(goVCamera)
	end

	local attacker = attackInfo:getAttacker()

	if not attacker.property:isStateActive(BattleEnum.State.DEAD) then
		directorSetter:SetGenericBinding(SkillTimelineContext.AttackerAnimationTrack, attacker.meshModel:getAnimationPlayer())
		directorSetter:SetGenericBinding(SkillTimelineContext.AttackerFaceAnimationTrack, attacker.meshModel:getAnimationPlayer())
	end

	local victims = attackInfo:getVictims()

	if #victims > 1 then
		local goVictimRoot = GameObjectUtils.FindChildRecursively(goTimeline, 10, SkillTimelineContext.VictimRoot)

		if goVictimRoot then
			local animationPlayerCollection = AnimationPlayerCollection.Get(goVictimRoot)

			for _, victim in ipairs(victims) do
				if victim ~= attacker and SkillPerformanceAssistant:isUnitNeedHitAnimation(victim) then
					animationPlayerCollection:AddAnimationPlayer(victim.meshModel:getAnimationPlayer())
				end
			end

			directorSetter:SetGenericBinding(SkillTimelineContext.VictimAnimationTrack, animationPlayerCollection)
		end
	elseif #victims > 0 then
		local victim = victims[1]

		if SkillPerformanceAssistant:isUnitNeedHitAnimation(victim) then
			directorSetter:SetGenericBinding(SkillTimelineContext.VictimAnimationTrack, victim.meshModel:getAnimationPlayer())
		end
	end

	local goAttackerSynchronizerRoot = GameObjectUtils.FindChildRecursively(goTimeline, 2, SkillTimelineContext.AttackerSynchronizerRoot)

	if goAttackerSynchronizerRoot then
		local attackerSynchronizer = ModelSynchronizer.Get(goAttackerSynchronizerRoot)
		local attackerAnimationPlayer = attacker.meshModel:getAnimationPlayer()

		attackerSynchronizer:SetSource(attackerAnimationPlayer.gameObject)
		SkillPerformanceAssistant:setupModelFeatureSynchronizerTarget(goAttackerSynchronizerRoot, attackerAnimationPlayer.gameObject)
	end

	local goVictimSynchronizerRoot = GameObjectUtils.FindChildRecursively(goTimeline, 2, SkillTimelineContext.VictimSynchronizerRoot)

	if goVictimSynchronizerRoot then
		local goVictimRoot = GameObjectUtils.FindChildRecursively(goTimeline, 10, SkillTimelineContext.VictimRoot)

		if goVictimRoot then
			SkillPerformanceAssistant:setupModelFeatureSynchronizerTarget(goVictimSynchronizerRoot, goVictimRoot)
		end
	end

	if directorSetter:ContainsGenericBindingKey(SkillTimelineContext.ToonMaskTrack) then
		for _, victim in ipairs(victims) do
			victim.material:turnOnLayerMask(RenderingLayerMask.Layer18)
		end
	end

	local goCharacterLight = kBattleScene.light:getCharacterLightGameObject()

	if goCharacterLight then
		local lightAnimator = goutil.addComponentOnce(goCharacterLight, ComponentType.Animator)

		directorSetter:SetGenericBinding(SkillTimelineContext.CharacterLightTrack, lightAnimator)
	end

	local activeCamera = VirtualCameraMgr.instance:getActiveCamera()

	directorSetter:SetGenericBinding(SkillTimelineContext.NormalRelativeVirtualCameraTrack, activeCamera:getVirtualCameraAnimator())
	directorSetter:SetGenericBinding(SkillTimelineContext.NormalCameraShakeTrack, activeCamera:getVirtualCamera())

	if directorSetter:ContainsGenericBindingKey(SkillTimelineContext.SceneActiveTrack) then
		local sceneName = kBattleScene.stage:getAdditionSceneName()
		local sceneActiveSetter = goTimeline:GetComponent(typeof(Timeline.SceneActiveSetter))

		if sceneActiveSetter then
			sceneActiveSetter:SetScene(sceneName)
		end
	end

	local goFeature = GameObjectUtils.FindChildRecursively(goTimeline, 3, SkillTimelineContext.UnitFeature)

	if goFeature then
		SkillPerformanceAssistant:setupModelFeatureSynchronizerTarget(goFeature, attacker.mountRoot:getAvatarRoot())
	end

	if directorSetter:ContainsGenericBindingKey(SkillTimelineContext.ActiveVirtualCameraTrack) then
		local camera = VirtualCameraMgr.instance:getActiveCamera()

		directorSetter:SetGenericBinding(SkillTimelineContext.ActiveVirtualCameraTrack, camera:getGo())
	end
end

function SkillPerformanceAssistant:setupBullet(directorSetter, goTimeline, attackInfo)
	local goBullet = goutil.findChild(goTimeline, SkillTimelineContext.Bullet)

	if goBullet then
		local bindingMovable = BindingMovable.Get(goBullet)
		local x1, y1, z1 = BattleUnitUtil.getUnitCenterPos(attackInfo:getAttacker())
		local x2, y2, z2 = BattleUnitUtil.getUnitCenterPos(attackInfo:getFirstVictim())

		bindingMovable:SetBeginPosition(x1, y1, z1)
		bindingMovable:SetEndPosition(x2, y2, z2)
	end
end

function SkillPerformanceAssistant:setupUnitXinMao(attackInfo)
	local attacker = attackInfo:getAttacker()
	local goInst = attacker.meshModel:getInst()
	local xinMao = Astral.SimpleLuaComponentContainer.Add(goInst, UnitCompHeroXinMao)
	local modelCode = attacker.property:getModelCode()

	xinMao:setInfo(modelCode, goInst)
end

function SkillPerformanceAssistant:setupLoopRegionFeature(directorSetter, goTimeline, attackInfo)
	local continuousType = attackInfo:getContinuousType()

	if continuousType == BattleEnum.SkillContinuousType.LOOP_TIMELINE then
		local continuousCount = attackInfo:getContinuousCount()
		local regionBinding = LoopRegionBinding.Get(goTimeline)

		regionBinding:SetLoopCount(0, continuousCount)
		directorSetter:SetGenericBinding(SkillTimelineContext.LoopRegionTrack, regionBinding)
	end
end

function SkillPerformanceAssistant:cleanupTimelineBindings(directorSetter, attackInfo)
	if directorSetter:ContainsGenericBindingKey(SkillTimelineContext.ToonMaskTrack) then
		local victims = attackInfo:getVictims()

		for _, victim in ipairs(victims) do
			victim.material:turnOffLayerMask(RenderingLayerMask.Layer18)
		end
	end

	local activeCamera = VirtualCameraMgr.instance:getActiveCamera()

	activeCamera:clearRelativeComponent()
	SkillPerformanceAssistant:resetCharacterLight()
end

function SkillPerformanceAssistant:setupModelFeatureSynchronizerTarget(goSynchronizer, goTarget)
	SpaceX.ModelModifierUtils.SetupSynchronizerTarget(goSynchronizer, goTarget)
end

function SkillPerformanceAssistant:collectSkillVSInfoPreloadList(resLoader, skillVSInfo)
	local preloadResPathList = skillVSInfo:getPreloadResPathList()

	for _, resPath in ipairs(preloadResPathList) do
		resLoader:addNormalRes(resPath)
	end

	SkillPerformanceAssistant:collectHighModelUrl(resLoader, skillVSInfo:getAttacker())
	SkillPerformanceAssistant:collectHighModelUrl(resLoader, skillVSInfo:getVictim())
end

function SkillPerformanceAssistant:collectAttackInfoPreloadList(resLoader, attackInfo)
	local attacker = attackInfo:getAttacker()

	SkillPerformanceAssistant:collectHighModelUrl(resLoader, attacker)

	if attackInfo:isStrengthening() then
		local modelCode = attacker.property:getModelCode()
		local modelData = ModelConfig.instance:getModelData(modelCode)
		local xinMaoUrl = modelData and modelData:getXinMaoPath()

		if xinMaoUrl then
			resLoader:addNormalRes(xinMaoUrl)
		end
	end

	local victims = attackInfo:getVictims()

	for _, victim in ipairs(victims) do
		SkillPerformanceAssistant:collectHighModelUrl(resLoader, victim)
	end
end

function SkillPerformanceAssistant:collectHighModelUrl(resLoader, unit)
	if not unit then
		return
	end

	local modelCode = unit.property:getModelCode()
	local modelCO = ModelConfig.instance:getModelConfig(modelCode)
	local url = ModelCOUtil.getHighModelUrl(modelCO)

	if url then
		resLoader:addModelRes(url)
	end
end

function SkillPerformanceAssistant:collecLowModelUrl(resLoader, unit)
	if not unit then
		return
	end

	local modelCode = unit.property:getModelCode()
	local modelCO = ModelConfig.instance:getModelConfig(modelCode)
	local url = ModelCOUtil.getLowModelUrl(modelCO)

	if url then
		resLoader:addModelRes(url)
	end
end

function SkillPerformanceAssistant:switchHighModel(attackInfo)
	local attacker = attackInfo:getAttacker()

	SkillPerformanceAssistant:switchUnit2HighModel(attacker)

	local victims = attackInfo:getVictims()

	for _, victim in ipairs(victims) do
		SkillPerformanceAssistant:switchUnit2HighModel(victim)
	end
end

function SkillPerformanceAssistant:switchUnit2HighModel(unit)
	local animState = unit.meshModelMover:getMappedAnimation(UnitAnimState.Idle2)

	unit.meshModelMover:mapSystemAnimation(UnitAnimState.Idle, animState)

	if SkillPerformanceAssistant:hasLowModel(unit) then
		local animationName = unit.meshModelMover:getMappedAnimation(UnitAnimState.Idle)

		unit.meshModel:setDefaultAnimation(animationName, true)
		BattleUnitGenerator.setModelQuality(unit, true)
		unit.effectPlayer:switchEffectWithModelUpdate(true)
	end
end

function SkillPerformanceAssistant:switchUnit2LowModel(unit)
	unit.meshModelMover:resetSystemMappedAnimation(UnitAnimState.Idle)

	if SkillPerformanceAssistant:hasLowModel(unit) then
		local animationName = unit.meshModelMover:getMappedAnimation(UnitAnimState.Idle)

		unit.meshModel:setDefaultAnimation(animationName, true)
		BattleUnitGenerator.setModelQuality(unit, false)
		unit.effectPlayer:switchEffectWithModelUpdate(false)
	end
end

function SkillPerformanceAssistant:hasLowModel(unit)
	local modelCO = ModelConfig.instance:getModelConfig(unit.property:getModelCode())

	return ModelCOUtil.hasLowModel(modelCO)
end

local kHitVoiceAnimationLight = {
	"hit1",
	"hit2",
	"hit_up",
	"hit_floating"
}
local kHitVoiceAnimationHeavy = {
	"hit3",
	"hit3_start"
}

function SkillPerformanceAssistant:handleHitVoice(unit, animationName, lastTimeStamp)
	if not unit or unit.property:isStateActive(BattleEnum.State.DEAD) then
		return lastTimeStamp
	end

	if animationName == BattleTimelineEventName.KeyLastHitAnimation then
		BattleAudioUtil.playVoice(unit, BattleAudioUtil.VoiceEnum.speech_hit_heavy_vo)

		return lastTimeStamp
	end

	if table.indexof(kHitVoiceAnimationLight, animationName) then
		local timeStamp = Time.realtimeSinceStartup

		if not lastTimeStamp or timeStamp - lastTimeStamp > 0.5 then
			BattleAudioUtil.playVoice(unit, BattleAudioUtil.VoiceEnum.speech_hit_light)

			return timeStamp
		end

		return lastTimeStamp
	end

	if table.indexof(kHitVoiceAnimationHeavy, animationName) then
		BattleAudioUtil.playVoice(unit, BattleAudioUtil.VoiceEnum.speech_hit_heavy)

		return lastTimeStamp
	end

	return lastTimeStamp
end

function SkillPerformanceAssistant:setupAOESkillTimelineAttackEffect(goTimeline, attackInfo)
	local attacker = attackInfo:getAttacker()
	local modelId = BattleSkillAssist.getModelShapeAoeSkillModelId(attackInfo:getSkillId(), attackInfo:isStrengthening())

	if not modelId then
		return
	end

	local goAoeAttackRoot = GameObjectUtils.FindChildRecursively(goTimeline, 10, SkillTimelineContext.SceneAOEAttackRoot)

	if not goAoeAttackRoot then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("Cannot find [scene_aoe_effect] for skill %s", attackInfo:getSkillId()))
		end

		return
	end

	local effectTemplate = goAoeAttackRoot.transform:GetChild(0)

	if not effectTemplate then
		if BattleLog.enableError then
			BattleLog.error(string.format("Cannot find effect template for skill %s", attackInfo:getSkillId()))
		end

		return
	end

	local unitMgr = BattleMgr.instance:getUnitMgr()
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local centerPosList = BattleTableUtil.getTempList()

	for _, unit in ipairs(unitMgr:getAllUnits()) do
		if unit:getUnitType() == BattleEnum.UnitType.Person and unit.property:getModelCode() == modelId then
			local minx, maxx, minz, maxz = BattleSkillAssist.calculateUnitRect(attacker, unit)
			local x1, y1, z1 = boardMgr:getCellPosition(BoardIndexConverter.coordinatesToUnionIndex(minx, minz)):Get()
			local x2, y2, z2 = boardMgr:getCellPosition(BoardIndexConverter.coordinatesToUnionIndex(maxx, maxz)):Get()

			table.insert(centerPosList, (x1 + x2) / 2)
			table.insert(centerPosList, (z1 + z2) / 2)
		end
	end

	local totalEffectCount = goAoeAttackRoot.transform.childCount
	local totalCount = #centerPosList / 2

	for i = 1, totalCount do
		local index = i * 2

		if i <= totalEffectCount then
			local transEffect = goAoeAttackRoot.transform:GetChild(i - 1)

			goutil.setActive(transEffect.gameObject, true)
			Astral.TransformUtil.SetPos(transEffect, centerPosList[index - 1], 0, centerPosList[index])
		else
			local goEffect = goutil.clone(effectTemplate).gameObject

			goutil.setActive(goEffect, true)
			goutil.addChildToParent(goEffect, goAoeAttackRoot)
			Astral.TransformUtil.SetPos(goEffect.transform, centerPosList[index - 1], 0, centerPosList[index])
		end
	end

	for i = totalCount + 1, totalEffectCount do
		local goEffect = goAoeAttackRoot.transform:GetChild(i - 1).gameObject

		goutil.setActive(goEffect, false)
	end

	BattleTableUtil.releaseTempList(centerPosList)
end

function SkillPerformanceAssistant:setupAOESkillTimelineHitEffect(goTimeline, attackInfo)
	local attacker = attackInfo:getAttacker()

	if not BattleSkillAssist.isAoeSkill(attackInfo:getSkillId(), attackInfo:isStrengthening()) then
		return
	end

	local goAoeAttackedRoot = GameObjectUtils.FindChildRecursively(goTimeline, 10, SkillTimelineContext.AOEAttackedRoot)

	if not goAoeAttackedRoot then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("Cannot find hit[aoeeffect] for %s", attackInfo:getSkillId()))
		end

		return
	end

	local effectTemplate = goAoeAttackedRoot.transform:GetChild(0)

	if not effectTemplate then
		if BattleLog.enableError then
			BattleLog.error(string.format("Cannot find template for %s", attackInfo:getSkillId()))
		end

		return
	end

	local victims = attackInfo:getVictims()
	local victimCount = #victims
	local totalEffectCount = goAoeAttackedRoot.transform.childCount

	for i = 1, victimCount do
		if i <= totalEffectCount then
			local transEffect = goAoeAttackedRoot.transform:GetChild(i - 1)

			goutil.setActive(transEffect.gameObject, true)

			local position = SkillPerformanceAssistant:getVictimPositionDiff(i)

			Astral.TransformUtil.SetLocalPos(transEffect, position.x, 0, position.z)
		else
			local goEffect = goutil.clone(effectTemplate).gameObject

			goutil.setActive(goEffect, true)
			goutil.addChildToParent(goEffect, goAoeAttackedRoot)

			local position = SkillPerformanceAssistant:getVictimPositionDiff(i)

			Astral.TransformUtil.SetLocalPos(goEffect.transform, position.x, 0, position.z)
		end
	end

	for i = victimCount + 1, totalEffectCount do
		local transEffect = goAoeAttackedRoot.transform:GetChild(i - 1)

		goutil.setActive(transEffect.gameObject, false)
	end
end

function SkillPerformanceAssistant:getSkillAudioName(perfromanceTimeline)
	return string.format("skill_%s_p", perfromanceTimeline)
end

function SkillPerformanceAssistant:playSkillAudio(unit, seName)
	BattleAudioUtil.playSEByName(seName, unit.mainGO)
end

function SkillPerformanceAssistant:playSkillSpeech(unit, perfromanceTimeline)
	local skillSpeechCueName = string.format("speech_%s_p", perfromanceTimeline)

	SkillPerformanceAssistant:playSkillAudio(unit, skillSpeechCueName)
end

return SkillPerformanceAssistant
