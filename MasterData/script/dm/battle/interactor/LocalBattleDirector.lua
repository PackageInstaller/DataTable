-- chunkname: @/tmp/or_script/lua_compile/dm/battle/interactor/LocalBattleDirector.lua

LocalBattleDirector = class("LocalBattleDirector", BattleDirector)

function LocalBattleDirector:initialize()
	super.initialize(self)
end

function LocalBattleDirector:setupBattleSystem(battleSimulator)
	assert(battleSimulator ~= nil, "No battle simulator!")

	self._battleSimulator = battleSimulator
end

function LocalBattleDirector:createPlayerController()
	if self._battleSimulator == nil then
		return nil
	end

	local inputManager = self._battleSimulator:getInputManager()

	return LocalPlayerController:new(inputManager)
end
