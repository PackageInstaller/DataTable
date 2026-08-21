-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/WorkRogueExtraMechanism.lua

module("logic.extensions.roguelike.flow.work.WorkRogueExtraMechanism", package.seeall)

local M = class("WorkRogueExtraMechanism", WorkBase)

function M:ctor(delay)
	M.super.ctor(self)
end

function M:onEnter(context)
	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	return
end

return M
