-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitCompMainSceneHeroTouch.lua

module("logic.extensions.mainui.scene.unit.UnitCompMainSceneHeroTouch", package.seeall)

local M = class("UnitCompMainSceneHeroTouch", UnitCompMainSceneTimelineAniBase)

M.MAX_COUNT = 3

function M:getCompName()
	return "shafaTouch"
end

function M:ctor(unit)
	M.super.ctor(self, unit)
	self:setVaild(true)

	self._resLoaderTouch = MultiResLoader.New()
end

function M:onInit()
	M.super.onInit(self)
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._resLoaderTouch = nil
end

function M:onReset()
	self:stopVoice()
	M.super.onReset(self)
end

function M:onReuse()
	M.super.onReuse(self)
end

function M:getIsLoadedFinish()
	return self._isAllFinish
end

function M:getResInst(path)
	if self._resInstTouch then
		return self._resInstTouch[path]
	end

	return nil
end

function M:clear()
	M.super.clear(self)
	self:stopVoice()

	self._isAllFinish = false

	self:_clearTimeLineCompListener()

	for _, comp in pairs(self._timelineComp or {}) do
		if comp.directorSetter then
			comp.directorSetter:Clear()
		end
	end

	self._timelineComp = nil

	for path, go in pairs(self._resInstTouch or {}) do
		if go and not goutil.isNil(go) then
			goutil.destroy(go.gameObject)
		end
	end

	self._resInstTouch = nil

	if self._resDicTouch then
		for _, res in pairs(self._resDicTouch) do
			res:Release()
		end
	end

	self._resDicTouch = nil

	if self._resLoaderTouch then
		self._resLoaderTouch:clear()
	end

	self._path = {}
	self._path2ClipName = {}
	self._clip2Path = {}
	self._clip2Id = {}
	self._exitClips = {}
	self._randomClips = {}
end

function M:setEvent(add)
	M.super.setEvent(self, add)

	if add then
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_CLICK, self._handleMainSceneHeroClick, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_ACTIVE_CHANGE, self._handleMainSceneHeroActiveChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_CLICK, self._handleMainSceneHeroClick, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_ACTIVE_CHANGE, self._handleMainSceneHeroActiveChange, self)
	end
end

function M:_handleMainSceneHeroActiveChange(e, pointId, heroId, active)
	if self:isDestroyed() then
		return
	end

	if pointId ~= self._unit:getPointId() then
		return
	end

	if not active then
		self:stopVoice()
	end
end

function M:onMeshModelLoaded()
	M.super.onMeshModelLoaded(self)
	self:_loadTouch()
end

function M:onAnimStatePlay(animState)
	if self:isDestroyed() then
		return
	end

	if string.match(animState, MainPerformEnum.AnimFullName.ShafaTouch) then
		-- block empty
	else
		self:stopVoice()
		self:_clearTimeLineCompListener()

		self._playingPath = nil
		self._playingState = nil
	end
end

function M:_handleMainSceneHeroClick(e, tag, pointId, heroId)
	if pointId ~= self._unit:getPointId() then
		return
	end

	if heroId ~= self._unit:getHeroId() then
		return
	end

	self:tryPlayRandomTouch()
end

function M:setVaild(vaild)
	self._vaild = vaild
end

function M:getVaild()
	return self._vaild
end

function M:_getShafaTouchPath(id)
	local modelData = self._unit:getModelData()
	local resName = modelData:mainSceneResName()

	return GameUrl.getShafaTouchTimelinePath(resName, id)
end

function M:playVoice(id)
	self:stopVoice()

	local heroId = self._unit:getHeroId()

	self._playingVoice = string.format("speech_%s_zhujiemian_%02d", heroId, id)

	CriwareAudioFacade.instance:playVoiceByName(self._playingVoice)
end

function M:stopVoice()
	if self._playingVoice then
		CriwareAudioPlayer.instance:stopAllVoiceSound()

		self._playingVoice = nil
	end
end

function M:playTimelineAni(animState)
	if self:isDestroyed() then
		return false
	end

	if not string.match(animState, MainPerformEnum.AnimFullName.ShafaTouch) then
		return false
	end

	local id = tonumber(string.match(animState, "(%d+)"))

	return self:_playShafaTouch(id)
end

function M:tryPlayRandomTouch()
	if not ViewMgr.instance:isOpen(ViewName.MainUIView) then
		return
	end

	if self:isDestroyed() then
		return
	end

	local meshModel = self._unit.meshModel
	local curState = meshModel:getCurAnimState()

	if curState ~= MainPerformEnum.AnimFullName.ShafaIdle then
		if Astral.OSDef.isEditor then
			printWarn(string.format("[%s]正在播放%s, 不响应点击", self._unit:getPointId(), curState))
		end

		return
	end

	if not self._randomClips then
		self._randomClips = {}
	end

	if #self._randomClips == 0 then
		for _, _clipName in pairs(self._exitClips or {}) do
			table.insert(self._randomClips, _clipName)
		end

		if #self._randomClips > 1 then
			for i = 1, #self._randomClips do
				local rIndex = math.random(1, #self._randomClips)
				local _a = self._randomClips[i]
				local _b = self._randomClips[rIndex]

				self._randomClips[i] = _b
				self._randomClips[rIndex] = _a
			end

			if self._lastPlayAnimState and self._lastPlayAnimState == self._randomClips[1] then
				table.remove(self._randomClips, 1)
				table.insert(self._randomClips, self._lastPlayAnimState)
			end
		end
	end

	if #self._randomClips > 0 then
		local animState = table.remove(self._randomClips, 1)

		meshModel:playFullNameAni(animState)
	end
end

function M:_playShafaTouch(id)
	if not id then
		return false
	end

	local animState = string.format("shafa_touch_%s", id)
	local meshModel = self._unit.meshModel
	local animationPlayer = meshModel:getAnimationPlayer()
	local hasAnim = animationPlayer:ContainsAnimation(animState)
	local playSuccess = false
	local comp = self:_getTimelineComp(id)

	if hasAnim and comp and not goutil.isNil(comp.playableDirector) then
		self:_clearTimeLineCompListener()

		local go = comp.playableDirector.gameObject

		comp.directorSetter:SetGenericBinding(SkillTimelineContext.AttackerAnimationTrack, animationPlayer)

		local goAttackerSynchronizerRoot = GameObjectUtils.FindChildRecursively(go, 2, SkillTimelineContext.AttackerSynchronizerRoot)

		if goAttackerSynchronizerRoot then
			local attackerSynchronizer = ModelSynchronizer.Get(goAttackerSynchronizerRoot)

			attackerSynchronizer:SetSource(animationPlayer.gameObject)
		end

		PlayableDirectorUtil.JumpToTime(comp.playableDirector, 0)
		goutil.setActive(go, false)
		comp.directorSetter:AddListener(self._handleTouchTimelineStop, self)
		comp.timelineListener:AddListener(self._onTouchTimelineEvent, self)
		goutil.setActive(go, true)
		comp.directorSetter:Play()
		self._unit:dispatchInnerEvent(UnitActionType.MainSceneHeroAniPlay, animState)
		meshModel:setCurAnimState(animState)
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_ANIM_PLAY, self._unit:getPointId(), self._unit:getElementId(), self._unit:getHeroId(), animState)

		self._playingPath = comp.path
		self._playingState = animState
		playSuccess = true
	else
		self._playingPath = nil
		self._playingState = nil
	end

	if hasAnim then
		self:playVoice(id)

		self._lastPlayAnimState = animState
	end

	return playSuccess
end

function M:_handleTouchTimelineStop()
	if self:isDestroyed() then
		return
	end

	if not self._playingPath then
		return
	end

	local animState = self._path2ClipName[self._playingPath]

	self:_clearTimeLineCompListener()

	self._playingPath = nil
	self._playingState = nil

	self._unit:dispatchInnerEvent(UnitActionType.AnimationEvent, AnimationEventName.Complete, animState)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_ANIM_PLAY_FINISHED, self._unit:getPointId(), self._unit:getElementId(), self._unit:getHeroId(), animState)
end

function M:_onTouchTimelineEvent(eventName, param)
	if self:isDestroyed() then
		return
	end

	if not self._playingPath then
		return
	end

	local listener
	local comp = self._timelineComp[self._playingPath]

	if comp then
		listener = comp.timelineListener
	end
end

function M:_loadTouch()
	self:clear()

	local animPlayer = self._unit.meshModel:getAnimationPlayer()

	for i = 1, M.MAX_COUNT do
		local animClipName = string.format("shafa_touch_%s", i)

		if animPlayer:ContainsAnimation(animClipName) then
			table.insert(self._exitClips, animClipName)

			local _path = self:_getShafaTouchPath(i)

			if not string.nilorempty(_path) and Astral.LuaResourceCache.Instance:ExistsResource(_path) then
				table.insert(self._path, _path)

				self._path2ClipName[_path] = animClipName
				self._clip2Path[animClipName] = _path
				self._clip2Id[animClipName] = i
			end
		end
	end

	if #self._path > 0 then
		self._resLoaderTouch:setResPaths(self._path)
		self._resLoaderTouch:load(self._onAllResLoadedTouch, self._onResLoadedTouch, self)
	end
end

function M:_onAllResLoadedTouch(loader)
	self._isAllFinish = true

	for _path, _prefabInst in pairs(self._resInstTouch or {}) do
		self:_registerTimeline(_prefabInst, _path)
	end
end

function M:_onResLoadedTouch(res)
	if not res.IsSuccess then
		printError(string.format("资源加载失败:%s", res.ResPath))

		return
	end

	local prefabAsset = res:GetAsset(nil, nil)
	local prefabInst = goutil.cloneAndSetParent(prefabAsset, self._unit:getTransform())

	goutil.setActive(prefabInst.gameObject, false)

	local prefabTr = prefabInst.transform

	Astral.TransformUtil.SetLocalPos(prefabTr, 0, 0, 0)
	Astral.TransformUtil.SetLocalRotation(prefabTr, 0, 0, 0)

	prefabInst.layer = self._unit:getGameObject().layer

	if not self._resDicTouch then
		self._resDicTouch = {}
	end

	self._resDicTouch[res.ResPath] = res

	res:Retain()

	if not self._resInstTouch then
		self._resInstTouch = {}
	end

	self._resInstTouch[res.ResPath] = prefabInst
end

function M:_getTimelineComp(id)
	local comp

	if self._timelineComp then
		local _path = self:_getShafaTouchPath(id)

		comp = self._timelineComp[_path]
	end

	return comp
end

function M:_registerTimeline(prefabInst, path)
	if not prefabInst or goutil.isNil(prefabInst) then
		return
	end

	if not self._timelineComp then
		self._timelineComp = {}
	end

	local animState = self._path2ClipName[path]
	local directorSetter = PlayableDirectorSetter.New()

	directorSetter:Build(prefabInst)
	directorSetter:SetWrapMode(UnityEngine.Playables.DirectorWrapMode.None)

	local playableDirector = prefabInst:GetComponent(ComponentType.PlayableDirector)

	PlayableDirectorUtil.JumpToTime(playableDirector, 0)

	local timelineListener = TimelineEventListener.Get(prefabInst)

	self._timelineComp[path] = {
		id = self._clip2Id[animState],
		go = prefabInst,
		path = path,
		animState = animState,
		directorSetter = directorSetter,
		playableDirector = playableDirector,
		timelineListener = timelineListener
	}
end

function M:_clearTimeLineCompListener()
	for _, _comp in pairs(self._timelineComp or {}) do
		if _comp.directorSetter then
			_comp.directorSetter:RemoveListener()
		end

		if _comp.timelineListener then
			_comp.timelineListener:RemoveListener()
		end

		if _comp.playableDirector and not goutil.isNil(_comp.playableDirector) then
			goutil.setActive(_comp.playableDirector.gameObject, false)
		end
	end
end

return M
