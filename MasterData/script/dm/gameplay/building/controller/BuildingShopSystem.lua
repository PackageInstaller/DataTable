-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/controller/BuildingShopSystem.lua

BuildingShopSystem = class("BuildingShopSystem", Facade)

function BuildingShopSystem:initialize()
	super.initialize(self)
end

function BuildingShopSystem:userInject()
	self:listenPush()
end

function BuildingShopSystem:listenPush()
	return
end

function BuildingShopSystem:dispose()
	super.dispose(self)
end
