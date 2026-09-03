-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/MazeHero.lua

MazeHero = class("MazeMaster", Master, _M)

function MazeHero:initialize(heroId, player)
	super.initialize(self)
end

function MazeHero:synchronize(data)
	super:synchronize(data)
end
