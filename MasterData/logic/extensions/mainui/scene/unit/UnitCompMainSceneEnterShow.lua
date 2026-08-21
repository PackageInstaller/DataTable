-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitCompMainSceneEnterShow.lua

module("logic.extensions.mainui.scene.unit.UnitCompMainSceneEnterShow", package.seeall)

local M = class("UnitCompMainSceneEnterShow", UnitCompMainSceneTimelineAniBase)

function M:getCompName()
	return "enterShow"
end

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)
end

function M:onInit()
	self._directorSetter = PlayableDirectorSetter.New()

	M.super.onInit(self)
end

function M:onDestroy()
	M.super.onDestroy(self)
end

function M:onReset()
	self:_stopCurSE()
	self:_stopVoice()
	M.super.onReset(self)
end

function M:onReuse()
	M.super.onReuse(self)
end

function M:clear()
	M.super.clear(self)
	removetimer(self._setMeshLayer, self)
	self:_stopCurSE()
	self:_stopVoice()

	self._lastHeroAnimState = nil
	self._changeShowPlayableDirector = nil

	if self._changeShowTimelineListener and not goutil.isNil(self._changeShowTimelineListener) then
		self._changeShowTimelineListener:RemoveListener()
	end

	self._changeShowTimelineListener = nil

	if self._directorSetter then
		self._directorSetter:Clear()
	end
end

function M:setEvent(add)
	M.super.setEvent(self, add)

	if add then
		self._unit:addInnerEventListener(UnitActionType.MainSceneHeroOnResLoaded, self._handleHeroOnResLoaded, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.MainSceneHeroOnResLoaded, self._handleHeroOnResLoaded, self)
	end
end

function M:_handleHeroOnResLoaded(eventUid, unitActionType, mainSceneResType, prefabInst)
	if mainSceneResType ~= MainPerformEnum.ResTyp.ChangeTimeline then
		return
	end

	self:clear()

	if not prefabInst or goutil.isNil(prefabInst) then
		return
	end

	self._directorSetter:Build(prefabInst)
	self._directorSetter:SetWrapMode(UnityEngine.Playables.DirectorWrapMode.None)
	self._directorSetter:AddListener(self._handleChangeTimelineStop, self)

	self._changeShowPlayableDirector = prefabInst:GetComponent(ComponentType.PlayableDirector)

	PlayableDirectorUtil.JumpToTime(self._changeShowPlayableDirector, 0)

	self._changeShowTimelineListener = TimelineEventListener.Get(prefabInst)

	self._changeShowTimelineListener:AddListener(self._onChangeShowTimelineEvent, self)
	goutil.setActive(prefabInst.gameObject, false)
end

function M:_handleChangeTimelineStop()
	if self._isPlay then
		self._isPlay = false

		self._unit:dispatchInnerEvent(UnitActionType.AnimationEvent, AnimationEventName.Complete, MainPerformEnum.AnimFullName.ChangeShow)
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_ANIM_PLAY_FINISHED, self._unit:getPointId(), self._unit:getElementId(), self._unit:getHeroId(), MainPerformEnum.AnimFullName.ChangeShow)
	end
end

function M:onMeshSetBody()
	M.super.onMeshSetBody(self)
	MainScenePerformUtil.setCamOffsetFov(0, 0.5)
end

function M:onAnimationEvent(eventName, animationName)
	if eventName == AnimationEventName.Complete then
		-- block empty
	end
end

function M:_isChangeShowAnim(heroAnimState)
	return heroAnimState == MainPerformEnum.AnimFullName.ChangeShow
end

function M:playTimelineAni(animName)
	if self:isDestroyed() then
		return false
	end

	if not self:_isChangeShowAnim(animName) then
		return false
	end

	return self:tryPlayChangeShow()
end

function M:playDefaultAni(entityInfo)
	local animState = MainPerformEnum.AnimFullName.ChangeShow
	local meshModel = self._unit.meshModel
	local animationPlayer = meshModel:getAnimationPlayer()
	local hasAnim = animationPlayer:ContainsAnimation(animState)

	if not hasAnim then
		return false
	end

	if entityInfo.isChange then
		local animPrefixForStep = entityInfo.defaultPrefix

		if string.nilorempty(animPrefixForStep) then
			animPrefixForStep = MainPerformEnum.AnimPrefix.XiangQing
		end

		if goutil.isNil(self._changeShowPlayableDirector) then
			self:_stopCurSE()

			local success = self._unit.animSeqCtrl:hardSetPlay(MainPerformEnum.AnimPrefix.XiangQing, "change", 0, true)

			self._unit.animSeqCtrl:refreshAnimStep(animPrefixForStep)
			self:_setMeshLayer()
			self:_playSEAndVoice()
			MainScenePerformUtil.characterLightSetDirty(MainPerformEnum.LightDirtyMark.EnterShow, false)
			MainScenePerformUtil.characterLightReset()
			MainScenePerformUtil.setElementTransparency(self._unit:getElementId(), 1, 0)
			MainScenePerformUtil.setCamOffsetFov(0, 0.5)

			return animState
		else
			self:tryPlayChangeShow(animPrefixForStep)

			return animState
		end
	end
end

function M:tryPlayChangeShow(animPrefixForStep)
	local success = false
	local meshModel = self._unit.meshModel
	local animationPlayer = meshModel:getAnimationPlayer()

	if not animationPlayer:ContainsAnimation(MainPerformEnum.AnimFullName.ChangeShow) then
		return success
	end

	if string.nilorempty(animPrefixForStep) then
		animPrefixForStep = MainPerformEnum.AnimPrefix.XiangQing
	end

	if goutil.isNil(self._changeShowPlayableDirector) then
		self:_setMeshLayer()

		success = false
	else
		self._isPlay = true

		self._unit.animSeqCtrl:refreshAnimStep(animPrefixForStep)

		local animState = MainPerformEnum.AnimFullName.ChangeShow
		local go = self._changeShowPlayableDirector.gameObject

		if PlayableDirectorUtil.ContainsTrack(self._changeShowPlayableDirector, SkillTimelineContext.AttackerAnimationTrack) then
			self._directorSetter:SetGenericBinding(SkillTimelineContext.AttackerAnimationTrack, animationPlayer)
		end

		local goAttackerSynchronizerRoot = GameObjectUtils.FindChildRecursively(go, 2, SkillTimelineContext.AttackerSynchronizerRoot)

		if goAttackerSynchronizerRoot then
			local attackerSynchronizer = ModelSynchronizer.Get(goAttackerSynchronizerRoot)

			attackerSynchronizer:SetSource(animationPlayer.gameObject)
		end

		MainScenePerformUtil.setCamOffsetFov(0, 0.5)
		MainScenePerformUtil.characterLightReset()
		PlayableDirectorUtil.JumpToTime(self._changeShowPlayableDirector, 0)

		if PlayableDirectorUtil.ContainsTrack(self._changeShowPlayableDirector, "CharacterLightTrack") then
			local characterLight = MainScenePerformUtil.getMainSceneCharacterLight()

			if characterLight and not goutil.isNil(characterLight) then
				MainScenePerformUtil.characterLightSetDirty(MainPerformEnum.LightDirtyMark.EnterShow, true)
				PlayableDirectorUtil.AddTrackBinding(self._changeShowPlayableDirector, "CharacterLightTrack", goutil.addComponentOnce(characterLight.gameObject, ComponentType.Animator))
			end
		end

		if PlayableDirectorUtil.ContainsTrack(self._changeShowPlayableDirector, SkillTimelineContext.SceneActiveTrack) then
			local curScene = SceneMgr.instance:getCurScene()

			if curScene then
				local sceneName = curScene.stage:getSceneName()
				local sceneActiveSetter = self._changeShowPlayableDirector.gameObject:GetComponent(typeof(Timeline.SceneActiveSetter))

				if sceneActiveSetter then
					sceneActiveSetter:SetScene(sceneName)
				end
			end
		end

		goutil.setActive(go, false)
		goutil.setActive(go, true)
		self._directorSetter:Play()
		self._unit:dispatchInnerEvent(UnitActionType.MainSceneHeroAniPlay, animState)
		meshModel:setCurAnimState(animState)
		self:_playSEAndVoice()
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_ANIM_PLAY, self._unit:getPointId(), self._unit:getElementId(), self._unit:getHeroId(), animState)
		settimer(0, self._setMeshLayer, self, false)

		success = true

		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_SET_HQ_SHADOW)
	end

	return success
end

function M:_setMeshLayer()
	if self:isDestroyed() then
		return
	end

	local meshModel = self._unit.meshModel
	local inst = meshModel:getResInst(MainPerformEnum.ResTyp.Model)

	if inst and not goutil.isNil(inst) then
		meshModel:setMeshLayer(inst, self._unit:getGameObject().layer)
	end

	inst = meshModel:getResInst(MainPerformEnum.ResTyp.Item)

	if inst and not goutil.isNil(inst) then
		meshModel:setMeshLayer(inst, self._unit:getGameObject().layer)
	end
end

function M:onAnimStatePlay(heroAnimState)
	if self:isDestroyed() then
		return
	end

	local needPlay = self:_isChangeShowAnim(heroAnimState)

	if self._lastHeroAnimState then
		local lastNeedPlay = self:_isChangeShowAnim(self._lastHeroAnimState)

		if lastNeedPlay and not needPlay and self._unit.materialComp then
			local matSwitcher = self._unit.materialComp:getMatSwitcher()

			if matSwitcher and not goutil.isNil(matSwitcher) then
				matSwitcher:ResumeAnimationMaterialModifier()
			end
		end
	end

	if not needPlay then
		self:_stopCurSE()
		MainScenePerformUtil.characterLightSetDirty(MainPerformEnum.LightDirtyMark.EnterShow, false)
		MainScenePerformUtil.setElementTransparency(self._unit:getElementId(), 1, 0)
		MainScenePerformUtil.setCamOffsetFov(0, 0.5)

		if self._changeShowPlayableDirector and not goutil.isNil(self._changeShowPlayableDirector) then
			goutil.setActive(self._changeShowPlayableDirector.gameObject, false)
		end
	end

	self._lastHeroAnimState = heroAnimState
end

function M:_onChangeShowTimelineEvent(eventName, param)
	if self:isDestroyed() then
		return
	end

	if not self._isPlay then
		return
	end

	local listener = self._changeShowTimelineListener

	if eventName == listener.MainSceneEleHide then
		MainScenePerformUtil.setElementTransparency(self._unit:getElementId(), 0, 0.2)
	elseif eventName == listener.MainSceneEleShow then
		MainScenePerformUtil.setElementTransparency(self._unit:getElementId(), 1, 2.5)
	elseif eventName == listener.MainSceneCamFovOffset then
		MainScenePerformUtil.setCamOffsetFov(tonumber(param), 0.5)
	end
end

function M:_playSEAndVoice()
	self:_stopCurSE()
	self:_stopVoice()

	local modelId = self._unit:getModelId()
	local mainSceneResName = MainScenePerformUtil.getMainSceneResName(modelId)

	if not string.nilorempty(mainSceneResName) then
		self._playingSE = string.format("show_%s_xiangqing_change_p", mainSceneResName)

		CriwareAudioFacade.instance:playSEByName(self._playingSE)
	end

	self._playingVoice = string.format("speech_%s_xingge", self._unit:getHeroId())

	CriwareAudioFacade.instance:playVoiceByName(self._playingVoice)
end

function M:_stopCurSE()
	if self._playingSE then
		CriwareAudioFacade.instance:stopSoundByByName(self._playingSE)

		self._playingSE = nil
	end
end

function M:_stopVoice()
	if self._playingVoice then
		CriwareAudioFacade.instance:stopVoice()

		self._playingVoice = nil
	end
end

return M
