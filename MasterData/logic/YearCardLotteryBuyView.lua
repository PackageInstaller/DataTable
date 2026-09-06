-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardlottery/view/YearCardLotteryBuyView.lua

module("logic.extensions.yearcardlottery.view.YearCardLotteryBuyView", package.seeall)

local YearCardLotteryBuyView = class("YearCardLotteryBuyView", ViewComponent)

function YearCardLotteryBuyView:buildUI()
	YearCardLotteryBuyView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnAdd = self:getBtn("content/inputNum/BtnAdd")
	self._btnAdd10 = self:getBtn("content/inputNum/BtnAddTen")
	self._btnMinus = self:getBtn("content/inputNum/BtnMinus")
	self._btnMinus10 = self:getBtn("content/inputNum/BtnMinusTen")
	self._btnBuy = self:getBtn("content/BtnBuy")
	self._inputNum = self:getInput("content/inputNum")
	self._itemCell = self:getGo("content/Icon/ItemCell")
	self._itemCost = self:getGo("content/cost/item")
	self._txtCost = self:getTxt("content/cost/txt")
	self._txtName = self:getTxt("content/txtName")
	self._txtHave = self:getTxt("content/txtHave")
	self._txtDesc = self:getTxt("content/txtDesc")
	self._txtLimit = self:getTxt("content/txtLimit")
end

function YearCardLotteryBuyView:onEnter()
	YearCardLotteryBuyView.super.onEnter(self)

	self._actId = YearCardModel.instance:getCurAnnuityId()
	self._curCfg = YearCardLotteryConfig.instance:getCommonCfg(self._actId)

	if self._curCfg then
		self:_setViewByCfg()
		YearCardLotteryController.instance:sendGetInfoReq(self._actId)
	else
		printError("当前活动配置为空")
	end

	GlobalDispatcher:addListener(GlobalNotify.YearCardLotteryInfoUpdate, self._refreshView, self)
end

function YearCardLotteryBuyView:onExit()
	YearCardLotteryBuyView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.YearCardLotteryInfoUpdate, self._refreshView, self)
	MaterialMgr.resetAll(self._itemCell)
	MaterialMgr.clearIcon(self._itemCost)
end

function YearCardLotteryBuyView:bindEvents()
	YearCardLotteryBuyView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)
	self._btnAdd10:AddClickListener(self._onClickAdd10, self)
	self._btnMinus:AddClickListener(self._onClickMinus, self)
	self._btnMinus10:AddClickListener(self._onClickMinus10, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
	self._inputNum:AddOnValueChanged(self._onInputValueChanged, self)
end

function YearCardLotteryBuyView:unbindEvents()
	YearCardLotteryBuyView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnAdd10:RemoveClickListener()
	self._btnMinus:RemoveClickListener()
	self._btnMinus10:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._inputNum:RemoveOnValueChanged()
end

function YearCardLotteryBuyView:_setViewByCfg()
	self._costMat = self._curCfg.buyCost

	local costType, costId, costNum = MaterialMgr.getMatParams(self._costMat)

	self._costNum = costNum

	MaterialMgr.setIcon(self._itemCost, costType, costId)

	self._itemMat = self._curCfg.lotteryItem

	local proxy = MaterialMgr.setCellByCfg(self._itemMat, self._itemCell)

	proxy:setAutoTips(false)

	self._itemCfg = MaterialMgr.getMatCfgByStr(self._itemMat)
	self._txtName.text = lang(self._itemCfg.name)
	self._txtDesc.text = lang(self._itemCfg.desc)
end

function YearCardLotteryBuyView:_refreshView()
	self._txtHave.text = langPara("拥有： %s", MaterialMgr.getMatCount(self._itemMat))

	local buyNum = YearCardLotteryModel.instance:getBuyNum(self._actId)

	self._txtLimit.text = langPara("限售： %s/%s", buyNum, self._curCfg.buyLimit)

	self:_refreshBuyCount(1)
end

function YearCardLotteryBuyView:_onClickAdd()
	self:_refreshBuyCount(self._curCount + 1)
end

function YearCardLotteryBuyView:_onClickAdd10()
	self:_refreshBuyCount(self._curCount + 10)
end

function YearCardLotteryBuyView:_onClickMinus()
	self:_refreshBuyCount(self._curCount - 1)
end

function YearCardLotteryBuyView:_onClickMinus10()
	self:_refreshBuyCount(self._curCount - 10)
end

function YearCardLotteryBuyView:_onInputValueChanged()
	self:_refreshBuyCount(checknumber(self._inputNum:GetText()))
end

function YearCardLotteryBuyView:_refreshBuyCount(count)
	local buyNum = YearCardLotteryModel.instance:getBuyNum(self._actId)

	self._curCount = count
	self._curCount = math.max(self._curCount, 1)
	self._curCount = math.min(self._curCount, self._curCfg.buyLimit - buyNum)

	local totalCost = self._costNum * self._curCount

	self._txtCost.text = totalCost
	self._isCostMatEnough = totalCost <= MaterialMgr.getMatCount(self._costMat)

	if not self._isCostMatEnough then
		self._txtCost.text = langPara("<color=red>%s</color>", totalCost)
	end

	local str = tostring(self._curCount)

	self._inputNum:SetText(str)
end

function YearCardLotteryBuyView:_onClickBuy()
	if self._curCount == 0 then
		FloatWordMgr.instance:show(lang("购买数量不可为0"))

		return
	end

	if not self._isCostMatEnough then
		FloatWordMgr.instance:show(langPara("当前%s不足", MaterialMgr.getMaterialsNameByCfg(self._costMat)))
		TipsFacade.instance:openItemSourceView(self._costMat)

		return
	end

	self:close()
	YearCardLotteryController.instance:sendBuyReq(self._actId, self._curCount)
end

return YearCardLotteryBuyView
