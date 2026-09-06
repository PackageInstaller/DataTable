-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fanruilottery/view/FanRuiLotterySettingView.lua

module("logic.extensions.fanruilottery.view.FanRuiLotterySettingView", package.seeall)

local FanRuiLotterySettingView = class("FanRuiLotterySettingView", ViewComponent)

function FanRuiLotterySettingView:ctor()
	FanRuiLotterySettingView.super.ctor(self)
end

function FanRuiLotterySettingView:buildUI()
	FanRuiLotterySettingView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnStart = self:getGo("btnStart")
	self._btnAdd = self:getGo("adjust/BtnAdd")
	self._btnReduce = self:getGo("adjust/BtnReduce")
	self._btnCheat = self:getGo("btnCheat")
	self._costCon = self:getGo("cost/con")
	self._txtCostName = self:getTxt("cost/txtName")
	self._txtCostHave = self:getTxt("cost/txtHave")
	self._txtGameTip = self:getTxt("txtGameTip")
	self._txtCostUse = self:getTxt("inputNum/Text")
	self._cheatCon = self:getGo("item/con")
	self._txtCheatName = self:getTxt("item/txtName")
	self._txtCheatHave = self:getTxt("item/txtHave")
	self._txtCheattTip = self:getTxt("label")
	self._selectCheatGo = self:getGo("btnCheat/Background/Checkmark")
	self._txtAdd = self:getTxt("adjust/BtnAdd/Txt")
	self._txtReduce = self:getTxt("adjust/BtnReduce/Txt")
end

function FanRuiLotterySettingView:bindEvents()
	FanRuiLotterySettingView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnAdd, self._onClickAdd, self)
	GameUtil.addClickHandler(self._btnReduce, self._onClickReduce, self)
	GameUtil.addClickHandler(self._btnCheat, self._onClickCheat, self)
end

function FanRuiLotterySettingView:unbindEvents()
	FanRuiLotterySettingView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnReduce)
	GameUtil.rmClickHandler(self._btnCheat)
end

function FanRuiLotterySettingView:onEnter()
	FanRuiLotterySettingView.super.onEnter(self)

	self._actId = self:getFirstParam()
	self._gameCfg = FanRuiLotteryConfig.instance:getGameCfg(self._actId)

	self:initView()
end

function FanRuiLotterySettingView:onExit()
	FanRuiLotterySettingView.super.onExit(self)
	MaterialMgr.resetAll(self._costCon)
	MaterialMgr.resetAll(self._cheatCon)
end

function FanRuiLotterySettingView:initView()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._gameCfg.cheatCost)
	local matName = MaterialMgr.getMaterialsName(matType, matId)

	self._txtCheattTip.text = langPara("勾选后，本局将使用%d个%s,预测对手的每次出招", matNum, matName)
	self._txtCheatName.text = langPara("%s", matName)
	self._txtCheatHave.text = langPara("已拥有：<color=#0d8d36FF>%d</color>个", MaterialModel.instance:getMaterialsNumber(matType, matId))
	self._useCheat = false

	GameUtil.SetActive(self._selectCheatGo, self._useCheat)
	MaterialMgr.setCellByCfg(self._gameCfg.cheatCost, self._cheatCon)

	self._costMatType, self._costMatId = MaterialMgr.getMatParams(self._gameCfg.chipItem)
	self._costMatName = MaterialMgr.getMaterialsName(self._costMatType, self._costMatId)
	self._costMatHave = MaterialModel.instance:getMaterialsNumber(self._costMatType, self._costMatId)
	self._txtCostName.text = langPara("%s", self._costMatName)
	self._txtCostHave.text = langPara("已拥有：<color=#0d8d36FF>%d</color>个", self._costMatHave)
	self._useCost = self._gameCfg.lowerLimit or 0
	self._txtCostUse.text = self._useCost
	self._txtGameTip.text = langPara("注意：若博弈成功返还<color=#0d8d36FF>%d</color>%s，若失败返还<color=#0d8d36FF>%d</color>%s", self._useCost * self._gameCfg.winRate, self._costMatName, self._useCost * self._gameCfg.loseRate, self._costMatName)

	MaterialMgr.setCellByCfg(self._gameCfg.chipItem, self._costCon)

	self._txtAdd.text = langPara("+%d", self._gameCfg.chengeChip)
	self._txtReduce.text = langPara("-%d", self._gameCfg.chengeChip)
end

function FanRuiLotterySettingView:refreshView()
	GameUtil.SetActive(self._selectCheatGo, self._useCheat)

	self._txtCostUse.text = self._useCost
	self._txtGameTip.text = langPara("注意：若博弈成功返还<color=#0d8d36FF>%d</color>%s，若失败返还<color=#0d8d36FF>%d</color>%s", self._useCost * self._gameCfg.winRate, self._costMatName, self._useCost * self._gameCfg.loseRate, self._costMatName)
end

function FanRuiLotterySettingView:_onClickStart()
	if self._costMatHave >= self._useCost then
		UIStateManager.instance:push(ViewName.FanRuiLotteryGameView, self._actId, self._useCost, self._useCheat)
		self:close()
	else
		FloatWordMgr.instance:show(langPara("道具不足%d，无法参与博弈~", self._gameCfg.lowerLimit))
	end
end

function FanRuiLotterySettingView:_onClickAdd()
	if self._costMatHave >= self._useCost + self._gameCfg.chengeChip and self._useCost + self._gameCfg.chengeChip <= self._gameCfg.highLimit then
		self._useCost = self._useCost + self._gameCfg.chengeChip
	else
		FloatWordMgr.instance:show(lang("已达上限，无法放入更多~"))
	end

	self:refreshView()
end

function FanRuiLotterySettingView:_onClickReduce()
	if self._useCost - self._gameCfg.chengeChip >= self._gameCfg.lowerLimit then
		self._useCost = self._useCost - self._gameCfg.chengeChip
	end

	self:refreshView()
end

function FanRuiLotterySettingView:_onClickCheat()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._gameCfg.cheatCost)

	if MaterialModel.instance:IsEnough(matType, matId, matNum) then
		self._useCheat = not self._useCheat

		self:refreshView()
	else
		FloatWordMgr.instance:show(lang("道具不足，本局无法使用"))
	end
end

return FanRuiLotterySettingView
