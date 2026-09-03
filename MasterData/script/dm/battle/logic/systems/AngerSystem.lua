-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/systems/AngerSystem.lua

local floor, ceil = math.floor, math.ceil

AngerSystem = class("AngerSystem", BattleSubSystem)

function AngerSystem:initialize()
	super.initialize(self)
end

function AngerSystem:performAngerDamage(actor, target, damage, workId)
	local targetAngerComp = target:getComponent("Anger")

	if targetAngerComp == nil then
		return nil
	end

	local result = targetAngerComp:applyDamage(damage)

	if result and self._processRecorder then
		self._processRecorder:recordObjectEvent(target:getId(), "Sync", {
			anger = result.val
		}, workId)
	end

	return result
end

function AngerSystem:performAngerRecovery(actor, target, recovery, workId)
	local targetAngerComp = target:getComponent("Anger")

	if targetAngerComp == nil then
		return nil
	end

	local result = targetAngerComp:applyRecovery(recovery)

	if result then
		if self._processRecorder then
			self._processRecorder:recordObjectEvent(target:getId(), "Sync", {
				anger = result.val
			}, workId)
		end

		if self._eventCenter then
			self._eventCenter:dispatchEvent("GainAnger", {
				unit = target,
				anger = result
			})
		end
	end

	return result
end

function AngerSystem:applyKillAnger(workId, target, killAnger)
	local targetAngerComp = target:getComponent("Anger")

	if targetAngerComp == nil then
		return nil
	end

	local result = targetAngerComp:applyRecovery(killAnger)

	if result then
		if self._processRecorder then
			self._processRecorder:recordObjectEvent(target:getId(), "Sync", {
				anger = result.val
			}, workId)
		end

		if self._eventCenter then
			self._eventCenter:dispatchEvent("GainAnger", {
				unit = target,
				anger = result
			})
		end
	end
end

function AngerSystem:applyMasterAnger(workId, target, masterAnger)
	local targetAngerComp = target:getComponent("Anger")

	if targetAngerComp == nil then
		return nil
	end

	local result = targetAngerComp:applyRecovery(masterAnger)

	if result then
		if self._processRecorder then
			self._processRecorder:recordObjectEvent(target:getId(), "Sync", {
				anger = result.val
			}, workId)
		end

		if self._eventCenter then
			self._eventCenter:dispatchEvent("GainAnger", {
				unit = target,
				anger = result
			})
		end
	end
end

function AngerSystem:checkAnger(target)
	local targetAngerComp = target:getComponent("Anger")

	if targetAngerComp == nil then
		return nil
	end

	local anger = targetAngerComp:getAnger()

	if anger == targetAngerComp:getMaxAnger() and self._eventCenter then
		self._eventCenter:dispatchEvent("GainAnger", {
			check = true,
			unit = target,
			anger = {
				raw = 0,
				eft = 0,
				val = anger
			}
		})
	end
end

function AngerSystem:applyAngerRuleOnTarget(workId, target, rule, ...)
	local targetAngerComp = target:getComponent("Anger")
	local result = targetAngerComp:applyAngerRule(rule, ...)

	if result then
		if self._processRecorder then
			self._processRecorder:recordObjectEvent(target:getId(), "Sync", {
				anger = result.val
			}, workId)
		end

		if self._eventCenter then
			self._eventCenter:dispatchEvent("GainAnger", {
				unit = target,
				anger = result
			})
		end
	end

	return result
end
