-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/comp/EffectCompTimelineListener.lua

module("logic.battle.effect.comp.EffectCompTimelineListener", package.seeall)

local EffectCompTimelineListener = class("EffectCompTimelineListener", IEffectComp)

function EffectCompTimelineListener:onInit()
	self._loader = self.unit.loader
	self._handler = Handler.New()
	self._timelineListener = false
end

function EffectCompTimelineListener:onReuse()
	return
end

function EffectCompTimelineListener:onReset()
	if self._timelineListener then
		self._timelineListener:RemoveListener()

		self._timelineListener = false
	end

	self._handler:clear()
end

function EffectCompTimelineListener:onDestroy()
	self:onReset()
end

function EffectCompTimelineListener:setTimelineEventListener(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
end

function EffectCompTimelineListener:removeTimelineEventListener()
	self._handler:removeListener()
end

function EffectCompTimelineListener:onResourceLoaded()
	local goTimeline = self._loader:getInst()

	self._timelineListener = TimelineEventListener.Get(goTimeline)

	self._timelineListener:AddListener(self._onTimelineEvent, self)
end

function EffectCompTimelineListener:_onTimelineEvent(eventName, param)
	self._handler:call(eventName, param)
end

return EffectCompTimelineListener
