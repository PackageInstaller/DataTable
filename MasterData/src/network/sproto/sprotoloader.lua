local sprotoparser = require("sprotoparser")
local core = require("sproto.core")
local sproto = require("sproto")

return {
	register = function(arg_1_0, arg_1_1)
		local var_1_0 = assert(io.open(arg_1_0), "Can't open sproto file")

		var_1_0:close()
		core.saveproto(core.newproto(sprotoparser.parse((var_1_0:read("a")))), arg_1_1)
	end,
	save = function(arg_2_0, arg_2_1)
		core.saveproto(core.newproto(arg_2_0), arg_2_1)
	end,
	load = function(arg_3_0)
		return sproto.sharenew((core.loadproto(arg_3_0)))
	end
}
