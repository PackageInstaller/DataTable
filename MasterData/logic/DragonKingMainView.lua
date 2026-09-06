-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonking/view/DragonKingMainView.lua

module("logic.extensions.dragonking.view.DragonKingMainView", package.seeall)

local DragonKingMainView = class("DragonKingMainView", HuarongRoadMainView)

function DragonKingMainView:ctor()
	DragonKingMainView.super.ctor(self)
end

function DragonKingMainView:unbindEvents()
	DragonKingMainView.super.unbindEvents(self)
end

function DragonKingMainView:bindEvents()
	DragonKingMainView.super.bindEvents(self)
end

function DragonKingMainView:buildUI()
	DragonKingMainView.super.buildUI(self)

	self._redPoint = self:getGo("btnChallenge/redpoint")
end

function DragonKingMainView:onExit()
	DragonKingMainView.super.onExit(self)
end

function DragonKingMainView:onEnter()
	GlobalDispatcher:addListener(HuarongRoadController.PM_HuarongRoadGetInfoRes, self._PM_HuarongRoadGetInfoRes, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("没有活动id哦~")
		self:close()
	end

	self._activityType = math.floor(self._activityId / 1000)

	HuarongRoadAgent.instance:sendPM_HuarongRoadGetInfoReq(self._activityId)

	local effectPath = "20220729/fx_ui_shengqixiaonuo_jm.prefab"

	self._uiEffectPath = UIEffectManager.instance:playEffect(self, effectPath, self.mainGO, 0, 0, loop, nil, nil, inLeft, self)

	self._uiEffectPath:setParent(self.mainGO.transform)
	self._uiEffectPath:setLocalPos(0, 0, 0)
	self._uiEffectPath:setScale(1)

	if HuarongRoadModel.instance:getIsFirstEnter(self._activityId) then
		local cfg = HuarongRoadConfig.instance:getProgressCfg(self._activityId, 0)
		local storyId

		if cfg then
			storyId = cfg.operaId
		end

		if storyId then
			GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
		end

		HuarongRoadModel.instance:setIsFirstEnter(self._activityId)
	end

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))
end

function DragonKingMainView:refreshView()
	DragonKingMainView.super.refreshView(self)
	GameUtil.SetActive(self._redPoint, self._enterTimes > 0)
end

function DragonKingMainView:_onClickEnter()
	if self._enterTimes > 0 then
		UIStateManager.instance:push(ViewName.DragonKingSelectView, self._activityId)
	end
end

function DragonKingMainView:_onClickRule()
	UIStateManager.instance:push(ViewName.RulesView, "DragonKingMainView_rule")
end

function DragonKingMainView:_onClickCard()
	local cfg = HuarongRoadConfig.instance:getActivityCfg(self._activityId)

	if not string.nilorempty(cfg.jumpTo) then
		GotoMgr.gotoByString(cfg.jumpTo)
	else
		GotoMgr.gotoByString("func#637#2")
	end
end

function DragonKingMainView:_onClickRank()
	local cfg = HuarongRoadConfig.instance:getActivityCfg(self._activityId)

	if not string.nilorempty(cfg.switchTo) then
		GotoMgr.gotoByString(cfg.switchTo)
	else
		GotoMgr.gotoByString("func#618#14008")
	end
end

return DragonKingMainView
