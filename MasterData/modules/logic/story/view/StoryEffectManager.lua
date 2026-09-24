-- chunkname: @modules/logic/story/view/StoryEffectManager.lua

module("modules.logic.story.view.StoryEffectManager", package.seeall)

local StoryEffectManager = class("StoryEffectManager")

function StoryEffectManager:ctor(config)
	self._config = config or {}
	self._active = {}
end

function StoryEffectManager:activate(effType, initArg)
	local cfg = self._config[effType]

	if not cfg then
		return nil
	end

	local inst = self._active[effType]

	if inst and inst:isAlive() then
		if not inst.hasStarted then
			inst:init(initArg)
			inst:start(self._onEffectFinished, self)
		else
			inst:reset(initArg)
		end

		return inst
	end

	inst = cfg.cls.New()

	inst:init(initArg)
	inst:start(self._onEffectFinished, self)

	self._active[effType] = inst

	return inst
end

function StoryEffectManager:deactivate(effType)
	local inst = self._active[effType]

	if inst then
		inst:destroy()

		self._active[effType] = nil
	end
end

function StoryEffectManager:deactivateExcept(effType)
	local toRemove = {}

	for t, inst in pairs(self._active) do
		if t ~= effType then
			inst:destroy()
			table.insert(toRemove, t)
		end
	end

	for _, t in ipairs(toRemove) do
		self._active[t] = nil
	end
end

function StoryEffectManager:deactivateAll()
	for t, inst in pairs(self._active) do
		inst:destroy()

		self._active[t] = nil
	end
end

function StoryEffectManager:isActive(effType)
	return self._active[effType] ~= nil
end

function StoryEffectManager:get(effType)
	return self._active[effType]
end

function StoryEffectManager:_onEffectFinished(inst)
	if not inst then
		return
	end

	local effType = inst:getEffType()

	if effType == nil then
		logError(string.format("StoryEffectManager:_onEffectFinished: effType is nil, inst = %s", inst.__cname))
	end

	inst:destroy()

	self._active[effType] = nil
end

function StoryEffectManager:destroy()
	self:deactivateAll()

	self._config = nil
end

return StoryEffectManager
