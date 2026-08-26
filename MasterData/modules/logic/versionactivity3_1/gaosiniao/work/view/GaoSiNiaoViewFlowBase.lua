-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/view/GaoSiNiaoViewFlowBase.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.view.GaoSiNiaoViewFlowBase", package.seeall)

local GaoSiNiaoViewFlowBase = class("GaoSiNiaoViewFlowBase", GaoSiNiaoFlowSequence_Base)

function GaoSiNiaoViewFlowBase:ctor(...)
	GaoSiNiaoViewFlowBase.super.ctor(self, ...)
end

function GaoSiNiaoViewFlowBase:start(viewObj)
	self:reset()
	self:setViewObj(viewObj)
	GaoSiNiaoViewFlowBase.super.start(self)
end

function GaoSiNiaoViewFlowBase:setViewObj(viewObj)
	self._viewObj = assert(viewObj)
end

function GaoSiNiaoViewFlowBase:viewObj()
	return self._viewObj
end

function GaoSiNiaoViewFlowBase:baseViewContainer()
	if type(self._viewObj.baseViewContainer) == "function" then
		return self._viewObj:baseViewContainer()
	end

	return self._viewObj.viewContainer
end

function GaoSiNiaoViewFlowBase:gameObject()
	return self._viewObj.viewGO
end

function GaoSiNiaoViewFlowBase:transform()
	return self:gameObject().transform
end

function GaoSiNiaoViewFlowBase:setActive(isActive)
	gohelper.setActive(self:gameObject(), isActive)
end

return GaoSiNiaoViewFlowBase
