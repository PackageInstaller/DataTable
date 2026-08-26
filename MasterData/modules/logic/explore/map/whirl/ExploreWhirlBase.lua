-- chunkname: @modules/logic/explore/map/whirl/ExploreWhirlBase.lua

module("modules.logic.explore.map.whirl.ExploreWhirlBase", package.seeall)

local ExploreWhirlBase = class("ExploreWhirlBase", BaseUnitSpawn)

function ExploreWhirlBase:ctor(parentGo, type)
	local go = gohelper.create3d(parentGo, type)

	self.trans = go.transform

	self:init(go)

	self._type = type
	self._resPath = ""

	self:onInit()
	self:_loadAssets()
end

function ExploreWhirlBase:initComponents()
	self:addComp("followComp", ExploreWhirlFollowComp)
	self:addComp("effectComp", ExploreWhirlEffectComp)
end

function ExploreWhirlBase:onInit()
	return
end

function ExploreWhirlBase:_loadAssets()
	if string.nilorempty(self._resPath) then
		return
	end

	self._assetId = ResMgr.getAbAsset(self._resPath, self._onResLoaded, self, self._assetId)
end

function ExploreWhirlBase:getResPath()
	return self._resPath
end

function ExploreWhirlBase:onResLoaded()
	return
end

function ExploreWhirlBase:getGo()
	return self._displayGo
end

function ExploreWhirlBase:_onResLoaded(assetMO)
	if not assetMO.IsLoadSuccess then
		return
	end

	self:_releaseDisplayGo()

	self._displayGo = assetMO:getInstance(nil, nil, self.go)
	self._displayTr = self._displayGo.transform

	if self.followComp then
		self.followComp:setup(self.go)
		self.followComp:start()
	end

	self:onResLoaded()
end

function ExploreWhirlBase:_releaseDisplayGo()
	ResMgr.ReleaseObj(self._displayGo)
	ResMgr.removeCallBack(self._assetId)

	self._displayGo = nil
	self._displayTr = nil
end

function ExploreWhirlBase:destroy()
	self:_releaseDisplayGo()
	gohelper.destroy(self.go)
	self:onDestroy()

	self.trans = nil
end

return ExploreWhirlBase
