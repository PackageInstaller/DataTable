-- chunkname: @modules/logic/fight/entity/comp/FightNameUIStressMgr.lua

module("modules.logic.fight.entity.comp.FightNameUIStressMgr", package.seeall)

local FightNameUIStressMgr = class("FightNameUIStressMgr", UserDataDispose)

FightNameUIStressMgr.HeroDefaultIdentityId = 1001
FightNameUIStressMgr.UiType = {
	Act183 = 1,
	Normal = 0
}
FightNameUIStressMgr.UiType2PrefabPath = {
	[FightNameUIStressMgr.UiType.Normal] = "ui/viewres/fight/fightstressitem.prefab",
	[FightNameUIStressMgr.UiType.Act183] = "ui/viewres/fight/fightstressitem2.prefab"
}
FightNameUIStressMgr.UiType2Behaviour = {
	[FightNameUIStressMgr.UiType.Normal] = StressNormalBehavior,
	[FightNameUIStressMgr.UiType.Act183] = StressAct183Behavior
}

function FightNameUIStressMgr:initMgr(goStress, entity)
	self:__onInit()

	self.goStress = goStress
	self.entity = entity
	self.entityId = self.entity.id

	self:loadPrefab()
end

function FightNameUIStressMgr:loadPrefab()
	self.uiType = FightStressHelper.getStressUiType(self.entityId)

	local res = FightNameUIStressMgr.UiType2PrefabPath[self.uiType]

	res = res or FightNameUIStressMgr.UiType2PrefabPath[FightNameUIStressMgr.UiType.Normal]
	self.loader = PrefabInstantiate.Create(self.goStress)

	self.loader:startLoad(res, self.onLoadFinish, self)
end

function FightNameUIStressMgr:onLoadFinish()
	self.instanceGo = self.loader:getInstGO()

	local behaviour = FightNameUIStressMgr.UiType2Behaviour[self.uiType]

	behaviour = behaviour or StressNormalBehavior
	self.stressBehavior = behaviour.New()

	self.stressBehavior:init(self.instanceGo, self.entity)
end

function FightNameUIStressMgr:beforeDestroy()
	if self.stressBehavior then
		self.stressBehavior:beforeDestroy()
	end

	self.loader:dispose()

	self.loader = nil

	self:__onDispose()
end

return FightNameUIStressMgr
