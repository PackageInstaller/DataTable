-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungchampionkingsupportView.lua

module("logic.extensions.youngchampionking.view.YoungchampionkingsupportView", package.seeall)

local YoungchampionkingsupportView = class("YoungchampionkingsupportView", ViewComponent)

YoungchampionkingsupportView.Type = {
	Left = 1,
	Right = 2
}

function YoungchampionkingsupportView:ctor()
	YoungchampionkingsupportView.super.ctor(self)
end

function YoungchampionkingsupportView:unbindEvents()
	YoungchampionkingsupportView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnMinus:RemoveClickListener()
	self._btnMax:RemoveClickListener()
	self._btnMin:RemoveClickListener()
	self._input:RemoveOnValueChanged()

	for k, v in pairs(self._parts) do
		v.btn:RemoveClickListener()
	end
end

function YoungchampionkingsupportView:bindEvents()
	YoungchampionkingsupportView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnAdd:AddClickListener(self._onClickbtnAdd, self)
	self._btnMinus:AddClickListener(self._onClickbtnMinus, self)
	self._btnMax:AddClickListener(self._onClickbtnMax, self)
	self._btnMin:AddClickListener(self._onClickbtnMin, self)
	self._input:AddOnValueChanged(self._buyCountChanged, self)

	for k, v in pairs(self._parts) do
		v.btn:AddClickListener(function()
			self:_onClickPart(v.posType)
		end)
	end
end

function YoungchampionkingsupportView:buildUI()
	YoungchampionkingsupportView.super.buildUI(self)

	self._txtSupportLimit = self:getTxt("txtSupportLimit")
	self._txtNum = self:getTxt("bgNum/txtNum")
	self._btnSure = self:getBtn("btnSure")
	self._btnClose = self:getBtn("btnClose")
	self._btnAdd = self:getBtn("bgNum/btnAdd")
	self._btnMinus = self:getBtn("bgNum/btnMinus")
	self._btnMax = self:getBtn("bgNum/btnMax")
	self._btnMin = self:getBtn("bgNum/btnMin")
	self._input = self:getInput("bgNum")
	self._txtFinishGo = self:getGo("txtFinish")
	self._txtTips = self:getTxt("txtTips")
	self._bgNumGo = self:getGo("bgNum")

	self:_buildParts()
end

function YoungchampionkingsupportView:_buildParts()
	local left = self:getGo("left")
	local right = self:getGo("right")

	self._parts = {}

	self:_buildPart(left, YoungchampionkingsupportView.Type.Left)
	self:_buildPart(right, YoungchampionkingsupportView.Type.Right)
end

function YoungchampionkingsupportView:_buildPart(root, posType)
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

function YoungchampionkingsupportView:onExit()
	YoungchampionkingsupportView.super.onExit(self)
end

function YoungchampionkingsupportView:onEnter()
	YoungchampionkingsupportView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._groupInfo = params[2]
	self._roundId = params[3]
	self._groupId = params[4]

	if not self._groupInfo then
		self:close()

		return
	end

	local roundCfg = YoungChampionKingConfig.instance:getRoundCfg(self._activityId, self._groupInfo.roundId)

	if not roundCfg or roundCfg.gussPlanId <= 0 then
		FloatWordMgr.instance:show("暂无应援方案")
		self:close()

		return
	end

	local guessCfg = YoungChampionKingConfig.instance:getGuessCfg(roundCfg.gussPlanId)
	local actCfg = YoungChampionKingConfig.instance:getActCfg(self._activityId)

	self._limitMax = roundCfg.guessLimit
	self._maxOneTime = guessCfg.maxGuessScore

	local info = YoungChampionKingModel.instance:getKnockoutScheduleInfo(self._activityId, self._roundId, self._groupId)

	self._roundGuessCount = checknumber(info.roundGuessCount)
	self._maxCount = math.min(self._limitMax - self._roundGuessCount, self._maxOneTime)
	self._minCount = 1
	self._hasCount = MaterialMgr.getMatCount(actCfg.guessItem)
	self._supportCount = self._minCount
	self._guessPlayerId = checknumber(self._groupInfo.guessPlayerId)
	self._guessCount = checknumber(self._groupInfo.guessCount)
	self._targetPlayerId = self._guessPlayerId
	self._txtTips.text = string.format("应援选手胜利，以%s倍返还应援棒；应援选手失败，扣除%s%%应援棒；同时只能应援一位选手", guessCfg.sucReturnRatio, guessCfg.failReturnRatio * 100)

	self:_refreshBuyCount()
	self:_updateUI()
end

function YoungchampionkingsupportView:_onClickbtnClose()
	self:close()
end

function YoungchampionkingsupportView:_onClickbtnSure()
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
		YoungChampionKingController.instance:sendPM_YCKGuessReq(self._activityId, self._targetPlayerId, self._supportCount, self._groupId, self._roundId, self._groupInfo.index)
		self:close()
	end)
end

function YoungchampionkingsupportView:_onClickbtnAdd()
	self._supportCount = self._supportCount + 1

	self:_refreshBuyCount()
end

function YoungchampionkingsupportView:_onClickbtnMinus()
	self._supportCount = self._supportCount - 1

	self:_refreshBuyCount()
end

function YoungchampionkingsupportView:_onClickbtnMax()
	self._supportCount = math.min(self._maxCount, self._hasCount)

	self:_refreshBuyCount()
end

function YoungchampionkingsupportView:_onClickbtnMin()
	self._supportCount = self._minCount

	self:_refreshBuyCount()
end

function YoungchampionkingsupportView:_refreshBuyCount()
	goutil.setActive(self._bgNumGo, self._roundGuessCount < self._limitMax)
	goutil.setActive(self._txtFinishGo, self._roundGuessCount >= self._limitMax)

	local str = tostring(self._supportCount)

	self._input:SetText(str)

	local curCount = self._roundGuessCount + self._supportCount

	curCount = math.min(curCount, self._limitMax)
	self._txtSupportLimit.text = string.format("%s/%s", curCount, self._limitMax)
end

function YoungchampionkingsupportView:_buyCountChanged()
	self._supportCount = checknumber(self._input:GetText())

	local maxCount = math.min(self._maxCount, self._hasCount)

	self._supportCount = math.min(self._supportCount, maxCount)
	self._supportCount = math.max(self._supportCount, self._minCount)

	self:_refreshBuyCount()
end

function YoungchampionkingsupportView:_updateUI()
	self._partInfos = {
		[YoungchampionkingsupportView.Type.Left] = self._groupInfo.playerA,
		[YoungchampionkingsupportView.Type.Right] = self._groupInfo.playerB
	}

	if self._targetPlayerId == 0 then
		self._targetPlayerId = checknumber(self._groupInfo.playerA.headInfo.headInfo.userId)
	end

	self:_updatePrartsInfo()
end

function YoungchampionkingsupportView:_updatePrartsInfo()
	for k, posType in pairs(YoungchampionkingsupportView.Type) do
		self:_updatePartInfo(posType)
	end
end

function YoungchampionkingsupportView:_updatePartInfo(posType)
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

function YoungchampionkingsupportView:_onClickPart(posType)
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

return YoungchampionkingsupportView
