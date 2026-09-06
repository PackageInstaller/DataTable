-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingorderclg/view/OriginKingOrderClgFmtExView.lua

module("logic.extensions.originkingorderclg.view.OriginKingOrderClgFmtExView", package.seeall)

local OriginKingOrderClgFmtExView = class("OriginKingOrderClgFmtExView", ViewComponent)

function OriginKingOrderClgFmtExView:buildUI()
	OriginKingOrderClgFmtExView.super.buildUI(self)

	self._btnBuff = self:getGo("btnBuff")
end

function OriginKingOrderClgFmtExView:bindEvents()
	OriginKingOrderClgFmtExView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
end

function OriginKingOrderClgFmtExView:unbindEvents()
	OriginKingOrderClgFmtExView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuff)
end

function OriginKingOrderClgFmtExView:onEnter()
	OriginKingOrderClgFmtExView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._activityId = self._customFmtMo:getActivityId()
	self._stageId = self._customFmtMo:getStageId()
	self._subMo = OriginKingOrderClgController.instance:getSubMo(self._activityId)
	self._stageType = self._subMo:getStageType(self._stageId)
end

function OriginKingOrderClgFmtExView:onExit()
	OriginKingOrderClgFmtExView.super.onExit(self)
end

function OriginKingOrderClgFmtExView:_onClickBtnBuff()
	if self._stageType == OriginKingOrderClgEnum.StageType_Water then
		UIStateManager.instance:push(ViewName.OriginKingOrderClgStageWaterInfoView, self._activityId)
	elseif self._stageType == OriginKingOrderClgEnum.StageType_Kong then
		UIStateManager.instance:push(ViewName.OriginKingOrderClgStageKongInfoView, self._activityId)
	end
end

return OriginKingOrderClgFmtExView
