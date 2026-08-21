-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/particle/impl/ParticleCacheable.lua

module("logic.common.particle.impl.ParticleCacheable", package.seeall)

local ParticleCacheable = class("ParticleCacheable", AbstractGlobalReusable)

function ParticleCacheable:ctor()
	self._url = false
	self.settings = ParticleSettings.New(self)
end

function ParticleCacheable:reset()
	local mainGO = self.settings:getMainGO()

	if mainGO then
		GameObjectCache.instance:releaseGameObject(self._url, mainGO)
	end

	if self._url then
		GameObjectCache.instance:cancelLoadGameObject(self._url, self._onGameObjectLoaded, self)

		self._url = false
	end

	self.settings:clear()
end

function ParticleCacheable:destroy()
	self:reset()
end

function ParticleCacheable:load(url)
	self._url = url

	GameObjectCache.instance:loadGameObject(url, self._onGameObjectLoaded, self)
end

function ParticleCacheable:internal_onParticleFinish()
	self:returnSelf()
end

function ParticleCacheable:_onGameObjectLoaded(goInst)
	self.settings:setMainGO(goInst)
end

return ParticleCacheable
