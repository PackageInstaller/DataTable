-- chunkname: @/tmp/or_script/lua_compile/dragon/game/GameContext.lua

GameContext = class("GameContext", legs.Context)

GameContext:has("_gameInstance", {
	is = "rw"
})

function GameContext:startup()
	super.startup(self)

	local injector = self:getInjector()
	local commandMap = self:getCommandMap()
	local mediatorMap = self:getMediatorMap()
	local viewMap = self:getViewMap()

	injector:mapValue("__residentLayer__", cc.Node:create())
	commandMap:mapEvent(EVT_SWITCH_SCENE, "SwitchSceneCommand")
	commandMap:mapEvent(EVT_SWITCH_VIEW, "SwitchViewCommand")
	commandMap:mapEvent(EVT_PUSH_VIEW, "PushViewCommand")
	commandMap:mapEvent(EVT_SHOW_POPUP, "ShowPopupViewCommand")
	commandMap:mapEvent(EVT_SHOW_TOAST, "ShowToastCommand")
	commandMap:mapEvent(EVT_SHOW_REWARD_TOAST, "ShowQueueToastCommand")
	commandMap:mapEvent(EVT_PLAY_EFFECT, "PlayEffectCommand")
end

function GameContext:shutdown()
	super.shutdown(self)
end

local function tryFindingClass(className)
	local clazz = _G.objectlua.Object:find(className)

	return clazz or className
end

local function findNodeClass(className)
	local names = string.split(className, ".")
	local nsOrClazz = _G

	for i, name in ipairs(names) do
		nsOrClazz = nsOrClazz[name]

		if nsOrClazz == nil then
			break
		end
	end

	return nsOrClazz
end

local function mapSingletons(injector, singletons)
	for i, item in ipairs(singletons) do
		if type(item) == "string" then
			injector:mapSingleton(item)
		elseif item.clazz == nil or item.clazz == "" then
			injector:mapSingleton(item.whenAskFor, item.named)
		else
			local clazz = tryFindingClass(item.clazz)

			injector:mapSingletonOf(item.whenAskFor, clazz, item.named)
		end
	end
end

local function mapClasses(injector, classes)
	for i, item in ipairs(classes) do
		if type(item) == "string" then
			local clazz = tryFindingClass(item)

			injector:mapClass(item, clazz)
		else
			local clazz = tryFindingClass(item.clazz)

			injector:mapClass(item.whenAskFor, clazz, item.named)
		end
	end
end

local function mapViews(viewMap, mediatorMap, views)
	for i, item in ipairs(views) do
		local viewName = item.name

		if item.res then
			viewMap:mapViewToRes(viewName, item.res)
		elseif item.node then
			local nodeClazz = findNodeClass(item.node)

			assert(nodeClazz ~= nil, string.format("Node \"%s\" not found!", item.node))
			viewMap:mapViewToCreator(viewName, function()
				return nodeClazz:create()
			end)
		elseif item.clazz then
			local clazz = tryFindingClass(item.clazz)

			if type(clazz) == "string" then
				viewMap:mapViewToCreator(viewName, function()
					local realClazz = tryFindingClass(clazz)

					return realClazz:new()
				end)
			else
				viewMap:mapViewToClass(viewName, clazz)
			end
		end

		if item.mediator then
			local mediatorClazz = tryFindingClass(item.mediator)

			mediatorMap:mapView(viewName, mediatorClazz)
		end
	end
end

local function mapEvents(commandMap, events)
	for i, item in ipairs(events) do
		local commandClass = tryFindingClass(item.command)

		commandMap:mapEvent(item.event, commandClass, item.oneshot)
	end
end

function GameContext:loadModule(moduleConfig, skipRequires)
	if moduleConfig == nil then
		return
	end

	local requires = moduleConfig.requires

	if requires and not skipRequires then
		for i, url in ipairs(requires) do
			require(url)
		end
	end

	local injections = moduleConfig.injections

	if injections then
		local injector = self:getInjector()
		local commandMap = self:getCommandMap()
		local mediatorMap = self:getMediatorMap()
		local viewMap = self:getViewMap()

		if injections.singletons then
			mapSingletons(injector, injections.singletons)
		end

		if injections.classes then
			mapClasses(injector, injections.classes)
		end

		if injections.views then
			mapViews(viewMap, mediatorMap, injections.views)
		end

		if injections.events then
			mapEvents(commandMap, injections.events)
		end
	end

	local submodules = moduleConfig.submodules

	if submodules then
		for i, submodule in ipairs(submodules) do
			self:loadModule(submodule, skipRequires)
		end
	end
end

local function collectModuleRequires(output, moduleConfig, skipSubmodules)
	local requires = moduleConfig.requires

	if requires then
		local n = #output + 1

		for i, url in ipairs(requires) do
			n = n + 1
			output[n] = url
		end
	end

	local submodules = moduleConfig.submodules

	if submodules and not skipSubmodules then
		for i, submodule in ipairs(submodules) do
			collectModuleRequires(output, submodule, skipSubmodules)
		end
	end

	return output
end

function GameContext:collectModuleRequires(moduleConfig, skipSubmodules)
	if moduleConfig == nil then
		return nil
	end

	return collectModuleRequires({}, moduleConfig, skipSubmodules)
end

local function makeSubmoduleIndices(indexTable, submodules, prefix)
	if submodules == nil then
		return
	end

	for i, modulecfg in ipairs(submodules) do
		if modulecfg.name ~= nil then
			local fullname = prefix .. modulecfg.name

			indexTable[fullname] = modulecfg

			local submodules = modulecfg.submodules

			if submodules then
				makeSubmoduleIndices(indexTable, submodules, fullname .. ".")
			end
		end
	end
end

function GameContext:initModuleConfigs(modules)
	self._namedModules = {}

	if modules == nil then
		return
	end

	local namedModules = self._namedModules

	for name, modulecfg in pairs(modules) do
		namedModules[name] = modulecfg

		local submodules = modulecfg.submodules

		if submodules ~= nil then
			makeSubmoduleIndices(namedModules, submodules, name .. ".")
		end
	end
end

function GameContext:getModuleConfig(name)
	local namedModules = self._namedModules

	return namedModules and namedModules[name]
end

function GameContext:loadModuleByName(moduleName, skipRequires)
	local moduleConfig = self:getModuleConfig(moduleName)

	if not moduleConfig then
		return
	end

	return self:loadModule(moduleConfig, skipRequires)
end

function GameContext:collectModuleRequiresByName(moduleName, skipSubmodules)
	local moduleConfig = self:getModuleConfig(moduleName)

	return self:collectModuleRequires(moduleConfig, skipSubmodules)
end
