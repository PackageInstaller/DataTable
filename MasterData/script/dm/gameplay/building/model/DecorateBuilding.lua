-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/model/DecorateBuilding.lua

DecorateBuilding = class("DecorateBuilding", BaseBuilding, _M)

function DecorateBuilding:initialize()
	super.initialize(self)
end

function DecorateBuilding:dispose()
	super.dispose(self)
end

function DecorateBuilding:synchronize(data)
	if not data then
		return
	end

	super.synchronize(self, data)
end
