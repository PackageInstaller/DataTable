-- chunkname: @modules/logic/explore/map/whirl/comp/ExploreWhirlEffectComp.lua

module("modules.logic.explore.map.whirl.comp.ExploreWhirlEffectComp", package.seeall)

local ExploreWhirlEffectComp = class("ExploreWhirlEffectComp", LuaCompBase)

function ExploreWhirlEffectComp:ctor(whirl)
	self.whirl = whirl
	self._effectGo = nil
end

function ExploreWhirlEffectComp:init(go)
	self.go = go
end

function ExploreWhirlEffectComp:playAnim(animName)
	self:_releaseEffectGo()

	if animName then
		local effName = ExploreConfig.instance:getUnitEffectConfig(self.whirl:getResPath(), animName)

		if string.nilorempty(effName) == false then
			self._effectPath = ResUrl.getExploreEffectPath(effName)
			self._assetId = ResMgr.getAbAsset(self._effectPath, self._onResLoaded, self, self._assetId)
		end
	else
		self._effectPath = nil
	end
end

function ExploreWhirlEffectComp:_onResLoaded(assetMO)
	if not assetMO.IsLoadSuccess then
		return
	end

	if self._effectPath == assetMO:getUrl() then
		self:_releaseEffectGo()

		self._effectPath = assetMO:getUrl()
		self._effectGo = assetMO:getInstance(nil, nil, self.go)
	end
end

function ExploreWhirlEffectComp:_releaseEffectGo()
	ResMgr.ReleaseObj(self._effectGo)
	ResMgr.removeCallBack(self._assetId)

	self._effectGo = nil
	self._effectPath = nil
end

function ExploreWhirlEffectComp:onDestroy()
	self:_releaseEffectGo()
end

return ExploreWhirlEffectComp
