-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/solo/SkillSoloInAdditionScene.lua

module("logic.battle.skill.performance.solo.SkillSoloInAdditionScene", package.seeall)

local SkillSoloInAdditionScene = class("SkillSoloInAdditionScene", ISkillPerformance)
local kSceneRoot = SceneMgr.instance:getSceneRoot()

function SkillSoloInAdditionScene:ctor()
	self._handler = Handler.New()
	self._resLoader = SingleResLoader.New()
	self._directorSetter = PlayableDirectorSetter.New()
	self._timelineTask = TimelineTask.New()
	self._context = false
	self._attackInfo = false
	self._timelineListener = false
	self._goTimeline = false
	self._skillAudioName = false
	self._timelineResPath = false
end

function SkillSoloInAdditionScene:bindContext(context)
	self._context = context
end

function SkillSoloInAdditionScene:setupAudioName(audioName)
	self._skillAudioName = audioName
end

function SkillSoloInAdditionScene:setTimelineResPath(timelineResPath)
	self._timelineResPath = timelineResPath
end

function SkillSoloInAdditionScene:clear()
	if self._goTimeline then
		goutil.setActive(self._goTimeline, false)
		goutil.destroy(self._goTimeline)

		self._goTimeline = false
	end

	if self._timelineListener then
		self._timelineListener:RemoveListener()

		self._timelineListener = false
	end

	self._directorSetter:Clear()
	self._resLoader:clear()
	self._timelineTask:clear()
	self._handler:clear()

	self._context = false
	self._attackInfo = false
	self._timelineListener = false
	self._skillAudioName = false
	self._timelineResPath = false
end

function SkillSoloInAdditionScene:loadResource(url, callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self._resLoader:load(url, self._onResLoaded, self)
end

function SkillSoloInAdditionScene:isResourceLoaded()
	return self._resLoader:getResource() and true or false
end

function SkillSoloInAdditionScene:start(attackInfo, callback, callbackSelf)
	self._attackInfo = attackInfo

	self._handler:setListener(callback, callbackSelf)
	self._timelineTask:stop()
	self._timelineTask:addTask(0, self._tRecordUnitsInfo, self)
	self._timelineTask:addTask(0, self._tSwitchToPerformanceScene, self)
	self._timelineTask:addTask(0, self._tActiveTimeline, self)
	self._timelineTask:start()
end

function SkillSoloInAdditionScene:stop()
	if not self._context then
		return
	end

	local attacker = self._attackInfo:getAttacker()

	BattleUnitGenerator.addUnitToScene(attacker)
	self._context:resumeUnit(attacker)
	SkillPerformanceAssistant:switchUnit2LowModel(attacker)
	GlobalDispatcher:dispatchEvent(EventType.ON_ENTER_OR_EXIT_BATTLE_VS, false)
	SkillPerformanceAssistant:showSceneObjectRoot()
	SkillPerformanceAssistant:activeMainScene()
	SkillPerformanceAssistant:showUIProperties()
	BattleMainViewFacade.instance:setVisible(true)
	ViewMgr.instance:close(ViewName.BattleVs)
end

function SkillSoloInAdditionScene:_onResLoaded()
	self._handler:callAndClear()
end

function SkillSoloInAdditionScene:_tRecordUnitsInfo()
	self._context:recordUnit(self._attackInfo:getAttacker())
	SkillPerformanceAssistant:switchUnit2HighModel(self._attackInfo:getAttacker())
	SkillPerformanceAssistant:setupUnitXinMao(self._attackInfo)
end

function SkillSoloInAdditionScene:_tSwitchToPerformanceScene()
	GlobalDispatcher:dispatchEvent(EventType.ON_ENTER_OR_EXIT_BATTLE_VS, true)
	SkillPerformanceAssistant:hideSceneObjectRoot()
	SkillPerformanceAssistant:activeAdditionScene()
	SkillPerformanceAssistant:hideUIProperties()
	SkillPerformanceAssistant:normalizeVirtualCamera()
	BattleMainViewFacade.instance:setVisible(false)
	ViewMgr.instance:open(ViewName.BattleVs, true)
end

function SkillSoloInAdditionScene:_tActiveTimeline()
	local resource = self._resLoader:getResource()
	local asset = resource:GetAsset(nil, nil)
	local goTimeline = goutil.clone(asset)
	local attacker = self._attackInfo:getAttacker()
	local centerPosition = self._context:getCenterPosition()

	goutil.addChildToParent(goTimeline, kSceneRoot)
	Astral.TransformUtil.SetPos(goTimeline.transform, centerPosition:Get())
	Astral.TransformUtil.SetLocalRotation(goTimeline.transform, 0, 180, 0)
	attacker.meshModel:lookAtDirVec3(MeshModelDirection.Forward)
	attacker.mover:setPosDirectly(centerPosition.x, centerPosition.z)
	BattleUnitGenerator.addUnitToRoot(attacker, goTimeline)

	self._goTimeline = goTimeline

	self._directorSetter:Build(goTimeline)
	self._directorSetter:SetWrapMode(UnityEngine.Playables.DirectorWrapMode.None)

	self._timelineListener = TimelineEventListener.Get(goTimeline)

	self._timelineListener:AddListener(self._onTimelineEvent, self)
	SkillPerformanceAssistant:setupTimelineBindings(self._directorSetter, goTimeline, self._attackInfo)
	self._directorSetter:Play()
	SkillPerformanceAssistant:playSkillAudio(attacker, self._skillAudioName)
	SkillPerformanceAssistant:playSkillSpeech(self._attackInfo:getAttacker(), self._timelineResPath)
end

function SkillSoloInAdditionScene:_onTimelineEvent(eventName, param)
	if eventName == BattleTimelineEventName.Stopped then
		self:_onTimelineStop()
	elseif eventName == BattleTimelineEventName.SanityConsume and not self._attackInfo:isStrengthening() then
		BattleDispatcher:dispatchEvent(BattleEventType.PlaySanityConsumeAnim, self._attackInfo)
	end
end

function SkillSoloInAdditionScene:_onTimelineStop()
	self._handler:callAndClear()
end

return SkillSoloInAdditionScene
