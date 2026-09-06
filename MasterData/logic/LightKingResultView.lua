-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingResultView.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingResultView", package.seeall)

local LightKingResultView = class("LightKingResultView", TLCBattleResultView)

function LightKingResultView:unbindEvents()
	LightKingResultView.super.unbindEvents(self)
end

function LightKingResultView:bindEvents()
	LightKingResultView.super.bindEvents(self)
end

function LightKingResultView:onExit()
	LightKingResultView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LightKingCheatRes, self._onClickClose, self)
end

function LightKingResultView:buildUI()
	self._txtTitle = self:getTxt("txtTitle")
	self._win = self:getGo("content/top/win")
	self._txtWin = goutil.findChildTextComponent(self._win, "Text")
	self._failureTip = self:getGo("content/top/failureTip")
	self._txtFailTip = MaterialMgr.findGraphicText(self._failureTip, "txtTip")
	self._rewards = self:getGo("content/dowm/rewards")
	self._itemsView = goutil.findChild(self._rewards, "itemsView/Viewport/Content").transform
	self._itemsLayout = goutil.findChildComponent(self._itemsView, "items", typeof(UILayoutMulLines))
	self._txtRewardTip = goutil.findChild(self._rewards, "txtTips")
	self._failure = self:getGo("content/dowm/failure")
	self._btnOk = self:getBtn("btnGroup/btnOk")
	self._btnCancel = self:getBtn("btnGroup/btnCancel")
	self._txtBtnOk = goutil.findChildTextComponent(self._btnOk.gameObject, "Text")
	self._txtBtnCancel = goutil.findChildTextComponent(self._btnCancel.gameObject, "Text")
	self._txtFailureTip = goutil.findChildTextComponent(self._failure, "txt")
end

local failureTipDict = {
	"lightking_shengguang_result_tips",
	"lightking_yaoshi_result_tips",
	"lightking_jixian_result_tips"
}
local isWin, challengeType

function LightKingResultView:onEnter()
	self._cells = {}

	local btlResult = LightKingModel.instance:getBtlResult()

	isWin = btlResult.isWin
	challengeType = btlResult.challengeType
	self._cheatCfg = LightKingConfig.instance:getCheatCfg(challengeType, btlResult.stage)
	self._btlResult = btlResult

	goutil.findChild(self._win, "true"):SetActive(isWin)
	goutil.findChild(self._win, "false"):SetActive(not isWin)

	local stageCfg = LightKingConfig.instance:getStageCfg(challengeType, btlResult.stage)

	self._txtWin.text = stageCfg.WinDesc
	self._txtTitle.text = isWin and "战斗胜利" or "战斗失败"

	if challengeType == GameEnum.LightKingChallengeType.SHENGGUANG then
		self:_updateFirstResult()
	elseif challengeType == GameEnum.LightKingChallengeType.YAOSHI then
		self:_updateSecondResult()
	elseif challengeType == GameEnum.LightKingChallengeType.JIXIAN then
		self:_updateThirdResult()
	end

	local items = LightKingController.instance:getResultItems()
	local hasItems = #items > 0

	self._rewards:SetActive(hasItems)

	if hasItems then
		self:_updateRewards(items)
	end

	self._txtFailureTip.text = lang(failureTipDict[challengeType])
end

function LightKingResultView:_updateFirstResult()
	self._rewards:SetActive(true)
	self._failure:SetActive(false)
	self._txtRewardTip:SetActive(not isWin)
	self._btnCancel.gameObject:SetActive(not isWin)
	self._failureTip:SetActive(not isWin)

	if isWin then
		self._txtBtnOk.text = "领取奖励"

		self._btnOk:AddClickListener(self._onClickReceive, self)
	else
		self._txtBtnOk.text = "重新挑战"
		self._txtBtnCancel.text = "一键通关"

		self._btnOk:AddClickListener(self._onClickReGame, self)
		self._btnCancel:AddClickListener(self._onClickOneKey, self)

		local icon = TipsFacade.instance:getContentMatStr(string.format("%s:%s", MatType.Diamond, 2), 50, -10, true)
		local _, _, matNum = unpack(string.splitToNumber(self._cheatCfg.consume, ":"))

		self._txtFailTip.text = string.format("很遗憾，未能通过本关挑战！\n你可以花费%s<color=#0174DEFF>%d</color>一键通过本关，也可免费重新挑战！", icon, matNum)
	end
end

function LightKingResultView:_updateSecondResult()
	self._failureTip:SetActive(false)
	self._failure:SetActive(not isWin)
	self._rewards:SetActive(isWin)
	self._txtRewardTip:SetActive(false)
	self._btnCancel.gameObject:SetActive(false)

	if isWin then
		self._txtBtnOk.text = "领取奖励"

		self._btnOk:AddClickListener(self._onClickReceive, self)
	else
		self._txtBtnOk.text = "知道了"

		self._btnOk:AddClickListener(self._onClickClose, self)
	end
end

function LightKingResultView:_updateThirdResult()
	self._failureTip:SetActive(false)
	self._failure:SetActive(not isWin)
	self._rewards:SetActive(isWin)
	self._txtRewardTip:SetActive(false)
	self._btnCancel.gameObject:SetActive(false)

	if isWin then
		self._txtBtnOk.text = "领取奖励"

		self._btnOk:AddClickListener(self._onClickReceive, self)
	else
		self._txtBtnOk.text = "知道了"

		self._btnOk:AddClickListener(self._onClickClose, self)
	end
end

function LightKingResultView:_onClickReGame()
	BattleController.instance:endBattle()
end

function LightKingResultView:_onClickReceive()
	BattleController.instance:endBattle()
end

function LightKingResultView:_onClickClose()
	BattleController.instance:endBattle()
end

function LightKingResultView:_onClickOneKey()
	if not MaterialMgr.getMatEnough(self._cheatCfg.consume) then
		FloatWordMgr.instance:show("钻石不足")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.LightKingCheatRes, self._onClickClose, self)
	LightKingController.instance:sendCheatReq(self._btlResult.challengeType, self._btlResult.stage)
end

return LightKingResultView
