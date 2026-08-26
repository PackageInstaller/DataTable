-- chunkname: @modules/logic/versionactivity3_4/chg/flow/ChgCmdFlowBase.lua

module("modules.logic.versionactivity3_4.chg.flow.ChgCmdFlowBase", package.seeall)

local Base = ChgFlowParallel_Base
local ChgCmdFlowBase = class("ChgCmdFlowBase", Base)

function ChgCmdFlowBase:ctor(myData)
	for k, v in pairs(ChgFlowInterface) do
		if type(v) == "function" then
			self[k] = v
		end
	end

	Base.ctor(self)

	self._myData = myData
	self._displayFrame = myData:lastFrame()
	self._lastDisplayFrame = myData:cacheFrame()
	self._diffInfo = self._displayFrame:diff(self._lastDisplayFrame)
	self._myData.editEnergy = self._displayFrame.detectFinalEnergy
end

function ChgCmdFlowBase:start(dragContext)
	self:reset()

	self.dragContext = dragContext
	self.viewObj = dragContext._viewObj
	self.viewContainer = dragContext._viewContainer

	Base.start(self)
end

return ChgCmdFlowBase
