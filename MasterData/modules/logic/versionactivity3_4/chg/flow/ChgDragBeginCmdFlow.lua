-- chunkname: @modules/logic/versionactivity3_4/chg/flow/ChgDragBeginCmdFlow.lua

module("modules.logic.versionactivity3_4.chg.flow.ChgDragBeginCmdFlow", package.seeall)

local Base = ChgCmdFlowBase
local ChgDragBeginCmdFlow = class("ChgDragBeginCmdFlow", Base)

function ChgDragBeginCmdFlow:ctor(...)
	Base.ctor(self, ...)
end

return ChgDragBeginCmdFlow
