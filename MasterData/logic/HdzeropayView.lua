-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zeropay/view/HdzeropayView.lua

module("logic.extensions.zeropay.view.HdzeropayView", package.seeall)

local HdzeropayView = class("HdzeropayView", ViewComponent)

function HdzeropayView:ctor()
	HdzeropayView.super.ctor(self)
end

function HdzeropayView:buildUI()
	HdzeropayView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnBuy = self:getGo("btnBuy")
	self._btnText = self:getTxt("btnBuy/Text")
	self.txtTime = self:getTxt("time/txt")
	self.txtDesc = self:getTxt("description/txtDesc")
	self.txtExt = self:getTxt("text")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("item")
	self.scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._btnInfo = self:getBtn("btnInfo")
	self._btnSkill = self:getBtn("btnSkill")
	self._effectGo = self:getGo("effect")
	self._btnPetVerify = self:getBtn("btnPetVerify")
	self._btnGet = self:getBtn("btnGet")
	self._petVerifyRed = self:getGo("btnPetVerify/redPoint")
end

function HdzeropayView:bindEvents()
	HdzeropayView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnBuy, self._onClickbuyBtn, self)
	self._btnInfo:AddClickListener(self._onClickbtnInfo, self)
	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)
	self._btnPetVerify:AddClickListener(self._onClickbtnPetVerify, self)
	self._btnGet:AddClickListener(self._onClickbtnGet, self)
end

function HdzeropayView:unbindEvents()
	HdzeropayView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnBuy)
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnPetVerify:RemoveClickListener()
	self._btnGet:RemoveClickListener()
end

function HdzeropayView:destroyUI()
	HdzeropayView.super.destroyUI(self)
end

function HdzeropayView:onEnter()
	HdzeropayView.super.onEnter(self)
	GlobalDispatcher:addListener(HDZeropayController.PM_GetGiftInfoRes, self._PM_GetGiftInfoRes, self)
	GlobalDispatcher:addListener(HDZeropayController.PM_NotifyBuyGiftRes, self._PM_NotifyBuyGiftRes, self)
	HDZeropayController.instance:sendPM_GetGiftInfoReq()
	self:_updateView()
	self:_setEffect()
	PetAwakenVerificationController.instance:regRedAboutPetAwken(self._petVerifyRed, "xingjiangview")
end

function HdzeropayView:onEnterFinished()
	HdzeropayView.super.onEnterFinished(self)
end

function HdzeropayView:onExit()
	HdzeropayView.super.onExit(self)
	GlobalDispatcher:removeListener(HDZeropayController.PM_GetGiftInfoRes, self._PM_GetGiftInfoRes, self)
	GlobalDispatcher:removeListener(HDZeropayController.PM_NotifyBuyGiftRes, self._PM_NotifyBuyGiftRes, self)
	self.scrollList:dispose()
	UIEffectManager.instance:stopEffect(self._effectHandler)
	PetAwakenVerificationController.instance:unRegRedAboutPetAwken(self._petVerifyRed)

	self._getJumpTo = nil
end

function HdzeropayView:onExitFinished()
	HdzeropayView.super.onExitFinished(self)
end

function HdzeropayView:_PM_GetGiftInfoRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function HdzeropayView:_PM_NotifyBuyGiftRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function HdzeropayView:_updateView()
	self._actId = HDZeropayController.instance.curActId

	if self._actId then
		self._giftId = 1

		self:_initParams()

		self._hasBuyGift = not HDZeropayController.instance:getGiftCanBuy(self._actId, self._giftId)

		local cfg = HDZeropayConfig.instance:getNewActCfg(self._actId, self._giftId)

		self._isOutLimit = ((cfg or nil) and cfg.maxBuyTimes) <= HDZeropayController.instance:getBuyTimes(self._actId, self._giftId)

		self:_updateReward()
		self:_setBtnState()

		local cfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.NewZeroPay, self._actId)
		local startDate, endDate = GameUtil.string2date(cfg.startTime), GameUtil.string2date(cfg.endTime)

		self.txtTime.text = langPara("FunArena_HallView_Tips_1", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)

		goutil.setActive(self._btnGet.gameObject, not string.nilorempty(self._getJumpTo))
	end
end

function HdzeropayView:_updateReward()
	local cfg = HDZeropayConfig.instance:getNewActCfg(self._actId, self._giftId)
	local pcfg = PayConfig.instance:getPayGoodsCfg(cfg.payGoodsId)

	self._btnText.text = self._hasBuyGift and lang("已购买") or "¥ " .. pcfg.payMoney * PayModel.RMB_UNIT
	self.txtDesc.text = tostring(cfg.desc)
	self.txtExt.text = tostring(cfg.ext)

	if HDZeropayController.instance:getBuyTimes(self._actId, self._giftId) >= 1 then
		if not cfg.followUpGiftContent then
			local currMatStr = cfg.giftContent
			local immgetList = MaterialMgr.changeItemStrArr(currMatStr)
			local daygetList = MaterialMgr.changeItemStrArr(cfg.mailContent)
			local list = {}

			for i, v in ipairs(immgetList) do
				table.insert(list, {
					isDayGet = false,
					cfgStr = v
				})
			end

			for i, v in ipairs(daygetList) do
				table.insert(list, {
					isDayGet = true,
					cfgStr = v,
					getDay = cfg.mailDay
				})
			end

			self.scrollList:reloadData(list)
		end
	end
end

function HdzeropayView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local tagText = goutil.findChildTextComponent(cell, "tagBg/text")
	local tagBgGo = goutil.findChild(cell, "tagBg")
	local showBg = false

	if data.isDayGet then
		tagText.text = langPara("%s天返", data.getDay)
		showBg = true
	else
		local arr = string.split(data.cfgStr, ":")
		local matType = checknumber(arr[1])
		local matId = checknumber(arr[2])

		if matType == MatType.Pet then
			tagText.text = lang("精灵")
			showBg = true
		else
			tagText.text = ""
			showBg = false
		end
	end

	goutil.setActive(tagBgGo, showBg)
	MaterialMgr.setCellByCfg(data.cfgStr, con)
end

function HdzeropayView:clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function HdzeropayView:_setBtnState()
	GameUtil.SetGray(self.btnBuy.gameObject, self._hasBuyGift or self._isOutLimit)
end

function HdzeropayView:_onClickbuyBtn()
	local cfg = HDZeropayConfig.instance:getNewActCfg(self._actId, self._giftId)

	if self._isOutLimit then
		FloatWordMgr.instance:show(langPara("已购买%s次，无法再次购买", (cfg or nil) and cfg.maxBuyTimes))

		return
	end

	if self._hasBuyGift then
		FloatWordMgr.instance:show(langPara("您已购买此活动礼包，需领完%s天钻石返利后次日才可再次购买", cfg.mailDay))

		return
	end

	local obj = {}

	obj.actId = self._actId

	local paramStr = GameUtil.jsonToString(obj)

	PayController.instance:pay(cfg.payGoodsId, GameEnum.PaySubGoodsType.NewZeroPay, self._giftId, paramStr)
end

function HdzeropayView:_onClickbtnInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function HdzeropayView:_onClickbtnSkill()
	if self._raceId then
		BattleFacade.instance:sendPreviewPetBattle(self._raceId, self._raceId)
	end
end

function HdzeropayView:_onClickbtnPetVerify()
	self:close()
	GotoMgr.gotoByString("func#493#115003#1")
end

function HdzeropayView:_onClickbtnGet()
	if self._getJumpTo then
		GotoMgr.gotoByString(self._getJumpTo)
	end
end

function HdzeropayView:_setEffect()
	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)
	end

	local effName = "fx_ui_wangyezhigou/fx_ui_grxx_beijing.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

function HdzeropayView:_initParams()
	if self._actId and self._giftId then
		local cfg = HDZeropayConfig.instance:getNewActCfg(self._actId, self._giftId)

		self._raceId = cfg.raceId
		self._getJumpTo = cfg.getJumpTo
	end
end

return HdzeropayView
