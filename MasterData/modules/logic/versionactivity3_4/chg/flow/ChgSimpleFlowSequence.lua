-- chunkname: @modules/logic/versionactivity3_4/chg/flow/ChgSimpleFlowSequence.lua

module("modules.logic.versionactivity3_4.chg.flow.ChgSimpleFlowSequence", package.seeall)

local Base = GaoSiNiaoFlowSequence_Base
local ChgSimpleFlowSequence = class("ChgSimpleFlowSequence", Base)

function ChgSimpleFlowSequence:ctor(...)
	for k, v in pairs(ChgFlowInterface) do
		if type(v) == "function" then
			self[k] = v
		end
	end

	Base.ctor(self, ...)
end

function ChgSimpleFlowSequence:start(dragContext)
	self:reset()

	self.dragContext = dragContext
	self.viewObj = dragContext._viewObj
	self.viewContainer = dragContext._viewContainer

	Base.start(self)
end

return ChgSimpleFlowSequence
