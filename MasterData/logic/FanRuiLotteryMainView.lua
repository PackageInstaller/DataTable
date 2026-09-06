-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruilottery/view/FanRuiLotteryMainView.lua

module("logic.extensions.fanruilottery.view.FanRuiLotteryMainView", package.seeall)

local FanRuiLotteryMainView = class("FanRuiLotteryMainView", ViewComponent)

function FanRuiLotteryMainView:ctor()
	FanRuiLotteryMainView.super.ctor(self)
end

function FanRuiLotteryMainView:buildUI()
	FanRuiLotteryMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("leftTop/btnTip")
	self._btnChallenge = self:getGo("btnChallenge")
	self._btnLottery = self:getGo("btnLottery")
	self._redPointLottery = self:getGo("btnLottery/redpoint")
	self._btn_1 = self:getGo("btn_1")
	self._btn_2 = self:getGo("btn_2")
	self._txtTime = self:getTxt("time/txt")
	self._txtCost = self:getTxt("btnLottery/txt")
	self._conCost = self:getGo("btnLottery/icon")
	self._tableView = self:getGo("tableview")
	self._tableCell = self:getGo("tableCell")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnSkip = self:getGo("btnPass")
	self._animMaskGo = self:getGo("viewBoxGo")
end

function FanRuiLotteryMainView:destroyUI()
	self._tableList:dispose()
end

function FanRuiLotteryMainView:bindEvents()
	FanRuiLotteryMainView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickLottery, self)
	GameUtil.addClickHandler(self._btn_1, self._onClickBtn1, self)
	GameUtil.addClickHandler(self._btn_2, self._onClickBtn2, self)
	GameUtil.addClickHandler(self._btnSkip, self._onClickSkip, self)
end

function FanRuiLotteryMainView:unbindEvents()
	FanRuiLotteryMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnSkip)
end

function FanRuiLotteryMainView:onEnter()
	FanRuiLotteryMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_FanRuiLotteryGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_FanRuiLotteryLotteryRes, self._PM_FanRuiLotteryLotteryRes, self)
	RedPointController.instance:regRedPoint(self._redPointLottery, RedPointModel.ID_FANRUI_LOTTERY_LOTTERYABLE)

	self._activityId = FanRuiLotteryModel.instance:getCurrActId()
	self._actCfg = FanRuiLotteryConfig.instance:getActivityCfg(self._activityId)
	self._canLottery = false
	self._prizeList = FanRuiLotteryConfig.instance:getLotteryPrize(self._activityId)

	self._tableList:reloadData(self._prizeList)
	self:_setTopGoldBar()

	local startTimeStemp, endTimeStemp = ActivityDefineController:getStartTimeAndEndTime(GameEnum.ActivityType.FanRuiLottery, self._activityId)
	local startTime = GameUtil.time2date(startTimeStemp)
	local endTime = GameUtil.time2date(endTimeStemp)

	self._txtTime.text = langPara("活动时间：%d.%d %d:%02d -%d.%d %d:%02d", startTime.month, startTime.day, startTime.hour, startTime.min, endTime.month, endTime.day, endTime.hour, endTime.min)

	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.lotteryCost)
	local matName = MaterialMgr.getMaterialsName(matType, matId)

	self._txtCost.text = langPara("投%d个%s", matNum, matName)

	MaterialMgr.setIcon(self._conCost, matType, matId)
	FanRuiLotteryAgent.instance:sendPM_FanRuiLotteryGetInfoReq(self._activityId)

	if not FanRuiLotteryModel.instance:getIsReadStory(self._activityId) and checknumber(self._actCfg.storyId) ~= 0 then
		FanRuiLotteryModel.instance:setIsReadStory(self._activityId)
		GlobalDispatcher:dispatch(GlobalNotify.StartStory, self._actCfg.storyId)
	end

	GameUtil.SetActive(self._btnSkip, false)
	GameUtil.SetActive(self._animMaskGo, false)
end

function FanRuiLotteryMainView:onExit()
	FanRuiLotteryMainView.super.onExit(self)
	MaterialMgr.resetAll(self._conCost)
	RedPointController.instance:unregRedPoint(self._redPointLottery)
end

function FanRuiLotteryMainView:_refreshView()
	self._canLottery = false

	for i, v in ipairs(self._prizeList) do
		if not FanRuiLotteryModel.instance:getIsGetPrize(v.prizeId) then
			self._canLottery = true
		end
	end

	GameUtil.SetActive(self._btnLottery, self._canLottery)
	self._tableList:reloadData(self._prizeList)
end

function FanRuiLotteryMainView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")
	local receive = goutil.findChild(go, "imgReceive")
	local tag = goutil.findChild(go, "tag")
	local txtTag = goutil.findChildTextComponent(go, "tag/Text")

	MaterialMgr.setCellByCfg(data.prize, item)

	local isReceive = FanRuiLotteryModel.instance:getIsGetPrize(data.prizeId)

	GameUtil.SetActive(receive, isReceive)
	GameUtil.SetActive(tag, not string.nilorempty(data.tag))

	txtTag.text = data.tag
end

function FanRuiLotteryMainView:_clearCell(cell)
	local go = cell.gameObject
	local item = goutil.findChild(go, "item")

	MaterialMgr.resetAll(item)
end

function FanRuiLotteryMainView:_setTopGoldBar()
	local btn_list = {}
	local costMatType, costMatId, costMatNum = MaterialMgr.getMatParams(self._actCfg.exchangeCost)
	local costMatName = MaterialMgr.getMaterialsName(costMatType, costMatId)
	local exchangeMatType, exchangeMatId, exchangeMatNum = MaterialMgr.getMatParams(self._actCfg.exchangePrize)
	local exchangeMatName = MaterialMgr.getMaterialsName(exchangeMatType, exchangeMatId)
	local content = langPara("是否确认消耗%d个%s,购买%d个%s", costMatNum, costMatName, exchangeMatNum, exchangeMatName)

	local function exchengeHaneler()
		TipsFacade.instance:openPopupCostMatViewNew(costMatType, costMatId, costMatNum, content, function()
			if ServerTime.now() >= FanRuiLotteryModel.instance:getNextExchangeTime() then
				FanRuiLotteryAgent.instance:sendPM_FanRuiLotteryExchangeReq(self._activityId)
			else
				local time = checknumber(FanRuiLotteryModel.instance:getNextExchangeTime() - ServerTime.now())
				local min = math.floor(time / 60) + 1

				FloatWordMgr.instance:show(langPara("可兑换时间剩余：%d分钟", min))
			end
		end)
	end

	table.insert(btn_list, {
		showAdd = true,
		id = self._actCfg.lotteryCost
	})
	table.insert(btn_list, {
		showAdd = true,
		id = self._actCfg.exchangePrize,
		showAddCallBack = exchengeHaneler
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function FanRuiLotteryMainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.FanRuiLotterySettingView, self._activityId)
end

function FanRuiLotteryMainView:_onClickRule()
	TipsFacade.instance:openRulesView("fanruilotterymainview_rule")
end

function FanRuiLotteryMainView:_onClickLottery()
	if self._canLottery == false then
		FloatWordMgr.instance:show(lang("奖池内道具不足"))
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.lotteryCost)
	local matName = MaterialMgr.getMaterialsName(matType, matId)

	if MaterialModel.instance:IsEnough(matType, matId, matNum) == true then
		local content = langPara("是否确认消耗%d个%s，让梵瑞尝试合体呢？", matNum, matName)

		TipsFacade.instance:openPopupWindowWithX(lang("提示"), content, GameUtil.handler(function()
			FanRuiLotteryAgent.instance:sendPM_FanRuiLotteryLotteryReq(self._activityId)
		end, self))
	else
		FloatWordMgr.instance:show(lang("所需道具不足"))
	end
end

function FanRuiLotteryMainView:_onClickBtn1()
	GotoMgr.gotoByString(self._actCfg.jumpTo[1])
end

function FanRuiLotteryMainView:_onClickBtn2()
	GotoMgr.gotoByString(self._actCfg.jumpTo[2])
end

function FanRuiLotteryMainView:_onClickSkip()
	if self._playingAni == true and self._lotteryAnim then
		self._lotteryAnim:Stop()
		removetimer(self._onFinshAnimation, false)
		self:_onFinshAnimation()
	end
end

function FanRuiLotteryMainView:_PM_FanRuiLotteryLotteryRes(changeId, prizeId)
	if checknumber(changeId) > 0 then
		MaterialController.instance:saveChangeSetToTemp(changeId)
	else
		self:_refreshView()

		return
	end

	local prizeCfg = FanRuiLotteryConfig.instance:getLotteryPrizeById(self._activityId, prizeId)

	GameUtil.SetActive(self._animMaskGo, true)

	if string.nilorempty(prizeCfg.tag) then
		if not FanRuiLotteryModel.instance:getIsGetNotTagPrize(self._activityId) then
			self._playingAni = true
			self._lotteryAnim = AnimationPlayer.play("storyconfig/animations/story_frcj_shibai.txt", nil, self._onStartLoseAnimation, self)
			self._isCanSkip = false

			FanRuiLotteryModel.instance:setIsGetNotTagPrize(self._activityId)
		else
			self._playingAni = true

			GameUtil.SetActive(self._btnSkip, true)

			self._lotteryAnim = AnimationPlayer.play("storyconfig/animations/story_frcj_shibai.txt", nil, self._onStartLoseAnimation, self)
		end
	elseif not FanRuiLotteryModel.instance:getIsGetTagPrize(self._activityId) then
		self._lotteryAnim = AnimationPlayer.play("storyconfig/animations/story_frcj_chenggong.txt", nil, self._onStartAnimation, self)
		self._playingAni = true
		self._isCanSkip = false

		FanRuiLotteryModel.instance:setIsGetTagPrize(self._activityId)
	else
		self._lotteryAnim = AnimationPlayer.play("storyconfig/animations/story_frcj_chenggong.txt", nil, self._onStartAnimation, self)
		self._playingAni = true

		GameUtil.SetActive(self._btnSkip, true)
	end

	self._lotteryChangeId = changeId
end

function FanRuiLotteryMainView:_onStartAnimation()
	removetimer(self._onFinshAnimation, self)
	settimer(1, self._onFinshAnimation, self, false)
end

function FanRuiLotteryMainView:_onStartLoseAnimation()
	removetimer(self._onFinshAnimation, self)
	settimer(2, self._onFinshAnimation, self, false)
end

function FanRuiLotteryMainView:_onFinshAnimation()
	self:_refreshView()
	GameUtil.SetActive(self._btnSkip, false)

	self._playingAni = false

	if self._lotteryAnim then
		self._lotteryAnim:Stop()

		self._lotteryAnim = nil
	end

	if checknumber(self._lotteryChangeId) > 0 then
		MaterialController.instance:showChangeSetInTemp(self._lotteryChangeId)
	end

	self._lotteryChangeId = nil

	GameUtil.SetActive(self._animMaskGo, false)
end

return FanRuiLotteryMainView
