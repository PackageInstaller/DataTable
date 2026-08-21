-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/Feature.lua

module("logic.common.entitas.Feature", package.seeall)

local M = class("Feature", Systems)

function M:ctor(contexts, name)
	M.super.ctor(self)

	self._contexts = contexts
	self._featureName = name or "default"
end

return M
