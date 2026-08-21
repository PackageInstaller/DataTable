-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/base/ReusableUnitBase.lua

module("logic.scene.unit.base.ReusableUnitBase", package.seeall)

local M = class("ReusableUnitBase", UnitBase, AbstractGlobalReusable)
local kPoolRoot = PoolRootUtil.createScenePoolRoot("unit")
local kOnReuseFuncName = "onReuse"
local kOnResetFuncName = "onReset"
local kOnEnableFuncName = "onEnable"
local kOnDisableFuncName = "onDisable"
local kOnDestroyFuncName = "onDestroy"

function M:NewObject(name, x, y, z)
	local goUnit = goutil.create(name, false)

	Astral.TransformUtil.SetLocalPos(goUnit.transform, x or 0, y or 0, z or 0)

	local unit = Astral.LuaComponentContainer.Add(goUnit, self)

	return unit
end

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)

	self._trs = self.go.transform
	self._isDestroyed = false
end

function M:OnEnable()
	self:_executeCompFunc(kOnEnableFuncName)
end

function M:OnDisable()
	self:_executeCompFunc(kOnDisableFuncName)
end

function M:getCapacity()
	return 50
end

function M:getGameObject()
	return self.go
end

function M:getTransform()
	return self._trs
end

function M:setupEditorDisplayName()
	if enableDebug then
		self.go.name = self:getEditorDisplayName()
	end
end

function M:getEditorDisplayName()
	return
end

function M:reuse(name, x, y, z)
	self._isDestroyed = false

	local goUnit = self.go

	goutil.setActive(goUnit, true)
	Astral.TransformUtil.SetLocalPos(goUnit.transform, x or 0, y or 0, z or 0)
	Astral.TransformUtil.SetLocalRotation(goUnit.transform, 0, 0, 0)

	self._isDestroyed = false

	self:_executeCompFunc(kOnReuseFuncName)
end

function M:reset()
	self._isDestroyed = true

	self:_executeCompFunc(kOnResetFuncName)
	goutil.addChildToParent(self.go, kPoolRoot)
end

function M:destroy()
	self._isDestroyed = true

	self:_executeCompFunc(kOnDestroyFuncName)
	table.clear(self._compList)
	goutil.destroy(self.go)
end

function M:isDestroyed()
	return self._isDestroyed
end

function UnitCompSpine:onReset()
	self:clear()
end

function UnitCompMover:onReset()
	self:clearWayPoints()
end

return M
