-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/view/TongPlayView.lua

module("logic.extensions.tongbattle.view.TongPlayView", package.seeall)

local TongPlayView = class("TongPlayView", ViewComponent)

function TongPlayView:ctor()
	TongPlayView.super.ctor(self)
end

function TongPlayView:bindEvents()
	TongPlayView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._leftBtn:AddClickListener(function()
		self:_onClickleftRightBtn(true)
	end, self)
	self._rightBtn:AddClickListener(function()
		self:_onClickleftRightBtn(false)
	end, self)
end

function TongPlayView:unbindEvents()
	TongPlayView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._leftBtn:RemoveClickListener()
	self._rightBtn:RemoveClickListener()
end

function TongPlayView:onExit()
	TongPlayView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateTongBossInfo, self._updataRoundCount, self)
end

function TongPlayView:destroyUI()
	TongPlayView.super.destroyUI(self)
end

function TongPlayView:buildUI()
	TongPlayView.super.buildUI(self)

	local viewBgGo = self:getGo("viewBgGo")

	self._titleImaR = goutil.findChild(viewBgGo, "titleImaR"):GetComponent("UIImageSpriteChange")
	self._closeBtn = Framework.ButtonAdapter.GetFrom(viewBgGo, "closeBtn")
	self._leftBtn = Framework.ButtonAdapter.GetFrom(viewBgGo, "leftBtn")
	self._rightBtn = Framework.ButtonAdapter.GetFrom(viewBgGo, "rightBtn")
	self._leftTxt = goutil.findChildTextComponent(viewBgGo, "leftBtn/leftTxt")
	self._rightTxt = goutil.findChildTextComponent(viewBgGo, "rightBtn/rightTxt")
	self._leftRoundTxt = goutil.findChildTextComponent(viewBgGo, "leftRoundTxt")
	self._rightRoundTxt = goutil.findChildTextComponent(viewBgGo, "rightRoundTxt")
	self._descTxt = goutil.findChildTextComponent(viewBgGo, "descGo/descTxt")
	self._condTxt = goutil.findChildTextComponent(viewBgGo, "condTxt")
	self._leftTxt.text = ""
	self._rightTxt.text = ""
	self._leftRoundTxt.text = ""
	self._rightRoundTxt.text = ""
	self._descTxt.text = ""
	self._condTxt.text = ""
end

function TongPlayView:onEnter()
	TongPlayView.super.onEnter(self)

	self._paramInfo = self:getFirstParam()

	if self._paramInfo == nil or checknumber(self._paramInfo.chalType) == 0 then
		printError("sr---桶挑战 TongPlayView:onEnter()   传入参数错误！")

		return
	end

	self._challCfg = TongBattleConfig.instance:getBattleBaseCfg(TongBattleModel.instance.challengeId)

	local leftCfg = TongBattleConfig.instance:getMasterTeamCfg(self._paramInfo.planId, self._paramInfo.chalType, 1)
	local rightCfg = TongBattleConfig.instance:getMasterTeamCfg(self._paramInfo.planId, self._paramInfo.chalType, 2)

	if leftCfg == nil or rightCfg == nil then
		print("sr---桶挑战 TongPlayView:onEnter()   获取的挑战配置空 = ", self._paramInfo.planId, self._paramInfo.chalType)

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.UpdateTongBossInfo, self._updataRoundCount, self)
	self._titleImaR:SetState(self._paramInfo.chalType - 3)

	local names = string.split(leftCfg.name, "·")

	if names then
		self._leftTxt.text = names[2] or "火"
	end

	names = string.split(rightCfg.name, "·")

	if names then
		self._rightTxt.text = names[2] or "暗"
	end

	self._descTxt.text = leftCfg.popExplanation
	self._condTxt.text = leftCfg.popCondition

	self:_updataRoundCount()
	TongBattleController.instance:csGetTongBossInfoReq(self._paramInfo.chalType == 3)
end

function TongPlayView:_updataRoundCount()
	local battleInfo = TongBattleModel.instance:getTongBattleInfo()

	if self._paramInfo.chalType == 3 then
		self._leftRoundTxt.text = battleInfo.demonRounds[1] .. lang("text_round_name")
		self._rightRoundTxt.text = battleInfo.demonRounds[2] .. lang("text_round_name")
	else
		self._leftRoundTxt.text = battleInfo.demonRounds[3] .. lang("text_round_name")
		self._rightRoundTxt.text = battleInfo.demonRounds[4] .. lang("text_round_name")
	end
end

function TongPlayView:_onClickleftRightBtn(isLeft)
	if not TLChallengeController.instance:isInOpenTime(TongBattleModel.instance.challengeId) then
		FloatWordMgr.instance:show(lang("text_tong_desc_12"))
		self:close()

		return
	end

	local baseInfo = TongBattleModel.instance:getTongBaseInfo()

	if self._challCfg.freeChallengeTimes + baseInfo.buyCount <= baseInfo.useCount then
		self:_onClickDayAddBtn(baseInfo.buyCount)

		return
	end

	local params = {
		stageId = 1,
		planId = self._paramInfo.planId,
		chalType = self._paramInfo.chalType
	}

	if not isLeft then
		params.stageId = 2
	end

	UIStateManager.instance:push(ViewName.TongMission, params)
	self:close()
end

function TongPlayView:_onClickDayAddBtn(buyCount)
	local list, allNum = TongBattleModel.instance:getBuyCountConsume(self._challCfg.buyTimePlanId, buyCount + 1)

	if list == nil or checknumber(allNum) <= 0 then
		FloatWordMgr.instance:show(lang("text_tong_desc_17"))

		return
	end

	if allNum <= buyCount then
		TipsFacade.instance:openTipWindow(lang("text_tong_tips"), lang("text_tong_desc_18"), nil, lang("text_tong_know"), UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	local function callback()
		TongBattleController.instance:csGetTongBuyTimesReq()
	end

	local matName = MaterialMgr.getMaterialsName(tonumber(list[1]), tonumber(list[2]))
	local content = langPara("text_tong_desc_19", list[3], matName, allNum, allNum - buyCount)

	if tonumber(list[1]) == MatType.Diamond or tonumber(list[1]) == MatType.Diamond_Consume then
		TipsFacade.instance:openPopupCostDiamondView(tonumber(list[3]), content, callback)
	elseif tonumber(list[1]) == MatType.Coin then
		TipsFacade.instance:openPopupCostCoinView(tonumber(list[3]), content, callback)
	else
		TipsFacade.instance:openPopupWindow(lang("text_buy_tips"), content, callback, nil, lang("text_lottery_buy"), lang("mail_cancel"), UnityEngine.TextAnchor.MiddleCenter)
	end
end

return TongPlayView
