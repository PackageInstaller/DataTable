-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/luaComponent/LuaComponent.lua

module("logic.common.viewlib.luaComponent.LuaComponent", package.seeall)

local M = class("LuaComponent")

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

function M:OnTriggerEnter()
	return
end

function M:OnTriggerExit()
	return
end

return M
