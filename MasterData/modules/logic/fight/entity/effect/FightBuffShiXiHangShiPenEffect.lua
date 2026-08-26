-- chunkname: @modules/logic/fight/entity/effect/FightBuffShiXiHangShiPenEffect.lua

module("modules.logic.fight.entity.effect.FightBuffShiXiHangShiPenEffect", package.seeall)

local FightBuffShiXiHangShiPenEffect = class("FightBuffShiXiHangShiPenEffect", FightBaseClass)

function FightBuffShiXiHangShiPenEffect:onConstructor(entity)
	self.entity = entity
	self.entityId = entity.id
	self.entityData = entity.entityData

	self:com_registMsg(FightMsgId.OnAddBuff, self.onAddBuff)
	self:com_registMsg(FightMsgId.OnRemoveBuff, self.onRemoveBuff)
end

function FightBuffShiXiHangShiPenEffect:onAddBuff(buffData)
	if self.entityId ~= buffData.entityId then
		return
	end

	self:checkPenEffect()
end

function FightBuffShiXiHangShiPenEffect:checkPenEffect()
	local level, rank = HeroConfig.instance:getShowLevel(self.entityData.level)

	if rank < 2 then
		return
	end

	local haveGoodBuff = false
	local buffDic = self.entityData:getBuffDic()

	for _, buffMO in pairs(buffDic) do
		local buff_config = lua_skill_buff.configDict[buffMO.buffId]
		local buff_type_config = lua_skill_bufftype.configDict[buff_config.typeId]

		for index, value in ipairs(FightEnum.BuffTypeList.GoodBuffList) do
			if buff_type_config.type == value then
				haveGoodBuff = true

				break
			end
		end

		if haveGoodBuff then
			break
		end
	end

	if haveGoodBuff then
		if not self._shi_si_hang_shi_good_effect then
			self._shi_si_hang_shi_good_effect = self.entity.effect:addHangEffect("buff/shisihangshi_innate", ModuleEnum.SpineHangPoint.mountweapon, nil, nil, {
				z = 0,
				x = 0,
				y = 0
			})

			self._shi_si_hang_shi_good_effect:setLocalPos(0, 0, 0)

			self._shi_si_hang_shi_uid = self.entity.id

			FightRenderOrderMgr.instance:onAddEffectWrap(self.entity.id, self._shi_si_hang_shi_good_effect)
		end
	else
		self:_releaseShiSiHangShiGoodEffect()
	end
end

function FightBuffShiXiHangShiPenEffect:_releaseShiSiHangShiGoodEffect()
	if self._shi_si_hang_shi_good_effect then
		local tar_entity = FightHelper.getEntity(self._shi_si_hang_shi_uid)

		if tar_entity then
			tar_entity.effect:removeEffect(self._shi_si_hang_shi_good_effect)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(self._shi_si_hang_shi_uid, self._shi_si_hang_shi_good_effect)

		self._shi_si_hang_shi_good_effect = nil
		self._shi_si_hang_shi_uid = nil
	end
end

function FightBuffShiXiHangShiPenEffect:onRemoveBuff(buffData)
	if self.entityId ~= buffData.entityId then
		return
	end

	self:checkPenEffect()
end

return FightBuffShiXiHangShiPenEffect
