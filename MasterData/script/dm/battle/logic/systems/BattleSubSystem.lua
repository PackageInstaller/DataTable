-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/systems/BattleSubSystem.lua

BattleSubSystem = class("BattleSubSystem")

BattleSubSystem:has("_eventCenter", {
	is = "rw"
})
BattleSubSystem:has("_battleField", {
	is = "rw"
})
BattleSubSystem:has("_processRecorder", {
	is = "rw"
})

function BattleSubSystem:initialize()
	super.initialize(self)
end

function BattleSubSystem:startup(battleContext)
	self._battleContext = battleContext
	self._eventCenter = battleContext:getObject("EventCenter")
	self._processRecorder = battleContext:getObject("ProcessRecorder")

	return self
end
