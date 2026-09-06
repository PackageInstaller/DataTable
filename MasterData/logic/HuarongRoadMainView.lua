-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/huarongroad/view/HuarongRoadMainView.lua

module("logic.extensions.huarongroad.view.HuarongRoadMainView", package.seeall)

local HuarongRoadMainView = class("HuarongRoadMainView", ViewComponent)

function HuarongRoadMainView:buildUI()
	HuarongRoadMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnEnter = self:getBtn("btnChallenge")
	self._btnRule = self:getBtn("leftTop/btnTip")
	self._btnCard = self:getBtn("btnCard")
	self._btnRank = self:getBtn("btnRank")
	self._txtCount = self:getTxt("txtLeaves")
	self._uiEffectGo = self:getGo("uiEffect")
	self._txtTime = self:getTxt("time/txt")
end

function HuarongRoadMainView:bindEvents()
	HuarongRoadMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickEnter, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnCard, self._onClickCard, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
end

function HuarongRoadMainView:unbindEvents()
	HuarongRoadMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnCard)
	GameUtil.rmClickHandler(self._btnRank)
end

function HuarongRoadMainView:onEnter()
	HuarongRoadMainView.super.onEnter(self)
	GlobalDispatcher:addListener(HuarongRoadController.PM_HuarongRoadGetInfoRes, self._PM_HuarongRoadGetInfoRes, self)

	self._activityType = 171

	local cfg = ActivityDefineController.instance:getActivityCfgByType(self._activityType)

	if cfg then
		self._activityId = cfg.activityId or 171001
	end

	HuarongRoadAgent.instance:sendPM_HuarongRoadGetInfoReq(self._activityId)

	self._uiEffectPath = "20220729/fx_ui_shengqixiaonuo_jm.prefab"

	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)
	end

	self._uiEffect = UIEffectManager.instance:playEffect(self, self._uiEffectPath, nil, 0, 0, true)

	self._uiEffect:setParent(self._uiEffectGo.transform)
	self._uiEffect:setScale(1, 1, 1)

	if HuarongRoadModel.instance:getIsFirstEnter(self._activityId) then
		local cfg = HuarongRoadConfig.instance:getProgressCfg(self._activityId, 0)
		local storyId

		if cfg then
			storyId = cfg.operaId
		end

		AnimationPlayer.play("storyconfig/animations/guanglun_dengchang.txt", function()
			if storyId then
				GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
			end
		end)
		HuarongRoadModel.instance:setIsFirstEnter(self._activityId)
	end

	local timeCfg = ActivityDefineConfig.instance:getCfgById(self._activityType, self._activityId)
	local startTime = GameUtil.string2date(timeCfg.startTime)
	local startMin = startTime.min

	if startMin < 10 then
		startMin = string.format("0%d", startMin)
	end

	local endTime = GameUtil.string2date(timeCfg.endTime)
	local endMin = endTime.min

	if endMin < 10 then
		endMin = string.format("0%d", endMin)
	end

	self._txtTime.text = langPara("活动时间：%d.%d %d:%s-%d.%d %d:%s", startTime.month, startTime.day, startTime.hour, startMin, endTime.month, endTime.day, endTime.hour, endMin)
end

function HuarongRoadMainView:onExit()
	HuarongRoadMainView.super.onExit(self)
	GlobalDispatcher:removeListener(HuarongRoadController.PM_HuarongRoadGetInfoRes, self._PM_HuarongRoadGetInfoRes, self)

	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)
	end
end

function HuarongRoadMainView:_PM_HuarongRoadGetInfoRes()
	self:refreshView()
end

function HuarongRoadMainView:refreshView()
	local totalTimes = HuarongRoadConfig.instance:challengeDailyTimes(self._activityId)
	local playTimes = HuarongRoadModel.instance:getPlayCount(self._activityId)

	self._enterTimes = totalTimes - playTimes

	if self._enterTimes <= 0 then
		self._enterTimes = 0
	end

	self._txtCount.text = HuarongRoadModel.instance:getAllPass(self._activityId) and lang("已成功复原所有场景") or langPara("今日剩余通关次数：%d", self._enterTimes)
end

function HuarongRoadMainView:_onClickClose()
	self:close()
end

function HuarongRoadMainView:_onClickEnter()
	if self._enterTimes > 0 then
		UIStateManager.instance:push(ViewName.HuarongRoadLevelView, self._activityId)
	end
end

function HuarongRoadMainView:_onClickRule()
	UIStateManager.instance:push(ViewName.RulesView, "huarongroad_rule")
end

function HuarongRoadMainView:_onClickCard()
	SurveyController.instance:reportBehavior(201083)

	local cfg = HuarongRoadConfig.instance:getActivityCfg(self._activityId)

	if not string.nilorempty(cfg.jumpTo) then
		GotoMgr.gotoByString(cfg.jumpTo)
	else
		GotoMgr.gotoByString("func#637#2")
	end
end

function HuarongRoadMainView:_onClickRank()
	SurveyController.instance:reportBehavior(201082)
	GotoMgr.gotoByString("func#618#14008")
end

return HuarongRoadMainView
