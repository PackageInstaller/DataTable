-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadextView.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadextView", package.seeall)

local ChuangjingroadextView = class("ChuangjingroadextView", ViewComponent)

function ChuangjingroadextView:ctor()
	ChuangjingroadextView.super.ctor(self)
end

function ChuangjingroadextView:unbindEvents()
	ChuangjingroadextView.super.unbindEvents(self)
end

function ChuangjingroadextView:bindEvents()
	ChuangjingroadextView.super.bindEvents(self)
end

function ChuangjingroadextView:buildUI()
	ChuangjingroadextView.super.buildUI(self)

	self._Icon = self:getGo("cost/Icon")
	self._txtCost = self:getTxt("cost/txtCost")
end

function ChuangjingroadextView:onExit()
	ChuangjingroadextView.super.onExit(self)
end

function ChuangjingroadextView:onEnter()
	ChuangjingroadextView.super.onEnter(self)

	self._fmtMo = self:getFirstParam() or {}

	local cfg = ChuangJingRoadConfig.instance:getStageConfigById(self._fmtMo.activityId, self._fmtMo.zoneId, self._fmtMo.stageId) or {}
	local type, id, num = MaterialMgr.getMatParams(cfg.cost)

	self._txtCost.text = checknumber(num)

	MaterialMgr.setIcon(self._Icon, type, id)
end

return ChuangjingroadextView
