-- chunkname: @IQIGame\\Util\\TimeLine\\TimelineUtilityByLua.lua

TimelineUtilityByLua = {}
TimelineUtilityByLua.IsLogLoadTimelineEffect = false

local timelineAudioSource

TimelineUtilityByLua.commonVirtualCameras = {}

local commonPointParent
local commonVirtualCameraNames = {
	"default",
	"selectTarget",
	"friendlyCenter",
	"enemyCenter"
}

TimelineUtilityByLua.CinemachineBrain = nil
TimelineUtilityByLua.BattleCamera = nil
TimelineUtilityByLua.BattleCameraGameObjectName = "CommonBattleCamera"
TimelineUtilityByLua.TimelineEffectsToLoadCount = 0
TimelineUtilityByLua.E_EffectParentType = {
	Self = "Self",
	Undefine = "Undefine",
	PublicPoint = "PublicPoint",
	SkillTarget = "SkillTarget",
	Camera = "Camera"
}
TimelineUtilityByLua.E_SubEffectType = {
	Sub = "Sub",
	Main = "Main"
}
TimelineUtilityByLua.E_EffectSelfParent = {
	fx_center = "fx_center",
	fx_foot = "fx_foot",
	fx_head = "fx_head"
}
TimelineUtilityByLua.E_EffectPointParent = {
	other = "other",
	hero = "hero",
	enemy = "enemy"
}
TimelineUtilityByLua.E_EffectPointOther = {
	friendlyCenter = "friendlyCenter",
	enemyCenter = "enemyCenter"
}
TimelineUtilityByLua.E_Battle_VirtualCameraFollowTarget = {
	Grid = "Grid",
	Self = "Self",
	SkillTarget = "SkillTarget"
}
TimelineUtilityByLua.E_SignalClip_SignalType = {
	MoveBack = "MoveBack",
	MoveTo = "MoveTo",
	Attack = "Attack",
	Hit = "Hit"
}

local initialized = false

function TimelineUtilityByLua.Init()
	if initialized then
		return
	end

	initialized = true

	local obj = UnityEngine.GameObject("AudioSourceForTimeline")

	obj.hideFlags = UnityEngine.HideFlags.HideInHierarchy

	GameObject.DontDestroyOnLoad(obj)

	timelineAudioSource = obj:AddComponent(typeof(UnityEngine.AudioSource))
	timelineAudioSource.volume = SettingModule.currentMusicVolume * SettingModule.AllAudioVolume

	EventDispatcher.AddEventListener(EventID.SoundVolumeChange, TimelineUtilityByLua.OnSoundComponentSoundVolumeChanged)
end

local function TbContainsKey(targetTb, key)
	for i, _ in pairs(targetTb) do
		if i == key then
			return true
		end
	end

	return false
end

local function TbContainsValue(targetTb, value)
	for _, v in pairs(targetTb) do
		if v == value then
			return true
		end
	end

	return false
end

local function TbTryGetValue(targetTb, key)
	for i, v in pairs(targetTb) do
		if i == key then
			return v
		end
	end

	return nil
end

function TimelineUtilityByLua.OnSoundComponentSoundVolumeChanged(volume)
	if timelineAudioSource ~= nil then
		timelineAudioSource.volume = volume
	end
end

function TimelineUtilityByLua.InitCommonVirtualCameraAndPoint(luaBattleView)
	luaBattleView.commonVirtualCameras = {}

	local luaVirtualCameras = luaBattleView.commonVirtualCameras
	local battleCameraObj = UnityEngine.GameObject.Find(TimelineUtilityByLua.BattleCameraGameObjectName)

	TimelineUtilityByLua.CinemachineBrain = battleCameraObj:GetComponent("CinemachineBrain")
	TimelineUtilityByLua.BattleCamera = battleCameraObj:GetComponent("Camera")

	local CommonVirtualCameraTrans = UnityEngine.GameObject.Find("CommonVirtualCamera").transform
	local children = CommonVirtualCameraTrans:GetComponentsInChildren(typeof(Cinemachine.CinemachineVirtualCamera), true)

	for i = 0, children.Length - 1 do
		for _, name in pairs(commonVirtualCameraNames) do
			if name == children[i].name then
				TimelineUtility.commonVirtualCameras:set_Item(name, children[i])

				luaVirtualCameras[name] = children[i].gameObject
			end
		end
	end

	commonPointParent = UnityEngine.GameObject.Find("CommonPoint").transform
end

function TimelineUtilityByLua.LoadAttackTimelineEffect(playableAsset, playableDirector, selfTrans, isFriendly, cameraTransform, isActiveOnLoaded, battleUnitID)
	if isActiveOnLoaded == nil then
		-- block empty
	end

	return CoroutineUtility.StartCoroutine(TimelineUtilityByLua.LoadTimelineEffectCoroutine, playableAsset, playableDirector, selfTrans, isFriendly, cameraTransform, isActiveOnLoaded, battleUnitID)
end

function TimelineUtilityByLua.LoadAttackTimelineEffectCoroutine(playableAsset, playableDirector, selfTrans, isFriendly, cameraTransform, isActiveOnLoaded, battleUnitID)
	if isActiveOnLoaded == nil then
		-- block empty
	end

	return CoroutineUtility.Yield(TimelineUtilityByLua.LoadTimelineEffectCoroutine, playableAsset, playableDirector, selfTrans, isFriendly, cameraTransform, isActiveOnLoaded, battleUnitID)
end

function TimelineUtilityByLua.LoadTimelineEffectCoroutine(playableAsset, playableDirector, selfTrans, isFriendly, cameraTransform, isActiveOnLoaded, battleUnitID)
	if isActiveOnLoaded == nil then
		-- block empty
	end

	local effectGroupToEffects = {}
	local groupIndexToSubEffects = {}
	local tracks = playableAsset:GetOutputTracks()

	for index = 0, tracks.Length - 1 do
		local track = tracks[index]
		local particleControlTrack = track

		if particleControlTrack == nil or particleControlTrack:GetType() ~= typeof(Battle.ParticleControlTrack) then
			-- block empty
		else
			local isSubEffectTrack = tostring(particleControlTrack.subEffectType) == TimelineUtilityByLua.E_SubEffectType.Sub
			local parent
			local position = Vector3.zero
			local groupTrack = particleControlTrack.parent

			if groupTrack == nil or groupTrack:GetType() ~= typeof(UnityEngine.Timeline.GroupTrack) then
				logError("特效轨道必须都放在fx group轨道上，但{0} 的轨道 {1} 没有", tostring(particleControlTrack.timelineAsset), tostring(particleControlTrack.name))

				return
			end

			if tostring(particleControlTrack.effectParentType) == TimelineUtilityByLua.E_EffectParentType.Self then
				parent = selfTrans:FindChildByName(tostring(particleControlTrack.effectSelfParent))
			elseif tostring(particleControlTrack.effectParentType) == TimelineUtilityByLua.E_EffectParentType.PublicPoint then
				if tostring(particleControlTrack.effectPointParent) == TimelineUtilityByLua.E_EffectPointParent.other then
					-- block empty
				elseif tostring(particleControlTrack.effectPointParent) == TimelineUtilityByLua.E_EffectPointParent.enemy or tostring(particleControlTrack.effectPointParent) == TimelineUtilityByLua.E_EffectPointParent.hero then
					local gridOrUnitTransform = commonPointParent:Find(tostring(particleControlTrack.effectPointParent)):Find(tostring(particleControlTrack.effectPointIndex + 1))
					local battleUnitChildPointTransform = gridOrUnitTransform:Find(tostring(particleControlTrack.effectSelfParent))

					parent = battleUnitChildPointTransform == nil and gridOrUnitTransform or battleUnitChildPointTransform
				end
			elseif tostring(particleControlTrack.effectParentType) == TimelineUtilityByLua.E_EffectParentType.Camera then
				parent = cameraTransform
			elseif tostring(particleControlTrack.effectParentType) == TimelineUtilityByLua.E_EffectParentType.SkillTarget then
				-- block empty
			elseif tostring(particleControlTrack.effectParentType) == TimelineUtilityByLua.E_EffectParentType.Undefine then
				-- block empty
			end

			local clips = particleControlTrack:GetClips()
			local clip

			for i = 0, clips.Length - 1 do
				clip = clips[i]

				local controlPlayableAsset = clip.asset
				local parentEffectObj = TbTryGetValue(effectGroupToEffects, groupTrack)

				if isSubEffectTrack then
					if parentEffectObj ~= nil then
						controlPlayableAsset:SetIsDestroySourceGameObjectOnDestroy(false)

						local trans = parentEffectObj.transform:FindChildByName(tostring(clip.displayName))

						if trans ~= nil then
							local obj = trans.gameObject

							TimelineUtility.PlayableDirectorToSetReferenceValue(playableDirector, controlPlayableAsset, obj)

							groupIndexToSubEffects[index] = obj:GetComponent("Animator")
						else
							logError("父特效={0} 的物体内找不到名为 {1} 的子特效物体，请检查父特效预制体 或 Timeline={2}内子特效的配置片段.", tostring(parentEffectObj), tostring(clip.displayName), particleControlTrack.timelineAsset.name)
						end
					else
						logError("Timeline={0} 中 clip={1} 的子特效无法检索到其父特效物体，请排查其父特效是否生成成功.", particleControlTrack.timelineAsset.name, clip.displayName)
					end
				else
					if tostring(particleControlTrack.effectParentType) == TimelineUtilityByLua.E_EffectParentType.PublicPoint and (tostring(particleControlTrack.effectPointParent) == TimelineUtilityByLua.E_EffectPointParent.enemy or tostring(particleControlTrack.effectPointParent) == TimelineUtilityByLua.E_EffectPointParent.hero) then
						local effectEntityConfig = CfgEffectEntityTable[controlPlayableAsset.EffectEntityId]

						if effectEntityConfig == nil or effectEntityConfig.EffectTeam == 0 or isFriendly and effectEntityConfig.EffectTeam == 1 or not isFriendly and effectEntityConfig.EffectTeam == 2 then
							-- block empty
						else
							local gridOrUnitTransform

							if tostring(particleControlTrack.effectPointParent) == TimelineUtilityByLua.E_EffectPointParent.enemy then
								gridOrUnitTransform = commonPointParent:Find(TimelineUtilityByLua.E_EffectPointParent.hero):Find(tostring(particleControlTrack.effectPointIndex + 1))
							end

							if tostring(particleControlTrack.effectPointParent) == TimelineUtilityByLua.E_EffectPointParent.hero then
								gridOrUnitTransform = commonPointParent:Find(TimelineUtilityByLua.E_EffectPointParent.enemy):Find(tostring(particleControlTrack.effectPointIndex + 1))
							end

							if gridOrUnitTransform then
								local battleUnitChildPointTransform = gridOrUnitTransform:Find(tostring(particleControlTrack.effectSelfParent))

								parent = battleUnitChildPointTransform == nil and gridOrUnitTransform or battleUnitChildPointTransform
							end
						end
					end

					controlPlayableAsset:SetIsDestroySourceGameObjectOnDestroy(true)

					local entityId = GameEntry.Entity:GenerateEntityID()
					local battleUnitData = BattleModel.GetBattleUnitByUnitID(battleUnitID)

					if battleUnitData ~= nil and battleUnitData.isSummon and BattleSummonManager ~= nil then
						BattleSummonManager.RecordOtherEntityID(battleUnitID, entityId)
					end

					CoroutineUtility.Yield(TimelineUtilityByLua.LoadTimelineEffect, parent, position, particleControlTrack.scale, clip.displayName, particleControlTrack.timelineAsset.name, isFriendly, entityId, index, groupIndexToSubEffects, groupTrack, effectGroupToEffects, controlPlayableAsset, playableDirector, isActiveOnLoaded)

					local entity = GameEntry.Entity:GetEntity(entityId)

					if entity then
						local criManaMovieController = entity.gameObject:GetComponentInChildren(typeof(CriWare.CriManaMovieController))

						if criManaMovieController then
							TimelineUtilityByLua.BindCriManaMovieController(playableAsset, playableDirector, criManaMovieController, criManaMovieController.gameObject.name)
						end
					end
				end
			end
		end
	end

	local outputs = TimelineUtility.GetPlayableBindingsByPlayableAsset(playableAsset)

	for i = 0, outputs.Length - 1 do
		local playableBinding = outputs[i]

		if TimelineUtility.IsPlayableBindingoutputTargetTypeSameAs(playableBinding, typeof(UnityEngine.Animator)) then
			local animator = TbTryGetValue(groupIndexToSubEffects, i - 1)

			if animator ~= nil then
				playableDirector:SetGenericBinding(TimelineUtility.GetPlayableBindingsourceObject(playableBinding), animator)
			elseif TimelineUtility.GetPlayableBindingSGroupName(playableBinding) == "fx" then
				logError("{0}的第{1}轨道上是Animator轨道，但第{2}轨道没有对应的子特效。请联系timeline制作人员", tostring(playableAsset), i, i - 1)
			end
		end
	end

	for index = 0, tracks.Length - 1 do
		local track = tracks[index]
		local flyableItemTrack = track

		if flyableItemTrack == nil or flyableItemTrack:GetType() ~= typeof(Battle.FlyableItemTrack) then
			-- block empty
		else
			local groupTrack = flyableItemTrack.parent
			local clips = flyableItemTrack:GetClips()
			local clip

			for i = 0, clips.Length - 1 do
				clip = clips[i]

				local controlPlayableAsset = clip.asset
				local parentEffectObj = TbTryGetValue(effectGroupToEffects, groupTrack)
				local trans = parentEffectObj.transform:FindChildByName(tostring(clip.displayName))

				if trans ~= nil then
					TimelineUtility.PlayableDirectorToSetReferenceValue(playableDirector, controlPlayableAsset, trans.gameObject)
				else
					logError("FlyableItemClip 找不到对应节点" .. tostring(clip.displayName))
				end
			end
		end
	end
end

function TimelineUtilityByLua.LoadTimelineEffect(parent, position, scale, clipName, timelineAssetName, isFriendly, entityId, index, indexToAnimator, groupTrack, effectGroupToEffects, controlPlayableAsset, playableDirector, isActiveOnLoaded)
	local path = ""

	if controlPlayableAsset ~= nil and CfgEffectEntityTable[controlPlayableAsset.EffectEntityId] ~= nil then
		path = BattleApi:GetEffectUrl(CfgEffectEntityTable[controlPlayableAsset.EffectEntityId].PrefabName)
	end

	if path == "" or not GameEntry.Resource:HasAsset(path) then
		logError("加载 Cid={0}  的Timeline={1}  中的particleClip={2} 特效片段错误, EffectEntityId={3} path={4}。请检查ParticleClip的配置或EffectEntity配表", playableDirector.name, timelineAssetName, clipName, controlPlayableAsset ~= nil and controlPlayableAsset.EffectEntityId or -1, path)

		return
	end

	if isActiveOnLoaded == nil then
		-- block empty
	end

	TimelineUtilityByLua.TimelineEffectsToLoadCount = TimelineUtilityByLua.TimelineEffectsToLoadCount + 1

	controlPlayableAsset:SetIsDestroyByEntity(true)

	if not isActiveOnLoaded then
		position = Vector3.New(999, 999, 999)
	end

	GameEntry.Entity:ShowCommonEntity_Effect(entityId, path, 0, parent, position)
	CoroutineUtility.Yield()

	local entity, entityObj

	while UIUtil.IsNil(entity) do
		entity = GameEntry.Entity:GetEntity(entityId)

		CoroutineUtility.Yield()
	end

	entityObj = entity.gameObject

	if not isActiveOnLoaded then
		LuaUtility.SetGameObjectShow(entityObj, false)
	end

	if UIUtil.IsNil(entity) or UIUtil.IsNil(entityObj) then
		logError("entity or entityObj is nil.")

		return
	end

	entityObj.transform.localScale = Vector3.New(scale, scale, scale)

	local effectEntityConfig = CfgEffectEntityTable[controlPlayableAsset.EffectEntityId]

	if effectEntityConfig ~= nil then
		local newScale = entityObj.transform.localScale

		if effectEntityConfig.EffectTeam == 0 or isFriendly and effectEntityConfig.EffectTeam == 1 or not isFriendly and effectEntityConfig.EffectTeam == 2 then
			newScale.x = math.abs(newScale.x)
		else
			newScale.x = -math.abs(newScale.x)
		end

		entityObj.transform.localScale = newScale
	end

	if TimelineUtilityByLua.IsLogLoadTimelineEffect then
		log("结束：从 {0} 加载timeline特效 {1}", path, clipName)
	end

	indexToAnimator[index] = entity:GetComponent(typeof(UnityEngine.Animator))

	if groupTrack ~= nil then
		if TbContainsKey(effectGroupToEffects, groupTrack) then
			logError("与特效约定：特效轨道都放在fx group轨道上，且只能有一个父特效，其他应该都是子特效，但{0}下的该groupTrack {1} 存在多个父特效", tostring(groupTrack.timelineAsset), groupTrack.name)
		else
			effectGroupToEffects[groupTrack] = entityObj
		end
	end

	entityObj.transform:SetParent(parent, false)

	entityObj.transform.localPosition = Vector3.zero
	entityObj.transform.localRotation = UnityEngine.Quaternion.identity

	TimelineUtility.PlayableDirectorToSetReferenceValue(playableDirector, controlPlayableAsset, entityObj)

	TimelineUtilityByLua.TimelineEffectsToLoadCount = TimelineUtilityByLua.TimelineEffectsToLoadCount - 1
end

function TimelineUtilityByLua.SetHitEffectTrackForEachHitter(playableAsset, playableDirector, effectInstance)
	local indexToAnimator = {}
	local tracks = playableAsset:GetOutputTracks()

	for index = 0, tracks.Length - 1 do
		local track = tracks[index]
		local controlTrack = track

		if controlTrack ~= nil and controlTrack:GetType() == typeof(Battle.ParticleControlTrack) then
			local clips = controlTrack:GetClips()
			local clip

			for i = 0, clips.Length - 1 do
				clip = clips[i]

				local child = effectInstance.transform:FindChildByName(tostring(clip.displayName))
				local controlPlayableAsset = clip.asset

				TimelineUtility.PlayableDirectorToSetReferenceValue(playableDirector, controlPlayableAsset, child ~= nil and child or effectInstance)

				if child ~= nil then
					indexToAnimator[index] = child:GetComponent("Animator")
				end
			end
		elseif controlTrack ~= nil and controlTrack:GetType() == typeof(Battle.FlyableItemTrack) then
			local clips = controlTrack:GetClips()
			local clip

			for i = 0, clips.Length - 1 do
				clip = clips[i]

				local child = effectInstance.transform:FindChildByName(tostring(clip.displayName))
				local controlPlayableAsset = clip.asset

				TimelineUtility.PlayableDirectorToSetReferenceValue(playableDirector, controlPlayableAsset, child ~= nil and child or effectInstance)
			end
		end
	end

	local outputs = TimelineUtility.GetPlayableBindingsByPlayableAsset(playableAsset)

	for i = 0, outputs.Length - 1 do
		local output = outputs[i]

		if TimelineUtility.IsPlayableBindingoutputTargetTypeSameAs(output, typeof(UnityEngine.Animator)) then
			playableDirector:SetGenericBinding(TimelineUtility.GetPlayableBindingsourceObject(output), indexToAnimator[i - 1])
		end
	end

	playableDirector:Play(playableAsset)
end

function TimelineUtilityByLua.InitAttackClip(playableAsset, playableDirector, selfTrans, targetTransform, compositeDelta, effectRowTargets, effectColumnTargets, battleUnitID)
	playableDirector.playableAsset = playableAsset

	local battleUnitData = BattleModel.GetBattleUnitByUnitID(battleUnitID)
	local isUnitFlip = battleUnitData ~= nil and battleUnitData.isUnitFlip or false
	local tracks = playableAsset:GetOutputTracks()
	local track

	for i = 0, tracks.Length - 1 do
		track = tracks[i]

		if track:GetType() == typeof(Battle.MoveTrack) then
			local moveTrack = track
			local timelineClips = moveTrack:GetClips()
			local timelineClip

			for k = 0, timelineClips.Length - 1 do
				timelineClip = timelineClips[k]

				local moveClip = timelineClip.asset

				moveClip:InitForPlayer(playableDirector, selfTrans, targetTransform, compositeDelta, isUnitFlip)
			end
		elseif track:GetType() == typeof(Battle.DispatchLuaEventTrack) then
			local dispatchLuaEventTrack = track
			local timelineClips = dispatchLuaEventTrack:GetClips()
			local timelineClip

			for k = 0, timelineClips.Length - 1 do
				timelineClip = timelineClips[k]

				local dispatchLuaEventClip = timelineClip.asset
				local OnClipEnterEventID = dispatchLuaEventClip:GetLuaEventStr(true)
				local OnClipExitEventID = dispatchLuaEventClip:GetLuaEventStr(false)
				local luaTableParamForClipEnterEvent = {}
				local luaTableParamForClipExitEvent = {}

				if OnClipEnterEventID == EventID.ShowBattleSummons then
					luaTableParamForClipEnterEvent[1] = battleUnitID
				end

				if OnClipExitEventID == EventID.ShowBattleSummons then
					luaTableParamForClipExitEvent[1] = battleUnitID
				end

				dispatchLuaEventClip:SetLuaTableParam(luaTableParamForClipEnterEvent, luaTableParamForClipExitEvent)
			end
		end
	end

	for index = 0, tracks.Length - 1 do
		track = tracks[index]

		local controlTrack = track

		if controlTrack:GetType() ~= typeof(Battle.ParticleControlTrack) or tostring(controlTrack.subEffectType) ~= TimelineUtilityByLua.E_SubEffectType.Main or tostring(controlTrack.effectParentType) ~= TimelineUtilityByLua.E_EffectParentType.SkillTarget then
			-- block empty
		else
			local rowOrColumnSkillParent
			local x = controlTrack.skillTargetColumnIndexForOneRow
			local y = controlTrack.skillTargetRowIndexForOneColumn

			if x ~= 0 and y == 0 then
				rowOrColumnSkillParent = effectRowTargets[x]
			elseif x == 0 and y ~= 0 then
				rowOrColumnSkillParent = effectColumnTargets[y]
			end

			local isRowOrColumnSkill = rowOrColumnSkillParent ~= nil
			local clips = controlTrack:GetClips()
			local clip

			for i = 0, clips.Length - 1 do
				clip = clips[i]

				local controlPlayableAsset = clip.asset
				local effectObj = TimelineUtility.PlayableDirectorToGetReferenceValue(playableDirector, controlPlayableAsset)
				local parent

				if isRowOrColumnSkill then
					parent = rowOrColumnSkillParent
				else
					parent = targetTransform:FindChildByName(tostring(controlTrack.effectSelfParent))
				end

				if effectObj == nil then
					logError(string.format("effectObj == nil  parent=%s playableDirector=%s controlPlayableAsset=%s", tostring(parent), tostring(playableDirector), tostring(controlPlayableAsset)))
				else
					effectObj.transform:SetParent(parent, false)
				end
			end
		end
	end

	for index = 0, tracks.Length - 1 do
		track = tracks[index]

		if track:GetType() == typeof(Battle.FlyableItemTrack) then
			local flyableItemTrack = track
			local timelineClips = flyableItemTrack:GetClips()
			local timelineClip

			for k = 0, timelineClips.Length - 1 do
				timelineClip = timelineClips[k]

				local flyableItemClip = timelineClip.asset

				flyableItemClip:InitClip(selfTrans, targetTransform, isUnitFlip)
			end
		end
	end
end

function TimelineUtilityByLua.ResolveAttackClip(playableAsset, moveToTimeStamp, attackStartTimeStamp, attackEndTimeStamp, moveBackTimeStamp)
	moveToTimeStamp = 0
	attackEndTimeStamp = playableAsset.duration
	attackStartTimeStamp = 0
	moveBackTimeStamp = 0

	local tracks = playableAsset:GetOutputTracks()
	local track

	for i = 0, tracks.Length - 1 do
		track = tracks[i]

		local signalTrack = track

		if signalTrack:GetType() == typeof(Battle.SignalTrack) then
			local clips = signalTrack:GetClips()
			local clip

			for k = 0, clips.Length - 1 do
				clip = clips[k]

				local signalClip = clip.asset

				if tostring(signalClip.signalType) == TimelineUtilityByLua.E_SignalClip_SignalType.MoveTo then
					moveToTimeStamp = TimelineUtility.GetTimeLineClipStartOrEndTime(clip, true)
				elseif tostring(signalClip.signalType) == TimelineUtilityByLua.E_SignalClip_SignalType.Attack then
					attackStartTimeStamp = TimelineUtility.GetTimeLineClipStartOrEndTime(clip, true)
					attackEndTimeStamp = TimelineUtility.GetTimeLineClipStartOrEndTime(clip, false)
				elseif tostring(signalClip.signalType) == TimelineUtilityByLua.E_SignalClip_SignalType.MoveBack then
					moveBackTimeStamp = TimelineUtility.GetTimeLineClipStartOrEndTime(clip, true)
				end
			end
		end
	end

	return moveToTimeStamp, attackStartTimeStamp, attackEndTimeStamp, moveBackTimeStamp
end

function TimelineUtilityByLua.ShowBinding(playableDirector, skeletonAnimation)
	local outputs = TimelineUtility.GetPlayableBindingsByPlayableAsset(playableDirector.playableAsset)

	log("为 spine物体 {0} 的timeline资源 {1} 的轨道 绑定spine 轨道长度为：{2}", skeletonAnimation.gameObject.name, playableDirector.playableAsset.name, outputs.Length)

	local playableBinding

	for i = 0, outputs.Length - 1 do
		playableBinding = outputs[i]

		log("为 spine物体 {0} 的timeline资源 {1} 的轨道 {2} 关联 {3} 绑定 {4} ", skeletonAnimation.gameObject.name, playableDirector.playableAsset.name, playableBinding.streamName, playableBinding.outputTargetType ~= nil and playableBinding.outputTargetType.FullName or string.Empty, TimelineUtility.GetPlayableBindingsourceObject(playableBinding))
	end
end

function TimelineUtilityByLua.BindSkeletonAnimation(playableAsset, playableDirector, skeletonAnimation)
	local outputs

	if playableAsset ~= nil then
		outputs = TimelineUtility.GetPlayableBindingsByPlayableAsset(playableAsset)
	else
		outputs = TimelineUtility.GetPlayableBindingsByPlayableAsset(playableDirector.playableAsset)
	end

	for i = 0, outputs.Length - 1 do
		local playableBinding = outputs[i]

		if TimelineUtility.IsPlayableBindingoutputTargetTypeSameAs(playableBinding, typeof(Spine.Unity.SkeletonAnimation)) then
			local track = TimelineUtility.GetPlayableBindingsourceObject(playableBinding)

			playableDirector:SetGenericBinding(track, skeletonAnimation)

			local animations = TimelineUtility.GetAnimationsWithSkeletonAnimation(skeletonAnimation)
			local clips = track:GetClips()

			for j = 0, clips.Length - 1 do
				local clip = clips[j]

				for k = 0, animations.Length - 1 do
					if string.lower(animations[k].Name) == clip.displayName then
						TimelineUtility.SetTimelineAnimationClipSpineAnimation(clip.asset, animations[k])

						break
					end
				end
			end
		end
	end
end

function TimelineUtilityByLua.BindControlTrack(playableAsset, playableDirector, unitView)
	local tracks = playableAsset:GetOutputTracks()

	for index = 0, tracks.Length - 1 do
		local track = tracks[index]
		local controlTrack = track

		if controlTrack ~= nil and controlTrack:GetType() == typeof(UnityEngine.Timeline.ControlTrack) then
			local clips = controlTrack:GetClips()
			local clip

			for i = 0, clips.Length - 1 do
				clip = clips[i]

				local asset = clip.asset

				TimelineUtility.PlayableDirectorToSetReferenceValue(playableDirector, asset, unitView.skeletonAnimation.gameObject)
			end
		end

		if controlTrack ~= nil and controlTrack:GetType() == typeof(Battle.ControlExTrack) then
			local clips = controlTrack:GetClips()
			local clip

			for i = 0, clips.Length - 1 do
				clip = clips[i]

				local asset = clip.asset

				TimelineUtility.PlayableDirectorToSetReferenceValue(playableDirector, asset, unitView.skeletonAnimation.gameObject)
			end
		end
	end
end

function TimelineUtilityByLua.BindCinemachine(playableAsset, playableDirector, uniqueCinemachineObjInstance, targetTransform)
	local outputs = TimelineUtility.GetPlayableBindingsByPlayableAsset(playableAsset)
	local playableBinding

	for i = 0, outputs.Length - 1 do
		playableBinding = outputs[i]

		if TimelineUtility.IsPlayableBindingoutputTargetTypeSameAs(playableBinding, typeof(Cinemachine.CinemachineBrain)) then
			playableDirector:SetGenericBinding(TimelineUtility.GetPlayableBindingsourceObject(playableBinding), TimelineUtilityByLua.CinemachineBrain)
		end

		if TimelineUtility.IsPlayableBindingoutputTargetTypeSameAs(playableBinding, typeof(RenderHeads.Media.AVProVideo.MediaPlayer)) then
			playableDirector:SetGenericBinding(TimelineUtility.GetPlayableBindingsourceObject(playableBinding), uniqueCinemachineObjInstance:GetComponentInChildren(typeof(RenderHeads.Media.AVProVideo.MediaPlayer)))
		end
	end

	local tracks = playableAsset:GetOutputTracks()
	local track

	for i = 0, tracks.Length - 1 do
		track = tracks[i]

		if track:GetType() == typeof(CinemachineTrack) then
			local cinemachineTrack = track
			local cinemachineClips = cinemachineTrack:GetClips()
			local clip

			for k = 0, cinemachineClips.Length - 1 do
				clip = cinemachineClips[k]

				local cinemachineShot = clip.asset
				local virtualCamera

				if TimelineUtility.commonVirtualCameras:ContainsKey(clip.displayName) then
					virtualCamera = TimelineUtility.commonVirtualCameras:get_Item(clip.displayName)
				end

				if virtualCamera ~= nil then
					TimelineUtility.PlayableDirectorToSetReferenceValue(playableDirector, cinemachineShot, virtualCamera)
				else
					local virtualCameras = uniqueCinemachineObjInstance.transform:GetComponentsInChildren(typeof(Cinemachine.CinemachineVirtualCamera))
					local childVirtualCamera

					for j = 0, virtualCameras.Length - 1 do
						childVirtualCamera = virtualCameras[j]

						if childVirtualCamera.gameObject.name == clip.displayName then
							TimelineUtility.PlayableDirectorToSetReferenceValue(playableDirector, cinemachineShot, childVirtualCamera)

							local virtualCameraFollow = childVirtualCamera.gameObject:GetComponent(typeof(Battle.VirtualCameraFollow))

							if virtualCameraFollow ~= nil then
								if tostring(virtualCameraFollow.Follow) == TimelineUtilityByLua.E_Battle_VirtualCameraFollowTarget.SkillTarget then
									childVirtualCamera.Follow = targetTransform
								elseif tostring(virtualCameraFollow.Follow) == TimelineUtilityByLua.E_Battle_VirtualCameraFollowTarget.Self then
									childVirtualCamera.Follow = playableDirector.transform
								elseif tostring(virtualCameraFollow.Follow) == TimelineUtilityByLua.E_Battle_VirtualCameraFollowTarget.Grid then
									-- block empty
								end
							end
						end
					end
				end
			end
		elseif track:GetType() == typeof(UnityEngine.Timeline.ControlTrack) then
			local controlTrack = track
			local controlClips = controlTrack:GetClips()
			local clip

			for m = 0, controlClips.Length - 1 do
				clip = controlClips[m]

				if clip.displayName == "quad" then
					local child = uniqueCinemachineObjInstance.transform:FindChildByName(clip.displayName)

					if child ~= nil then
						local controlPlayableAsset = clip.asset

						TimelineUtility.PlayableDirectorToSetReferenceValue(playableDirector, controlPlayableAsset, child.gameObject)
					end
				end

				if clip.displayName == "Spine_Ya" then
					local child = playableDirector.transform:FindChildByName(clip.displayName)

					if child ~= nil then
						local controlPlayableAsset = clip.asset

						TimelineUtility.PlayableDirectorToSetReferenceValue(playableDirector, controlPlayableAsset, child.gameObject)
					end
				end
			end
		elseif track:GetType() == typeof(IQIGame.wlh.Game.VideoTrack) then
			local videoTrack = track
			local videoClips = videoTrack:GetClips()
			local clip

			for j = 0, videoClips.Length - 1 do
				clip = videoClips[j]

				local child = uniqueCinemachineObjInstance.transform:FindChildByName("quad")

				if child ~= nil then
					local videoClip = clip.asset

					TimelineUtility.PlayableDirectorToSetReferenceValue(playableDirector, videoClip, child.gameObject)
				end
			end
		end
	end
end

function TimelineUtilityByLua.BindPostProcessAnimation(playableAsset, playableDirector, postProcessAnimationObjInstance)
	local tracks = playableAsset:GetOutputTracks()

	for index = 0, tracks.Length - 1 do
		local track = tracks[index]
		local animationTrack = track

		if TimelineUtility.IsParentTrackNameMatch(animationTrack, "PostProcess") and animationTrack:GetType() == typeof(UnityEngine.Timeline.AnimationTrack) then
			local child = postProcessAnimationObjInstance.transform:FindChildByName(animationTrack.name)

			if child then
				playableDirector:SetGenericBinding(animationTrack, child.gameObject:GetComponent(typeof(UnityEngine.Animator)))
			end
		end
	end
end

function TimelineUtilityByLua.BindAudioSource(playableAsset, playableDirector)
	local outputs = TimelineUtility.GetPlayableBindingsByPlayableAsset(playableAsset)
	local playableBinding

	for i = 0, outputs.Length - 1 do
		playableBinding = outputs[i]

		if TimelineUtility.IsPlayableBindingoutputTargetTypeSameAs(playableBinding, typeof(UnityEngine.AudioSource)) then
			playableDirector:SetGenericBinding(TimelineUtility.GetPlayableBindingsourceObject(playableBinding), timelineAudioSource)
		end
	end
end

function TimelineUtilityByLua.BindCriManaMovieController(playableAsset, playableDirector, criManaMovieController, targetStreamName)
	local outputs = TimelineUtility.GetPlayableBindingsByPlayableAsset(playableAsset)
	local playableBinding

	for i = 0, outputs.Length - 1 do
		playableBinding = outputs[i]

		if targetStreamName ~= nil and TimelineUtility.GetPlayableBindingStreamName(playableBinding) ~= targetStreamName then
			-- block empty
		end

		if TimelineUtility.IsPlayableBindingoutputTargetTypeSameAs(playableBinding, typeof(CriWare.CriManaMovieMaterialBase)) then
			playableDirector:SetGenericBinding(TimelineUtility.GetPlayableBindingsourceObject(playableBinding), criManaMovieController)
			logDebug("绑定" .. criManaMovieController.name)
		end
	end
end

function TimelineUtilityByLua.InitWatcher(playableAsset, playableDirector)
	playableDirector.playableAsset = playableAsset

	local tracks = playableAsset:GetOutputTracks()
	local track

	for i = 0, tracks.Length - 1 do
		track = tracks[i]

		if track:GetType() == typeof(Battle.MoveTrack) then
			local moveTrack = track
			local timelineClips = moveTrack:GetClips()
			local timelineClip

			for k = 0, timelineClips.Length - 1 do
				timelineClip = timelineClips[k]

				local moveClip = timelineClip.asset

				moveClip:SetPlayableDirector(playableDirector)
				moveClip:SetTime(TimelineUtility.GetTimeLineClipStartOrEndTime(timelineClip, true), TimelineUtility.GetTimeLineClipStartOrEndTime(timelineClip, false))
			end
		elseif track:GetType() == typeof(Battle.SignalTrack) then
			local signalTrack = track
			local timelineClips = signalTrack:GetClips()
			local timelineClip

			for k = 0, timelineClips.Length - 1 do
				timelineClip = timelineClips[k]

				local signalClip = timelineClip.asset

				signalClip:SetPlayableDirector(playableDirector)
				signalClip:SetTime(TimelineUtility.GetTimeLineClipStartOrEndTime(timelineClip, true), TimelineUtility.GetTimeLineClipStartOrEndTime(timelineClip, false))
			end
		elseif track:GetType() == typeof(Battle.DispatchLuaEventTrack) then
			local dispatchLuaEventTrack = track
			local timelineClips = dispatchLuaEventTrack:GetClips()
			local timelineClip

			for k = 0, timelineClips.Length - 1 do
				timelineClip = timelineClips[k]

				local dispatchLuaEventClip = timelineClip.asset

				dispatchLuaEventClip:SetPlayableDirector(playableDirector)
				dispatchLuaEventClip:SetTime(TimelineUtility.GetTimeLineClipStartOrEndTime(timelineClip, true), TimelineUtility.GetTimeLineClipStartOrEndTime(timelineClip, false))
			end
		end
	end
end

function TimelineUtilityByLua.LoadTimelineEffectCoroutineForCommonUse(playableAsset, playableDirector, selfTrans, cameraTransform, isActiveOnLoaded, onComplete)
	local effectGroupToEffects = {}
	local groupIndexToSubEffects = {}
	local tracks = playableAsset:GetOutputTracks()

	for index = 0, tracks.Length - 1 do
		local track = tracks[index]
		local particleControlTrack = track

		if not TimelineUtility.IsGroupTrackNameMatch("fx") or particleControlTrack:GetType() ~= typeof(Battle.ParticleControlTrack) then
			-- block empty
		else
			local isSubEffectTrack = tostring(particleControlTrack.subEffectType) == TimelineUtilityByLua.E_SubEffectType.Sub
			local parent
			local position = Vector3.zero
			local groupTrack = particleControlTrack.parent

			if tostring(particleControlTrack.effectParentType) == TimelineUtilityByLua.E_EffectParentType.Self then
				parent = selfTrans:FindChildByName(tostring(particleControlTrack.effectSelfParent))
			elseif tostring(particleControlTrack.effectParentType) == TimelineUtilityByLua.E_EffectParentType.PublicPoint then
				if tostring(particleControlTrack.effectPointParent) == TimelineUtilityByLua.E_EffectPointParent.other then
					-- block empty
				elseif tostring(particleControlTrack.effectPointParent) == TimelineUtilityByLua.E_EffectPointParent.enemy or tostring(particleControlTrack.effectPointParent) == TimelineUtilityByLua.E_EffectPointParent.hero then
					local gridOrUnitTransform = selfTrans
					local battleUnitChildPointTransform = gridOrUnitTransform:Find(tostring(particleControlTrack.effectSelfParent))

					parent = battleUnitChildPointTransform ~= nil and battleUnitChildPointTransform or gridOrUnitTransform
				end
			elseif tostring(particleControlTrack.effectParentType) == TimelineUtilityByLua.E_EffectParentType.Camera then
				parent = cameraTransform
			elseif tostring(particleControlTrack.effectParentType) ~= TimelineUtilityByLua.E_EffectParentType.SkillTarget and particleControlTrack.effectParentType == TimelineUtilityByLua.E_EffectParentType.Undefine then
				-- block empty
			end

			local effectScale = particleControlTrack.scale * 5
			local particleControlTrackClips = particleControlTrack:GetClips()
			local clip

			for i = 0, particleControlTrackClips.Length - 1 do
				clip = particleControlTrackClips[i]

				local controlPlayableAsset = clip.asset
				local parentEffectObj = TbTryGetValue(effectGroupToEffects, groupTrack)

				if isSubEffectTrack and parentEffectObj ~= nil then
					controlPlayableAsset:SetIsDestroySourceGameObjectOnDestroy(false)

					local obj = parentEffectObj.transform:FindChildByName(clip.displayName).gameObject

					TimelineUtility.PlayableDirectorToSetReferenceValue(playableDirector, controlPlayableAsset, obj)

					groupIndexToSubEffects[index] = obj:GetComponent(typeof(UnityEngine.Animator))
				else
					controlPlayableAsset:SetIsDestroySourceGameObjectOnDestroy(true)

					local entityId = GameEntry.Entity:GenerateEntityID()

					CoroutineUtility.Yield(TimelineUtilityByLua.LoadTimelineEffectForCommonUse, parent, effectScale, position, controlPlayableAsset.assetPath, entityId, index, groupIndexToSubEffects, groupTrack, effectGroupToEffects, controlPlayableAsset, playableDirector, isActiveOnLoaded)
				end
			end
		end
	end

	local outputs = TimelineUtility.GetPlayableBindingsByPlayableAsset(playableAsset)

	for i = 0, outputs.Length - 1 do
		local output = outputs[i]

		if TimelineUtility.IsPlayableBindingoutputTargetTypeSameAs(output, typeof(UnityEngine.Animator)) then
			playableDirector:SetGenericBinding(TimelineUtility.GetPlayableBindingsourceObject(output), groupIndexToSubEffects[i - 1])
		end
	end

	if onComplete ~= nil then
		onComplete()
	end
end

function TimelineUtilityByLua.LoadTimelineEffectForCommonUse(parent, scale, position, path, entityId, index, indexToAnimator, groupTrack, effectGroupToEffects, controlPlayableAsset, playableDirector, isActiveOnLoaded)
	if isActiveOnLoaded == nil then
		-- block empty
	end

	if path == "" or not GameEntry.Resource:HasAsset(path) then
		logError("加载 路径={0} 的资源失败，请检查该路径下是否存在该资源，或 EffectEntity.csv 内是否正确配置资源的路径", path)

		return
	end

	controlPlayableAsset:SetIsDestroyByEntity(true)
	GameEntry.Entity:ShowCommonEntity_Effect(entityId, path, 0, parent, position)
	CoroutineUtility.Yield()

	local entity

	CoroutineUtility.Yield(function()
		while entity == nil do
			entity = GameEntry.Entity:GetEntity(entityId)

			CoroutineUtility.Yield()
		end
	end)

	local entityObj = entity.gameObject

	indexToAnimator[index] = entity:GetComponent(typeof(UnityEngine.Animator))

	if groupTrack ~= nil then
		effectGroupToEffects[groupTrack] = entityObj
	end

	if not isActiveOnLoaded then
		entityObj:SetActive(false)
	end

	entityObj.transform:SetParent(parent, false)

	entityObj.transform.localPosition = Vector3.zero
	entityObj.transform.localRotation = UnityEngine.Quaternion.identity
	entityObj.transform.localScale = Vector3.New(scale, scale, scale)

	logError("资源缩放倍数： {0}  名字： {1}", entityObj.name, tostring(scale))
	TimelineUtility.PlayableDirectorToSetReferenceValue(playableDirector, controlPlayableAsset, entityObj)
end

function TimelineUtilityByLua.InitTimelineByCastSkillPOD(playableAsset, castSkillPOD, hits)
	local attackUnitView = BattleView.GetBattleUnitByUnitID(castSkillPOD.CasterID)
	local battleUnitData = BattleModel.GetBattleUnitByUnitID(castSkillPOD.CasterID)
	local isUnitFlip = battleUnitData ~= nil and battleUnitData.isUnitFlip or false

	attackUnitView.timelineDirector.playableAsset = playableAsset.asset

	local tracks = TimelineUtilityByLua.GetAllTrackAssetsWidthType(playableAsset.asset)
	local hitUnitViews = {}

	for hitUnitID, _num in pairs(hits) do
		if hitUnitID ~= castSkillPOD.CasterID then
			local hitUnitView = BattleView.GetBattleUnitByUnitID(hitUnitID)

			table.insert(hitUnitViews, hitUnitView)
		end
	end

	local spineAnimTracks = tracks[typeof(Spine.Unity.Playables.SpineAnimationStateTrack)]

	TimelineUtilityByLua.BindSpineAnimationTracks(spineAnimTracks, attackUnitView, hitUnitViews)
	TimelineUtilityByLua.BindSpineAnimationExTracks(tracks[typeof(Battle.SpineAnimationExTrack)], attackUnitView, playableAsset.customCaster, hitUnitViews)
	TimelineUtilityByLua.BindControlTracks(tracks[typeof(UnityEngine.Timeline.ControlTrack)], attackUnitView, hitUnitViews)
	TimelineUtilityByLua.BindControlExTracks(tracks[typeof(Battle.ControlExTrack)], attackUnitView, playableAsset.customCaster, hitUnitViews)
	TimelineUtilityByLua.BindMoveTracks(tracks[typeof(Battle.MoveTrack)], attackUnitView, hitUnitViews)
	TimelineUtilityByLua.BindFlyableItemTracks(tracks[typeof(Battle.FlyableItemTrack)], attackUnitView, hitUnitViews, isUnitFlip)
	TimelineUtilityByLua.BindDispatchLuaEventTracks(tracks[typeof(Battle.DispatchLuaEventTrack)], attackUnitView)
	TimelineUtilityByLua.BingSignalClip(tracks[typeof(Battle.SignalTrack)], attackUnitView)
	TimelineUtilityByLua.InitTimelineEffects(playableAsset, castSkillPOD, attackUnitView, hitUnitViews)
	TimelineUtilityByLua.BindingHitTracks(attackUnitView.timelineDirector, castSkillPOD, attackUnitView, hits)
end

function TimelineUtilityByLua.BingSignalClip(playableBindings, attackUnitView)
	if playableBindings == nil then
		return
	end

	for i = 1, #playableBindings do
		local signalTrack = TimelineUtility.GetPlayableBindingsourceObject(playableBindings[i])
		local timelineClips = signalTrack:GetClips()
		local timelineClip

		for k = 0, timelineClips.Length - 1 do
			timelineClip = timelineClips[k]

			local signalClip = timelineClip.asset

			signalClip:SetPlayableDirector(attackUnitView.timelineDirector)
			signalClip:SetTime(TimelineUtility.GetTimeLineClipStartOrEndTime(timelineClip, true), TimelineUtility.GetTimeLineClipStartOrEndTime(timelineClip, false))
		end
	end
end

function TimelineUtilityByLua.GetAllTrackAssetsWidthType(playableAsset)
	local tracks = {}
	local playableBindings = TimelineUtility.GetPlayableBindingsByPlayableAsset(playableAsset)

	for i = 0, playableBindings.Length - 1 do
		local playableBinding = playableBindings[i]
		local track = TimelineUtility.GetPlayableBindingsourceObject(playableBinding)

		if track ~= nil then
			local type = track:GetType()

			if tracks[type] == nil then
				tracks[type] = {}
			end

			table.insert(tracks[type], playableBinding)
		else
			local streamName = TimelineUtility.GetPlayableBindingStreamName(playableBinding)

			if streamName ~= "Markers" then
				logError("{0}--->没有对应的sourceObject", streamName)
			end
		end
	end

	return tracks
end

function TimelineUtilityByLua.BindSpineAnimationTracks(spineAnimTracks, attackUnitView, hitUnitViews)
	if spineAnimTracks == nil then
		return
	end

	for i = 1, #spineAnimTracks do
		local track = TimelineUtility.GetPlayableBindingsourceObject(spineAnimTracks[i])

		attackUnitView.timelineDirector:SetGenericBinding(track, attackUnitView.skeletonAnimation)

		local animations = TimelineUtility.GetAnimationsWithSkeletonAnimation(attackUnitView.skeletonAnimation)
		local clips = track:GetClips()

		for j = 0, clips.Length - 1 do
			local clip = clips[j]

			for k = 0, animations.Length - 1 do
				if string.lower(animations[k].Name) == string.lower(clip.displayName) then
					TimelineUtility.SetTimelineAnimationClipSpineAnimation(clip.asset, animations[k])

					break
				end
			end
		end
	end
end

function TimelineUtilityByLua.BindSpineAnimationExTracks(spineAnimTracks, attackUnitView, customCaster, hitUnitViews)
	if spineAnimTracks == nil then
		return
	end

	for i = 1, #spineAnimTracks do
		local track = TimelineUtility.GetPlayableBindingsourceObject(spineAnimTracks[i])
		local skeletonAnimation = attackUnitView.skeletonAnimation

		if tostring(track.Scope) == "CustomCaster" then
			skeletonAnimation = customCaster:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation), true)
			customCaster.transform.parent = attackUnitView.gameObject.transform.parent
			customCaster.transform.localPosition = attackUnitView.gameObject.transform.localPosition
		elseif tostring(track.Scope) == "Target" and hitUnitViews[i] ~= nil then
			skeletonAnimation = hitUnitViews[i].skeletonAnimation
		end

		attackUnitView.timelineDirector:SetGenericBinding(track, skeletonAnimation)

		local animations = TimelineUtility.GetAnimationsWithSkeletonAnimation(skeletonAnimation)
		local clips = track:GetClips()

		for j = 0, clips.Length - 1 do
			local clip = clips[j]

			for k = 0, animations.Length - 1 do
				if string.lower(animations[k].Name) == clip.displayName then
					TimelineUtility.SetTimelineAnimationClipSpineAnimation(clip.asset, animations[k])

					break
				end
			end
		end
	end
end

function TimelineUtilityByLua.BindControlTracks(playableBindings, attackUnitView, hitUnitViews)
	if playableBindings == nil then
		return
	end

	for i = 1, #playableBindings do
		local track = TimelineUtility.GetPlayableBindingsourceObject(playableBindings[i])
		local clips = track:GetClips()
		local clip

		for clipIndex = 0, clips.Length - 1 do
			clip = clips[clipIndex]

			local asset = clip.asset
			local spine = attackUnitView.transform:FindChildByName(clip.displayName)

			if spine ~= nil then
				TimelineUtility.PlayableDirectorToSetReferenceValue(attackUnitView.timelineDirector, asset, spine.gameObject)
			end
		end
	end
end

function TimelineUtilityByLua.BindControlExTracks(playableBindings, attackUnitView, customCaster, hitUnitViews)
	if playableBindings == nil then
		return
	end

	for i = 1, #playableBindings do
		local track = TimelineUtility.GetPlayableBindingsourceObject(playableBindings[i])
		local spineGameObject = attackUnitView.skeletonAnimation.gameObject

		if tostring(track.Scope) == "CustomCaster" then
			spineGameObject = customCaster:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation), true).gameObject
		elseif tostring(track.Scope) == "Target" and hitUnitViews[i] ~= nil then
			spineGameObject = hitUnitViews[i].skeletonAnimation.gameObject
		end

		local clips = track:GetClips()
		local clip

		for clipIndex = 0, clips.Length - 1 do
			clip = clips[clipIndex]

			local asset = clip.asset

			TimelineUtility.PlayableDirectorToSetReferenceValue(attackUnitView.timelineDirector, asset, spineGameObject)
		end
	end
end

function TimelineUtilityByLua.BindMoveTracks(playableBindings, attackUnitView, hitUnitViews)
	if playableBindings == nil then
		return
	end

	local attackUnitModel = BattleModel.GetBattleUnitByUnitID(attackUnitView.battleUnitID)

	for i = 1, #playableBindings do
		local moveTrack = TimelineUtility.GetPlayableBindingsourceObject(playableBindings[i])
		local timelineClips = moveTrack:GetClips()
		local timelineClip

		for k = 0, timelineClips.Length - 1 do
			timelineClip = timelineClips[k]

			local moveClip = timelineClip.asset

			moveClip:InitForPlayer(attackUnitView.timelineDirector, attackUnitView.transform, hitUnitViews[1].transform, Vector3.zero, attackUnitModel.isUnitFlip)
			moveClip:SetPlayableDirector(attackUnitView.timelineDirector)
			moveClip:SetTime(TimelineUtility.GetTimeLineClipStartOrEndTime(timelineClip, true), TimelineUtility.GetTimeLineClipStartOrEndTime(timelineClip, false))
		end
	end
end

function TimelineUtilityByLua.BindParticleTracks(playableBindings, attackUnitView, hitUnitViews)
	if playableBindings == nil then
		return
	end
end

function TimelineUtilityByLua.BindAnimatorTracks(animatorTracks, attackUnitView, hitUnitViews)
	return
end

function TimelineUtilityByLua.BindFlyableItemTracks(playableBindings, attackUnitView, hitUnitViews, isUnitFlip)
	if playableBindings == nil then
		return
	end

	for index = 1, #playableBindings do
		local flyableItemTrack = TimelineUtility.GetPlayableBindingsourceObject(playableBindings[index])
		local timelineClips = flyableItemTrack:GetClips()
		local timelineClip

		for k = 0, timelineClips.Length - 1 do
			timelineClip = timelineClips[k]

			local flyableItemClip = timelineClip.asset

			if hitUnitViews[index] ~= nil then
				flyableItemClip:InitClip(attackUnitView.transform, hitUnitViews[index].transform, isUnitFlip)
			else
				logError("FlyableItemClip 没有对应的子弹受击者")
			end
		end
	end
end

function TimelineUtilityByLua.BindDispatchLuaEventTracks(playableBindings, attackUnitView)
	if playableBindings == nil then
		return
	end

	for i = 1, #playableBindings do
		local dispatchLuaEventTrack = TimelineUtility.GetPlayableBindingsourceObject(playableBindings[i])
		local timelineClips = dispatchLuaEventTrack:GetClips()
		local timelineClip

		for k = 0, timelineClips.Length - 1 do
			timelineClip = timelineClips[k]

			local dispatchLuaEventClip = timelineClip.asset

			dispatchLuaEventClip:SetPlayableDirector(attackUnitView.timelineDirector)
			dispatchLuaEventClip:SetTime(TimelineUtility.GetTimeLineClipStartOrEndTime(timelineClip, true), TimelineUtility.GetTimeLineClipStartOrEndTime(timelineClip, false))

			local OnClipEnterEventID = dispatchLuaEventClip:GetLuaEventStr(true)
			local OnClipExitEventID = dispatchLuaEventClip:GetLuaEventStr(false)
			local luaTableParamForClipEnterEvent = {}
			local luaTableParamForClipExitEvent = {}

			if OnClipEnterEventID == EventID.ShowBattleSummons then
				luaTableParamForClipEnterEvent[1] = attackUnitView.battleUnitID
			end

			if OnClipExitEventID == EventID.ShowBattleSummons then
				luaTableParamForClipExitEvent[1] = attackUnitView.battleUnitID
			end

			dispatchLuaEventClip:SetLuaTableParam(luaTableParamForClipEnterEvent, luaTableParamForClipExitEvent)
		end
	end
end

function TimelineUtilityByLua.BindCinemachineTracks(playableBindings, attackUnitView, hitUnitViews)
	if playableBindings == nil then
		return
	end

	for i = 1, #playableBindings do
		local cinemachineTrack = TimelineUtility.GetPlayableBindingsourceObject(playableBindings[i])
		local cinemachineClips = cinemachineTrack:GetClips()
		local clip

		for k = 0, cinemachineClips.Length - 1 do
			clip = cinemachineClips[k]

			local cinemachineShot = clip.asset
			local virtualCamera

			if TimelineUtility.commonVirtualCameras:ContainsKey(clip.displayName) then
				virtualCamera = TimelineUtility.commonVirtualCameras:get_Item(clip.displayName)
			end

			if virtualCamera ~= nil then
				TimelineUtility.PlayableDirectorToSetReferenceValue(attackUnitView.timelineDirector, cinemachineShot, virtualCamera)
			else
				local virtualCameras = uniqueCinemachineObjInstance.transform:GetComponentsInChildren(typeof(Cinemachine.CinemachineVirtualCamera))
				local childVirtualCamera

				for j = 0, virtualCameras.Length - 1 do
					childVirtualCamera = virtualCameras[j]

					if childVirtualCamera.gameObject.name == clip.displayName then
						TimelineUtility.PlayableDirectorToSetReferenceValue(attackUnitView.timelineDirector, cinemachineShot, childVirtualCamera)

						local virtualCameraFollow = childVirtualCamera.gameObject:GetComponent(typeof(Battle.VirtualCameraFollow))

						if virtualCameraFollow ~= nil then
							if tostring(virtualCameraFollow.Follow) == TimelineUtilityByLua.E_Battle_VirtualCameraFollowTarget.SkillTarget then
								childVirtualCamera.Follow = hitUnitViews[i].transform
							elseif tostring(virtualCameraFollow.Follow) == TimelineUtilityByLua.E_Battle_VirtualCameraFollowTarget.Self then
								childVirtualCamera.Follow = attackUnitView.transform
							end
						end
					end
				end
			end
		end
	end
end

function TimelineUtilityByLua.IsParticleControlTrack(track, isMain, parentType)
	if track == nil then
		return false
	end

	if track:GetType() ~= typeof(Battle.ParticleControlTrack) then
		return false
	end

	if not isMain then
		return true
	end

	if tostring(track.subEffectType) ~= TimelineUtilityByLua.E_SubEffectType.Main then
		return false
	end

	if parentType == nil then
		return true
	end

	return tostring(track.effectParentType) == parentType
end

function TimelineUtilityByLua.InitTimelineEffects(playableAsset, castSkillPOD, attackUnitView, hitUnitViews)
	local hit = castSkillPOD.SkillHits[1]

	if hit == nil then
		return
	end

	local hitGridData = hit.Scope == 0 and BattleModel.GetGridByBattleUnitID(hit.UnitID) or BattleModel.GetGridByTileID(hit.UnitID)
	local effectRowTargets = {}
	local effectColumnTargets = {}

	for _, gridData in pairs(BattleView.grids) do
		if BattleModel.GridIndexToRow(gridData.index) == BattleModel.GridIndexToRow(hitGridData.index) and (BattleModel.IsEnemyGrid(hitGridData.index) and BattleModel.IsEnemyGrid(gridData.index) or not BattleModel.IsEnemyGrid(hitGridData.index) and not BattleModel.IsEnemyGrid(gridData.index)) then
			table.insert(effectRowTargets, gridData.transform)
		end
	end

	for _, gridData in pairs(BattleView.grids) do
		if BattleModel.GridIndexToColumn(gridData.index) == BattleModel.GridIndexToColumn(hitGridData.index) and (BattleModel.IsEnemyGrid(hitGridData.index) and BattleModel.IsEnemyGrid(gridData.index) or not BattleModel.IsEnemyGrid(hitGridData.index) and not BattleModel.IsEnemyGrid(gridData.index)) then
			table.insert(effectColumnTargets, gridData.transform)
		end
	end

	local function sortFunction(transformLeft, transformRight)
		return tonumber(transformLeft.name) < tonumber(transformRight.name)
	end

	table.sort(effectRowTargets, sortFunction)
	table.sort(effectColumnTargets, sortFunction)

	local playableBindings = TimelineUtility.GetPlayableBindingsByPlayableAsset(playableAsset.asset)

	for i = 0, playableBindings.Length - 1 do
		local playableBinding = playableBindings[i]
		local controlTrack = TimelineUtility.GetPlayableBindingsourceObject(playableBinding)

		if TimelineUtilityByLua.IsParticleControlTrack(controlTrack, true, TimelineUtilityByLua.E_EffectParentType.SkillTarget) then
			local rowOrColumnSkillParent
			local x = controlTrack.skillTargetColumnIndexForOneRow
			local y = controlTrack.skillTargetRowIndexForOneColumn

			if x ~= 0 and y == 0 then
				rowOrColumnSkillParent = effectRowTargets[x]
			elseif x == 0 and y ~= 0 then
				rowOrColumnSkillParent = effectColumnTargets[y]
			end

			local isRowOrColumnSkill = rowOrColumnSkillParent ~= nil
			local clips = controlTrack:GetClips()
			local clip

			for j = 0, clips.Length - 1 do
				clip = clips[j]

				local controlPlayableAsset = clip.asset
				local effectObj = TimelineUtility.PlayableDirectorToGetReferenceValue(attackUnitView.timelineDirector, controlPlayableAsset)
				local parent

				if isRowOrColumnSkill then
					parent = rowOrColumnSkillParent
				elseif hitUnitViews[1] ~= nil then
					parent = hitUnitViews[1].transform:FindChildByName(tostring(controlTrack.effectSelfParent))
				else
					logError("Timeline 技能找不到伤害目标， {0}", tostring(controlTrack.effectSelfParent))
				end

				if effectObj == nil then
					logError(string.format("effectObj == nil  parent=%s playableDirector=%s controlPlayableAsset=%s", tostring(parent), tostring(playableDirector), tostring(controlPlayableAsset)))
				else
					effectObj.transform:SetParent(parent, false)
				end
			end
		end
	end
end

function TimelineUtilityByLua.GetHitRootTrack(playableDirector)
	local timelineAsset = playableDirector.playableAsset
	local tracks = TimelineUtility.IEnumerableTrackToArray(timelineAsset:GetRootTracks())

	for i = 0, tracks.Length - 1 do
		local track = tracks[i]

		if string.lower(track.name) == "hit" then
			return track
		end
	end

	return nil
end

function TimelineUtilityByLua.BindingHitTracks(playableDirector, castSkillPOD, attackUnitView, hits)
	local hitRootTrack = TimelineUtilityByLua.GetHitRootTrack(playableDirector)

	if hitRootTrack == nil then
		return
	end

	local realHits = {}

	for hitUnitID, _num in pairs(hits) do
		if hitUnitID ~= castSkillPOD.CasterID then
			realHits[hitUnitID] = _num
		end
	end

	local battleUnitData = BattleModel.GetBattleUnitByUnitID(castSkillPOD.CasterID)
	local timelineCid = battleUnitData.skillSkinId[castSkillPOD.SkillID]
	local timelineCfg = CfgTimelineTable[timelineCid]
	local hitChildTracks = TimelineUtility.IEnumerableTrackToArray(hitRootTrack:GetChildTracks())

	if timelineCfg.HitBindingType == 0 then
		TimelineUtilityByLua.BindingHitTracks_0(playableDirector, hitChildTracks, attackUnitView, realHits)
	elseif timelineCfg.HitBindingType == 1 or timelineCfg.HitBindingType == 2 then
		TimelineUtilityByLua.BindingHitTracks_1(playableDirector, hitChildTracks, attackUnitView, realHits)
	elseif timelineCfg.HitBindingType == 3 then
		TimelineUtilityByLua.BindingHitTracks_3(playableDirector, hitChildTracks, attackUnitView, realHits)
	elseif timelineCfg.HitBindingType == 4 then
		TimelineUtilityByLua.BindingHitTracks_3(playableDirector, hitChildTracks, attackUnitView, realHits)
	elseif timelineCfg.HitBindingType == 5 then
		TimelineUtilityByLua.BindingHitTracks_5(playableDirector, hitChildTracks, attackUnitView, realHits)
	else
		TimelineUtilityByLua.BindingHitTracks_0(playableDirector, hitChildTracks, attackUnitView, realHits)
	end
end

function TimelineUtilityByLua.BindingHitTracks_0(playableDirector, hitTracks, attackUnitView, hits)
	for i = 0, hitTracks.Length - 1 do
		hitTracks[i].muted = true
	end

	for unitId, _num in pairs(hits) do
		local hitUnitData = BattleModel.GetBattleUnitByUnitID(unitId)
		local hitUnitView = BattleView.GetBattleUnitByUnitID(unitId)

		TimelineUtilityByLua.BindingHitTrack(playableDirector, hitTracks[hitUnitData.battlePos - 1], attackUnitView, hitUnitView)
	end
end

function TimelineUtilityByLua.BindingHitTracks_1(playableDirector, hitTracks, attackUnitView, hits)
	local hitViews = {}

	for unitId, num in pairs(hits) do
		local hitUnitData = BattleModel.GetBattleUnitByUnitID(unitId)
		local key, _ = math.modf((hitUnitData.battlePos - 1) / 3)
		local hitUnitView = BattleView.GetBattleUnitByUnitID(unitId)

		hitViews[key] = hitUnitView
	end

	for i = 0, hitTracks.Length - 1 do
		if hitViews[i] == nil then
			hitTracks[i].muted = true
		else
			TimelineUtilityByLua.BindingHitTrack(playableDirector, hitTracks[i], attackUnitView, hitViews[i])
		end
	end
end

function TimelineUtilityByLua.BindingHitTracks_3(playableDirector, hitTracks, attackUnitView, hits)
	for unitId, num in pairs(hits) do
		local hitUnitView = BattleView.GetBattleUnitByUnitID(unitId)

		for i = 0, hitTracks.Length - 1 do
			TimelineUtilityByLua.BindingHitTrack(playableDirector, hitTracks[i], attackUnitView, hitUnitView)
		end

		break
	end
end

function TimelineUtilityByLua.BindingHitTracks_5(playableDirector, hitTracks, attackUnitView, hits)
	local index = 0

	for unitId, num in pairs(hits) do
		local hitUnitView = BattleView.GetBattleUnitByUnitID(unitId)

		TimelineUtilityByLua.BindingHitTrack(playableDirector, hitTracks[index], attackUnitView, hitUnitView)

		index = index + 1
	end

	for i = index, hitTracks.Length - 1 do
		hitTracks[i].muted = true
	end
end

function TimelineUtilityByLua.BindingHitTrack(playableDirector, hitTrack, attackUnitView, hitView)
	hitTrack.muted = false

	local tracks = TimelineUtility.IEnumerableTrackToArray(hitTrack:GetChildTracks())

	for i = 0, tracks.Length - 1 do
		local track = tracks[i]

		if string.sub(string.lower(track.name), 1, 2) == "fx" then
			TimelineUtilityByLua.BindingFxTrackGroup(playableDirector, fxTrackGroup, attackUnitView, hitUnitView)
		elseif track:GetType() == typeof(UnityEngine.Timeline.ControlTrack) then
			TimelineUtilityByLua.BindingControlTrack(playableDirector, track, hitView)
		elseif track:GetType() == typeof(Spine.Unity.Playables.SpineAnimationStateTrack) then
			TimelineUtilityByLua.BindingSpineAnimationStateTrack(playableDirector, track, hitView)
		elseif track:GetType() == typeof(Battle.ControlExTrack) then
			TimelineUtilityByLua.BindingControlTrack(playableDirector, track, hitView)
		elseif track:GetType() == typeof(Battle.SpineAnimationExTrack) then
			TimelineUtilityByLua.BindingSpineAnimationStateTrack(playableDirector, track, hitView)
		end
	end
end

function TimelineUtilityByLua.BindingControlTrack(playableDirector, controlTrack, unitView)
	local clips = controlTrack:GetClips()

	for i = 0, clips.Length - 1 do
		local clip = clips[i]

		TimelineUtility.PlayableDirectorToSetReferenceValue(playableDirector, clip.asset, unitView.skeletonAnimation.gameObject)
	end
end

function TimelineUtilityByLua.BindingSpineAnimationStateTrack(playableDirector, animTrack, unitView)
	playableDirector:SetGenericBinding(animTrack, unitView.skeletonAnimation)

	local animations = TimelineUtility.GetAnimationsWithSkeletonAnimation(unitView.skeletonAnimation)
	local clips = animTrack:GetClips()

	for i = 0, clips.Length - 1 do
		local clip = clips[i]

		for j = 0, animations.Length - 1 do
			if string.lower(animations[j].Name) == string.lower(clip.displayName) then
				TimelineUtility.SetTimelineAnimationClipSpineAnimation(clip.asset, animations[j])

				break
			end
		end
	end
end

function TimelineUtilityByLua.BindingFxTrackGroup(playableDirector, fxTrackGroup, attackUnitView, hitUnitView)
	return
end
