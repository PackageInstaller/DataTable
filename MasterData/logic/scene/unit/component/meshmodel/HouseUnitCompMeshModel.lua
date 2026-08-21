-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/meshmodel/HouseUnitCompMeshModel.lua

module("logic.scene.unit.component.meshmodel.HouseUnitCompMeshModel", package.seeall)

local M = class("HouseUnitCompMeshModel", UnitCompMeshModel)

function M:onInit()
	M.super.onInit(self)

	self._goAvatar = self._unit.mountRoot:getAvatarRoot()
	self._prefabLoader._go = self._goAvatar
end

function M:onReuse()
	return
end

function M:onReset()
	return
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._goAvatar = nil
end

function M:setVisible(visible)
	goutil.setActive(self._goAvatar, visible)
end

return M
