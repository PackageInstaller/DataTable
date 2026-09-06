-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompMountRoot.lua

module("logicscene.scene.unit.component.UnitCompMountRoot", package.seeall)

local UnitCompMountRoot = class("UnitCompMountRoot", UnitComponentBase)

function UnitCompMountRoot:ctor(unit)
	UnitCompMountRoot.super.ctor(self, unit)

	local unitGo = unit.go

	self._avatarRoot = goutil.create("avatarRoot", false)
	self._effectRoot = goutil.create("effectRoot", false)

	goutil.addChildToParent(self._avatarRoot, unitGo)
	goutil.addChildToParent(self._effectRoot, unitGo)

	self._avatarRoot.layer = unitGo.layer
end

function UnitCompMountRoot:getRoot()
	return self._unit.go
end

function UnitCompMountRoot:getAvatarRoot()
	return self._avatarRoot
end

function UnitCompMountRoot:getEffectRoot()
	return self._effectRoot
end

function UnitCompMountRoot:onDestroy()
	self._unit = nil
	self._effectRoot = nil
	self._avatarRoot = nil
end

return UnitCompMountRoot
