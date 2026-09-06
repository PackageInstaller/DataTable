-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanunlockworkposView.lua

module("logic.extensions.richmanxplan.view.RmxplanunlockworkposView", package.seeall)

local RmxplanunlockworkposView = class("RmxplanunlockworkposView", ViewComponent)

function RmxplanunlockworkposView:ctor()
	RmxplanunlockworkposView.super.ctor(self)
end

function RmxplanunlockworkposView:unbindEvents()
	RmxplanunlockworkposView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function RmxplanunlockworkposView:bindEvents()
	RmxplanunlockworkposView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnBuy:AddClickListener(self._onClickbtnBuy, self)
end

function RmxplanunlockworkposView:buildUI()
	RmxplanunlockworkposView.super.buildUI(self)

	self._btnClose = self:getBtn("btns/btnClose")
	self._btnBuy = self:getBtn("btns/btnBuy")
	self._txtHave = self:getTxt("txtHave")
	self._txtCost = self:getTxt("txtCost")
end

function RmxplanunlockworkposView:onExit()
	RmxplanunlockworkposView.super.onExit(self)
end

function RmxplanunlockworkposView:onEnter()
	RmxplanunlockworkposView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RichManXPlanWorkUnlockRes, self._onClickbtnClose, self)

	local param = self:getOpenParam()

	self._activityId = param[1]
	self._posId = param[2]

	self:_updateUI()
end

function RmxplanunlockworkposView:_onClickbtnClose()
	self:close()
end

function RmxplanunlockworkposView:_onClickbtnBuy()
	local info = RichmanxplanModel.instance:getInfo(self._activityId)
	local workCfg = RichmanxplanConfig.instance:getWorkCfg(self._activityId, self._posId)

	if checknumber(info.score) < workCfg.unlockCost then
		FloatWordMgr.instance:show("道具不足")

		return
	end

	RichManXPlanAgent.instance:sendPM_RichManXPlanWorkUnlockReq(self._activityId, self._posId)
end

function RmxplanunlockworkposView:_updateUI()
	local info = RichmanxplanModel.instance:getInfo(self._activityId)
	local workCfg = RichmanxplanConfig.instance:getWorkCfg(self._activityId, self._posId)

	self._txtCost.text = workCfg.unlockCost
	self._txtHave.text = info.score
end

return RmxplanunlockworkposView
