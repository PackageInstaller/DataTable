-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanbaochongeventView.lua

module("logic.extensions.richmanxplan.view.RmxplanbaochongeventView", package.seeall)

local RmxplanbaochongeventView = class("RmxplanbaochongeventView", ViewComponent)

function RmxplanbaochongeventView:ctor()
	RmxplanbaochongeventView.super.ctor(self)
end

function RmxplanbaochongeventView:unbindEvents()
	RmxplanbaochongeventView.super.unbindEvents(self)
	self._btnStart:RemoveClickListener()
end

function RmxplanbaochongeventView:bindEvents()
	RmxplanbaochongeventView.super.bindEvents(self)
	self._btnStart:AddClickListener(self._onClickbtnStart, self)
end

function RmxplanbaochongeventView:buildUI()
	RmxplanbaochongeventView.super.buildUI(self)

	self._btnStart = self:getBtn("btnStart")
	self._itemGo = self:getGo("item")
	self._roleGo = self:getGo("role")
	self._txtDesc = self:getTxt("txtDesc")
end

function RmxplanbaochongeventView:onExit()
	RmxplanbaochongeventView.super.onExit(self)
	MaterialMgr.resetAll(self._itemGo)
	uGuiUtil.clearImage(self._roleGo)
end

function RmxplanbaochongeventView:onEnter()
	RmxplanbaochongeventView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RichManXPlanEventRes, self._onRichManXPlanEventRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._event = params[2]
	self._score = RichmanxplanModel.instance:getScore(self._activityId)

	self:_updateUI()
	self:_setRole()
end

function RmxplanbaochongeventView:_onClickbtnStart()
	RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, false)
end

function RmxplanbaochongeventView:_onRichManXPlanEventRes(msg)
	self:close()
end

function RmxplanbaochongeventView:_updateUI()
	local cfg = RichmanxplanConfig.instance:getDiceCfg(self._activityId, RichmanxplanController.DiceType.Rush)

	MaterialMgr.setCellByCfg(cfg.cost, self._itemGo)

	self._txtDesc.text = "你途径沙之国，之间几只爆爆龙围绕着埋在沙中的宝藏，你挖开一看，竟然是一个爆冲骰子!"
end

function RmxplanbaochongeventView:_setRole()
	local raceId = RichmanxplanConfig.instance:getRushEventCfg(self._activityId, self._event.eventId).raceId
	local modelCo = CharacterConfig.instance:getModelCo(raceId)

	uGuiUtil.setSpriteToImage(self._roleGo, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
end

return RmxplanbaochongeventView
