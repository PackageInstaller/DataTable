-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/view/PinGameLevelView.lua

module("logic.extensions.pingame.view.PinGameLevelView", package.seeall)

local PinGameLevelView = class("PinGameLevelView", ViewComponent)

function PinGameLevelView:ctor()
	PinGameLevelView.super.ctor(self)
end

function PinGameLevelView:buildUI()
	PinGameLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._levelList = {}

	for i = 1, 3 do
		local cell = {}
		local go = goutil.findChild(self.mainGO, "main/level" .. i)

		cell.go = go
		cell.icon = goutil.findChild(go, "icon")
		cell.txtName = goutil.findChildTextComponent(go, "txtName")
		cell.txtScore = goutil.findChildTextComponent(go, "txtScore")
		cell.btn = Framework.ButtonAdapter.GetFrom(go, "btn")

		table.insert(self._levelList, cell)
	end

	self._txtGameNum = self:getTxt("main/gameNum/txt")
	self._txtScore = self:getTxt("main/score/txt")
end

function PinGameLevelView:bindEvents()
	PinGameLevelView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)

	for i, v in ipairs(self._levelList) do
		v.btn:AddClickListener(function()
			self:_onClickLevel(i)
		end)
	end
end

function PinGameLevelView:unbindEvents()
	PinGameLevelView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()

	for i, v in ipairs(self._levelList) do
		v.btn:RemoveClickListener()
	end
end

function PinGameLevelView:onEnter()
	PinGameLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PinGameStartGameRes, self._onPinGameStartGameRes, self)
	self.addGEvent(self, GlobalNotify.PinGameEndGameRes, self._initView, self)
	self.addGEvent(self, GlobalNotify.PinGameSweepRes, self._pinGameSweepRes, self)

	self._activityId = self:getFirstParam()
	self._isBelongSweep = AnnuityPrivilegeController.instance:isBelongSweep(self._activityId)

	self:_initView()
end

function PinGameLevelView:onExit()
	PinGameLevelView.super.onExit(self)
	self:_clearView()
end

function PinGameLevelView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "pingamelevelview_rule")
end

function PinGameLevelView:_onPinGameStartGameRes()
	local mode = PinGameModel.instance:getStartGameMode(self._activityId)
	local stageId = PinGameModel.instance:getStartGameStageId(self._activityId)

	PinGameController.instance:enterGame(mode, stageId, false, self._activityId)
end

function PinGameLevelView:_pinGameSweepRes(msg)
	FloatWordMgr.instance:show(string.format("扫荡成功！获得积分：%s", msg.addScore))
	self:_initView()
end

function PinGameLevelView:_initView()
	for i, v in ipairs(self._levelList) do
		local cfg = PinGameConfig.instance:getGameMode(self._activityId, i)

		v.txtScore.text = string.format("%d点积分", cfg.score)

		local modelCo = CharacterConfig.instance:getModelCo(cfg.raceId)

		uGuiUtil.setSpriteToImage(v.icon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	end

	self:_updateGameNum()
	self:_updateScore()
end

function PinGameLevelView:_clearView()
	for i, v in ipairs(self._levelList) do
		uGuiUtil.clearImage(v.icon)
	end
end

function PinGameLevelView:_updateGameNum()
	local leftNum, totalNum = PinGameController.instance:getGameTimesToday(self._activityId)

	if leftNum > 0 then
		if not ColorConst.Green2 then
			local colorStr = ColorConst.Red

			self._txtGameNum.text = string.format("今日剩余次数：<color=#%s>%d</color>/%d", colorStr, leftNum, totalNum)
		end
	end
end

function PinGameLevelView:_updateScore()
	self._txtScore.text = string.format("个人累计积分：%d", PinGameModel.instance:getScore(self._activityId))
end

function PinGameLevelView:_onClickLevel(mode)
	local isHasPassFirst = PinGameModel.instance:isSweepable(self._activityId, mode)

	if self._isBelongSweep and isHasPassFirst then
		local isInitInfo = YearCardModel.instance:isInitInfo()

		if not isInitInfo then
			FloatWordMgr.instance:show("正在读取年费特权信息，请稍后再试")

			return
		end

		local sweepResult = self:getTrySweepGameResultAndTips(false, self._activityId, mode, 1)

		if sweepResult == GameEnum.ResultCode.Success then
			local descTxt

			local function sureCallBack(view)
				self:_sweepGame(self._activityId, mode, view:getCurTimes())
			end

			local function cancelCallBack(view)
				self:_enterGame(self._activityId, mode)
			end

			local otherCallBack
			local maxCoinNum = PinGameController.instance:getMaxGameTimesToday(self._activityId)

			local function updateCoinTxtCallBack(view)
				view:getTxtCoin().text = string.format("游戏次数：%s/%s", view:getCurCoinNum(), maxCoinNum)
			end

			local data = PinGameConfig.instance:getGameMode(self._activityId, mode)
			local passGetScore = data.score

			local function updateDescTxtCallBack(view)
				view:getTxtDesc().text = string.format("您已首通完毕，是否扫荡获得进度？\n当前可获得积分：<color=#0068b7>%s</color>", passGetScore * view:getCurTimes())
			end

			local leftTimes = PinGameController.instance:getLeftGameTimesToday(self._activityId)

			TipsFacade.instance:openPopupCommonCostPopView(leftTimes, 1, "开始游戏", "扫荡", "直接开始", descTxt, sureCallBack, cancelCallBack, otherCallBack, updateCoinTxtCallBack, updateDescTxtCallBack)
		else
			self:_enterGame(self._activityId, mode)
		end
	else
		self:_enterGame(self._activityId, mode)
	end
end

function PinGameLevelView:_enterGame(activityId, mode)
	if not PinGameController.instance:isLeftGameTimeToday(activityId) then
		FloatWordMgr.instance:show("今日游戏次数已用尽，明天再来吧~")

		return
	end

	local clientKey = PinGameModel.instance:setClientKey(activityId)

	PinGameAgent.instance:sendPM_PinGameStartGameReq(activityId, clientKey, mode)
end

function PinGameLevelView:_sweepGame(activityId, mode, times)
	local result = self:getTrySweepGameResultAndTips(true, activityId, mode, times)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	PinGameAgent.instance:sendPM_PinGameSweepReq(activityId, mode, times)
end

function PinGameLevelView:getTrySweepGameResultAndTips(isNeedTips, activityId, mode, times)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success and not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	end

	if result == GameEnum.ResultCode.Success then
		local isCanSweep = AnnuityPrivilegeController.instance:isCanSweep(activityId)

		if not isCanSweep then
			result = GameEnum.ResultCode.Error
		end
	end

	if result == GameEnum.ResultCode.Success then
		local leftTimes = PinGameController.instance:getLeftGameTimesToday(activityId)

		if leftTimes <= 0 or leftTimes < times then
			result = GameEnum.ResultCode.Error
			tips = "次数不足"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

return PinGameLevelView
