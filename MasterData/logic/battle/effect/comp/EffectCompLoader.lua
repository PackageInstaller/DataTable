-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/effect/comp/EffectCompLoader.lua

module("logic.battle.effect.comp.EffectCompLoader", package.seeall)

local EffectCompLoader = class("EffectCompLoader", IEffectComp)

function EffectCompLoader:onInit()
	self._url = false
	self._inst = false
	self._resource = false
	self._handler = Handler.New()
end

function EffectCompLoader:onReuse()
	return
end

function EffectCompLoader:onReset()
	self._handler:clear()
	self:clear()
end

function EffectCompLoader:onDestroy()
	self._handler:clear()
	self:clear()
end

function EffectCompLoader:getInst()
	return self._inst
end

function EffectCompLoader:getUrl()
	return self._url
end

function EffectCompLoader:setListener(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
end

function EffectCompLoader:load(url, needPreloadAsset)
	if self._url == url then
		return
	end

	self:clear()

	if not url then
		return
	end

	self._url = url

	getres(url, self._onResourceLoaded, self, nil, needPreloadAsset)
end

function EffectCompLoader:_onResourceLoaded(resource)
	local mainGO = self.unit.mainGO

	if resource.IsSuccess and mainGO then
		local asset = resource:GetMainAsset()

		if asset then
			self._resource = resource

			self._resource:Retain()

			self._inst = Astral.GameObjectUtil.CloneAndSetParent(asset, mainGO.transform, nil)

			self.unit:internalEffectLoaded()
			self._handler:call(self._inst)
		end
	end
end

function EffectCompLoader:clear()
	if not self._url then
		return
	end

	if self._inst then
		goutil.destroy(self._inst)

		self._inst = false
	end

	if self._resource then
		self._resource:Release()

		self._resource = false
	else
		removeresl(self._url, self._onResourceLoaded, self)
	end

	self._url = false
end

return EffectCompLoader
