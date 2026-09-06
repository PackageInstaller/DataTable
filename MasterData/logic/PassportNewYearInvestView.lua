-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportNewYearInvestView.lua

module("logic.extensions.passport.view.PassportNewYearInvestView", package.seeall)

local PassportNewYearInvestView = class("PassportNewYearInvestView", ViewComponent)

function PassportNewYearInvestView:ctor()
	PassportNewYearInvestView.super.ctor(self)
end

function PassportNewYearInvestView:buildUI()
	PassportNewYearInvestView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnPay1 = self:getBtn("btnPay1")
	self._btnPay2 = self:getBtn("btnPay2")
	self._btnOneKey = self:getBtn("btnOneKey")
	self._btnSkin = self:getBtn("btnSkin")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._rpOneKey = self:getGo("btnOneKey/rp")
	self._txtPay1 = self:getTxt("btnPay1/txt")
	self._txtPay2 = self:getTxt("btnPay2/txt")
	self._pass1 = self:getGo("btnPay1/pass")
	self._pass2 = self:getGo("btnPay2/pass")
	self._payChange1 = self:getGo("btnPay1/bg"):GetComponent(ComponentType.UIImageSpriteChange)
	self._payChange2 = self:getGo("btnPay2/bg"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtTime = self:getTxt("time/img/txtTime")
	self._skinPass = self:getGo("skinPass")
	self._goTableview = self:getGo("reward/tableview")
	self._goCell = self:getGo("reward/cell")
	self._tableView = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollRect = self._goTableview:GetComponent(ComponentType.ScrollRect)
end

function PassportNewYearInvestView:bindEvents()
	PassportNewYearInvestView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnPay1:AddClickListener(self._onClickPay1, self)
	self._btnPay2:AddClickListener(self._onClickPay2, self)
	self._btnOneKey:AddClickListener(self._onClickOneKey, self)
	self._btnSkin:AddClickListener(self._onClickGetSkin, self)
	self._btnSkill:AddClickListener(self._onClickShowSkill, self)
end

function PassportNewYearInvestView:unbindEvents()
	PassportNewYearInvestView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnPay1:RemoveClickListener()
	self._btnPay2:RemoveClickListener()
	self._btnOneKey:RemoveClickListener()
	self._btnSkin:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
end

function PassportNewYearInvestView:onEnter()
	PassportNewYearInvestView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PassportStateUpdate, self._refreshView, self)
	GlobalDispatcher:addListener(PassportAgent.PM_GainPayAllPrizeRes, self._refreshView, self)
	PassportController.instance:sendGetInfoReq(PassportModel.ID_NewYearInvest)

	self._curData = nil
	self._cfgActivity = nil

	self:_initActivityTimeText()
end

function PassportNewYearInvestView:onExit()
	PassportNewYearInvestView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PassportStateUpdate, self._refreshView, self)
	GlobalDispatcher:removeListener(PassportAgent.PM_GainPayAllPrizeRes, self._refreshView, self)
	self._tableView:dispose()
end

function PassportNewYearInvestView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "passportnewyearinvestview")
end

function PassportNewYearInvestView:_onClickPay1()
	if not self._curData then
		return
	end

	if self._curData.hasPay then
		FloatWordMgr.instance:show(lang("已售罄"))

		return
	end

	if not string.nilorempty(self._curData.actCfg.ordinaryBuyStartTime) then
		local timeNow = ServerTime.now()

		if timeNow < GameUtil.string2time(self._curData.actCfg.ordinaryBuyStartTime) then
			FloatWordMgr.instance:show(langPara("%s后开启售卖", string.gsub(self._curData.actCfg.ordinaryBuyStartTime, "T", " ")))

			return
		end
	end

	PassportController.instance:_buyPassportWithDifferentPayType(self._curData.actId, false, false)
end

function PassportNewYearInvestView:_onClickPay2()
	if not self._curData then
		return
	end

	if self._curData.hasPayAdd then
		FloatWordMgr.instance:show(lang("已售罄"))

		return
	end

	if not string.nilorempty(self._curData.actCfg.additionalBuyStartTime) then
		local timeNow = ServerTime.now()

		if timeNow < GameUtil.string2time(self._curData.actCfg.additionalBuyStartTime) then
			FloatWordMgr.instance:show(langPara("%s后开启售卖", string.gsub(self._curData.actCfg.ordinaryBuyStartTime, "T", " ")))

			return
		end
	end

	PassportController.instance:_buyPassportWithDifferentPayType(self._curData.actId, false, true)
end

function PassportNewYearInvestView:_onClickOneKey()
	if self._ableToGetOneKey then
		PassportController.instance:sendOneKeyGainPrizeReq(self._curData.actId, self._curData.funcId)

		return
	end

	if not self._curData.hasPay then
		FloatWordMgr.instance:show(langPara("请先解锁%s元奖励", self._payNum))

		return
	end

	if not self._curData.hasPayAdd then
		FloatWordMgr.instance:show(langPara("请先解锁%s元奖励", self._payAddNum))

		return
	end

	FloatWordMgr.instance:show(lang("当前无可领取奖励"))
end

function PassportNewYearInvestView:_onClickShowSkill()
	if not self._cfgActivity.skinId then
		local skinId = 0
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:previewBattle(raceId, skinId)
		end
	end
end

function PassportNewYearInvestView:_onClickGetSkin()
	if not self._curData.hasPay and not self._curData.hasPayAdd or self._curData.gainPayAll then
		return
	end

	PassportController.instance:sendPMGainPayAllPrizeReq(self._curData.actId, self._curData.funcId)
end

function PassportNewYearInvestView:_refreshView()
	self._curData = PassportModel.instance:getInfo(PassportModel.ID_NewYearInvest)

	self._tableView:reloadData(self:_getCurDataList())
	self:_refreshOneKey()
	self:_refreshPayBtn()
end

function PassportNewYearInvestView:_updateCell(view, cell, data, tag)
	local cls = GameUtil.AddLuaOnce(cell.gameObject, PtNewYearInvestCell)

	cls:init(data, self._curData, self._scrollRect, self)
end

function PassportNewYearInvestView:_clearCell(cell)
	local cls = GameUtil.AddLuaOnce(cell.gameObject, PtNewYearInvestCell)

	cls:reset()
end

function PassportNewYearInvestView:_refreshOneKey()
	self._ableToGetOneKey = false

	for i = 1, self._curData.unlockIndex - 1 do
		if not self._curData.normalPrizeState[i] then
			self._ableToGetOneKey = true

			break
		end

		if self._curData.hasPay and not self._curData.superPrizeState[i] then
			self._ableToGetOneKey = true

			break
		end

		if self._curData.hasPayAdd and not self._curData.addPrizeState[i] then
			self._ableToGetOneKey = true

			break
		end
	end

	goutil.setActive(self._rpOneKey, self._ableToGetOneKey)
end

function PassportNewYearInvestView:_refreshPayBtn()
	local goodId = self._curData.actCfg.goodsId

	self._payNum = PayConfig.instance:getPayMoneyYuan(goodId)
	self._txtPay1.text = langPara("%s元\n解锁", self._payNum)

	if self._curData.hasPay then
		goutil.setActive(self._pass1, true)
		self._payChange1:SetState(0)
	else
		goutil.setActive(self._pass1, false)
		self._payChange1:SetState(1)
	end

	local goodId = self._curData.actCfg.additonalGoodsId

	self._payAddNum = PayConfig.instance:getPayMoneyYuan(goodId)
	self._txtPay2.text = langPara("%s元\n解锁", self._payAddNum)

	if self._curData.hasPayAdd then
		goutil.setActive(self._pass2, true)
		self._payChange2:SetState(0)
	else
		goutil.setActive(self._pass2, false)
		self._payChange2:SetState(1)
	end

	if self._curData.hasPay and self._curData.hasPayAdd and not self._curData.gainPayAll then
		GameUtil.SetGray(self._btnSkin, false)
	else
		GameUtil.SetGray(self._btnSkin, true)
	end

	goutil.setActive(self._skinPass, self._curData.gainPayAll)
end

function PassportNewYearInvestView:_getCurDataList()
	local dataList = {}

	for index, v in ipairs(self._curData.prizeCfgs) do
		local data = {}

		data.id = index
		data.progressKey = v.thresholdParam
		data.freePrize = v.freePrize
		data.payedPrize = v.payedPrize
		data.additionalPaymentPrize = v.additionalPaymentPrize
		data.freeState = self._curData.normalPrizeState[index]
		data.superState = self._curData.superPrizeState[index]
		data.addState = self._curData.addPrizeState[index]
		data.isLast = false

		table.insert(dataList, data)
	end

	dataList[#dataList].isLast = true

	return dataList
end

function PassportNewYearInvestView:_initActivityTimeText()
	local cfgList = PassportConfig.instance:getPeriodActivityCfgList(PassportModel.ID_NewYearInvest)
	local activityId

	for i, v in ipairs(cfgList) do
		if ActivityDefineController.instance:checkIsInActivityTimeByActivityId(v.actId) then
			activityId = v.actId
			self._cfgActivity = v

			break
		end
	end

	if activityId then
		local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)
		local startTimestamp, endTimestamp = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)

		self._txtTime.text = string.format("%s：%s", lang("activitytime"), GameUtil.getTimeTxt(startTimestamp, endTimestamp, GameEnum.TimeTxt.M_D_H))
	else
		self._txtTime.text = ""
	end
end

return PassportNewYearInvestView
