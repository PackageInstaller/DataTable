-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mirrortrial/view/MirrortrialbuyscoreView.lua

module("logic.extensions.mirrortrial.view.MirrortrialbuyscoreView", package.seeall)

local MirrortrialbuyscoreView = class("MirrortrialbuyscoreView", ViewComponent)

function MirrortrialbuyscoreView:ctor()
	MirrortrialbuyscoreView.super.ctor(self)
end

function MirrortrialbuyscoreView:buildUI()
	MirrortrialbuyscoreView.super.buildUI(self)

	self._closeBtn = self:getBtn("BG/Close")
	self._m10Btn = self:getBtn("Tip/Marks/BtnM10")
	self._minusBtn = self:getBtn("Tip/Marks/BtnMs")
	self._addBtn = self:getBtn("Tip/Marks/BtnAdd")
	self._a10Btn = self:getBtn("Tip/Marks/BtnA10")
	self._procNumText = self:getInput("Tip/IptItem")
	self._agreeBtn = self:getBtn("Tip/BtnAgree")
	self._cancelBtn = self:getBtn("Tip/BtnCancel")
	self._buyText = goutil.findChildTextComponent(self.mainGO, "Tip/TxtBuy")
end

function MirrortrialbuyscoreView:bindEvents()
	MirrortrialbuyscoreView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._m10Btn:AddClickListener(function()
		self:_changeNumText(-10)
	end)
	self._minusBtn:AddClickListener(function()
		self:_changeNumText(-1)
	end)
	self._addBtn:AddClickListener(function()
		self:_changeNumText(1)
	end)
	self._a10Btn:AddClickListener(function()
		self:_changeNumText(10)
	end)
	self._procNumText:AddOnValueChanged(self._onValueChanged, self)
	self._agreeBtn:AddClickListener(self._onClickAgree, self)
	self._cancelBtn:AddClickListener(self.close, self)
end

function MirrortrialbuyscoreView:unbindEvents()
	MirrortrialbuyscoreView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._m10Btn:RemoveClickListener()
	self._minusBtn:RemoveClickListener()
	self._addBtn:RemoveClickListener()
	self._a10Btn:RemoveClickListener()
	self._procNumText:RemoveOnValueChanged()
	self._agreeBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
end

function MirrortrialbuyscoreView:destroyUI()
	MirrortrialbuyscoreView.super.destroyUI(self)
end

function MirrortrialbuyscoreView:onEnter()
	MirrortrialbuyscoreView.super.onEnter(self)

	self._lastNum = -1
	self._params = self:getOpenParam()
	self._curActBaseCfg = self._params[1]
	self._totalScore = self._params[2]
	self._isAbleToBuy, self._leftTimes = MirrorTrialModel.instance:getIsAbleToBuyScoreParms()
	self._maxScore = MirrorTrialModel.instance:getCurMaxScore()

	if self._isAbleToBuy then
		self._costMatType, self._costId, self._costNum = MaterialMgr.getMatParams(self._curActBaseCfg.buyScoreCost)
		self._getNum = self._curActBaseCfg.buyScoreAdd
		self._ableToBuyTime = math.ceil((self._maxScore - self._totalScore) / self._getNum)
		self._numMax = math.min(self._leftTimes, self._ableToBuyTime)

		self:_chargeNum(1)
	else
		self:close()
		TipsFacade.instance:openCommonTips("当前不可购买积分")
	end
end

function MirrortrialbuyscoreView:onEnterFinished()
	MirrortrialbuyscoreView.super.onEnterFinished(self)
end

function MirrortrialbuyscoreView:onExit()
	MirrortrialbuyscoreView.super.onExit(self)
end

function MirrortrialbuyscoreView:onExitFinished()
	MirrortrialbuyscoreView.super.onExitFinished(self)
end

function MirrortrialbuyscoreView:_changeNumText(delta)
	local num = checkint(self._lastNum) + delta

	self:_chargeNum(num)
end

function MirrortrialbuyscoreView:_onValueChanged(strNum)
	local num = checkint(strNum)

	self:_chargeNum(num)
end

function MirrortrialbuyscoreView:_chargeNum(inputNum)
	local newNum = checkint(inputNum)

	if self._lastNum ~= newNum then
		newNum = Mathf.Clamp(newNum, 1, self._numMax)
		self._lastNum = newNum

		self._procNumText:SetText(tostring(self._lastNum))

		self._buyText.text = langPara("是否花费%s*%s购买%s积分？", MaterialMgr.getMaterialsName(self._costMatType, self._costId), self._lastNum * self._costNum, self._lastNum * self._getNum)
	end
end

function MirrortrialbuyscoreView:_onClickAgree()
	self:close()
	MirrorTrialAgent.instance:sendPM_MirrorTrialBuyScoreReq(self._curActBaseCfg.activityId, self._lastNum)
end

return MirrortrialbuyscoreView
