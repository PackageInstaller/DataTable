-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/UnitCompBuffPerform.lua

module("logicscene.scene.unit.component.UnitCompBuffPerform", package.seeall)

local UnitCompBuffPerform = class("UnitCompBuffPerform", UnitComponentBase)
local performs_buff

function UnitCompBuffPerform:onInit()
	if not performs_buff then
		self:_initBuffPerformed()
	end
end

function UnitCompBuffPerform:_initBuffPerformed()
	performs_buff = {}
	performs_buff.default = BuffPerformBase.New()
	performs_buff[GameEnum.BuffHurtOriginType.Rebound] = BuffPerformRebound.New()
	performs_buff[GameEnum.BuffHurtOriginType.Burn] = BuffPerformBurn.New()
	performs_buff[GameEnum.BuffHurtOriginType.Poison] = BuffPerformCommon.New()
	performs_buff[GameEnum.BuffHurtOriginType.Null] = BuffPerformBase.New()
end

function UnitCompBuffPerform:_isNeedCache(hurtOrigin)
	if self._waitingHud and not self._waitingHud:isDone() and self._waitingHud:isFadingIn() then
		return hurtOrigin ~= GameEnum.BuffHurtOriginType.Rebound
	end
end

function UnitCompBuffPerform:onBuffToggle(buffId, damage)
	local buffCo = BattleConfig.instance:getBuffCo(buffId)
	local hurtOrigin

	if buffCo and buffCo.hurtOrigin then
		hurtOrigin = buffCo.hurtOrigin
	end

	if self:_isNeedCache(hurtOrigin) then
		self.buffDamageCaches = self.buffDamageCaches or {}

		table.insert(self.buffDamageCaches, {
			buffId,
			damage,
			hurtOrigin
		})

		return
	end

	self:_startPerformed(buffId, damage, hurtOrigin)
end

function UnitCompBuffPerform:_startPerformed(buffId, damage, hurtOrigin, isInvalid)
	if not isInvalid then
		self._unit.attrs:addCurTempHp(damage)
	end

	GlobalDispatcher:dispatch(GlobalNotify.BattleBuffDamage, self._unit, damage)

	if hurtOrigin then
		local perform = performs_buff[hurtOrigin]

		if perform then
			perform:onToggle(self._unit, damage, hurtOrigin)

			if self._unit.battleFlow:isHardable(self._unit) then
				self._unit:onHard()
			end

			return
		end
	end

	performs_buff.default:onToggle(self._unit, damage)
end

function UnitCompBuffPerform:_popPerformed()
	if self.buffDamageCaches and #self.buffDamageCaches > 0 then
		local param = self.buffDamageCaches[1]

		table.remove(self.buffDamageCaches, 1)

		return param
	end
end

function UnitCompBuffPerform:invalidPerformeds()
	if self.buffDamageCaches then
		for i = 1, #self.buffDamageCaches do
			if not self.buffDamageCaches[i][4] then
				self._unit.attrs:addCurTempHp(self.buffDamageCaches[i][2])

				self.buffDamageCaches[i][4] = true

				GlobalDispatcher:dispatch(GlobalNotify.BattleBuffDamage, self._unit, self.buffDamageCaches[i][2])
			end
		end
	end
end

function UnitCompBuffPerform:checkInvalidPerformeds(damage)
	local sign = damage >= 0 and 1 or -1
	local invalidPers = false

	if self.buffDamageCaches then
		for i = 1, #self.buffDamageCaches do
			local sign1 = self.buffDamageCaches[i][2] >= 0 and 1 or -1

			if sign1 ~= sign then
				invalidPers = true

				break
			end
		end
	end

	if invalidPers then
		self:invalidPerformeds()
	end
end

function UnitCompBuffPerform:update()
	if not self._waitingHud or self._waitingHud:isDone() or not self._waitingHud:isFadingIn() then
		local params = self:_popPerformed()

		if params then
			self:_startPerformed(params[1], params[2], params[3], params[4])

			params[4] = true
		end
	end
end

function UnitCompBuffPerform:clearBuffDamages()
	self.buffDamageCaches = nil
end

function UnitCompBuffPerform:hasBuffDamages()
	return self.buffDamageCaches and #self.buffDamageCaches > 0
end

function UnitCompBuffPerform:waitingHud(hud)
	self._waitingHud = hud
end

return UnitCompBuffPerform
