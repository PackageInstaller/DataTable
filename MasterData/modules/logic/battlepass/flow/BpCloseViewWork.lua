-- chunkname: @modules/logic/battlepass/flow/BpCloseViewWork.lua

module("modules.logic.battlepass.flow.BpCloseViewWork", package.seeall)

local BpCloseViewWork = class("BpCloseViewWork", BaseWork)

function BpCloseViewWork:ctor(viewName)
	self._viewName = viewName
end

function BpCloseViewWork:onStart()
	ViewMgr.instance:closeView(self._viewName)
	self:onDone(true)
end

return BpCloseViewWork
