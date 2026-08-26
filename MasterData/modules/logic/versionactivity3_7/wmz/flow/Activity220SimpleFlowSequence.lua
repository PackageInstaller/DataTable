-- chunkname: @modules/logic/versionactivity3_7/wmz/flow/Activity220SimpleFlowSequence.lua

module("modules.logic.versionactivity3_7.wmz.flow.Activity220SimpleFlowSequence", package.seeall)

local Base = GaoSiNiaoFlowSequence_Base
local Activity220SimpleFlowSequence = class("Activity220SimpleFlowSequence", Base)

function Activity220SimpleFlowSequence:ctor(...)
	if self._interfaceCls then
		for k, v in pairs(self._interfaceCls) do
			if type(v) == "function" then
				self[k] = v
			end
		end
	end

	Base.ctor(self, ...)
end

function Activity220SimpleFlowSequence:start(dragContext)
	self:reset()

	self.dragContext = dragContext
	self.viewObj = dragContext._viewObj
	self.viewContainer = dragContext._viewContainer

	Base.start(self)
end

return Activity220SimpleFlowSequence
