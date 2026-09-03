-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/master/MazeMaster.lua

MazeMaster = class("MazeMaster", Master, _M)

function MazeMaster:initialize(masterId, player)
	super.initialize(self, masterId, player)
end

function MazeMaster:synchronize(data)
	super:synchronize(data)
end

function MazeMaster:initAttr()
	return
end
