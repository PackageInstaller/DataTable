-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesssnowman/view/GuessSnowmanSelectView.lua

module("logic.extensions.guesssnowman.view.GuessSnowmanSelectView", package.seeall)

local GuessSnowmanSelectView = class("GuessSnowmanSelectView", ViewComponent)

function GuessSnowmanSelectView:ctor()
	GuessSnowmanSelectView.super.ctor(self)
end

function GuessSnowmanSelectView:buildUI()
	GuessSnowmanSelectView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnRule = goutil.findChild(self.mainGO, "btnRule")
	self._btnNomal = goutil.findChild(self.mainGO, "btnNomal")
	self._btnHard = goutil.findChild(self.mainGO, "btnHard")
	self._txtGameNum = goutil.findChildTextComponent(self.mainGO, "times/txt")
end

function GuessSnowmanSelectView:bindEvents()
	GuessSnowmanSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnNomal, self._onClickNomal, self)
	GameUtil.addClickHandler(self._btnHard, self._onClickHard, self)
end

function GuessSnowmanSelectView:unbindEvents()
	GuessSnowmanSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnNomal)
	GameUtil.rmClickHandler(self._btnHard)
end

function GuessSnowmanSelectView:destroyUI()
	GuessSnowmanSelectView.super.destroyUI(self)
end

function GuessSnowmanSelectView:onEnter()
	GuessSnowmanSelectView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._levelCfg = GuessBoxConfig.instance:getGbLevelCfg(self._activityId)
	self._gbCfg = GuessBoxConfig.instance:getGbCfg(self._activityId)

	GlobalDispatcher:addListener(GlobalNotify.GuessBoxGameGetInfo, self._refreshView, self)
	GuessBoxAgent.instance:sendPM_GuessBoxGameGetInfoReq(self._activityId)
end

function GuessSnowmanSelectView:onExit()
	GuessSnowmanSelectView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GuessBoxGameGetInfo, self._refreshView, self)
end

function GuessSnowmanSelectView:_refreshView()
	self._txtGameNum.text = langPara("剩余游戏次数：<color=#eb4624>%d/%d</color>", self._gbCfg.dailyPlayTimes - GuessBoxModel.instance:getDailyHasPlayeTimes(), self._gbCfg.dailyPlayTimes)
end

function GuessSnowmanSelectView:_onClickRule()
	UIStateManager.instance:push(ViewName.GuessSnowmanRankView, self._activityId)
end

function GuessSnowmanSelectView:_onClickNomal()
	if self._gbCfg.dailyPlayTimes > GuessBoxModel.instance:getDailyHasPlayeTimes() then
		UIStateManager.instance:push(ViewName.GuessSnowmanGameView, self._activityId, self._levelCfg[1].levelId)
		self:close()
	else
		FloatWordMgr.instance:show(lang("今日游玩次数已达上限"))
	end
end

function GuessSnowmanSelectView:_onClickHard()
	if self._gbCfg.dailyPlayTimes > GuessBoxModel.instance:getDailyHasPlayeTimes() then
		UIStateManager.instance:push(ViewName.GuessSnowmanGameView, self._activityId, self._levelCfg[2].levelId)
		self:close()
	else
		FloatWordMgr.instance:show(lang("今日游玩次数已达上限"))
	end
end

return GuessSnowmanSelectView
