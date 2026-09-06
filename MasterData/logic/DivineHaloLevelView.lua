-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinehalogame/view/DivineHaloLevelView.lua

module("logic.extensions.divinehalogame.view.DivineHaloLevelView", package.seeall)

local DivineHaloLevelView = class("DivineHaloLevelView", ViewComponent)

function DivineHaloLevelView:ctor()
	DivineHaloLevelView.super.ctor(self)
end

function DivineHaloLevelView:unbindEvents()
	DivineHaloLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPlayTeach)
	GameUtil.rmClickHandler(self._btnBuyTime)
end

function DivineHaloLevelView:bindEvents()
	DivineHaloLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnPlayTeach, self._onClickBtnPlayTeach, self)
	GameUtil.addClickHandler(self._btnBuyTime, self._onClickBtnBuyTime, self)
end

function DivineHaloLevelView:buildUI()
	DivineHaloLevelView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTime = self:getTxt("time/txt")
	self._btnPlayTeach = self:getGo("btnPlayTeach")
	self._btnBuyTime = self:getGo("btnBuyTime")
	self._txtGameTime = self:getTxt("tipGameTime/txtGameTime")
	self._txtTipLogin = self:getTxt("tipLogin/txtTipLogin")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineHaloLevelView:onExit()
	DivineHaloLevelView.super.onExit(self)
	self._scrollList:dispose()

	self._prizeScrollDic = nil
end

function DivineHaloLevelView:onEnter()
	DivineHaloLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineHaloGameInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_DivineHaloGameBuyTimesRes, self._onGameBuyTimeRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 476001
	end

	self._activityType = GameEnum.ActivityType.DivineHaloGame
	self._actCfg = DivineHaloGameConfig.instance:getActData(self._activityId)
	self._stageCfgs = DivineHaloGameConfig.instance:getStageDatas(self._activityId)
	self._buyGameTimeCostStr = DivineHaloGameConfig.instance:getBuyTimeDataByBuyTime(self._activityId, 1)
	self._info = DivineHaloGameModel.instance:getInfo(self._activityId)
	self._prizeScrollDic = {}

	self:_onSetUI()
	DivineHaloGameController.instance:sendPM_DivineHaloGameInfoReq(self._activityId)
end

function DivineHaloLevelView:_onSetUI()
	if self._txtTime then
		self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	self._txtTipLogin.text = string.format("每日登录可获得%d次闯关次数", self._actCfg.dailyRegisterGainTimes)
end

function DivineHaloLevelView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function DivineHaloLevelView:_updateData()
	self._info = DivineHaloGameModel.instance:getInfo(self._activityId)
end

function DivineHaloLevelView:_updateUI()
	self._txtGameTime.text = string.format("剩余闯关次数：<color=#E84642>%d / %d</color>", self._info.existingTimes, self._actCfg.storeTimesLimit)

	if not self._info.passStageIds then
		self._scrollList:MoveCellToCenter(#self._info.passStageIds)
		self._scrollList:reloadData(self._stageCfgs)
	end
end

function DivineHaloLevelView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function DivineHaloLevelView:_onClickBtnPlayTeach()
	local ruleCfg = DivineHaloGameConfig.instance:getRuleDataById(self._actCfg.ruleId)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.resPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade.instance:openImageRuleView(ruleList, "游戏规则")
end

function DivineHaloLevelView:_onClickBtnBuyTime()
	if self._info.todayBuyTimes == self._actCfg.dailyBuyTimesLimit then
		FloatWordMgr.instance:show("今日购买游戏次数已超上限")

		return
	end

	if self._info.existingTimes >= self._actCfg.storeTimesLimit then
		FloatWordMgr.instance:show("游戏存储次数已达上限，无需购买")

		return
	end

	local totalStageNum = #self._stageCfgs

	if not self._info.passStageIds then
		local passedStageIds = {}
		local leftStageNum = totalStageNum - #passedStageIds

		if leftStageNum <= self._info.existingTimes then
			FloatWordMgr.instance:show("当前游戏次数足够通关，无需再次购买")

			return
		end

		UIStateManager.instance:push(ViewName.DivineHaloCostView, self._activityId)
	end
end

function DivineHaloLevelView:_updateCell(view, cell, data)
	local txtLevelName = goutil.findChildTextComponent(cell, "txtLevelName")
	local txtTip = goutil.findChildTextComponent(cell, "txtTip")
	local btnChallenge = goutil.findChild(cell, "btnChallenge")
	local bgChangeComp = goutil.findChild(cell, "bgDifficult"):GetComponent("UIImageSpriteChange")
	local hasFinishGo = goutil.findChild(cell, "hasFinish")
	local prizeTableView = goutil.findChild(cell, "prizetableview")
	local prizeTableCell = goutil.findChild(cell, "tablecell")
	local prizeScroll

	if self._prizeScrollDic[cell.gameObject] then
		prizeScroll = self._prizeScrollDic[cell.gameObject]
	else
		prizeScroll = ScrollerList.create(prizeTableView, prizeTableCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
		self._prizeScrollDic[cell.gameObject] = prizeScroll
	end

	prizeScroll:setCenterMode(true)
	prizeScroll:dragNotifyParent()

	if not self._info.passStageIds then
		local passedStageIds = {}

		GameUtil.SetActive(hasFinishGo, data.stageId <= #passedStageIds)

		txtTip.text = string.format("难度%s", data.difficultLevel)
		txtLevelName.text = string.format("第%d关", data.stageId)

		bgChangeComp:SetState(string.byte(data.difficultLevel) - 65)

		local prizeDataList = {}
		local prizeArr = string.split(data.prize, "#")

		for i, prizeStr in ipairs(prizeArr) do
			local prizeData = {}

			prizeData.stageId = data.stageId
			prizeData.prize = prizeStr

			table.insert(prizeDataList, prizeData)
		end

		prizeScroll:reloadData(prizeDataList)
		GameUtil.addClickHandler(btnChallenge, function()
			if not self._info.passStageIds then
				if table.indexof(self._info.passStageIds, data.stageId) then
					FloatWordMgr.instance:show("已完成，无需重复挑战")

					return
				end

				if self._info.existingTimes <= 0 then
					FloatWordMgr.instance:show("游戏次数已用完，请购买或明日登陆后获取")

					return
				end

				if #self._info.passStageIds + 1 < data.stageId then
					FloatWordMgr.instance:show("请先完成之前关卡")

					return
				end

				DivineHaloGameController.instance:sendPM_DivineHaloGameStartGameReq(self._activityId)
				UIStateManager.instance:push(ViewName.DivineHaloGameView, self._activityId, data.stageId)
			end
		end, self)
	end
end

function DivineHaloLevelView:_clearCell(cell)
	local btnChallenge = goutil.findChild(cell, "btnChallenge")

	GameUtil.rmClickHandler(btnChallenge)

	local scrollList = self._prizeScrollDic[cell.gameObject]

	if scrollList then
		scrollList:dispose()

		self._prizeScrollDic[cell.gameObject] = nil
	end
end

function DivineHaloLevelView:_updatePrizeCell(view, cell, data)
	local geted = goutil.findChild(cell, "geted")
	local item = goutil.findChild(cell, "item")

	if not self._info.passStageIds then
		local passedStageIds = {}
		local hasGain = table.indexof(passedStageIds, data.stageId)

		MaterialMgr.setCellByCfg(data.prize, item)
		GameUtil.SetActive(geted, hasGain)
	end
end

function DivineHaloLevelView:_clearPrizeCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function DivineHaloLevelView:_onGameBuyTimeRes()
	FloatWordMgr.instance:show("成功增加闯关次数！")
	DivineHaloGameController.instance:sendPM_DivineHaloGameInfoReq(self._activityId)
end

return DivineHaloLevelView
