-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/effect/Effect.lua

Effect = class("Effect", objectlua.Object, _M)

Effect:has("_config", {
	is = "r"
})

function Effect:initialize(config)
	self._config = config
end

function Effect:takeEffect(target)
	assert(false, "Override me")
end

function Effect:cancelEffect(target)
	assert(false, "Override me")
end
