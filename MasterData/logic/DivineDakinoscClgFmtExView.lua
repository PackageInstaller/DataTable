-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedakinosclg/view/DivineDakinoscClgFmtExView.lua

module("logic.extensions.divinedakinosclg.view.DivineDakinoscClgFmtExView", package.seeall)

local DivineDakinoscClgFmtExView = class("DivineDakinoscClgFmtExView", ViewComponent)

function DivineDakinoscClgFmtExView:ctor()
	DivineDakinoscClgFmtExView.super.ctor(self)
end

function DivineDakinoscClgFmtExView:unbindEvents()
	DivineDakinoscClgFmtExView.super.unbindEvents(self)
end

function DivineDakinoscClgFmtExView:bindEvents()
	DivineDakinoscClgFmtExView.super.bindEvents(self)
end

function DivineDakinoscClgFmtExView:buildUI()
	DivineDakinoscClgFmtExView.super.buildUI(self)

	self._txtTips = self:getTxt("txtTips")
end

function DivineDakinoscClgFmtExView:onExit()
	DivineDakinoscClgFmtExView.super.onExit(self)
end

function DivineDakinoscClgFmtExView:onEnter()
	DivineDakinoscClgFmtExView.super.onEnter(self)

	local params = self:getOpenParam()

	self.customFmtMo = params[1]
	self.activityId = self.customFmtMo.activityId
	self.phaseId = self.customFmtMo.phaseId
	self.stageId = self.customFmtMo.stageId
	self._phaseCfg = DivineDakinosClgConfig.instance:getPhaseCfg(self.activityId, self.phaseId)
	self._stageCfgs = DivineDakinosClgConfig.instance:getStageCfgs(self._phaseCfg.stagePlanId)
	self._stageCfg = self._stageCfgs[self.stageId]

	self:_updateCount()
	self.addGEvent(self, GlobalNotify.DivineDakinosClgBelieverCountChange, self._updateCount, self)
end

function DivineDakinoscClgFmtExView:_updateCount()
	local cfg = DivineDakinosClgConfig.instance:getActCfg(self.activityId) or {}

	if not cfg.lockDesc then
		local lockDesc = ""

		self._txtTips.text = string.format("光圈位置上的精灵将变为%s，本关要求存活%s%s（已上阵%s）", lockDesc, self._stageCfg.needSaveCount, lockDesc, self.customFmtMo:getMatchCount())
	end
end

return DivineDakinoscClgFmtExView
