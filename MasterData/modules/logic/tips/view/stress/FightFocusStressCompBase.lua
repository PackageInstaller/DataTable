-- chunkname: @modules/logic/tips/view/stress/FightFocusStressCompBase.lua

module("modules.logic.tips.view.stress.FightFocusStressCompBase", package.seeall)

local FightFocusStressCompBase = class("FightFocusStressCompBase", UserDataDispose)

FightFocusStressCompBase.PrefabPath = FightNameUIStressMgr.PrefabPath

function FightFocusStressCompBase:init(goStress)
	self:__onInit()

	self.goStress = goStress

	self:loadPrefab()
end

function FightFocusStressCompBase:getUiType()
	return FightNameUIStressMgr.UiType.Normal
end

function FightFocusStressCompBase:loadPrefab()
	self.loader = PrefabInstantiate.Create(self.goStress)

	local res = FightNameUIStressMgr.UiType2PrefabPath[self:getUiType()]

	res = res or FightNameUIStressMgr.UiType2PrefabPath[FightNameUIStressMgr.UiType.Normal]

	self.loader:startLoad(res, self.onLoadFinish, self)
end

function FightFocusStressCompBase:onLoadFinish()
	self.instanceGo = self.loader:getInstGO()
	self.loaded = true

	self:initUI()
	self:refreshStress(self.cacheEntityMo)

	self.cacheEntityMo = nil
end

function FightFocusStressCompBase:initUI()
	return
end

function FightFocusStressCompBase:show()
	gohelper.setActive(self.instanceGo, true)
end

function FightFocusStressCompBase:hide()
	gohelper.setActive(self.instanceGo, false)
end

function FightFocusStressCompBase:refreshStress(entityMo)
	if not self.loaded then
		self.cacheEntityMo = entityMo

		return
	end

	self.entityMo = entityMo

	if not entityMo then
		self:hide()

		return
	end

	if not entityMo:hasStress() then
		self:hide()

		return
	end

	self.entityMo = entityMo
end

function FightFocusStressCompBase:destroy()
	self.loader:dispose()

	self.loader = nil

	self:__onDispose()
end

return FightFocusStressCompBase
