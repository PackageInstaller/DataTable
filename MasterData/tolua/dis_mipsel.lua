-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/ToLua/Lua/jit/dis_mipsel.lua

local dis_mips = require((string.match(..., ".*%.") or "") .. "dis_mips")

return {
	create = dis_mips.create_el,
	disass = dis_mips.disass_el,
	regname = dis_mips.regname
}
