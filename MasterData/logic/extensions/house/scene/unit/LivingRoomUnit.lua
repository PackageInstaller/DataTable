-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/LivingRoomUnit.lua

module("logic.extensions.house.scene.unit.LivingRoomUnit", package.seeall)

local M = class("LivingRoomUnit", HouseRoomUnit)

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)
end

function M:_initComponents()
	M.super._initComponents(self)
	self:_addComponent("furnitureMgr", UnitCompRoomFurnitureMgr)
	self:_addComponent("furnitureMap", UnitCompRoomFurnitureMap)
	self:_addComponent("furnitureHandler", UnitCompRoomFurnitureHandler)
	self:_addComponent("furniturePaper", UnitCompRoomFurniturePaper)
	self:_addComponent("furniturePerform", UnitCompRoomFurniturePerform)
end

return M
