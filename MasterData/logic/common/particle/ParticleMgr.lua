-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/particle/ParticleMgr.lua

module("logic.common.particle.ParticleMgr", package.seeall)

local ParticleMgr = class("ParticleMgr")

function ParticleMgr:ctor()
	self._genHandleId = 0
	self._allList = {}
end

function ParticleMgr:create(effectCode, goParent)
	local effectCO = EffectConfig.instance:getEffectCO(effectCode)

	if effectCO then
		local resPath = GameUrl.getEffectUrl(effectCO.resPath)
		local particle, handleId = self:createByPath(resPath, goParent)

		particle.settings:setLifeTime(effectCO.time)

		return particle, handleId
	end

	return false
end

function ParticleMgr:createByPath(resPath, goParent)
	local particle = ParticleBase:createInstance()
	local handleId = self:_createParticleHandleId(particle)

	particle.settings:setParentGO(goParent)
	particle:load(resPath)
	table.insert(self._allList, particle)

	return particle, handleId
end

function ParticleMgr:initCache(effectCode, capacity)
	local effectCO = EffectConfig.instance:getEffectCO(effectCode)

	if effectCO then
		local resPath = GameUrl.getEffectUrl(effectCO.resPath)

		GameObjectCache.instance:bindUrl(resPath, capacity)
	end
end

function ParticleMgr:clearCache(effectCode)
	local effectCO = EffectConfig.instance:getEffectCO(effectCode)

	if effectCO then
		local resPath = GameUrl.getEffectUrl(effectCO.resPath)

		GameObjectCache.instance:unbindUrl(resPath)
	end
end

function ParticleMgr:createFromCache(effectCode, goParent)
	local effectCO = EffectConfig.instance:getEffectCO(effectCode)

	if effectCO then
		local resPath = GameUrl.getEffectUrl(effectCO.resPath)
		local particle, handleId = self:createByPathFromCache(resPath, goParent)

		particle.settings:setLifeTime(effectCO.time)

		return particle, handleId
	end

	return false
end

function ParticleMgr:createByPathFromCache(resPath, goParent)
	local particle = ParticleCacheable:createInstance()
	local handleId = self:_createParticleHandleId(particle)

	particle.settings:setParentGO(goParent)
	particle:load(resPath)
	table.insert(self._allList, particle)

	return particle, handleId
end

function ParticleMgr:remove(handleId)
	for _, effect in pairs(self._allList) do
		if effect and effect.settings:getHandleId() == handleId then
			effect:returnSelf()

			return
		end
	end
end

function ParticleMgr:removeAll()
	for _, effect in pairs(self._allList) do
		effect:returnSelf()
	end

	BattleTableUtil.clearTable(self._allList)
end

function ParticleMgr:_createParticleHandleId(particle)
	self._genHandleId = self._genHandleId + 1

	local handleId = self._genHandleId

	particle.settings:setHandleId(handleId)

	return handleId
end

ParticleMgr.instance = ParticleMgr.New()

return ParticleMgr
