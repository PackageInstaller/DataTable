-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/luaComponent/SimpleLuaComponent.lua

module("logic.common.viewlib.luaComponent.SimpleLuaComponent", package.seeall)

local M = class("SimpleLuaComponent")

function M:ctor(container)
	self._container = container
	self._go = container.gameObject
end

function M:Awake()
	return
end

function M:OnEnable()
	return
end

function M:OnDisable()
	return
end

function M:OnDestroy()
	return
end

function M:getContainer()
	return self._container
end

function M:getMainGo()
	return self._go
end

return M
