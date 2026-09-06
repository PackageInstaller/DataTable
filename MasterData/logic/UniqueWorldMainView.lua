-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/view/UniqueWorldMainView.lua

module("logic.extensions.uniqueworld.view.UniqueWorldMainView", package.seeall)

local UniqueWorldMainView = class("UniqueWorldMainView", ViewComponent)

function UniqueWorldMainView:ctor()
	UniqueWorldMainView.super.ctor(self)
end

function UniqueWorldMainView:unbindEvents()
	UniqueWorldMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
end

function UniqueWorldMainView:bindEvents()
	UniqueWorldMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
end

function UniqueWorldMainView:buildUI()
	UniqueWorldMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnStart = self:getGo("btnStart")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._txtLeftGameNum = self:getTxt("leftGameNum/txt")
	self._txtOpenTime = self:getTxt("time/txt")
end

function UniqueWorldMainView:onExit()
	UniqueWorldMainView.super.onExit(self)
end

function UniqueWorldMainView:onEnter()
	UniqueWorldMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_UniqueWorldGetInfoRes, self._onUpate, self)
	self.addGEvent(self, GlobalNotify.PM_UniqueWorldNewGameRes, self._onNewGameRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 584001
	end

	self._actCfg = UniqueWorldConfig.instance:getActCfg(self._activityId) or {}

	self:_onSetUI()
	UniqueWorldController.instance:sendPM_UniqueWorldGetInfoReq(self._activityId)
end

function UniqueWorldMainView:_onSetUI()
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
end

function UniqueWorldMainView:_updateData()
	self._info = UniqueWorldModel.instance:getInfo(self._activityId)

	if self._info then
		local mapInfo = self._info.mapInfo
		local gameInfo = mapInfo and mapInfo.gameInfo

		if gameInfo then
			self._gameId = gameInfo.gameId or 1
		end
	end
end

function UniqueWorldMainView:_onUpate()
	self:_updateData()

	local dailyStartGameTimes = self._actCfg.dailyStartGameTimes
	local todayStartGameTimes = self._info.todayStartGameTimes
	local leftNum = dailyStartGameTimes - todayStartGameTimes

	self._txtLeftGameNum.text = string.format(lang("剩余次数：%d"), leftNum)
end

function UniqueWorldMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function UniqueWorldMainView:_onClickBtnStart()
	if not self._info then
		FloatWordMgr.instance:show(lang("读取信息中，请稍后..."))

		return
	end

	local hasPlayingGame = self._info.mapInfo
	local mapInfo = self._info.mapInfo
	local gameInfo = mapInfo and mapInfo.gameInfo
	local dailyStartGameTimes = self._actCfg.dailyStartGameTimes
	local todayStartGameTimes = self._info.todayStartGameTimes

	if gameInfo then
		if not gameInfo.curLevel then
			if dailyStartGameTimes <= todayStartGameTimes and not hasPlayingGame then
				FloatWordMgr.instance:show(lang("今日已无次数，明日再来吧"))

				return
			end

			if not hasPlayingGame then
				local function okFunc()
					UniqueWorldController.instance:sendPM_UniqueWorldNewGameReq(self._activityId)
				end

				TipsFacade.instance:openPopupWindow(lang("提示"), lang("是否确认消耗1次探索次数进入洞穴？"), okFunc, nil, lang("确定"), lang("取消"))

				return
			end

			UIStateManager.instance:push(ViewName.UniqueWorldGameView, self._activityId, self._gameId)
		end
	end
end

function UniqueWorldMainView:_onNewGameRes()
	self:_updateData()
	UIStateManager.instance:push(ViewName.UniqueWorldGameView, self._activityId, self._gameId)
end

function UniqueWorldMainView:_onClickBtnJump(jumpIdx)
	if self._actCfg.jumpTo then
		if not self._actCfg.jumpTo[jumpIdx] then
			local btnStr = ""

			GotoMgr.gotoByString(btnStr)
		end
	end
end

return UniqueWorldMainView
