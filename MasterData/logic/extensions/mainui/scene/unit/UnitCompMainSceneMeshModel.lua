-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitCompMainSceneMeshModel.lua

module("logic.extensions.mainui.scene.unit.UnitCompMainSceneMeshModel", package.seeall)

local M = class("UnitCompMainSceneMeshModel", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._resLoader = MultiResLoader.New()
	self._animationPlayer = nil

	self:setCurAnimState(nil)

	self._defaultAnim = nil
	self._originRotation = nil
	self._compTimelineAni = {}
end

function M:getMixDuration()
	return MainPerformEnum.AnimDefaultMixDuration
end

function M:onInit()
	self._isManualUpdateEnable = true

	self:setEvent(true)
end

function M:onReuse()
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_UNIT_LOAD, self._unit:getPointId(), self._unit:getHeroId())
	self:setCurAnimState(nil)
	self:setEvent(true)
end

function M:onReset()
	self:setEvent(false)
	self:clear()
	self:setCurAnimState(nil)
end

function M:onDestroy()
	self:setEvent(false)
	self:clear()

	self._resLoader = nil
end

function M:isDestroyed()
	if self._unit then
		return self._unit:isDestroyed()
	end

	return true
end

function M:registerTimelineAni(compName, unitCompMainSceneTimelineAniBase)
	if not self._compTimelineAni then
		self._compTimelineAni = {}
	end

	self._compTimelineAni[compName] = unitCompMainSceneTimelineAniBase

	if Astral.OSDef.isEditor then
		printWarn("注册comp:", compName)
		TableUtil.dump(self._compTimelineAni)
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_ANIM_CALL_PLAY, self._handleMainHeroAnimCallPlay, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_SET_MAGICAL_CLOTH, self._handleSetMagicalCloth, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_SET_POINT_HERO_SHOW, self._handleSetPointHeroShow, self)
		self._unit:addInnerEventListener(UnitActionType.MainSceneHeroAniPrepareFinish, self._handleOnAniPrepareFinish, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_ANIM_CALL_PLAY, self._handleMainHeroAnimCallPlay, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_SET_MAGICAL_CLOTH, self._handleSetMagicalCloth, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_SET_POINT_HERO_SHOW, self._handleSetPointHeroShow, self)
		self._unit:removeInnerEventListener(UnitActionType.MainSceneHeroAniPrepareFinish, self._handleOnAniPrepareFinish, self)
	end
end

function M:_handleSetMagicalCloth(e, info)
	if self:isDestroyed() then
		return
	end

	if self._unit:getPointId() ~= info.pointId then
		return
	end

	if info.enabled == nil then
		info.enabled = false
	end

	self:setEnableAllMagicalCloth(info.enabled)
end

function M:_handleSetPointHeroShow(e, info)
	if self:isDestroyed() then
		return
	end

	if self._unit:getPointId() ~= info.pointId then
		return
	end

	local show = info.show

	self:setModelActive(show, info.forcePrefix)

	if info.includeElement and self._unit.getElementId then
		local elementId = self._unit:getElementId()

		if elementId then
			MainScenePerformUtil.setElementShow(elementId, show)
		end
	end
end

function M:setModelActive(active, forcePrefix)
	if not self._isAllFinish then
		if enableLog then
			printWarn(string.format("[%s]%s is not load finish", self._unit:getPointId(), self._unit:getHeroId()))
		end

		return
	end

	if active then
		local obj = self._unit:getGameObject()

		if obj ~= nil and not goutil.isNil(obj) then
			local orgState = obj.activeSelf

			if not orgState then
				goutil.setActive(obj, true)
				self:setCurAnimState(nil)

				if self._guiAnimation then
					self._guiAnimation:AddListener(self._dealTimelineListener, self)
				end

				if self._unit.animSeqCtrl then
					local success = self._unit.animSeqCtrl:refreshCurPrefix(forcePrefix)

					if not success then
						local heroId = self._unit:getHeroId()
						local pointId = self._unit:getPointId()
						local skinId = self._unit:getSkinId()

						self._unit.animSeqCtrl:seqAnimPlay(MainPerformConfig.instance:getHeroElementPrefix(heroId, pointId, skinId))
					end
				end

				if self._entityInfoCache.defaultHide then
					self._unit:dispatchInnerEvent(UnitActionType.MainSceneMeshShowUp, false)
					GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_SHOW_UP, self._unit:getPointId(), self._unit:getHeroId(), self._unit, false)
				end
			end
		end
	else
		if self._guiAnimation then
			self._guiAnimation:StopTimelineAni()
			self._guiAnimation:RemoveListener()
		end

		self:setCurAnimState(nil)
		goutil.setActive(self._unit:getGameObject(), false)
	end

	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_ACTIVE_CHANGE, self._unit:getPointId(), self._unit:getHeroId(), active)
end

function M:_handleMainHeroAnimCallPlay(e, info)
	if info.heroId ~= self._unit:getHeroId() then
		return
	end

	local animationPlayer = self:getAnimationPlayer()

	if goutil.isNil(animationPlayer) then
		return
	end

	local animName = info.animName

	if string.nilorempty(animName) then
		return
	end

	if not self._animationPlayer:ContainsAnimation(animName) then
		local fallBackAnimState = MainPerformEnum.AnimFullNameFallBack[animName]

		if not string.nilorempty(fallBackAnimState) and self._animationPlayer:ContainsAnimation(fallBackAnimState) then
			animName = fallBackAnimState
		else
			if Astral.OSDef.isEditor then
				printError(string.format("[%s] 不包含动画 %s 或 %s", self._unit:getHeroId(), animName, fallBackAnimState))
			end

			return
		end
	end

	local isLoop = info.isLoop
	local isForceRestart = info.isForceRestart
	local mixDuration = info.mixDuration or self:getMixDuration()

	self:playFullNameAni(animName, mixDuration, isForceRestart)
end

function M:_handleOnAniPrepareFinish()
	if self._isAllFinish then
		self:_modelShowUp()
	end
end

function M:clear()
	if self._delayTween then
		self._delayTween:Kill(false)

		self._delayTween = nil
	end

	if self._guiAnimation then
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:RemoveListener()
	end

	self._animator = nil
	self._animationPlayer = nil
	self._playableDirector = nil
	self._magicalCloth = nil
	self._activationPlayableDirector = nil
	self._guiAnimation = nil

	for typ, go in pairs(self._resInst or {}) do
		goutil.destroy(go.gameObject)
	end

	self._pathCache = nil
	self._resInst = nil

	if self._resLoader then
		self._resLoader:clear()
	end

	self._cacheMark = nil
	self._animPrefix = nil
	self._activationItemStateCache = nil
	self._isAllFinish = false

	removetimer(self._revertSpeed, self)
end

function M:getModelTr()
	return self:getInst().transform
end

function M:getAnimationPlayer()
	return self._animationPlayer
end

function M:getResInst(resType)
	if not self._resInst then
		return
	end

	return self._resInst[resType]
end

function M:getAnimationPlayerItem()
	return self:getResInst(MainPerformEnum.ResTyp.Item)
end

function M:getInst()
	return self:getResInst(MainPerformEnum.ResTyp.Model)
end

function M:setMeshLayer(rootGO, layer)
	if not rootGO or goutil.isNil(rootGO) then
		return
	end

	local skinnedMeshRLst = rootGO.transform:GetComponentsInChildren(typeof(UnityEngine.SkinnedMeshRenderer), true)
	local len = skinnedMeshRLst.Length

	if len > 0 then
		for i = 0, len - 1 do
			local skinnedMeshR = skinnedMeshRLst[i]

			skinnedMeshR.gameObject.layer = layer
		end
	end
end

function M:setBody(resPaths, entityInfo)
	local len = resPaths and #resPaths or 0

	if len == 0 then
		return
	end

	local _mark = string.format("%s#%s#%s", entityInfo.entityCode, entityInfo.skinId, entityInfo.elementId)

	if self._cacheMark and self._cacheMark == _mark then
		return
	end

	self._unit:dispatchInnerEvent(UnitActionType.MainSceneMeshSetBody)
	self:clear()

	self._cacheMark = _mark
	self._entityInfoCache = entityInfo
	self._pathCache = {}

	local paths = {}

	for key, value in pairs(resPaths) do
		local _path = value.path

		if not string.nilorempty(_path) then
			table.insert(paths, _path)

			self._pathCache[_path] = value.typ
		end
	end

	Astral.TransformUtil.SetLocalPos(self._unit:getGameObject().transform, entityInfo.pos.x, entityInfo.pos.y, entityInfo.pos.z)
	self._resLoader:setResPaths(paths)
	self._resLoader:load(self._onAllResLoaded, self._onResLoaded, self)
end

function M:_onAllResLoaded(loader)
	self._delayTween = DoTweenUtil.DelayedCall(0, function()
		local canExcute = self._unit:checkInScene() and not self:isDestroyed()

		if canExcute then
			self._isAllFinish = true

			self:setCurAnimState(nil)

			if self._unit.animClip then
				if self._unit.animClip:getIsLoadedFinish() then
					self:_modelShowUp()
				end
			else
				self:_modelShowUp()
			end
		end
	end, self)
end

function M:_modelShowUp()
	local canExcute = self._unit:checkInScene() and not self:isDestroyed()

	if canExcute then
		local info = self._entityInfoCache

		Astral.TransformUtil.SetLocalPos(self._unit:getGameObject().transform, info.pos.x, info.pos.y, info.pos.z)
		goutil.setActive(self._unit:getGameObject(), true)

		local goAnimItemRoot

		if self._animator then
			goAnimItemRoot = goutil.findChild(self._animator.gameObject, "animItem")
		end

		local animItemTr = self:getResInst(MainPerformEnum.ResTyp.Item)

		if goAnimItemRoot and animItemTr then
			animItemTr = animItemTr.transform

			animItemTr:SetParent(goAnimItemRoot.transform, false)
			Astral.TransformUtil.SetLocalPos(animItemTr, 0, 0, 0)
			Astral.TransformUtil.SetLocalRotation(animItemTr, 0, 0, 0)
		end

		if info.defaultHide then
			self:setModelActive(false)
			self:setMeshLayer(self:getResInst(MainPerformEnum.ResTyp.Model), self._unit:getGameObject().layer)
			self:setMeshLayer(self:getResInst(MainPerformEnum.ResTyp.Item), self._unit:getGameObject().layer)

			return
		end

		local defaultAnimState = self:_playDefaultAni()

		if defaultAnimState ~= MainPerformEnum.AnimFullName.ChangeShow then
			self:setMeshLayer(self:getResInst(MainPerformEnum.ResTyp.Model), self._unit:getGameObject().layer)
			self:setMeshLayer(self:getResInst(MainPerformEnum.ResTyp.Item), self._unit:getGameObject().layer)
		end

		self._unit:dispatchInnerEvent(UnitActionType.MainSceneMeshShowUp, defaultAnimState)
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_SHOW_UP, self._unit:getPointId(), self._unit:getHeroId(), self._unit, defaultAnimState)
	end
end

function M:_playDefaultAni()
	local info = self._entityInfoCache
	local defaultPrefix = info.defaultPrefix
	local defaultAnimState

	if info.isChange and self._unit.enterShow and self._unit.enterShow:playDefaultAni(info) then
		defaultAnimState = MainPerformEnum.AnimFullName.ChangeShow
	end

	if not defaultAnimState and self._unit.animSeqCtrl then
		defaultAnimState = self._unit.animSeqCtrl:refreshCurPrefix(defaultPrefix)
	end

	if not defaultAnimState then
		if info.defaultAnim then
			defaultAnimState = info.defaultAnim
		else
			defaultAnimState = self:getAnimStateWithPrefix(UnitAnimState.MainSceneIdle)
		end

		self:playFullNameAni(defaultAnimState)
	end

	return defaultAnimState
end

function M:_onResLoaded(res)
	if not res.IsSuccess then
		printError(string.format("资源加载失败:%s", res.ResPath))

		return
	end

	local typ = self._pathCache[res.ResPath] and self._pathCache[res.ResPath] or 0
	local prefabAsset = res:GetAsset(nil, nil)
	local prefabInst, prefabTr
	local info = self._entityInfoCache

	prefabInst = goutil.cloneAndSetParent(prefabAsset, self._unit:getTransform())
	prefabTr = prefabInst.transform

	local posOffset = info.posOffset or {}
	local rotateOffset = info.rotateOffset or {}

	Astral.TransformUtil.SetLocalPos(prefabTr, posOffset.x or 0, posOffset.y or 0, posOffset.z or 0)
	Astral.TransformUtil.SetLocalRotation(prefabTr, rotateOffset.x or 0, rotateOffset.y or 0, rotateOffset.z or 0)

	if not self._resInst then
		self._resInst = {}
	end

	if typ == MainPerformEnum.ResTyp.Model then
		local lookAtIkAdpter = LookAtIKAdpter.Get(prefabInst)

		lookAtIkAdpter:SetBodyWeight(0)
		lookAtIkAdpter:EnableLookAt(false)

		lookAtIkAdpter.enabled = false

		self:setMeshLayer(prefabInst, SceneLayer.TransparentFX_Value)
		TransformUtils.SetLocalScale(prefabTr, info.localScale or 1, info.localScale or 1, info.localScale or 1)

		self._resInst[typ] = prefabInst
		self._animPrefix = nil

		local animator = prefabTr:GetComponent(ComponentType.Animator)

		animator.applyRootMotion = true
		self._animationPlayer = AnimationPlayer.Get(prefabInst)
		self._animationPlayer.isManualUpdateEnable = self._isManualUpdateEnable

		self:getAnimationPlayer():SetMixDuration(self:getMixDuration())
		self._unit:dispatchInnerEvent(UnitActionType.MeshModelLoaded, prefabInst)

		self._magicalCloth = SpaceX.MagicaCloth2Utils.Get(prefabInst)

		self:setEnableAllMagicalCloth(false)
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_UNIT_LOAD, self._unit:getPointId(), self._unit:getHeroId())
	elseif typ == MainPerformEnum.ResTyp.Timeline then
		prefabInst.layer = self._unit:getGameObject().layer
		self._resInst[typ] = prefabInst
		self._animator = goutil.addComponentOnce(prefabInst, ComponentType.Animator)
		self._playableDirector = goutil.addComponentOnce(prefabInst, ComponentType.PlayableDirector)

		PlayableDirectorUtil.SetWrapMode(self._playableDirector, UnityEngine.Playables.DirectorWrapMode.None)

		self._guiAnimation = goutil.addComponentOnce(self._animator.gameObject, typeof(Astral.GUITimelineAniLua))

		self._guiAnimation:AddListener(self._dealTimelineListener, self)
	elseif typ == MainPerformEnum.ResTyp.Item then
		self:setMeshLayer(prefabInst, SceneLayer.TransparentFX_Value)
		TransformUtils.SetLocalScale(prefabTr, info.localScale or 1, info.localScale or 1, info.localScale or 1)

		local animationPlayer = AnimationPlayer.Get(prefabInst)

		animationPlayer.isManualUpdateEnable = self._isManualUpdateEnable

		animationPlayer:SetMixDuration(self:getMixDuration())

		self._resInst[typ] = animationPlayer
	elseif typ == MainPerformEnum.ResTyp.ActivationItem then
		prefabInst.layer = self._unit:getGameObject().layer

		TransformUtils.SetLocalScale(prefabTr, info.localScale or 1, info.localScale or 1, info.localScale or 1)

		self._resInst[typ] = prefabInst
		self._activationPlayableDirector = prefabInst:GetComponent(ComponentType.PlayableDirector)
	elseif typ == MainPerformEnum.ResTyp.ChangeTimeline then
		prefabInst.layer = self._unit:getGameObject().layer

		TransformUtils.SetLocalScale(prefabTr, info.localScale or 1, info.localScale or 1, info.localScale or 1)

		self._resInst[typ] = prefabInst
	end

	self._unit:dispatchInnerEvent(UnitActionType.MainSceneHeroOnResLoaded, typ, prefabInst)
end

function M:setManualUpdateEnable(isManualUpdateEnable)
	self._isManualUpdateEnable = isManualUpdateEnable

	if self._animationPlayer then
		self._animationPlayer.isManualUpdateEnable = isManualUpdateEnable
	end
end

function M:setEnableAllMagicalCloth(enable)
	if self:isDestroyed() then
		return
	end

	if self._magicalCloth and not goutil.isNil(self._magicalCloth) then
		self._magicalCloth:SetEnableAllMagicaCloth(enable)
	end
end

function M:getCurAnimState()
	return self._curAnimState
end

function M:setCurAnimState(state)
	self._curAnimState = state
end

function M:isEqualCurAnimState(state)
	if self._curAnimState then
		return self._curAnimState == state
	end

	return false
end

function M:getAnimPrefix()
	if not self._animPrefix then
		local elementId = self._unit:getElementId()
		local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainInteractElement, elementId)

		self._animPrefix = cfg.animPrefix
	end

	return self._animPrefix
end

function M:getAnimStateWithPrefix(unitAnimState)
	return string.format("%s_%s", self:getAnimPrefix(), unitAnimState)
end

function M:containsAnim(animState)
	if string.nilorempty(animState) then
		return false
	end

	local animPlayer = self:getAnimationPlayer()

	if not animPlayer then
		printError(string.format("[%s]无法找到animPlayer", self._unit:getHeroId()))

		return false
	end

	return self:getAnimationPlayer():ContainsAnimation(animState)
end

function M:getTime()
	local time = self._playableDirector and self._playableDirector.time or 0

	return time
end

function M:getAnimationDuration(animationName)
	if self._animationPlayer then
		return self._animationPlayer:GetAnimationDuration(animationName)
	end

	return 0
end

function M:_addTimelineBinding(streamName, bindingInst, component)
	if not goutil.isNil(self._guiAnimation) and bindingInst then
		local _bind = component and goutil.addComponentOnce(bindingInst, component) or bindingInst

		if _bind then
			self._guiAnimation:AddTrackBinding(streamName, _bind, true, false)
		end
	end
end

function M:playFullNameAni(animState, mixDuration, forceRestart)
	if self:isDestroyed() then
		if enableLog then
			printWarn(string.format("[%s][%s] is disable or destroy could not play :%s", self._unit:getPointId(), self._unit:getHeroId(), animState), debug.traceback())
		end

		return
	end

	if string.nilorempty(animState) then
		printWarn(string.format("[%s][%s] animState is nil,could not play", self._unit:getPointId(), self._unit:getHeroId()), debug.traceback())

		return
	end

	if forceRestart == nil then
		forceRestart = true
	end

	if not goutil.isNil(self._guiAnimation) then
		if not goutil.isNil(self._activationPlayableDirector) then
			PlayableDirectorUtil.JumpToTime(self._activationPlayableDirector, 0)
		end

		if not self._animationPlayer:ContainsAnimation(animState) then
			animState = self._unit.animClip:getRandomAvaiableClipName()

			if string.nilorempty(animState) then
				printWarn(string.format("[%s][%s] animState is nil,could not play", self._unit:getPointId(), self._unit:getHeroId()), debug.traceback())

				return
			end
		end

		local isPlayTimelineAni = false

		for _compName, _comp in pairs(self._compTimelineAni or {}) do
			if not isPlayTimelineAni and _comp:playTimelineAni(animState) then
				isPlayTimelineAni = true
			end
		end

		self._guiAnimation:StopTimelineAni()

		if isPlayTimelineAni then
			-- block empty
		else
			self._guiAnimation:PlayAniByName(animState)

			if self._animationPlayer then
				self._animationPlayer:SetMixDuration(mixDuration or self:getMixDuration())
				self._animationPlayer:PlayAnimation(animState, false, forceRestart)
			else
				printError("could not found animationPlayer,", self._unit:getPointId())
			end
		end

		self:playItemAni(animState, false, nil, mixDuration)
		self:dealActivationItem(animState)
		self._unit:dispatchInnerEvent(UnitActionType.MainSceneHeroAniPlay, animState)
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_ANIM_PLAY, self._unit:getPointId(), self._unit:getElementId(), self._unit:getHeroId(), animState)
	end

	self:setCurAnimState(animState)
end

function M:jumpToTime(time)
	if self:isDestroyed() then
		if enableLog then
			printWarn(string.format("[%s][%s] is disable or destroy could not jumpToTime", self._unit:getPointId(), self._unit:getHeroId()))
		end

		return
	end

	if not goutil.isNil(self._playableDirector) then
		PlayableDirectorUtil.JumpToTime(self._playableDirector, time)
	end

	if not goutil.isNil(self._animationPlayer) then
		self._animationPlayer:JumpToTime(time)
	end

	self:playItemAni(self:getCurAnimState(), true, time)
end

function M:setFrozen(frozen)
	if not goutil.isNil(self._guiAnimation) then
		if frozen then
			self._guiAnimation:PauseAni()
		else
			self._guiAnimation:ResumeAni()
		end
	end

	if not goutil.isNil(self._animationPlayer) then
		self._animationPlayer:SetFrozen(frozen)
	end

	local itemAnimationPlayer = self:getAnimationPlayerItem()

	if not goutil.isNil(itemAnimationPlayer) then
		itemAnimationPlayer:SetFrozen(frozen)
	end
end

function M:_dealTimelineListener(tagName)
	if MainPerformEnum.AnimEventName.End == tagName then
		local curAnimState = self:getCurAnimState()

		self._unit:dispatchInnerEvent(UnitActionType.AnimationEvent, AnimationEventName.Complete, curAnimState)
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_ANIM_PLAY_FINISHED, self._unit:getPointId(), self._unit:getElementId(), self._unit:getHeroId(), curAnimState)
	end
end

function M:playItemAni(heroAnimState, playDefaultWhileNotFound, jumpToTime, mixDuration)
	local duration = 0
	local itemAnimationPlayer = self:getAnimationPlayerItem()

	if not goutil.isNil(itemAnimationPlayer) then
		local _itemAnimState = self:_getAnimState(itemAnimationPlayer, string.format("%s_%s", self._unit:getModelId(), heroAnimState), heroAnimState)

		if not string.nilorempty(_itemAnimState) then
			itemAnimationPlayer:SetMixDuration(mixDuration or self:getMixDuration())
			itemAnimationPlayer:PlayAnimation(_itemAnimState, false, true)

			duration = itemAnimationPlayer:GetAnimationDuration(_itemAnimState) or 0
		elseif playDefaultWhileNotFound then
			local tmpAniNames = {}

			itemAnimationPlayer:GetAnimationNamesLua(tmpAniNames)

			if #tmpAniNames > 0 then
				itemAnimationPlayer:SetMixDuration(mixDuration or self:getMixDuration())
				itemAnimationPlayer:PlayAnimation(tmpAniNames[1], false, true)

				duration = itemAnimationPlayer:GetAnimationDuration(tmpAniNames[1]) or 0
			end
		end
	end

	if duration > 0 and jumpToTime then
		jumpToTime = duration < jumpToTime and duration or jumpToTime

		itemAnimationPlayer:JumpToTime(jumpToTime)
	end
end

function M:_getAnimState(animPlayer, state, fallBackState)
	if not animPlayer then
		return nil
	end

	if animPlayer:ContainsAnimation(state) then
		return state
	end

	if animPlayer:ContainsAnimation(fallBackState) then
		return fallBackState
	end

	return nil
end

function M:dealActivationItem(heroAnimState)
	local go = self:getResInst(MainPerformEnum.ResTyp.ActivationItem)

	if go then
		goutil.setActive(go, false)
		goutil.setActive(go, self:getActivationItemNeedActive(heroAnimState))
	end
end

function M:getActivationItemNeedActive(heroAnimState)
	if not self._activationItemStateCache then
		self._activationItemStateCache = {}
	end

	if self._activationItemStateCache[heroAnimState] == nil then
		self._activationItemStateCache[heroAnimState] = MainScenePerformUtil.getHeroActivationItemNeedActive(self._unit:getModelId(), self._unit:getPointId(), heroAnimState)
	end

	return self._activationItemStateCache[heroAnimState]
end

function M:originRotation(rotation)
	self._originRotation = rotation
end

function M:rotate(degree)
	local x, y, z = Astral.TransformUtil.GetLocalRotation(self._unit:getTransform(), 0, 0, 0)

	Astral.TransformUtil.SetLocalRotation(self._unit:getTransform(), x, y + degree, z)
end

function M:setTransform(pos, rot)
	local inst = self:getResInst(MainPerformEnum.ResTyp.Model)

	if not inst or goutil.isNil(inst) then
		return
	end

	Astral.TransformUtil.SetLocalPos(inst.transform, pos.x, pos.y, pos.z)
	Astral.TransformUtil.SetLocalRotation(inst.transform, rot.x, rot.y, rot.z)
end

function M:resetTransform()
	local inst = self:getResInst(MainPerformEnum.ResTyp.Model)

	if not inst or goutil.isNil(inst) then
		return
	end

	local posOffset = self._entityInfoCache.posOffset or {}
	local rotateOffset = self._entityInfoCache.rotateOffset or {}

	Astral.TransformUtil.SetLocalPos(inst.transform, posOffset.x or 0, posOffset.y or 0, posOffset.z or 0)
	Astral.TransformUtil.SetLocalRotation(inst.transform, rotateOffset.x or 0, rotateOffset.y or 0, rotateOffset.z or 0)
	Astral.TransformUtil.SetLocalRotation(self._unit:getTransform(), self._originRotation.x, self._originRotation.y, self._originRotation.z)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_RESET_TRANSFORM, self._unit:getPointId(), self._unit:getHeroId())
end

return M
