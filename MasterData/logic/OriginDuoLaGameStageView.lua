-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originduolagame/view/OriginDuoLaGameStageView.lua

module("logic.extensions.originduolagame.view.OriginDuoLaGameStageView", package.seeall)

local OriginDuoLaGameStageView = class("OriginDuoLaGameStageView", ViewComponent)

function OriginDuoLaGameStageView:ctor()
	OriginDuoLaGameStageView.super.ctor(self)
end

function OriginDuoLaGameStageView:unbindEvents()
	OriginDuoLaGameStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function OriginDuoLaGameStageView:bindEvents()
	OriginDuoLaGameStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function OriginDuoLaGameStageView:buildUI()
	OriginDuoLaGameStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTimeLeft = self:getTxt("timeLeft/txt")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")

	local gotableview = self:getGo("tableview")
	local goCell = self:getGo("tableview/tablecell")

	self._tableView = ScrollerList.create(gotableview, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginDuoLaGameStageView:onExit()
	OriginDuoLaGameStageView.super.onExit(self)
	self._tableView:dispose()
end

function OriginDuoLaGameStageView:onEnter()
	OriginDuoLaGameStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginDuoLaGameGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_OriginDuoLaGameStartGameRes, self._handleStartGame, self)
	self.addGEvent(self, GlobalNotify.PM_OriginDuoLaGameEndGameRes, self._handleEndGame, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = OriginDuoLaGameController.instance:getDefaultActivityId() or 0
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	OriginDuoLaGameController.instance:getInfo(self._activityId)
end

function OriginDuoLaGameStageView:_handleStartGame()
	TipsFacade.instance:openCommonTips(lang("开始挑战"))
end

function OriginDuoLaGameStageView:_handleEndGame()
	TipsFacade.instance:openCommonTips(lang("挑战结束"))
	self:_updateUIByInfo()
end

function OriginDuoLaGameStageView:_updateUIByCfg()
	self._actCfg = OriginDuoLaGameConfig.instance:getActivityCfg(self._activityId) or {}
	self._dailyPassLimit = 0

	if self._actCfg then
		self._dailyPassLimit = self._actCfg.dailyPassLimit or 0
	end

	self._stageCfgs = OriginDuoLaGameConfig.instance:getStageCfgListByActivityId(self._activityId) or {}
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function OriginDuoLaGameStageView:_updateUIByInfo()
	self._todayPassTimes = OriginDuoLaGameModel.instance:getTodayPassTimes(self._activityId)
	self._txtTimeLeft.text = langPara("今日剩余：%s/%s", Mathf.Max(0, self._dailyPassLimit - self._todayPassTimes), self._dailyPassLimit)
	self._maxPassStageId = OriginDuoLaGameModel.instance:getMaxPassStageId(self._activityId)

	local stageCount = #self._stageCfgs

	if stageCount > 0 then
		self._tableView:MoveCellToBegin(Mathf.Min(stageCount - 1, self._maxPassStageId))
	end

	self:_updateStageList()
end

function OriginDuoLaGameStageView:_updateStageList()
	self._tableView:reloadData(self._stageCfgs)
end

function OriginDuoLaGameStageView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function OriginDuoLaGameStageView:_onClickBtnEnter(stageId)
	if self._todayPassTimes >= self._dailyPassLimit then
		TipsFacade.instance:openCommonTips(lang("今日挑战次数已用完"))

		return
	end

	UIStateManager.instance:push(ViewName.OriginDuoLaGameClgView, self._activityId, stageId)
end

function OriginDuoLaGameStageView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtSize = goutil.findChildTextComponent(go, "txtSize")
	local goEmoji = goutil.findChild(go, "emoji")

	if not data.showPicPath then
		local path = ""

		if path ~= "" then
			local pathParams = string.split(path, "/")
			local lastPath = GameUrl.getEmojiUrl(pathParams[1], pathParams[2])

			uGuiUtil.setSpriteToImage(goEmoji, uGuiUtil.SpriteType.BigBg, lastPath, function()
				local emojiImg = goEmoji:GetComponent(goutil.Type_UIImage)

				emojiImg:SetNativeSize()

				emojiImg.raycastTarget = false
			end)
		else
			uGuiUtil.clearImage(goEmoji)
		end

		txtName.text = langPara("第%s关", data.stageId)

		if not data.gamePlanId then
			local gamePlanId = 1
			local mapSize = OriginDuoLaGameConfig.instance:getGamePlanSize(gamePlanId) or {
				rowNum = 0,
				colNum = 0
			}

			txtSize.text = langPara("难度：%s*%s", mapSize.rowNum, mapSize.colNum)

			local conPrize = goutil.findChild(go, "prize/con")

			MaterialMgr.setCellListByCfg(data.prize, conPrize)

			local markPass = goutil.findChild(go, "markPass")
			local goLockTips = goutil.findChild(go, "lockTips")
			local txtLockTips = goutil.findChildTextComponent(goLockTips, "txt")
			local btnGoto = goutil.findChild(go, "btnGoto")

			goutil.setActive(markPass, false)
			goutil.setActive(goLockTips, false)
			goutil.setActive(btnGoto, false)

			if not data.stageId then
				local stageId = 0
				local isPass = stageId <= self._maxPassStageId
				local isTimeUnlock = true

				if not data.openTime then
					local openTime = ""

					if openTime ~= "" then
						local serverTime = ServerTime.now()
						local openTimeSec = GameUtil.string2time(openTime)

						isTimeUnlock = openTimeSec <= serverTime

						if not isTimeUnlock then
							local unLockTimeDate = GameUtil.time2date(openTimeSec)

							txtLockTips.text = langPara("%s.%s 5:00后解锁", unLockTimeDate.month, unLockTimeDate.day)
						else
							txtLockTips.text = lang("通关上一关后开启")
						end
					end

					local canEnter = isTimeUnlock and stageId == self._maxPassStageId + 1

					goutil.setActive(markPass, isPass)
					goutil.setActive(goLockTips, not canEnter and not isPass)
					goutil.setActive(btnGoto, canEnter)
					GameUtil.rmClickHandler(btnGoto)
					GameUtil.addClickHandler(btnGoto, function()
						self:_onClickBtnEnter(stageId)
					end, self)
				end
			end
		end
	end
end

function OriginDuoLaGameStageView:_clearCell(cell)
	local go = cell.gameObject
	local emojiGo = goutil.findChild(go, "emoji")

	uGuiUtil.clearImage(emojiGo)

	local conPrize = goutil.findChild(go, "prize/con")

	MaterialMgr.resetAll(conPrize)

	local btnGoto = goutil.findChild(go, "btnGoto")

	GameUtil.rmClickHandler(btnGoto)
end

return OriginDuoLaGameStageView
