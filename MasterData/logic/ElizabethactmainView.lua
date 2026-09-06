-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elizabethgame/view/ElizabethactmainView.lua

module("logic.extensions.elizabethgame.view.ElizabethactmainView", package.seeall)

local ElizabethactmainView = class("ElizabethactmainView", ViewComponent)

ElizabethactmainView.playFirstStoryKey = "ElizabethactmainView.playFirstStoryKey"

function ElizabethactmainView:ctor()
	ElizabethactmainView.super.ctor(self)
end

function ElizabethactmainView:unbindEvents()
	ElizabethactmainView.super.unbindEvents(self)
	self._btnStart:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function ElizabethactmainView:bindEvents()
	ElizabethactmainView.super.bindEvents(self)
	self._btnStart:AddClickListener(self._onClickbtnStart, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function ElizabethactmainView:buildUI()
	ElizabethactmainView.super.buildUI(self)

	self._txtLeftTime = self:getTxt("txtLeftTime")
	self._txtTime = self:getTxt("time/txt")
	self._btnStart = self:getBtn("btnStart")
	self._btnTip = self:getBtn("btnTip")
	self._btnClose = self:getBtn("btnClose")
	self._rewardCellGo = self:getGo("progress/rewardCell")
	self._tableviewGo = self:getGo("progress/tableview")
	self._rewardScrollerList = ScrollerList.create(self._tableviewGo, self._rewardCellGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._txtProgress = self:getTxt("progress/total/txtProgress")
	self._progressBar = self:getSlider("progress/tableview/Viewport/Content/progressBar")
	self._redpointGo = self:getGo("btnStart/redpoint")
end

function ElizabethactmainView:onExit()
	ElizabethactmainView.super.onExit(self)
	self._rewardScrollerList:dispose()

	self._firstSetReward = false

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function ElizabethactmainView:onEnter()
	ElizabethactmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ElizabethGameGetInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.ElizabethGameGainPrizeRes, self._updateReward, self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.ElizabethGame)

	if self._activityId <= 0 then
		self:colse()

		return
	end

	self._firstSetReward = false
	self._actCfg = ElizabethgameConfig.instance:getActCfg(self._activityId)

	self:_setTime()
	self:_updateUI()
	self:_playFirstStory()
	self:_playViewEffect()
	ElizabethGameAgent.instance:sendPM_ElizabethGameGetInfoReq(self._activityId)
end

function ElizabethactmainView:_setTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function ElizabethactmainView:_setLeftTime()
	local useTime = ElizabethgameModel.instance:getUsedTimes(self._activityId)
	local maxTime = self._actCfg.dailyFreeGameTimes
	local leftTime = maxTime - useTime

	if leftTime <= 0 then
		if not GameEnum.ColorConst.Red then
			local color = GameEnum.ColorConst.Green

			self._txtLeftTime.text = string.format("今日剩余次数：<color=%s>%s</color>/%s", color, leftTime, maxTime)

			goutil.setActive(self._redpointGo, leftTime > 0)
		end
	end
end

function ElizabethactmainView:_updateUI()
	self:_setLeftTime()
	self:_updateReward()
	self:_setProgress()
end

function ElizabethactmainView:_onClickbtnStart()
	local useTime = ElizabethgameModel.instance:getUsedTimes(self._activityId)
	local maxTime = self._actCfg.dailyFreeGameTimes
	local leftTime = maxTime - useTime

	if leftTime <= 0 then
		FloatWordMgr.instance:show("游戏次数不足")

		return
	end

	UIStateManager.instance:push(ViewName.ElizabethactgameView)
end

function ElizabethactmainView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("elizabethactmainview")
end

function ElizabethactmainView:_onClickbtnClose()
	self:close()
end

function ElizabethactmainView:_updateReward()
	local cfgs = ElizabethgameConfig.instance:getGamePrizeCfgs(self._actCfg.prizePlanId)
	local progress = ElizabethgameModel.instance:getProgress(self._activityId)

	self._rewardScrollerList:reloadData(cfgs)

	self._firstSetReward = false

	if not self._firstSetReward then
		self._firstSetReward = true

		local moveIndex = 1

		for i, v in ipairs(cfgs) do
			local isCanGet = ElizabethgameController.instance:isCanGet(self._activityId, v.prizeId)

			if isCanGet then
				moveIndex = i

				break
			end
		end

		self._rewardScrollerList:MoveCellToBegin(moveIndex - 1)
	end

	local scoreList = ElizabethgameConfig.instance:getGamePrizeScores(self._actCfg.prizePlanId)

	self._rewardScrollerList:updateUnderSlider(self._progressBar, progress, scoreList)
end

function ElizabethactmainView:_updateRewardCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")
	local received = goutil.findChild(cell, "received")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.flowerNum

	local isCanGet = false
	local isGainPrize = ElizabethgameController.instance:isGainPrize(self._activityId, data.prizeId)

	if not isGainPrize then
		isCanGet = ElizabethgameController.instance:isCanGet(self._activityId, data.prizeId)
	end

	GameUtil.SetActive(canGet, isCanGet)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet then
		self:_playEffect(effect)

		self._curProgress = cell.index
	end

	if isGainPrize then
		self._curProgress = cell.index + 1
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data.prizeId), self)
end

function ElizabethactmainView:_onClickGetPrize(prizeId)
	ElizabethgameController.instance:sendPM_ElizabethGameGainPrizeReq(self._activityId, prizeId)
end

function ElizabethactmainView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("progress/tableview/Viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function ElizabethactmainView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function ElizabethactmainView:_clearRewardCell(cell)
	local effect = goutil.findChild(cell, "effect")
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

function ElizabethactmainView:_setProgress()
	self._txtProgress.text = ElizabethgameModel.instance:getProgress(self._activityId)
end

function ElizabethactmainView:_playFirstStory()
	if self._actCfg.storyId <= 0 then
		return
	end

	local isPlay = GameUtil.getUserData(ElizabethactmainView.playFirstStoryKey)

	if isPlay then
		return
	end

	GameUtil.saveUserData(ElizabethactmainView.playFirstStoryKey, true)
	GlobalDispatcher:dispatch(GlobalNotify.StartStory, self._actCfg.storyId)
end

function ElizabethactmainView:_playViewEffect()
	local effName = "20240209/changanguwu/fx_ui_changanguwu_fenwei02.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self.mainGO.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

return ElizabethactmainView
