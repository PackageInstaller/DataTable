-- chunkname: @/tmp/or_script/lua_compile/dragon/game/model/GameObject.lua

GameObject = class("GameObject", legs.Actor)

function GameObject:initialize()
	super.initialize(self)
end

function GameObject:dispose()
	super.dispose(self)
end
