-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/generated/Contexts.lua

module("logic.common.entitas.generated.Contexts", package.seeall)

local M = class("Contexts")

function M:ctor()
	self.game = GameContext.Create()

	local index = GameIndex

	self.game:initGenerateEntityIndexes()
end

M.sharedInstance = M.New()

return M
