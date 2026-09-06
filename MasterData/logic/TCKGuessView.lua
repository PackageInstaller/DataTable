-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKGuessView.lua

module("logic.extensions.teenchampionking.view.TCKGuessView", package.seeall)

local TCKGuessView = class("TCKGuessView", ViewComponent)

TCKGuessView.Type = {
	Left = 1,
	Right = 2
}

function TCKGuessView:ctor()
	TCKGuessView.super.ctor(self)
end

function TCKGuessView:unbindEvents()
	TCKGuessView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnMinus)
	GameUtil.rmClickHandler(self._btnMax)
	GameUtil.rmClickHandler(self._btnMin)

	for k, v in pairs(self._parts) do
		GameUtil.rmClickHandler(v.btn)
	end

	self._input:RemoveOnValueChanged()
end

function TCKGuessView:bindEvents()
	TCKGuessView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickbtnSure, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickbtnClose, self)
	GameUtil.addClickHandler(self._btnAdd, self._onClickbtnAdd, self)
	GameUtil.addClickHandler(self._btnMinus, self._onClickbtnMinus, self)
	GameUtil.addClickHandler(self._btnMax, self._onClickbtnMax, self)
	GameUtil.addClickHandler(self._btnMin, self._onClickbtnMin, self)
	self._input:AddOnValueChanged(self._buyCountChanged, self)

	for k, v in pairs(self._parts) do
		GameUtil.addClickHandler(v.btn, GameUtil.handler(self._onClickPart, self, v.posType))
	end
end

function TCKGuessView:buildUI()
	TCKGuessView.super.buildUI(self)

	self._txtSupportLimit = self:getTxt("txtSupportLimit")
	self._txtNum = self:getTxt("bgNum/txtNum")
	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._btnAdd = self:getGo("bgNum/btnAdd")
	self._btnMinus = self:getGo("bgNum/btnMinus")
	self._btnMax = self:getGo("bgNum/btnMax")
	self._btnMin = self:getGo("bgNum/btnMin")
	self._input = self:getInput("bgNum")
	self._txtFinishGo = self:getGo("txtFinish")
	self._txtFinish = self:getTxt("txtFinish/txtFinish")
	self._txtTips = self:getTxt("txtTips")
	self._bgNumGo = self:getGo("bgNum")

	self:_buildParts()
end

function TCKGuessView:_buildParts()
	local left = self:getGo("left")
	local right = self:getGo("right")

	self._parts = {}

	self:_buildPart(left, TCKGuessView.Type.Left)
	self:_buildPart(right, TCKGuessView.Type.Right)
end

function TCKGuessView:_buildPart(root, posType)
	self._parts[posType] = {
		btn = Framework.ButtonAdapter.GetFrom(root, "btn"),
		goHead = goutil.findChild(root, "head"),
		goSelect = goutil.findChild(root, "select"),
		goGuess = goutil.findChild(root, "guess"),
		txtName = goutil.findChildTextComponent(root, "txtName"),
		txtPower = goutil.findChildTextComponent(root, "txtPower"),
		txtZone = goutil.findChildTextComponent(root, "txtZone"),
		txtRank = goutil.findChildTextComponent(root, "txtRank"),
		txtUp = goutil.findChildTextComponent(root, "txtUp"),
		txtWin = goutil.findChildTextComponent(root, "txtWin"),
		goSupport = goutil.findChild(root, "support"),
		txtSupport = goutil.findChildTextComponent(root, "support/txtSupport"),
		goSupportAdd = goutil.findChild(root, "supportAdd"),
		txtSupportAdd = goutil.findChildTextComponent(root, "supportAdd/txtSupportAdd"),
		posType = posType
	}
end

function TCKGuessView:onExit()
	TCKGuessView.super.onExit(self)

	for k, posType in pairs(TCKGuessView.Type) do
		local item = self._parts[posType]

		HeadItemController.instance:resetHeadCell(item.goHead)
	end
end

function TCKGuessView:onEnter()
	TCKGuessView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_TCKStepChange, self._onStepChange, self)

	local params = self:getOpenParam()

	self._activityId = params and params[1]
	self._roundId = params and params[2]
	self._viewGroupId = params and params[3]
	self._matchInfo = params and params[4]

	local info = TeenChampionKingModel.instance:getKnockoutScheduleInfo(self._activityId, self._viewGroupId, self._roundId)

	if not self._matchInfo or not info then
		self:close()

		return
	end

	local roundCfg = TeenChampionKingConfig.instance:getRoundCfgByRoundId(self._activityId, self._matchInfo.roundId)

	if not roundCfg or roundCfg.gussPlanId <= 0 then
		FloatWordMgr.instance:show("暂无应援方案")
		self:close()

		return
	end

	local guessCfg = TeenChampionKingConfig.instance:getGuessCfg(roundCfg.gussPlanId)
	local actCfg = TeenChampionKingConfig.instance:getActCfg(self._activityId)

	self._limitMax = roundCfg.guessLimit
	self._maxOneTime = guessCfg.maxGuessScore
	self._roundGuessCount = checknumber(info.roundGuessCount)
	self._maxCount = math.min(self._limitMax - self._roundGuessCount, self._maxOneTime)
	self._minCount = 1
	self._hasCount = MaterialMgr.getMatCount(actCfg.guessItem)
	self._supportCount = self._minCount
	self._guessPlayerId = checknumber(self._matchInfo.guessPlayerId)
	self._guessCount = checknumber(self._matchInfo.guessCount)
	self._targetPlayerId = self._guessPlayerId
	self._txtTips.text = string.format("应援选手胜利，以%s倍返还应援棒；应援选手失败，扣除%s%%应援棒；同时只能应援一位选手", guessCfg.sucReturnRatio, guessCfg.failReturnRatio * 100)

	self:_refreshBuyCount()
	self:_updateUI()

	local info = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)

	self._curStepCfg = TeenChampionKingConfig.instance:getStepCfgByStepId(self._activityId, (info or nil) and info.curStepId)
	self._canGuess = false

	if self._curStepCfg then
		if self._curStepCfg.canGuss then
			self._canGuess = true
			self._txtFinish.text = "已达本轮上限"
		else
			self._txtFinish.text = "当前不能应援"

			goutil.setActive(self._bgNumGo, false)
			goutil.setActive(self._txtFinishGo, true)
		end
	end
end

function TCKGuessView:_onClickbtnClose()
	self:close()
end

function TCKGuessView:_onStepChange()
	FloatWordMgr.instance:show("赛程阶段发生变化")
	self:close()
end

function TCKGuessView:_onClickbtnSure()
	if not self._canGuess then
		self:close()

		return
	end

	if self._roundGuessCount >= self._limitMax then
		self:close()

		return
	end

	if self._targetPlayerId <= 0 then
		FloatWordMgr.instance:show("请选择应援对象")

		return
	end

	local userName = self._targetPlayer.userName
	local text = string.format("是否消耗%s应援棒对%s进行应援?", self._supportCount, userName)

	TipsFacade.instance:openPopupWindow("提示", text, function()
		TeenChampionKingController.instance:guessKnockout(self._activityId, self._targetPlayerId, self._supportCount)
		self:close()
	end)
end

function TCKGuessView:_onClickbtnAdd()
	self._supportCount = self._supportCount + 1

	self:_refreshBuyCount()
end

function TCKGuessView:_onClickbtnMinus()
	self._supportCount = self._supportCount - 1

	self:_refreshBuyCount()
end

function TCKGuessView:_onClickbtnMax()
	self._supportCount = math.min(self._maxCount, self._hasCount)

	self:_refreshBuyCount()
end

function TCKGuessView:_onClickbtnMin()
	self._supportCount = self._minCount

	self:_refreshBuyCount()
end

function TCKGuessView:_refreshBuyCount()
	goutil.setActive(self._bgNumGo, self._roundGuessCount < self._limitMax)
	goutil.setActive(self._txtFinishGo, self._roundGuessCount >= self._limitMax)

	local str = tostring(self._supportCount)

	self._input:SetText(str)

	local curCount = self._roundGuessCount + self._supportCount

	curCount = math.min(curCount, self._limitMax)
	self._txtSupportLimit.text = string.format("%s/%s", curCount, self._limitMax)
end

function TCKGuessView:_buyCountChanged()
	self._supportCount = checknumber(self._input:GetText())

	local maxCount = math.min(self._maxCount, self._hasCount)

	self._supportCount = math.min(self._supportCount, maxCount)
	self._supportCount = math.max(self._supportCount, self._minCount)

	self:_refreshBuyCount()
end

function TCKGuessView:_updateUI()
	self._partInfos = {
		[TCKGuessView.Type.Left] = self._matchInfo.playerA,
		[TCKGuessView.Type.Right] = self._matchInfo.playerB
	}

	if self._targetPlayerId == 0 then
		self._targetPlayerId = checknumber(self._matchInfo.playerA.headInfo.headInfo.userId)
	end

	self:_updatePrartsInfo()
end

function TCKGuessView:_updatePrartsInfo()
	for k, posType in pairs(TCKGuessView.Type) do
		self:_updatePartInfo(posType)
	end
end

function TCKGuessView:_updatePartInfo(posType)
	local item = self._parts[posType]
	local info = self._partInfos[posType]
	local userId = checknumber(info.headInfo.headInfo.userId)

	item.txtName.text = info.headInfo.headInfo.userName
	item.txtWin.text = string.format("胜利场数：%s", info.winCount)
	item.txtSupport.text = info.totalGuessCount
	item.txtSupportAdd.text = "+" .. self._guessCount
	item.txtUp.text = string.format("出场数：%s", info.fightCount)
	item.txtZone.text = string.format("战区：%s", info.headInfo.zoneId)
	item.txtPower.text = info.zdl
	item.txtRank.text = string.format("积分排名：%s", info.headInfo.zoneRank)

	HeadItemController.instance:setHeadCellByInfo(item.goHead, info.headInfo.headInfo)
	goutil.setActive(item.goSelect, self._targetPlayerId == userId or self._guessPlayerId == userId)
	goutil.setActive(item.goGuess, self._guessPlayerId == userId)

	if self._targetPlayerId == userId then
		self._targetPlayer = info.headInfo.headInfo

		goutil.setActive(item.goSupportAdd, self._guessCount > 0)
	else
		goutil.setActive(item.goSupportAdd, false)
	end
end

function TCKGuessView:_onClickPart(posType)
	if not self._canGuess then
		return
	end

	if self._guessPlayerId > 0 then
		return
	end

	local info = self._partInfos[posType]
	local lastId = self._targetPlayerId

	self._targetPlayerId = checknumber(info.headInfo.headInfo.userId)

	if self._targetPlayerId ~= lastId then
		self:_onClickbtnMin()
	end

	self:_updatePrartsInfo()
end

return TCKGuessView
