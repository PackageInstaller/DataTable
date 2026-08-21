-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/pool/prefabpool/CharacterPoolFactory.lua

module("logic.common.pool.prefabpool.CharacterPoolFactory", package.seeall)

local M = class("CharacterPoolFactory", AbstractPrefabPoolFactory)

function M:onSpawn(transform)
	M.super.onSpawn(self, transform)
end

function M:onDespawn(transform)
	M.super.onDespawn(self, transform)
end

return M
