-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/HouseRoomUnit.lua

module("logic.extensions.house.scene.unit.HouseRoomUnit", package.seeall)

local M = class("HouseRoomUnit", ReusableUnitBase)
local kLateInitFuncName = "onLateInit"
local kRoomResLoadFuncName = "onRoomResLoaded"
local kRoomResUnloadFuncName = "onRoomResUnload"
local kRoomEnterFuncName = "onRoomEnter"
local kRoomExitFuncName = "onRoomExit"
local kCalculPosGoName = "_calcul_pos_go_"

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)
end

function M:_initComponents()
	self:_addComponent("resLoader", UnitCompRoomResLoader)
	self:_addComponent("model", UnitCompRoomModel)
	self:_addComponent("roomFocusCollider", UnitCompRoomFocusCollider)
	self:_addComponent("materialSetter", UnitCompRoomMaterialSetter)
	self:_addComponent("roomNavMesh", UnitCompRoomNavMesh)
end

function M:lateInit()
	self:_executeCompFunc(kLateInitFuncName)
end

function M:hasLoadedRoomRes()
	self:_executeCompFunc(kRoomResLoadFuncName)
end

function M:startUnloadRoomRes()
	self:_executeCompFunc(kRoomResUnloadFuncName)
end

function M:enterRoom(hasRes)
	self:_executeCompFunc(kRoomEnterFuncName, hasRes)
end

function M:exitRoom(hasRes)
	self:_executeCompFunc(kRoomExitFuncName, hasRes)
end

function M:getUnitGo()
	return self.go
end

function M:setUnitActive(isActive)
	goutil.setActive(self.go, isActive)
end

function M:setUnitLocalPos(x, y, z)
	Astral.TransformUtil.SetLocalPos(self.go.transform, x, y, z)
end

function M:getParentGO()
	return self.go.transform.parent.gameObject
end

function M:getParentRotaZ()
	local parentGO = self:getParentGO()
	local rotaX, rotaY, rotaZ = Astral.TransformUtil.GetLocalRotation(parentGO.transform, 0, 0, 0)

	return rotaZ
end

function M:getWorldPosByOffset(offsetX, offsetY, offsetZ)
	local calculGO = self:_tryGetCalculPosGO()

	Astral.TransformUtil.SetLocalPos(calculGO.transform, offsetX, offsetY, offsetZ)

	return Astral.TransformUtil.GetPos(calculGO.transform, 0, 0, 0)
end

function M:getRotationByOffset(rotaX, rotaY, rotaZ)
	local calculGO = self:_tryGetCalculPosGO()

	Astral.TransformUtil.SetLocalRotation(calculGO.transform, rotaX, rotaY, rotaZ)

	return calculGO.transform.rotation
end

function M:getOffsetByWorldPos(posX, posY, posZ)
	local calculGO = self:_tryGetCalculPosGO()

	Astral.TransformUtil.SetPos(calculGO.transform, posX, posY, posZ)

	return Astral.TransformUtil.GetLocalPos(calculGO.transform, 0, 0, 0)
end

function M:_tryGetCalculPosGO()
	local parentGO = self:getParentGO()
	local go = goutil.findChild(parentGO, kCalculPosGoName)

	if not go then
		go = goutil.create(kCalculPosGoName, false)

		goutil.addChildToParent(go, parentGO)
	end

	return go
end

return M
