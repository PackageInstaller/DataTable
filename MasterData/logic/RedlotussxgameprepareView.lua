-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redlotusdinnerparty/view/RedlotussxgameprepareView.lua

module("logic.extensions.redlotusdinnerparty.view.RedlotussxgameprepareView", package.seeall)

local RedlotussxgameprepareView = class("RedlotussxgameprepareView", ViewComponent)

function RedlotussxgameprepareView:ctor()
	RedlotussxgameprepareView.super.ctor(self)
end

function RedlotussxgameprepareView:unbindEvents()
	RedlotussxgameprepareView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBegin)
end

function RedlotussxgameprepareView:bindEvents()
	RedlotussxgameprepareView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnBegin, self._onClickBegin, self)
end

function RedlotussxgameprepareView:buildUI()
	RedlotussxgameprepareView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnBegin = self:getGo("btnBegin")
	self._timeScrollerview = self:getGo("schedule/timeScrollerview")
	self._timecell = self:getGo("schedule/timecell")
	self._timeScrollerList = ScrollerList.create(self._timeScrollerview, self._timecell, GameUtil.handler(self._updateTimeCell, self), GameUtil.handler(self.clearTimeCell, self))
	self._progressBar = self:getSlider("rewardCol/rewardView/ViewPort/Content/progressBar")
	self._rewardView = self:getGo("rewardCol/rewardView")
	self._rewardScrollerRectTrans = self:getGo("rewardCol/rewardView/ViewPort"):GetComponent(goutil.Type_RectTransform)
	self._cell = self:getGo("rewardCol/cell")
	self._rewardScrollerList = ScrollerList.create(self._rewardView, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._txtValue = self:getTxt("rewardCol/score/txtValue")
	self._txtRemain = self:getTxt("remain/txt")
end

function RedlotussxgameprepareView:onExit()
	RedlotussxgameprepareView.super.onExit(self)
	self._timeScrollerList:dispose()
	self._rewardScrollerList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PM_RedLotusGalaBuyTimesRes, self._onGetBuyTimes, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_RedLotusGalaStartGameRes, self._onGoStartGame, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_RedLotusGalaGetInfoRes, self._onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_RedLotusGalaGainPrizeRes, self._onRefreshUI, self)
end

function RedlotussxgameprepareView:onEnter()
	RedlotussxgameprepareView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_RedLotusGalaBuyTimesRes, self._onGetBuyTimes, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_RedLotusGalaStartGameRes, self._onGoStartGame, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_RedLotusGalaGetInfoRes, self._onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_RedLotusGalaGainPrizeRes, self._onRefreshUI, self)
	self:_getCurPerCfg()

	if self._curPerCfg then
		local activityId = RedLotusDinnerPartyModel.instance:getActivityId()

		RedLotusDinnerPartyController.instance:sendGetInfo(activityId, self._curPerCfg.gameId)
	end

	self:_onRefreshUI()
end

function RedlotussxgameprepareView:_getCurPerCfg()
	local activityId = RedLotusDinnerPartyModel.instance:getActivityId()
	local actCfg = RedLotusDinnerPartyConfig.instance:getActivityCfgById(activityId) or {}
	local performPlanId = actCfg.performPlanId
	local performCfgList = RedLotusDinnerPartyConfig.instance:getPerformPlanCfgList(performPlanId) or {}

	self._timeScrollerList:reloadData(performCfgList)

	self._curPerCfg = nil

	local idx = 0

	for i, v in ipairs(performCfgList) do
		if GameUtil.checkIsInTimePeriod(v.startTime, v.endTime) then
			idx = i - 1
			self._curPerCfg = v
		end
	end

	self._timeScrollerList:MoveCellToCenter(idx)
end

function RedlotussxgameprepareView:_onRefreshUI()
	self:_getCurPerCfg()

	local activityId = RedLotusDinnerPartyModel.instance:getActivityId()

	self._txtRemain.text = "0"
	self._txtValue.text = "0"

	if self._curPerCfg then
		local freeNum = self._curPerCfg.freeNum
		local info = RedLotusDinnerPartyModel.instance:getGalaInfo(activityId, self._curPerCfg.gameId) or {}
		local useGameTimes = checknumber(info.useGameTimes)

		self._txtRemain.text = "" .. math.max(0, freeNum - useGameTimes)
		self._txtValue.text = checknumber(info.progress)

		local gamePrizePlan = self._curPerCfg.gamePrizePlan
		local list = RedLotusDinnerPartyConfig.instance:getProgressCfgList(gamePrizePlan) or {}

		self._rewardScrollerList:reloadData(list)

		local valueList = {}
		local stepList = {}

		table.insert(valueList, 0)
		table.insert(stepList, 0)

		local tableView = self._rewardScrollerList:getView()
		local content = self:getGo("rewardCol/rewardView/ViewPort/Content")
		local height = GameUtil.getHeight(content)

		if height == 0 then
			height = 1
		end

		local step = tableView.gridHeight + tableView.cellSpacing.y
		local offset = tableView.cellOffset.y
		local idx = 0

		for i, v in ipairs(list) do
			table.insert(valueList, v.score)
			table.insert(stepList, (offset + (i - 1) * step) / height)

			if not info.gainPrizeIds then
				if table.indexof(info.gainPrizeIds, v.prizeId) ~= false then
					-- block empty
				elseif checknumber(info.progress) >= v.score then
					idx = math.min(idx, i - 1)
				end
			end
		end

		GameUtil.setProgress(self._progressBar, checknumber(info.progress), valueList, stepList)
		self._rewardScrollerList:MoveCellToCenter(idx)
	end
end

function RedlotussxgameprepareView:_updateTimeCell(view, cell, data, tag)
	local txtTime = goutil.findChildTextComponent(cell, "time/txtTime")
	local txtTitle = goutil.findChildTextComponent(cell, "title/txtTitle")
	local startTimeD = GameUtil.string2date(data.startTime)
	local endTimeD = GameUtil.string2date(data.endTime)

	txtTime.text = langPara("%s.%s-%s.%s", startTimeD.month, startTimeD.day, endTimeD.month, endTimeD.day)
	txtTitle.text = data.name

	local idx = 0

	if GameUtil.checkIsInTimePeriod(data.startTime, data.endTime) then
		idx = 1
	end

	GameUtil.setUIImageSpriteIdx(goutil.findChild(cell, "time"), idx)
	GameUtil.setUIImageSpriteIdx(goutil.findChild(cell, "title"), idx)
	GameUtil.setUITextColorIdx(goutil.findChild(cell, "time/txtTime"), idx)
	GameUtil.setUITextColorIdx(goutil.findChild(cell, "title/txtTitle"), idx)
end

function RedlotussxgameprepareView:clearTimeCell(cell)
	return
end

function RedlotussxgameprepareView:_updateCell(view, cell, data, tag)
	local btnGet = goutil.findChild(cell, "btnGet")
	local received = goutil.findChild(cell, "item/received")
	local itemcell = goutil.findChild(cell, "item/itemcell")
	local effGo = goutil.findChild(cell, "item/effGo")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")

	MaterialMgr.setCellByCfg(data.gain, itemcell)

	txtNum.text = data.score

	GameUtil.rmClickHandler(btnGet)
	GameUtil.SetActive(received, false)

	local activityId = RedLotusDinnerPartyModel.instance:getActivityId()

	if self._curPerCfg then
		local info = RedLotusDinnerPartyModel.instance:getGalaInfo(activityId, self._curPerCfg.gameId) or {}

		if not info.gainPrizeIds then
			local gainPrizeIds = {}

			self:_clearEffect(effGo)

			if table.indexof(gainPrizeIds, data.prizeId) ~= false then
				GameUtil.SetActive(received, true)
			elseif checknumber(info.progress) >= data.score then
				self:_playEffect(effGo)
			end

			GameUtil.addClickHandler(btnGet, function()
				if table.indexof(gainPrizeIds, data.prizeId) ~= false then
					TipsFacade.instance:openCommonTips("已经领取")
				elseif checknumber(info.progress) >= data.score then
					RedLotusDinnerPartyController.instance:sendGainPrize(activityId, self._curPerCfg.gameId, data.prizeId)
				end
			end)
		end
	end
end

function RedlotussxgameprepareView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		if not goutil.isNil(self._rewardScrollerRectTrans) then
			eff:setClipping(self._rewardScrollerRectTrans)
		end
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function RedlotussxgameprepareView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function RedlotussxgameprepareView:clearCell(cell)
	local itemcell = goutil.findChild(cell, "item/itemcell")
	local btnGet = goutil.findChild(cell, "btnGet")
	local effGo = goutil.findChild(cell, "item/effGo")

	MaterialMgr.resetAll(itemcell)
	GameUtil.rmClickHandler(btnGet)
	self:_clearEffect(effGo)
end

function RedlotussxgameprepareView:_onClickTip()
	TipsFacade.instance:openRulesView("RedlotussxgameprepareView_rule")
end

function RedlotussxgameprepareView:_onGoStartGame(clientKey, serverKey, actId, gameId, stageId)
	if clientKey == self._clientKey then
		UIStateManager.instance:push(ViewName.RedlotussxgameView, actId, gameId, clientKey, serverKey)
		self:close()
	end
end

function RedlotussxgameprepareView:_onGetBuyTimes()
	if self._curPerCfg then
		self:_onRefreshUI()

		local activityId = RedLotusDinnerPartyModel.instance:getActivityId()

		self._clientKey = RedLotusDinnerPartyController.instance:sendStartGame(activityId, self._curPerCfg.gameId)
	end
end

function RedlotussxgameprepareView:_onClickBegin()
	if self._curPerCfg then
		local activityId = RedLotusDinnerPartyModel.instance:getActivityId()
		local info = RedLotusDinnerPartyModel.instance:getGalaInfo(activityId, self._curPerCfg.gameId) or {}
		local useGameTimes = checknumber(info.useGameTimes)

		if self._curPerCfg.freeNum - useGameTimes > 0 then
			self._clientKey = RedLotusDinnerPartyController.instance:sendStartGame(activityId, self._curPerCfg.gameId)
		else
			local buyTimes = checknumber(info.buyGameTimes)
			local buyPlanId = self._curPerCfg.buyPlanId
			local buyCfgList = RedLotusDinnerPartyConfig.instance:getBuyCfgList(buyPlanId) or {}

			if buyTimes < #buyCfgList then
				if not buyCfgList[buyTimes + 1] then
					local buyCfg = {}
					local type, id, num = MaterialMgr.getMatParams(buyCfg.buyCost)
					local content = langPara("可以花费%s%s购买多一次游戏次数，确定购买吗？", num, MaterialMgr.getMaterialsName(type, id))

					TipsFacade.instance:openPopupCostMatViewNew(type, id, num, content, function()
						RedLotusDinnerPartyController.instance:sendBuyTimes(activityId, self._curPerCfg.gameId)
					end)
				end
			else
				TipsFacade.instance:openCommonTips(lang("已经超过可购买次数"))
			end
		end
	else
		TipsFacade.instance:openCommonTips(lang("当前时间不在活动时间内"))
	end
end

return RedlotussxgameprepareView
