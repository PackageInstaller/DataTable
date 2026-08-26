-- chunkname: @modules/logic/versionactivity3_7/travelgo/battle/entity/component/TravelGoAttributesComp.lua

module("modules.logic.versionactivity3_7.travelgo.battle.entity.component.TravelGoAttributesComp", package.seeall)

local TravelGoAttributesComp = class("TravelGoAttributesComp", TravelGoBase)

function TravelGoAttributesComp:ctor(entityType, cfgId)
	TravelGoAttributesComp.super.ctor(self)

	self.entityType = entityType
	self.cfgId = cfgId
	self.AttrType = TravelGoBattleEnum.AttrType
	self.basicAttr = {}
	self.flatModifiers = {}
	self.permillageModifiers = {}
	self.attrValue = {}
end

function TravelGoAttributesComp:onAwake()
	if self.entityType == TravelGoBattleEnum.EntityType.Player then
		local cfg = lua_activity220_game.configDict[TravelGoModel.instance.gameId]
		local infos = string.splitToNumber(cfg.baseAttr, "#")

		self.basicAttr[self.AttrType.MaxHp] = infos[1]
		self.basicAttr[self.AttrType.Attack] = infos[2]
		self.basicAttr[self.AttrType.Defence] = infos[3]
	elseif self.entityType == TravelGoBattleEnum.EntityType.Enemy and self.cfgId then
		local cfg = lua_activity220_unit.configDict[self.cfgId]
		local infos = string.splitToNumber(cfg.attribute, "#")

		self.basicAttr[self.AttrType.Attack] = infos[1]
		self.basicAttr[self.AttrType.Defence] = infos[2]
		self.basicAttr[self.AttrType.MaxHp] = infos[3]
	else
		return
	end

	self.basicAttr[self.AttrType.Hp] = self.basicAttr[self.AttrType.MaxHp]

	local attrCfg = lua_activity220_attribute.configList

	for i, cfg in ipairs(attrCfg) do
		local attrId = cfg.attrId

		if attrId ~= self.AttrType.Hp and attrId ~= self.AttrType.MaxHp and attrId ~= self.AttrType.Attack and attrId ~= self.AttrType.Defence then
			local min = lua_activity220_attribute.configDict[attrId].min

			self.basicAttr[attrId] = math.max(0, min)
		end
	end

	if self.entityType == TravelGoBattleEnum.EntityType.Enemy then
		self.attrValue[self.AttrType.MaxHp] = self.basicAttr[self.AttrType.MaxHp]
		self.attrValue[self.AttrType.Hp] = self.basicAttr[self.AttrType.Hp]

		for i, cfg in ipairs(attrCfg) do
			local attrId = cfg.attrId

			if attrId == self.AttrType.MaxHp or attrId == self.AttrType.Attack or attrId == self.AttrType.Defence then
				self:calculate(attrId)
			else
				self.attrValue[attrId] = self.basicAttr[attrId]
			end
		end
	else
		for i, cfg in ipairs(attrCfg) do
			local attrId = cfg.attrId

			self.attrValue[attrId] = self.basicAttr[attrId]
		end
	end
end

function TravelGoAttributesComp:onEnable()
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnBattleEventFinish, self.onBattleEventFinish, self)
end

function TravelGoAttributesComp:onBattleEventFinish()
	local min = lua_activity220_attribute.configDict[self.AttrType.Rage].min

	self:setRage(min)
end

function TravelGoAttributesComp:haveAttr(attrId)
	return self.basicAttr[attrId]
end

function TravelGoAttributesComp:getAttr(attrId)
	return self.attrValue[attrId]
end

function TravelGoAttributesComp:setBasicAttr(attrId, value)
	self.basicAttr[attrId] = value

	self:calculate(attrId)
end

function TravelGoAttributesComp:addModifier(isPercentModifier, attrId, value, param)
	if not self:haveAttr(attrId) then
		return
	end

	if attrId == self.AttrType.Rage then
		return self:modifyRage(value, isPercentModifier)
	elseif attrId == self.AttrType.Hp then
		return self:modifyHp(value, isPercentModifier)
	end

	if isPercentModifier then
		value = value / 1000
	end

	if isPercentModifier then
		if not self.permillageModifiers then
			local modifier = self.flatModifiers

			if modifier[attrId] == nil then
				modifier[attrId] = {}
			end

			local list = modifier[attrId]

			table.insert(list, {
				attrId = attrId,
				value = value,
				param = param
			})
			self:calculate(attrId)
		end
	end
end

function TravelGoAttributesComp:removeFlatModifier(isFlatModifier, attrId, uid)
	if attrId == self.AttrType.Hp or attrId == self.AttrType.Rage then
		return
	end

	if isFlatModifier then
		if not self.flatModifiers then
			local modifier = self.permillageModifiers
			local list = modifier[attrId]

			if not list then
				return
			end

			for i, v in ipairs(list) do
				if v.param then
					if v.attrId == attrId and (not uid or v.param == uid) then
						table.remove(list, i)
						self:calculate(attrId)

						break
					end
				end
			end
		end
	end
end

function TravelGoAttributesComp:calculate(attrId)
	local value = self.basicAttr[attrId]
	local flatModifier = self.flatModifiers[attrId]

	if flatModifier then
		for i, v in ipairs(flatModifier) do
			value = value + v.value
		end
	end

	local permillageV = 1
	local permillageModifier = self.permillageModifiers[attrId]

	if permillageModifier then
		for i, v in ipairs(permillageModifier) do
			permillageV = permillageV + v.value
		end
	end

	value = value * permillageV

	if self.entityType == TravelGoBattleEnum.EntityType.Enemy then
		local gameId = TravelGoModel.instance.gameId
		local day = TravelGoModel.instance.day

		value = value * lua_activity220_date.configDict[gameId][day].difficult
	end

	local hpPercent
	local max = lua_activity220_attribute.configDict[attrId].max
	local min = lua_activity220_attribute.configDict[attrId].min

	value = GameUtil.clamp(value, min, max)
	self.attrValue[attrId] = value

	self:onAttrChange(attrId)

	if attrId == self.AttrType.MaxHp then
		local maxHp = self:getMaxHp()
		local hp = maxHp * ((attrId == self.AttrType.MaxHp or nil) and self:getHpPercent())

		self:setHp(hp)
	end
end

function TravelGoAttributesComp:damage(value)
	local oldHp = self:getHp()
	local curHp = self:modifyHp(-value)
	local change = curHp - oldHp

	if change < 0 then
		local maxHp = self:getAttr(TravelGoBattleEnum.AttrType.MaxHp)
		local rage = math.floor(math.abs(change) / maxHp * 100)

		if rage > 0 then
			local playerEntity = TravelGoController.instance.travelGoEntityMgr.playerEntity

			if playerEntity then
				playerEntity.attributes:modifyRage(rage)
			end
		end
	end
end

function TravelGoAttributesComp:setHp(value)
	local attrId = self.AttrType.Hp
	local min = lua_activity220_attribute.configDict[attrId].min
	local max = self:getMaxHp()

	value = GameUtil.clamp(value, min, max)

	local oldValue = self:getHp()

	self.basicAttr[attrId] = value
	self.attrValue[attrId] = value

	self:onAttrChange(attrId)

	return value, value - oldValue
end

function TravelGoAttributesComp:modifyHp(value, isPercentModifier)
	if not isPercentModifier then
		value = self:getHp() + value

		return self:setHp(value)
	else
		local percent = value / 1000

		value = self:getMaxHp() * percent
		value = self:getHp() + value

		return self:setHp(value)
	end
end

function TravelGoAttributesComp:getHp()
	return self:getAttr(self.AttrType.Hp)
end

function TravelGoAttributesComp:getMaxHp()
	return self:getAttr(self.AttrType.MaxHp)
end

function TravelGoAttributesComp:getHpPercent()
	local hp = self:getHp()
	local maxHp = self:getMaxHp()

	return hp / maxHp
end

function TravelGoAttributesComp:recoverHpRound()
	local rate = self:getAttr(TravelGoBattleEnum.AttrType.HpRecoverPerRound)

	if rate and rate ~= 0 then
		local curHp, change = self:modifyHp(rate, true)
		local number = TravelGoController.instance:formatNumber(change)
		local isNumberSubtract = number < 0

		TravelGoController.instance:createFloatItem({
			number = number,
			isNumberSubtract = isNumberSubtract,
			uid = self.parent.uid
		})
	end
end

function TravelGoAttributesComp:setRage(value)
	local attrId = self.AttrType.Rage
	local max = lua_activity220_attribute.configDict[attrId].max
	local min = lua_activity220_attribute.configDict[attrId].min

	value = GameUtil.clamp(value, min, max)

	local oldValue = self:getRage() or 0

	self.basicAttr[attrId] = value
	self.attrValue[attrId] = value

	self:onAttrChange(attrId)

	return value, value - oldValue
end

function TravelGoAttributesComp:modifyRage(value, isPercentModifier)
	if not isPercentModifier then
		value = self:getRage() + value

		return self:setRage(value)
	else
		local max = lua_activity220_attribute.configDict[self.AttrType.Rage].max
		local percent = value / 1000

		value = max * percent
		value = self:getRage() + max * percent

		return self:setRage(max * percent)
	end
end

function TravelGoAttributesComp:getRage()
	return self:getAttr(self.AttrType.Rage)
end

function TravelGoAttributesComp:getMaxRage()
	local max = lua_activity220_attribute.configDict[self.AttrType.Rage]

	if max then
		return max.max
	end

	return 1
end

function TravelGoAttributesComp:getRagePercent()
	local max = self:getMaxRage()

	return self:getRage() / max
end

function TravelGoAttributesComp:onAttrChange(attrId)
	local value = self:getAttr(attrId)

	logNormal(string.format("小瑞安依 属性变化 实体id:%s id：%s 值：%s", self.parent.uid, attrId, value))
	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnAttrChange, {
		entity = self.parent,
		attrId = attrId,
		value = value
	})
end

function TravelGoAttributesComp:isDie()
	return self:getHp() <= 0
end

function TravelGoAttributesComp:isFrozen()
	local v = self:getAttr(TravelGoBattleEnum.AttrType.Frozen)

	return v and v > 0
end

return TravelGoAttributesComp
