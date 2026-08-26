-- chunkname: @modules/logic/fight/entity/effect/FightNarcissusImmunityEffect.lua

module("modules.logic.fight.entity.effect.FightNarcissusImmunityEffect", package.seeall)

local FightNarcissusImmunityEffect = class("FightNarcissusImmunityEffect", FightBaseClass)

function FightNarcissusImmunityEffect:onConstructor(entity)
	self.entity = entity
	self.entityId = entity.id
	self.entityData = FightDataHelper.entityMgr:getById(self.entityId)

	self:com_registMsg(FightMsgId.NarcissusImmunityEffect, self.onNarcissusImmunityEffect)
end

function FightNarcissusImmunityEffect:onNarcissusImmunityEffect(uid)
	if uid ~= self.entityId then
		return
	end

	if not self.entityData then
		return
	end

	if not self.entity.effect then
		return
	end

	local has, buffData = self.entityData:hasBuffActId(FightEnum.BuffFeature.NarcissusCounterDamageImmune)
	local config

	if buffData then
		local fromEntity = FightDataHelper.entityMgr:getById(buffData.fromUid)

		config = fromEntity and lua_fight_na_xi_suo_si_immunity_effect.configDict[fromEntity.skin]
	end

	config = config or lua_fight_na_xi_suo_si_immunity_effect.configDict[0]

	local effectPath = config.effect
	local effectHang = config.effectHang
	local duration = config.duration
	local audio = config.audio
	local effectWrap = self.entity.effect:addHangEffect(effectPath, effectHang, nil, duration)

	effectWrap:setLocalPos(0, 0, 0)

	if audio ~= 0 then
		AudioMgr.instance:trigger(audio)
	end

	if self.entity.nameUI then
		local nameUIGO = self.entity.nameUI:getGO()

		if nameUIGO then
			self.entity.nameUI:setActive(false, "FightNarcissusImmunityEffect")

			local url = "ui/viewres/fight/fightnameuinaxisuosi.prefab"

			self:com_loadAsset(url, self.onUILoaded, nameUIGO)
		end
	end
end

function FightNarcissusImmunityEffect:onUILoaded(success, assetItem, nameUIGO)
	if not success then
		return
	end

	local resObj = assetItem:GetResource()
	local obj = gohelper.clone(resObj, nameUIGO)
	local ani = gohelper.onceAddComponent(obj, gohelper.Type_Animator)
	local uiSpeed = FightModel.instance:getUISpeed()

	ani.speed = uiSpeed

	self:com_registTimer(self.releaseUIEffect, 1.2 / uiSpeed, obj)
end

function FightNarcissusImmunityEffect:releaseUIEffect(obj)
	gohelper.destroy(obj)
	self.entity.nameUI:setActive(true, "FightNarcissusImmunityEffect")
end

return FightNarcissusImmunityEffect
