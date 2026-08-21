-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/UnitCompMountRoot.lua

module("logic.scene.unit.component.UnitCompMountRoot", package.seeall)

local M = class("UnitCompMountRoot", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._avatarRoot = self:createRoot("avatarRoot")
	self._relativeRoot = self:createRoot("relativeRoot")
end

function M:onInit()
	return
end

function M:onReuse()
	return
end

function M:onReset()
	goutil.setActive(self._avatarRoot, true)
	goutil.setActive(self._relativeRoot, true)
end

function M:onDestroy()
	self._avatarRoot = nil
	self._relativeRoot = nil
end

function M:getAvatarRoot()
	return self._avatarRoot
end

function M:setAvatarRootPos(x, y, z)
	Astral.TransformUtil.SetLocalPos(self._avatarRoot.transform, x, y, z)
end

function M:getRelativeLocalPosByWorldPos(posX, posY, posZ)
	Astral.TransformUtil.SetPos(self._relativeRoot.transform, posX, posY, posZ)

	return Astral.TransformUtil.GetLocalPos(self._relativeRoot.transform, 0, 0, 0)
end

function M:getRelativeWorldPosByLocalPos(posX, posY, posZ)
	Astral.TransformUtil.SetLocalPos(self._relativeRoot.transform, posX, posY, posZ)

	return Astral.TransformUtil.GetPos(self._relativeRoot.transform, 0, 0, 0)
end

function M:createRoot(name)
	local unitGO = self._unit.go
	local rootGO = goutil.create(name, false)

	rootGO.layer = unitGO.layer

	goutil.addChildToParent(rootGO, unitGO)

	return rootGO
end

return M
