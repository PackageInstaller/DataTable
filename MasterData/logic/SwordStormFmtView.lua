-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/swordstorm/view/SwordStormFmtView.lua

module("logic.extensions.swordstorm.view.SwordStormFmtView", package.seeall)

local SwordStormFmtView = class("SwordStormFmtView", ViewComponent)

function SwordStormFmtView:ctor()
	SwordStormFmtView.super.ctor(self)
end

function SwordStormFmtView:unbindEvents()
	SwordStormFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStory)
end

function SwordStormFmtView:bindEvents()
	SwordStormFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnStory, self._onClickStory, self)
end

function SwordStormFmtView:buildUI()
	SwordStormFmtView.super.buildUI(self)

	self._btnStory = self:getGo("btnStory")
end

function SwordStormFmtView:onExit()
	SwordStormFmtView.super.onExit(self)
end

function SwordStormFmtView:onEnter()
	SwordStormFmtView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()

	if not SwordStormModel.instance:getReadStageStory(self._fmtMo.activityId, self._fmtMo.phaseId, self._fmtMo.stageId) then
		SwordStormModel.instance:saveReadStageStory(self._fmtMo.activityId, self._fmtMo.phaseId, self._fmtMo.stageId)
		GlobalDispatcher:addListener(GlobalNotify.EndStory, self._endStory, self)
		self:_onClickStory()
	end
end

function SwordStormFmtView:_onClickStory()
	local stageCfg = SwordStormConfig.instance:getStageCfg(self._fmtMo.activityId, self._fmtMo.phaseId, self._fmtMo.stageId)

	GlobalDispatcher:dispatch(GlobalNotify.StartStory, stageCfg.story)
end

function SwordStormFmtView:_endStory()
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._endStory, self)

	local param1, param2 = MissionModel.instance:getRuleDesc()
	local param3 = MissionModel.instance:getRuleParam()
	local uiFlyParam = UIFlyTweenParam.New()
	local params = {
		param1,
		param2,
		param3,
		uiFlyParam,
		self._fmtMo.activityId,
		self._fmtMo.phaseId,
		self._fmtMo.stageId
	}

	UIStateManager.instance:push(ViewName.SwordStormRuleView, unpack(params))
end

return SwordStormFmtView
