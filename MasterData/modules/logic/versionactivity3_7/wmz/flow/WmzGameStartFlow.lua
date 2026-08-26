-- chunkname: @modules/logic/versionactivity3_7/wmz/flow/WmzGameStartFlow.lua

module("modules.logic.versionactivity3_7.wmz.flow.WmzGameStartFlow", package.seeall)

local Base = WmzFlowSequence
local WmzGameStartFlow = class("WmzGameStartFlow", Base)

function WmzGameStartFlow:ctor(...)
	Base.ctor(self, ...)
end

function WmzGameStartFlow:onStart()
	self.viewObj:_clearCache()
	self.viewObj:_refreshMap()
	self.viewObj:setEnableDragTiles(nil, true)
end

return WmzGameStartFlow
