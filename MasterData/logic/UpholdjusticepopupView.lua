-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/upholdjustice/view/UpholdjusticepopupView.lua

module("logic.extensions.upholdjustice.view.UpholdjusticepopupView", package.seeall)

local UpholdjusticepopupView = class("UpholdjusticepopupView", ViewComponent)

function UpholdjusticepopupView:ctor()
	UpholdjusticepopupView.super.ctor(self)
end

function UpholdjusticepopupView:unbindEvents()
	UpholdjusticepopupView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._BtnAdd)
	GameUtil.rmClickHandler(self._BtnMinus)
	GameUtil.rmClickHandler(self._BtnBig)
	GameUtil.rmClickHandler(self._BtnSmall)
	self._input:RemoveOnValueChanged()
end

function UpholdjusticepopupView:bindEvents()
	UpholdjusticepopupView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._BtnAdd, self._onClickAdd, self)
	GameUtil.addClickHandler(self._BtnMinus, self._onClickMinus, self)
	GameUtil.addClickHandler(self._BtnBig, self._onClickBig, self)
	GameUtil.addClickHandler(self._BtnSmall, self._onClickSmall, self)
	self._input:AddOnValueChanged(self._onInputChange, self)
end

function UpholdjusticepopupView:buildUI()
	UpholdjusticepopupView.super.buildUI(self)

	self._goldBar = self:getGo("goldBar")
	self._txtDesc1 = self:getTxt("txtDesc1")
	self._txtDesc2 = self:getTxt("txtDesc2")
	self._txtNum = self:getTxt("BgNum/txtNum")
	self._BtnAdd = self:getGo("BgNum/BtnAdd")
	self._BtnMinus = self:getGo("BgNum/BtnMinus")
	self._BtnBig = self:getGo("BgNum/BtnBig")
	self._BtnSmall = self:getGo("BgNum/BtnSmall")
	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._input = self:getInput("BgNum")
end

function UpholdjusticepopupView:onExit()
	UpholdjusticepopupView.super.onExit(self)
end

function UpholdjusticepopupView:onEnter()
	UpholdjusticepopupView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._type = checknumber(params[2])
	self._todayNum = checknumber(params[3])
	self._dailyLimit = checknumber(params[4])
	self._activityNum = checknumber(params[5])
	self._activityLimit = checknumber(params[6])
	self._buyCount = 0

	self:_refreshUI()

	local btnList = {
		{
			showAdd = true,
			id = GameEnum.GoldType.Tili
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, btnList)
end

function UpholdjusticepopupView:_refreshUI()
	local cfg = UpholdJusticConfig.instance:getTypeCfgByIdAndType(self._activityId, self._type) or {}
	local onceLimit = checknumber(cfg.onceLimit)
	local minMax1 = self._dailyLimit - self._todayNum
	local minMax2 = self._activityLimit - self._activityNum
	local minMax = math.min(onceLimit, minMax1)

	minMax = math.min(minMax, minMax2)
	self._minMax = minMax

	if self._type == 1 then
		self._txtDesc1.text = langPara("今日可捐献体力\n<color=#20b376>%s/%s</color>", self._dailyLimit - self._todayNum, self._dailyLimit)
		self._txtDesc2.text = langPara("活动捐赠上限\n<color=#20b376>%s/%s</color>", self._activityLimit - self._activityNum, self._activityLimit)
	elseif self._type == 2 then
		self._txtDesc1.text = langPara("今日可领取体力\n<color=#20b376>%s/%s</color>", self._dailyLimit - self._todayNum, self._dailyLimit)
		self._txtDesc2.text = langPara("活动领取上限\n<color=#20b376>%s/%s</color>", self._activityLimit - self._activityNum, self._activityLimit)
	end

	self._buyCount = math.min(minMax, self._buyCount)
	self._buyCount = math.max(0, self._buyCount)

	if self._buyCount == minMax then
		TipsFacade.instance:openCommonTips("已达上限")
	end

	self._input:SetText(self._buyCount)
end

function UpholdjusticepopupView:_onClickSure()
	if self._buyCount > 0 then
		UpholdJusticeController.instance:sendDonateOrGain(self._activityId, self._type, self._buyCount)
		self:close()
	end
end

function UpholdjusticepopupView:_onClickAdd()
	self._buyCount = self._buyCount + 1

	self:_refreshUI()
end

function UpholdjusticepopupView:_onClickMinus()
	self._buyCount = self._buyCount - 1

	self:_refreshUI()
end

function UpholdjusticepopupView:_onClickBig()
	self._buyCount = self._minMax

	self:_refreshUI()
end

function UpholdjusticepopupView:_onClickSmall()
	self._buyCount = 0

	self:_refreshUI()
end

function UpholdjusticepopupView:_onInputChange()
	self._buyCount = checknumber(self._input:GetText())
end

return UpholdjusticepopupView
