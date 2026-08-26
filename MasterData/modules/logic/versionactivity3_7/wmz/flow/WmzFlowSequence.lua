-- chunkname: @modules/logic/versionactivity3_7/wmz/flow/WmzFlowSequence.lua

module("modules.logic.versionactivity3_7.wmz.flow.WmzFlowSequence", package.seeall)

local Base = Activity220SimpleFlowSequence
local WmzFlowSequence = class("WmzFlowSequence", Base)

function WmzFlowSequence:ctor(...)
	self._interfaceCls = WmzFlowInterface

	Base.ctor(self, ...)
end

return WmzFlowSequence
