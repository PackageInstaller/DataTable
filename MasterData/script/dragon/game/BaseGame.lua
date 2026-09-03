-- chunkname: @/tmp/or_script/lua_compile/dragon/game/BaseGame.lua

BaseGame = class("BaseGame", _G.DisposableObject)

BaseGame:has("_context", {
	is = "r"
})

function BaseGame:initialize()
	super.initialize(self)
end

function BaseGame:dispose()
	super.dispose(self)
end

local __currentGame

function BaseGame.class:getInstance()
	assert(__currentGame ~= nil, "FATAL ERROR: Game is not running!")

	return __currentGame
end

function BaseGame:startup(...)
	__currentGame = self

	local injector = legs.Injector:new()

	self._injector = injector

	local context = self:setup(injector)

	if context == nil then
		cclog("[warning]", "Failed to create user game context. Using default `GameContext`.")

		local sharedDispatcher = EventDispatcher:new()

		context = GameContext:new(injector, sharedDispatcher)

		injector:injectInto(context)
	end

	self._context = context

	context:setGameInstance(self)
	injector.mapValue(injector, "GameInjector", injector)
	injector:mapValue("GameInstance", self)
	injector:mapValue("GameContext", context)
	self:run(...)

	return self
end

function BaseGame:shutdown()
	self:cleanup()

	if self._context ~= nil then
		self._context:shutdown()

		self._context = nil
	end

	if self._injector ~= nil then
		self._injector:dispose()

		self._injector = nil
	end

	__currentGame = nil
end

function BaseGame:exit(retValue)
	self:shutdown()
	self:dispose()
end

function BaseGame:setup(injector)
	return nil
end

function BaseGame:cleanup()
	return
end

function BaseGame:run(...)
	local context = self._context

	context:startup(...)
end

function BaseGame:dispatch(event)
	if self._context ~= nil then
		local eventDispatcher = self._context:getEventDispatcher()

		if eventDispatcher ~= nil then
			return eventDispatcher:dispatchEvent(event)
		end
	end
end

function BaseGame:switchToScene(sceneName, options, data)
	self:dispatch(SceneEvent:new(EVT_SWITCH_SCENE, sceneName, options, data))
end
