-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/mgr/ViewMgrSpacexImpl.lua

module("logic.common.mgr.ViewMgrSpacexImpl", package.seeall)

local M = class("ViewMgrSpacexImpl", ViewMgrDefaultImpl)

function M:ctor()
	M.super.ctor(self)
end

function M:_getDefaultMaskColor()
	return "#000000D7"
end

return M
