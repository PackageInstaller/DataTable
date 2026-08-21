-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/particle/impl/ParticleBase.lua

module("logic.common.particle.impl.ParticleBase", package.seeall)

local ParticleBase = class("ParticleBase", AbstractGlobalReusable)

function ParticleBase:ctor()
	self._loader = SingleResLoader.New()
	self.settings = ParticleSettings.New(self)
end

function ParticleBase:reset()
	local mainGO = self.settings:getMainGO()

	if mainGO then
		goutil.destroy(mainGO)
	end

	self._loader:clear()
	self.settings:clear()
end

function ParticleBase:destroy()
	self:reset()
end

function ParticleBase:load(url)
	self._loader:load(url, self._onResourceLoaded, self)
end

function ParticleBase:internal_onParticleFinish()
	self:returnSelf()
end

function ParticleBase:_onResourceLoaded(resource)
	if resource.IsSuccess then
		local asset = resource:GetAsset(nil, nil)

		if asset then
			local goInst = goutil.clone(asset)

			self.settings:setMainGO(goInst)

			return
		end
	end

	self:returnSelf()
end

return ParticleBase
