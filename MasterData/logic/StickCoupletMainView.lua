-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stickcouplet/view/StickCoupletMainView.lua

module("logic.extensions.stickcouplet.view.StickCoupletMainView", package.seeall)

local StickCoupletMainView = class("StickCoupletMainView", ViewComponent)

function StickCoupletMainView:ctor()
	StickCoupletMainView.super.ctor(self)
end

function StickCoupletMainView:buildUI()
	StickCoupletMainView.super.buildUI(self)

	self._con = self:getGo("con")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtTime = self:getTxt("time/txt")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._rewardcell = self:getGo("scorollReward/rewardcell")
	self._tableview = self:getGo("scorollReward/tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._rewardcell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._txtProgress = self:getTxt("total/txtProgress")
	self._progressSlider = self:getSlider("scorollReward/tableview/viewport/content/progressSlider")
	self._txtPlayTimes = self:getTxt("playTimes/txt")
	self._redpoint = self:getGo("btnStart/redpoint")
	self._btnStart = self:getGo("btnStart")
end

function StickCoupletMainView:bindEvents()
	StickCoupletMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function StickCoupletMainView:unbindEvents()
	StickCoupletMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnTip)
end

function StickCoupletMainView:onEnter()
	StickCoupletMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_StickCoupletGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_StickCoupletGainPrizeRes, self._onUpdate, self)

	self._activityType = StickCoupletController.instance:getActivityType()

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = StickCoupletController.instance:getActivityId()
	end

	self._actcfg = StickCoupletConfig.instance:getSCActData(self._activityId)
	self._model = StickCoupletModel.instance:getModel(self._activityId)

	local storyId = self._actcfg.firstStoryId

	if checknumber(storyId) > 0 then
		local key = string.format("StickCoupletMainView_%s", self._activityId)

		local function firstCallback()
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		GameUtil.doCallbackWhenFirst(key, firstCallback)
	end

	self:_onSetUI()
	StickCoupletController.instance:sendPM_StickCoupletGetInfoReq(self._activityId)
end

function StickCoupletMainView:onExit()
	StickCoupletMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self._scrollList:dispose()
end

function StickCoupletMainView:_onSetUI()
	if self._txtTime then
		self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	local skinId = self._actcfg.skinId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)
end

function StickCoupletMainView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function StickCoupletMainView:_updateData()
	self._model = StickCoupletModel.instance:getModel(self._activityId)
end

function StickCoupletMainView:_updateUI()
	if not self._model.gainPrizeIds then
		if not self._model.totalScore then
			local totalScore = 0
			local curProgress = StickCoupletController.instance:getCurProgress(self._activityId, totalScore)
			local dailyGameTimes = self._actcfg.dailyGameTimes
			local todayGameTimes = self._model.todayGameTimes
			local leftGameTime = dailyGameTimes - todayGameTimes
			local list = StickCoupletConfig.instance:getSCProgressData(self._activityId)

			self._scrollList:reloadData(list)

			self._txtProgress.text = totalScore
			self._txtPlayTimes.text = "剩余游戏次数:" .. leftGameTime .. "/" .. dailyGameTimes

			GameUtil.SetActive(self._redpoint, todayGameTimes < dailyGameTimes)

			local scoreList = {}

			for i, v in ipairs(list) do
				table.insert(scoreList, v.needScore)
			end

			self._scrollList:updateUnderSlider(self._progressSlider, self._model.totalScore, scoreList)
		end
	end
end

function StickCoupletMainView:_updateRewardCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effect = goutil.findChild(cell, "effect")
	local hasGet = false

	if not self._model.totalScore then
		local finishIds = {}
		local isCanGet = finishIds >= data.needScore

		if not self._model.gainPrizeIds then
			local gainPrizeIds = {}

			hasGet = table.indexof(gainPrizeIds, data.prizeId) ~= false
			txtScore.text = data.needScore

			MaterialMgr.setCellByCfg(data.prize, item)
			GameUtil.SetActive(geted, hasGet)
			GameUtil.SetActive(btnGet, isCanGet and not hasGet)
			self:_clearCellEffect(effect)

			if isCanGet and not hasGet then
				self:_playCellEffect(effect)
			end

			GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
		end
	end
end

function StickCoupletMainView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")
	local btnGet = goutil.findChild(cell, "btnGet")

	MaterialMgr.resetAll(item)
	self:_clearCellEffect(effect)
	GameUtil.rmClickHandler(btnGet)
end

local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function StickCoupletMainView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("scorollReward/tableview/viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function StickCoupletMainView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function StickCoupletMainView:_onClickBtnStart()
	local dailyGameTimes = self._actcfg.dailyGameTimes
	local todayGameTimes = self._model.todayGameTimes
	local leftGameTime = dailyGameTimes - todayGameTimes

	if leftGameTime <= 0 then
		FloatWordMgr.instance:show("今日剩余游戏次数为0")

		return
	end

	UIStateManager.instance:push(ViewName.StickCoupletChooseView, self._activityId)
end

function StickCoupletMainView:_onClickBtnTip()
	local key = self._actcfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function StickCoupletMainView:_onClickGetPrize(data)
	if not self._model.gainPrizeIds then
		local gainPrizeIds = {}
		local hasGet = table.indexof(gainPrizeIds, data.prizeId) ~= false

		if not hasGet then
			if not self._model.totalScore then
				local finishIds = {}
				local isCanGet = finishIds >= data.needScore

				if isCanGet then
					StickCoupletController.instance:sendPM_StickCoupletGainPrizeReq(self._activityId, data.prizeId)
				else
					TipsFacade.instance:openCommonTips("还没达到条件哦~")
				end
			end
		end
	end
end

return StickCoupletMainView
