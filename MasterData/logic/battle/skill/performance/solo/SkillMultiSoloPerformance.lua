-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/solo/SkillMultiSoloPerformance.lua

module("logic.battle.skill.performance.solo.SkillMultiSoloPerformance", package.seeall)

local SkillMultiSoloPerformance = class("SkillMultiSoloPerformance", ISkillPerformance)

function SkillMultiSoloPerformance:ctor()
	self._skillVSInfo = SkillVSInfo:createInstance()
	self._context = SkillTimelineContext.New(self._skillVSInfo)
	self._attackInfo = SkillAttackInfo:createInstance()
	self._handler = Handler.New()
	self._resLoader = BattleMultiResLoaderIncludeModel.New()
	self._soloInMainScene = SkillSoloInMainScene.New()
	self._soloInAdditionScene = SkillSoloInAdditionScene.New()
end

function SkillMultiSoloPerformance:init()
	self._context:init()
end

function SkillMultiSoloPerformance:beginPerformance(skillVSInfo, callback, callbackSelf)
	self._skillVSInfo:copyFrom(skillVSInfo)
	self._soloInMainScene:bindContext(self._context)
	self._soloInAdditionScene:bindContext(self._context)
	Handler:executeCallback(callback, callbackSelf)
end

function SkillMultiSoloPerformance:endPerformance(callback, callbackSelf)
	Handler:executeCallback(callback, callbackSelf)
end

function SkillMultiSoloPerformance:doAttack(attackInfo, callback, callbackSelf)
	SkillPerformanceAssistant:setCameraBlendDuration(0)
	self._attackInfo:copyFrom(attackInfo)
	self._handler:setListener(callback, callbackSelf)
	self:_loadAdditionScenePerformance()
	self:_loadMainScenePerformance()
	self:_loadOtherResources()
end

function SkillMultiSoloPerformance:interrupt()
	self:_internalStop()
	self._handler:callAndClear()
end

function SkillMultiSoloPerformance:_internalStop()
	SkillPerformanceAssistant:resetCameraBlendDuration()
	self._resLoader:clear()
	self._soloInAdditionScene:stop()
	self._soloInAdditionScene:clear()
	self._soloInMainScene:stop()
	self._soloInMainScene:clear()
	self._attackInfo:clear()
	self._skillVSInfo:clear()
	self._context:clear()
end

function SkillMultiSoloPerformance:_loadAdditionScenePerformance()
	local attacker = self._attackInfo:getAttacker()
	local timelineResPath = SkillPerformanceConfig.instance:getSkillMultiPerformanceTimeline(self._attackInfo:getAnimState(), attacker.property:getModelCode(), 1)
	local url = BattleSkillAssist.get3dEffectSkillUrl(timelineResPath, attacker, self._attackInfo:getFirstVictim(), self._attackInfo:getSkillId(), self._attackInfo:isStrengthening())

	self._soloInAdditionScene:setupAudioName(SkillPerformanceAssistant:getSkillAudioName(timelineResPath))
	self._soloInAdditionScene:setTimelineResPath(timelineResPath)
	self._soloInAdditionScene:loadResource(url, self._checkResourceLoaded, self)
end

function SkillMultiSoloPerformance:_loadMainScenePerformance()
	local attacker = self._attackInfo:getAttacker()
	local timelineResPath = SkillPerformanceConfig.instance:getSkillMultiPerformanceTimeline(self._attackInfo:getAnimState(), attacker.property:getModelCode(), 2)
	local url = BattleSkillAssist.get3dEffectSkillUrl(timelineResPath, attacker, self._attackInfo:getFirstVictim(), self._attackInfo:getSkillId(), self._attackInfo:isStrengthening())

	self._soloInMainScene:setupAudioName(SkillPerformanceAssistant:getSkillAudioName(timelineResPath))
	self._soloInMainScene:setTimelineResPath(timelineResPath)
	self._soloInMainScene:loadResource(url, self._checkResourceLoaded, self)
end

function SkillMultiSoloPerformance:_loadOtherResources()
	SkillPerformanceAssistant:collectHighModelUrl(self._resLoader, self._attackInfo:getAttacker())
	SkillPerformanceAssistant:collecLowModelUrl(self._resLoader, self._attackInfo:getAttacker())
	self._resLoader:load(self._checkResourceLoaded, self)
end

function SkillMultiSoloPerformance:_checkResourceLoaded()
	if self._soloInAdditionScene:isResourceLoaded() and self._soloInMainScene:isResourceLoaded() and self._resLoader:isAllSuccess() then
		self._soloInAdditionScene:start(self._attackInfo, self._onAdditionPerformanceFinished, self)
	end
end

function SkillMultiSoloPerformance:_onAdditionPerformanceFinished()
	self._soloInAdditionScene:stop()
	self._soloInAdditionScene:clear()
	self._soloInMainScene:start(self._attackInfo, self._onMainScenePerformanceFinished, self)
end

function SkillMultiSoloPerformance:_onMainScenePerformanceFinished()
	self:_internalStop()
	self._handler:callAndClear()
end

return SkillMultiSoloPerformance
