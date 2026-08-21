-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/RoomGoodsUnit.lua

module("logic.extensions.house.scene.unit.RoomGoodsUnit", package.seeall)

local M = class("RoomGoodsUnit", ReusableUnitBase)

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)

	self._originRoomId = nil
	self._resLoader = SingleResLoader.New()
	self._goInst = nil

	self:_onEnter()
end

function M:reset()
	self:_onExit()
	M.super.reset(self)
end

function M:reuse(...)
	self:_onEnter()
	M.super.reuse(self, ...)
end

function M:destroy()
	self:_onExit()
	M.super.destroy(self)

	self._resLoader = false
end

function M:_initComponents()
	self:_addComponent("mountRoot", UnitCompMountRoot)
end

function M:_onEnter()
	self:_loadGoodsRes()
end

function M:_onExit()
	if self._goInst then
		goutil.destroy(self._goInst)

		self._goInst = nil
	end

	if self._resLoader then
		self._resLoader:clear()
	end
end

function M:setOriginRoomId(roomId)
	self._originRoomId = roomId
end

function M:setUnitPos(x, y, z)
	Astral.TransformUtil.SetPos(self.go.transform, x, y, z)
end

function M:setUnitAngle(angle)
	Astral.TransformUtil.SetLocalRotation(self.go.transform, 0, 0, angle)
end

function M:getInst()
	return self._goInst
end

function M:_loadGoodsRes()
	local url = GameUrl.getHouseMeshModelUrl("box_001")

	self._resLoader:load(url, self._onResLoaded, self)
end

function M:_onResLoaded()
	self._goInst = self._resLoader:getResInstance()

	goutil.addChildToParent(self._goInst, self.go)
end

return M
