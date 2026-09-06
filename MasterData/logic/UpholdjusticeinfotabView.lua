-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/upholdjustice/view/UpholdjusticeinfotabView.lua

module("logic.extensions.upholdjustice.view.UpholdjusticeinfotabView", package.seeall)

local UpholdjusticeinfotabView = class("UpholdjusticeinfotabView", ViewComponent)

function UpholdjusticeinfotabView:ctor()
	UpholdjusticeinfotabView.super.ctor(self)
end

function UpholdjusticeinfotabView:unbindEvents()
	UpholdjusticeinfotabView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGet)
	GameUtil.rmClickHandler(self._btnDonate)
end

function UpholdjusticeinfotabView:bindEvents()
	UpholdjusticeinfotabView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGet, self._onClickGet, self)
	GameUtil.addClickHandler(self._btnDonate, self._onClickDonate, self)
end

function UpholdjusticeinfotabView:buildUI()
	UpholdjusticeinfotabView.super.buildUI(self)

	self._txtZdl = self:getTxt("info/txtZdl")
	self._txtTili = self:getTxt("info/txtTili")
	self._txtDesc = self:getTxt("info/txtDesc")
	self._head = self:getGo("info/head")
	self._btnDonate = self:getGo("right/btnDonate")
	self._btnGet = self:getGo("right/btnGet")
	self._txt1 = self:getTxt("right/imgTag1/txt")
	self._txt2 = self:getTxt("right/imgTag2/txt")
	self._txt3 = self:getTxt("right/imgTag3/txt")
	self._itemCon = self:getGo("right/itemCon")
	self._emptyGo = self:getGo("emptyGo")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function UpholdjusticeinfotabView:onExit()
	UpholdjusticeinfotabView.super.onExit(self)
	self._scrollList:dispose()
	HeadItemController.instance:resetHeadCell(self._head)
	MaterialMgr.resetAll(self._itemCon)
end

function UpholdjusticeinfotabView:onEnter()
	UpholdjusticeinfotabView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 581001
	end

	self.addGEvent(self, GlobalNotify.ON_UPHOLD_JUSTICE_INFO, self._refreshUI, self)
	UpholdJusticeController.instance:sendGetInfo(self._activityId)
	self:_refreshUI()
end

function UpholdjusticeinfotabView:_refreshUI()
	local info = UpholdJusticeModel.instance:getInfo(self._activityId) or {}

	if not info.strengthValueList then
		local strengthValueList = {}

		self._todayActivityValue = checknumber(info.todayActivityValue)

		HeadItemController.instance:setMyHeadCellWithoutVip(self._head)

		local zdl = RoleModel.instance:getMaxPower()

		self._txtZdl.text = zdl

		local hasTili = MaterialModel.instance:getMaterialsNumber(MatType.Strength, 1)

		self._txtTili.text = hasTili

		local cfgs = UpholdJusticConfig.instance:getTypeCfgById(self._activityId) or {}
		local type = 0
		local dailyLimit = 0
		local activityLimit = 0
		local needZdl1 = 0
		local needTili1 = 0
		local needZdl2 = 0
		local needTili2 = 0

		self._activityValueLimit = 0

		for i, v in pairs(cfgs) do
			if v.type == 1 then
				needZdl1 = v.zdlLimit
				needTili1 = v.strengthLimit

				if zdl >= v.zdlLimit and hasTili >= v.strengthLimit then
					type = v.type
					dailyLimit = v.dailyLimit
					activityLimit = v.activityLimit
				end
			elseif v.type == 2 then
				needZdl2 = v.zdlLimit
				needTili2 = v.strengthLimit

				if zdl < v.zdlLimit and hasTili < v.strengthLimit then
					type = v.type
					dailyLimit = v.dailyLimit
					activityLimit = v.activityLimit
					self._activityValueLimit = v.activityValueLimit
				end
			end
		end

		local historyDonateStrength = checknumber(info.historyDonateStrength)
		local leftDonateStrength = checknumber(info.leftDonateStrength)
		local todayNum = 0
		local activityNum = 0

		for i, v in ipairs(strengthValueList) do
			if v.playerType == type then
				todayNum = v.todayNum
				activityNum = v.activityNum

				break
			end
		end

		self._type = type
		self._todayNum, self._dailyLimit, self._activityNum, self._activityLimit = todayNum, dailyLimit, activityNum, activityLimit
		self._txt3.text = langPara("全服累计捐献<color=#30f5a3>%s</color>体力\n当前剩余<color=#30f5a3>%s</color>体力可领取", self:_formatNumber(historyDonateStrength), self:_formatNumber(leftDonateStrength))

		local a = langPara("<color=#eb4642>%s</color>", zdl)
		local b = langPara("<color=#eb4642>%s</color>", hasTili)
		local c = langPara("<color=#eb4642>%s</color>", zdl)
		local d = langPara("<color=#eb4642>%s</color>", hasTili)

		if needTili1 <= hasTili then
			d = langPara("<color=#30f5a3>%s</color>", hasTili)
		end

		self._txt1.text = langPara("领取条件：\n当前战力：\n%s<%s\n持有体力：\n%s<%s", (zdl < needZdl2 or nil) and langPara("<color=#30f5a3>%s</color>", zdl), needZdl2, (hasTili < needTili2 or nil) and langPara("<color=#30f5a3>%s</color>", hasTili), needTili2)
		self._txt2.text = langPara("捐赠条件：\n当前战力：\n%s>%s\n持有体力：\n%s>%s", (needZdl1 <= zdl or nil) and langPara("<color=#30f5a3>%s</color>", zdl), needZdl1 - 1, d, needTili1 - 1)

		if type == 0 then
			self._txtDesc.text = "当前身份为\n<color=#cccccc>初入江湖</color>"
		elseif type == 1 then
			self._txtDesc.text = "当前身份为<color=#cd7800>老江湖</color>\n可捐献体力"
			self._txt2.text = langPara("今日可捐赠体力\n%s/%s\n活动捐赠上限\n%s/%s", dailyLimit - todayNum, dailyLimit, activityLimit - activityNum, activityLimit)
		else
			self._txtDesc.text = "当前身份为<color=#30f5a3>小侠客</color>\n可领取体力"
			self._txt1.text = self._todayActivityValue < self._activityValueLimit and langPara("活跃度达到：<color=#eb4642>%s</color>/%s\n今日可领取体力\n%s/%s\n活动领取上限\n%s/%s", self._todayActivityValue, self._activityValueLimit, dailyLimit - todayNum, dailyLimit, activityLimit - activityNum, activityLimit) or langPara("今日可领取体力\n%s/%s\n活动领取上限\n%s/%s", dailyLimit - todayNum, dailyLimit, activityLimit - activityNum, activityLimit)
		end

		if not info.msgItems then
			local list = {}

			self._scrollList:reloadData(list)
			GameUtil.SetActive(self._emptyGo, #list == 0)
			MaterialMgr.setCellByCfg(GameEnum.GoldType.Tili, self._itemCon)
		end
	end
end

function UpholdjusticeinfotabView:_formatNumber(num)
	if num > 10000 then
		return MmUtil.formatNumber(num, MmUtil.Units_CN)
	end

	return num
end

function UpholdjusticeinfotabView:_updateCell(view, cell, data, tag)
	local head = goutil.findChild(cell, "head")
	local tab_1 = goutil.findChild(cell, "tab_1")
	local tab_2 = goutil.findChild(cell, "tab_2")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")

	HeadItemController.instance:setHeadCellByInfo(head, data.headInfo, true)

	txtName.text = data.headInfo.userName

	GameUtil.SetActive(tab_1, data.playerType == 2)
	GameUtil.SetActive(tab_2, data.playerType == 1)

	txtDesc.text = ""

	if data.playerType == 1 then
		txtDesc.text = langPara("我已捐赠<color=#30f5a3>%s</color>体力，助你在江湖行走一切顺利！", data.value)
	elseif data.playerType == 2 then
		txtDesc.text = langPara("我已领取<color=#30f5a3>%s</color>体力，感谢各位大侠出手相助！", data.value)
	end
end

function UpholdjusticeinfotabView:_clearCell(cell)
	local head = goutil.findChild(cell, "head")

	HeadItemController.instance:resetHeadCell(head)
end

function UpholdjusticeinfotabView:_onClickGet()
	if self._type == 2 then
		if self._todayActivityValue < self._activityValueLimit then
			TipsFacade.instance:openCommonTips(langPara("今日未达成%s活跃度，快去完成吧", self._activityValueLimit))
		else
			UIStateManager.instance:push(ViewName.UpholdjusticepopupView, self._activityId, self._type, self._todayNum, self._dailyLimit, self._activityNum, self._activityLimit)
		end
	else
		TipsFacade.instance:openCommonTips("暂未符合领取条件")
	end
end

function UpholdjusticeinfotabView:_onClickDonate()
	if self._type == 1 then
		UIStateManager.instance:push(ViewName.UpholdjusticepopupView, self._activityId, self._type, self._todayNum, self._dailyLimit, self._activityNum, self._activityLimit)
	else
		TipsFacade.instance:openCommonTips("暂未符合捐献条件")
	end
end

return UpholdjusticeinfotabView
