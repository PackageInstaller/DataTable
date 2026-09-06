-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyinjiade/view/LuYinJiaDeChallengeLevelView.lua

module("logic.extensions.luyinjiade.view.LuYinJiaDeChallengeLevelView", package.seeall)

local LuYinJiaDeChallengeLevelView = class("LuYinJiaDeChallengeLevelView", ViewComponent)
local AREA_NUM = 3

function LuYinJiaDeChallengeLevelView:ctor()
	LuYinJiaDeChallengeLevelView.super.ctor(self)
end

function LuYinJiaDeChallengeLevelView:unbindEvents()
	LuYinJiaDeChallengeLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnLevel1)
	GameUtil.rmClickHandler(self._btnLevel2)
	GameUtil.rmClickHandler(self._btnLevel3)
end

function LuYinJiaDeChallengeLevelView:bindEvents()
	LuYinJiaDeChallengeLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnLevel1, GameUtil.handler(self._onClickBtnLevel, self, 1))
	GameUtil.addClickHandler(self._btnLevel2, GameUtil.handler(self._onClickBtnLevel, self, 2))
	GameUtil.addClickHandler(self._btnLevel3, GameUtil.handler(self._onClickBtnLevel, self, 3))
end

function LuYinJiaDeChallengeLevelView:buildUI()
	LuYinJiaDeChallengeLevelView.super.buildUI(self)

	self._btnLevel3 = self:getGo("btnLevel3")
	self._btnLevel2 = self:getGo("btnLevel2")
	self._btnLevel1 = self:getGo("btnLevel1")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtScore = self:getTxt("goldBar/txtNum")
end

function LuYinJiaDeChallengeLevelView:onExit()
	LuYinJiaDeChallengeLevelView.super.onExit(self)
end

function LuYinJiaDeChallengeLevelView:onEnter()
	LuYinJiaDeChallengeLevelView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._actCfg = LuYinJiaDeConfig.instance:getActData(self._activityId)
	self._stageCfg = LuYinJiaDeConfig.instance:getStageData(self._activityId)
	self._info = LuYinJiaDeModel.instance:getInfo(self._activityId)

	self:_onSetUI()
end

function LuYinJiaDeChallengeLevelView:_onSetUI()
	local curTotalScore = LuYinJiaDeController.instance:getTotalScore(self._activityId)

	self._txtScore.text = string.format("总积分: <color=#64d944>%s</color>", curTotalScore)

	local curLevelInfos = self._info.stageList

	for i = 1, AREA_NUM do
		local stageCfg = self._stageCfg[i]
		local curLevelInfo = curLevelInfos[i]
		local txtTitle = self:getTxt("btnLevel" .. i .. "/txtTitle")
		local txtAreaScore = self:getTxt("btnLevel" .. i .. "/txtAreaScore")
		local txtLevelScore = self:getTxt("btnLevel" .. i .. "/txtLevelScore")
		local txtMaxTime = self:getTxt("btnLevel" .. i .. "/txtMaxTime")

		txtTitle.text = stageCfg.areaName
		txtAreaScore.text = string.format("领域分：<color=#34c1ff>%d</color>", checknumber(curLevelInfo.specialScore))
		txtLevelScore.text = string.format("关卡分：<color=#64d944>%d</color>", checknumber(curLevelInfo.stageScore))
		txtMaxTime.text = string.format("最大回合数：%d", stageCfg.circleLimit)
	end
end

function LuYinJiaDeChallengeLevelView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyChallenge

	TipsFacade.instance:openRulesView(key)
end

function LuYinJiaDeChallengeLevelView:_onClickBtnLevel(stageId)
	LuYinJiaDeController.instance:enterBattleClg(self._activityId, stageId)
end

return LuYinJiaDeChallengeLevelView
