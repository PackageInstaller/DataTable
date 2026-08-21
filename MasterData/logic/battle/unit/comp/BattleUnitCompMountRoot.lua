-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompMountRoot.lua

module("logic.battle.unit.comp.BattleUnitCompMountRoot", package.seeall)

local M = class("BattleUnitCompMountRoot", BattleUnitCompBase)

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._avatarRoot = self:createRoot("avatarRoot")
	self._signRoot = self:createRoot("signRoot")
	self._barRoot = self:createRoot("barRoot")
end

function M:onInit()
	return
end

function M:onReuse()
	return
end

function M:onReset()
	goutil.setActive(self._avatarRoot, true)
	goutil.setActive(self._signRoot, true)
	goutil.setActive(self._barRoot, true)
end

function M:onDestroy()
	self._avatarRoot = nil
	self._signRoot = nil
end

function M:getRoot()
	return self._unit.go
end

function M:getAvatarRoot()
	return self._avatarRoot
end

function M:getSignRoot()
	return self._signRoot
end

function M:getBarRoot()
	return self._barRoot
end

function M:createRoot(name)
	local unitGo = self._unit.go
	local go = goutil.create(name, false)

	go.layer = unitGo.layer

	goutil.addChildToParent(go, unitGo)

	return go
end

return M
