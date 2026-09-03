-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/kernel/Kernel.lua

Kernel = class("Kernel", objectlua.Object, _M)

Kernel:has("_serverId", {
	is = "rw"
})
Kernel:has("_subEffectsList", {
	is = "rw"
})
Kernel:has("_exp", {
	is = "rw"
})
Kernel:has("_level", {
	is = "rw"
})
Kernel:has("_mainEffectId", {
	is = "rw"
})
Kernel:has("_configId", {
	is = "rw"
})

function Kernel:initialize(data)
	super.initialize(self)

	self._serverId = data.key
	self._subEffectsList[data.key] = data.value
end
