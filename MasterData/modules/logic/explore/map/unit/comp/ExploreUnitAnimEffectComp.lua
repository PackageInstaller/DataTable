-- chunkname: @modules/logic/explore/map/unit/comp/ExploreUnitAnimEffectComp.lua

module("modules.logic.explore.map.unit.comp.ExploreUnitAnimEffectComp", package.seeall)

local ExploreUnitAnimEffectComp = class("ExploreUnitAnimEffectComp", LuaCompBase)

function ExploreUnitAnimEffectComp:ctor(unit)
	self.unit = unit
	self._effectGo = nil
	self._isOnce = false
end

function ExploreUnitAnimEffectComp:init(go)
	self.go = go
end

function ExploreUnitAnimEffectComp:playAnim(animName, noPlayOnceEffect)
	self._isOnce = false

	self:_releaseEffectGo()

	if animName then
		local effName, isOnce, audioId, isBindGo, isLoopAudio = ExploreConfig.instance:getUnitEffectConfig(self.unit:getResPath(), animName)

		self._isOnce = isOnce

		if noPlayOnceEffect and isOnce then
			return
		end

		ExploreHelper.triggerAudio(audioId, isBindGo, self.unit.go, (isLoopAudio or nil) and (self.unit.id or nil))

		if string.nilorempty(effName) == false then
			self._effectPath = ResUrl.getExploreEffectPath(effName)
			self._assetId = ResMgr.getAbAsset(self._effectPath, self._onResLoaded, self, self._assetId)
		end
	else
		self._effectPath = nil
	end
end

function ExploreUnitAnimEffectComp:_onResLoaded(assetMO)
	if not assetMO.IsLoadSuccess then
		return
	end

	if self._effectPath == assetMO:getUrl() then
		self:_releaseEffectGo()

		self._effectPath = assetMO:getUrl()

		local effectRoot = self.unit:getEffectRoot()

		self._effectGo = assetMO:getInstance(nil, nil, effectRoot.gameObject)
	end
end

function ExploreUnitAnimEffectComp:destoryEffectIfOnce()
	if self._isOnce then
		self:_releaseEffectGo()
	end
end

function ExploreUnitAnimEffectComp:_releaseEffectGo()
	ResMgr.removeCallBack(self._assetId)
	ResMgr.ReleaseObj(self._effectGo)

	self._effectGo = nil
	self._effectPath = nil
end

function ExploreUnitAnimEffectComp:clear()
	if not self.unit then
		return
	end

	local scene = GameSceneMgr.instance:getCurScene()

	scene.audio:stopAudioByUnit(self.unit.id)
end

function ExploreUnitAnimEffectComp:onDestroy()
	self._isOnce = false
	self.unit = false

	self:_releaseEffectGo()
end

return ExploreUnitAnimEffectComp
