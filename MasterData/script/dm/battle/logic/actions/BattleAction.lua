-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/actions/BattleAction.lua

BattleAction = class("BattleAction", objectlua.Object, _M)

BattleAction:has("_actor", {
	is = "rw"
})
BattleAction:has("_battleContext", {
	is = "r"
})
BattleAction:has("_formationSystem", {
	is = "r"
})
BattleAction:has("_actionScheduler", {
	is = "r"
})

function BattleAction:initialize()
	super.initialize(self)
end

function BattleAction:withActor(actor)
	self:setActor(actor)

	return self
end

function BattleAction:checkIsActive()
	if not self._actor:isInStages(ULS_Normal, ULS_Newborn) then
		return false
	end

	return true
end

function BattleAction:isFinished()
	return self._isFinished
end

function BattleAction:finish()
	self._willFinish = true
end

function BattleAction:start(battleContext, finishCallback)
	self._isFinished = false
	self._battleContext = battleContext
	self._actionScheduler = battleContext:getObject("ActionScheduler")
	self._formationSystem = battleContext:getObject("FormationSystem")
	self._finishCallback = finishCallback

	self:doStart(battleContext)

	if self._isFinished then
		if self._finishCallback then
			self:_finishCallback()
		end

		return true
	end
end

function BattleAction:update(dt)
	if self._isFinished then
		return true
	end

	self:doUpdate(dt)

	if self._willFinish then
		self._isFinished = true

		if self._finishCallback then
			self:_finishCallback()
		end

		return true
	end
end

function BattleAction:doStart(battleContext)
	return
end

function BattleAction:doUpdate(dt)
	return
end

function BattleAction:cancel(battleContext)
	return
end

function BattleAction:checkResultWithProcessDying()
	self:processDying()

	if self._actionScheduler:willBeFinished() then
		return true
	end

	return false
end

function BattleAction:processDying()
	local formationSystem = self._formationSystem

	return formationSystem:processExcludingUnits()
end

function BattleAction:checkDying(battleContext)
	if battleContext == nil then
		battleContext = self:getBattleContext()
	end

	local formationSystem = self._formationSystem

	return formationSystem:checkDying()
end
