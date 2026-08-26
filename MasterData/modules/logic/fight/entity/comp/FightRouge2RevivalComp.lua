-- chunkname: @modules/logic/fight/entity/comp/FightRouge2RevivalComp.lua

module("modules.logic.fight.entity.comp.FightRouge2RevivalComp", package.seeall)

local FightRouge2RevivalComp = class("FightRouge2RevivalComp", UserDataDispose)

FightRouge2RevivalComp.resPath = "ui/viewres/fight/fight_rouge2/fight_rouge2_revivaleffect.prefab"
FightRouge2RevivalComp.EffectPath = "v1a9_zwdsp1/zwdsp1_skill1_body_1"
FightRouge2RevivalComp.ReleaseTime = 1

function FightRouge2RevivalComp:init(entityId, uiGo)
	self:__onInit()

	self.containerGo = gohelper.create2d(uiGo, "rouge2Revival")

	local rectTr = self.containerGo:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchor(rectTr, 0, 100)

	self.entityId = entityId
	self.entityMo = FightDataHelper.entityMgr:getById(self.entityId)
	self.entity = FightHelper.getEntity(self.entityId)

	self.addEventCb(self, FightController.instance, FightEvent.UpdateFightParam, self.onParamChange, self)
end

function FightRouge2RevivalComp:onParamChange(keyId, oldValue, newValue, offset, actEffectData)
	if keyId ~= FightParamData.ParamKey.ROUGE2_REVIVAL_COIN then
		return
	end

	if actEffectData and actEffectData.targetId == self.entityId then
		self:activeEffect()
	end
end

function FightRouge2RevivalComp:activeEffect()
	if not self.animator then
		if not self.loader then
			self.loader = PrefabInstantiate.Create(self.containerGo)

			self.loader:startLoad(FightRouge2RevivalComp.resPath, self.onResLoaded, self)
		end

		return
	end

	self.animator:Play("active", 0, 0)

	if self.entity then
		local effectWrap = self.entity.effect:addHangEffect(FightRouge2RevivalComp.EffectPath, ModuleEnum.SpineHangPoint.mountbody, FightRouge2RevivalComp.ReleaseTime)

		FightRenderOrderMgr.instance:onAddEffectWrap(self.entityId, effectWrap)
		effectWrap:setLocalPos(0, 0, 0)
	end
end

function FightRouge2RevivalComp:onResLoaded()
	local go = self.loader:getInstGO()

	self.animator = go:GetComponent(gohelper.Type_Animator)

	self:activeEffect()
end

function FightRouge2RevivalComp:beforeDestroy()
	self:destroy()
end

function FightRouge2RevivalComp:destroy()
	if self.loader then
		self.loader:onDestroy()

		self.loader = nil
	end

	self:__onDispose()
end

return FightRouge2RevivalComp
