-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/base/prototype/PrototypeFactory.lua

require("dm.gameplay.base.prototype.HeroPrototype")
require("dm.gameplay.base.prototype.SkillPrototype")
require("dm.gameplay.base.prototype.EnemyHeroPrototype")
require("dm.gameplay.base.prototype.EnemyMasterPrototype")
require("dm.gameplay.base.prototype.MasterPrototype")

PrototypeCache = class("PrototypeCache", objectlua.Object, _M)

function PrototypeCache:initialize(creater)
	super.initialize(self)

	self._prototypes = {}
	self._creater = creater
end

function PrototypeCache:getPrototype(id)
	local prototype = self._prototypes[id]

	if prototype == nil then
		prototype = self._creater(id)

		if prototype ~= nil then
			self._prototypes[id] = prototype
		end
	end

	return prototype
end

PrototypeFactory = class("PrototypeFactory", objectlua.Object, _M)

local __prototypeFactory

function PrototypeFactory.class:getInstance()
	if __prototypeFactory == nil then
		__prototypeFactory = PrototypeFactory:new()
	end

	return __prototypeFactory
end

function PrototypeFactory:initialize()
	super.initialize(self)

	self._heroProtoCache = PrototypeCache:new(function(id)
		return HeroPrototype:new(id)
	end)
	self._skillProtoCache = PrototypeCache:new(function(id)
		return SkillPrototype:new(id)
	end)
	self._enemyHeroProtoCache = PrototypeCache:new(function(id)
		return EnemyHeroPrototype:new(id)
	end)
	self._enemyMasterProtoCache = PrototypeCache:new(function(id)
		return EnemyMasterPrototype:new(id)
	end)
	self._masterProCache = PrototypeCache:new(function(id)
		return MasterPrototype:new(id)
	end)
end

function PrototypeFactory:getHeroPrototype(id)
	return self._heroProtoCache:getPrototype(id)
end

function PrototypeFactory:getSkillPrototype(id)
	return self._skillProtoCache:getPrototype(id)
end

function PrototypeFactory:getEneryHeroPrototype(id)
	return self._enemyHeroProtoCache:getPrototype(id)
end

function PrototypeFactory:getEneryMasterPrototype(id)
	return self._enemyMasterProtoCache:getPrototype(id)
end

function PrototypeFactory:getMasterPrototype(id)
	return self._masterProCache:getPrototype(id)
end
