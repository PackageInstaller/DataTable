-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattleEntity.lua

BattleEntity = class("BattleEntity", objectlua.Object, _M)

BattleEntity:has("_id", {
	is = "r"
})

function BattleEntity:initialize(id)
	super.initialize(self)

	self._id = id
	self._referenceCount = 0
	self._components = {}
	self._userdata = {}
end

function BattleEntity:initWithRawData(data)
	local components = self._components

	for name, comp in pairs(components) do
		comp:initWithRawData(data)
	end
end

function BattleEntity:copyUnit(srcUnit, ratio)
	local components = self._components

	for name, comp in pairs(components) do
		comp:copyComponent(srcUnit:getComponent(name), ratio)
	end
end

function BattleEntity:incReferenceCount()
	self._referenceCount = self._referenceCount + 1
end

function BattleEntity:decReferenceCount()
	self._referenceCount = self._referenceCount - 1
end

function BattleEntity:getReferenceCount()
	return self._referenceCount
end

function BattleEntity:allComponents()
	return self._components
end

function BattleEntity:addComponent(name, component)
	local oldComponent = self._components[name]

	if oldComponent == component then
		return
	end

	self._components[name] = component

	if oldComponent ~= nil then
		oldComponent:setEntity(nil)
	end

	if component ~= nil then
		component:setEntity(self)
	end
end

function BattleEntity:removeComponent(name)
	local oldComponent = self._components[name]

	self._components[name] = nil

	if oldComponent ~= nil then
		oldComponent:setEntity(nil)
	end
end

function BattleEntity:getComponent(name)
	return self._components[name]
end

function BattleEntity:hasComponent(name)
	return self._components[name] ~= nil
end

function BattleEntity:setUserData(name, data)
	self._userdata[name] = data
end

function BattleEntity:getUserData(name)
	return (name or nil) and (self._userdata[name] or self._userdata)
end
