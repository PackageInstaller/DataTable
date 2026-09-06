-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2025/main/YearcardbuyfewsView.lua

module("logic.extensions.yearcard.view.yearcard2025.main.YearcardbuyfewsView", package.seeall)

local YearcardbuyfewsView = class("YearcardbuyfewsView", ViewComponent)

function YearcardbuyfewsView:ctor()
	YearcardbuyfewsView.super.ctor(self)

	self._curActId = 8005
	self._skinId = 18001
end

function YearcardbuyfewsView:unbindEvents()
	YearcardbuyfewsView.super.unbindEvents(self)
	self._btnPay328:RemoveClickListener()
	self._btnPay198:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnGoto:RemoveClickListener()
end

function YearcardbuyfewsView:bindEvents()
	YearcardbuyfewsView.super.bindEvents(self)
	self._btnPay328:AddClickListener(self._onClickbtnPay328, self)
	self._btnPay198:AddClickListener(self._onClickbtnPay198, self)
	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)
	self._btnInfo:AddClickListener(self._onClickbtnInfo, self)
	self._btnGoto:AddClickListener(self._onClickbtnGoto, self)
end

function YearcardbuyfewsView:buildUI()
	YearcardbuyfewsView.super.buildUI(self)

	self._btnPay328 = self:getBtn("btnPay328")
	self._btnPay198 = self:getBtn("btnPay198")
	self._mark198Go = self:getGo("mark198")
	self._mark328Go = self:getGo("mark328")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._txtDescName = self:getTxt("txtName")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnGoto = self:getBtn("btnGoto")
	self._itemGo = self:getGo("annualfee/item")

	goutil.setActive(self._itemGo, false)

	self._itemconGo1 = self:getGo("annualfee/awaken/itemcon")
	self._itemconGo2 = self:getGo("annualfee/cultivate/itemcon")
	self._itemGroup1 = ItemGroup.New(self._itemconGo1, self._itemGo, nil, nil, true, self._clearGroupItem, self)
	self._itemGroup2 = ItemGroup.New(self._itemconGo2, self._itemGo, nil, nil, true, self._clearGroupItem, self)
	self._layout1 = self._itemconGo1:GetComponent(ComponentType.UILayoutSingleLine)
	self._layout2 = self._itemconGo2:GetComponent(ComponentType.UILayoutSingleLine)
	self._rare = self:getGo("petInfo/rare")
	self._txtCost1 = self:getTxt("btnPay198/txtCost")
	self._txtCost2 = self:getTxt("btnPay328/txtCost")
	self._iconGo1 = self:getGo("btnPay198/icon")
	self._iconGo2 = self:getGo("btnPay328/icon")
end

function YearcardbuyfewsView:onExit()
	YearcardbuyfewsView.super.onExit(self)
	self._itemGroup1:dispose()
	self._itemGroup2:dispose()
	MaterialMgr.resetAll(self._iconGo1)
	MaterialMgr.resetAll(self._iconGo2)
end

function YearcardbuyfewsView:onEnter()
	YearcardbuyfewsView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.AnnuityExchangeRes, self._onAnnuityExchangeRes, self)
	self:_updateData()
	self:_updateUI()
end

function YearcardbuyfewsView:_updateData()
	self._exchangeList = YearCardModel.instance:getExchangeList(self._curActId) or {}
end

function YearcardbuyfewsView:_onClickbtnPay328()
	self:_buyGift(2)
end

function YearcardbuyfewsView:_onClickbtnPay198()
	self:_buyGift(1)
end

function YearcardbuyfewsView:_buyGift(giftId)
	local cfg = YearCardConfig.instance:GetAnnuityExchangeCfg(self._curActId, giftId)

	if cfg.needActiveAnnuity and not YearCardModel.instance:isActiveAnnuity(self._curActId) then
		FloatWordMgr.instance:show("需要激活年费后可购买")

		return
	end

	if not string.nilorempty(cfg.startTime) then
		local time = GameUtil.string2time(cfg.startTime)

		if time > ServerTime.now() then
			local date = GameUtil.string2date(cfg.startTime)
			local str = string.format("%s年%s月%s日%s点后开启售卖", date.year, date.month, date.day, date.hour)

			FloatWordMgr.instance:show(str)

			return
		end
	end

	local buyTime = self:_getBuyTime(giftId)

	if buyTime >= cfg.timesLimit then
		FloatWordMgr.instance:show("已购买该礼包")

		return
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(cfg.cost)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local content = string.format("确定花费%s%s购买该礼包吗？", matNum, matName)

	local function successCallBack()
		AnnuityAgent.instance:sendPM_AnnuityExchangeReq(self._curActId, giftId)
	end

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, successCallBack)
end

function YearcardbuyfewsView:_onClickbtnSkill()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self._skinId)
	end
end

function YearcardbuyfewsView:_onClickbtnInfo()
	PetbookController.instance:openPetinfoView(self._skinId)
end

function YearcardbuyfewsView:_onClickbtnGoto()
	GotoMgr.gotoByString("func#545# 1")
end

function YearcardbuyfewsView:_clearGroupItem(item)
	local goItem = goutil.findChild(item.mainGO, "item")

	MaterialMgr.resetAll(goItem)
end

function YearcardbuyfewsView:_updateUI()
	self:_updateRewards()
	self:_updatePet()
	self:_updateMark()
	self:_updateCost()
end

function YearcardbuyfewsView:_getBuyTime(giftId)
	local buyTime = 0

	if self._exchangeList then
		for i, v in ipairs(self._exchangeList) do
			if v.giftId == giftId then
				buyTime = v.buyTimes
			end
		end
	end

	return buyTime
end

function YearcardbuyfewsView:_updateMark()
	local cfg1 = YearCardConfig.instance:GetAnnuityExchangeCfg(self._curActId, 1)
	local buyTime1 = self:_getBuyTime(1)

	goutil.setActive(self._mark198Go, buyTime1 >= cfg1.timesLimit)

	local buyTime2 = self:_getBuyTime(2)
	local cfg2 = YearCardConfig.instance:GetAnnuityExchangeCfg(self._curActId, 2)

	goutil.setActive(self._mark328Go, buyTime2 >= cfg2.timesLimit)

	local isActiveAnnuity = YearCardModel.instance:isActiveAnnuity(self._curActId)

	GameUtil.SetGray(self._btnPay198.gameObject, buyTime1 < cfg1.timesLimit and cfg1.needActiveAnnuity and not isActiveAnnuity or true)
	GameUtil.SetGray(self._btnPay328.gameObject, buyTime2 < cfg2.timesLimit and cfg2.needActiveAnnuity and not isActiveAnnuity or true)
end

function YearcardbuyfewsView:_updateCost()
	local cfg1 = YearCardConfig.instance:GetAnnuityExchangeCfg(self._curActId, 1)
	local matType, matId, matNum = MaterialMgr.getMatParams(cfg1.cost)

	MaterialMgr.setIcon(self._iconGo1, matType, matId)

	self._txtCost1.text = matNum

	local cfg2 = YearCardConfig.instance:GetAnnuityExchangeCfg(self._curActId, 2)
	local matType, matId, matNum = MaterialMgr.getMatParams(cfg2.cost)

	MaterialMgr.setIcon(self._iconGo2, matType, matId)

	self._txtCost2.text = matNum
end

function YearcardbuyfewsView:_updatePet()
	MaterialMgr.setCell(MatType.Rare, self._skinId, self._rare)

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)

	self._txtPetName.text = skinCfg.name
end

function YearcardbuyfewsView:_updateRewards()
	local cfg1 = YearCardConfig.instance:GetAnnuityExchangeCfg(self._curActId, 1)
	local datas1 = self:_combineData(cfg1.prize, cfg1.prizeDescs)

	self._itemGroup1:updateWithMoArray(datas1, self._updateItemCell, self)

	local cfg2 = YearCardConfig.instance:GetAnnuityExchangeCfg(self._curActId, 2)
	local datas2 = self:_combineData(cfg2.prize, cfg2.prizeDescs)

	self._itemGroup2:updateWithMoArray(datas2, self._updateItemCell, self)
	self._layout1:Layout()
	self._layout2:Layout()
end

function YearcardbuyfewsView:_combineData(prizeStr, descs)
	local datas = {}
	local prizes = string.split(prizeStr, "#")

	for i, v in ipairs(prizes) do
		table.insert(datas, {
			prize = v,
			desc = descs[i]
		})
	end

	return datas
end

function YearcardbuyfewsView:_updateItemCell(item, data)
	local goItem = goutil.findChild(item.mainGO, "item")
	local txtDesc = goutil.findChildTextComponent(item.mainGO, "txtDesc")

	txtDesc.text = data.desc

	MaterialMgr.resetAll(goItem)
	MaterialMgr.setCellByCfg(data.prize, goItem)
end

function YearcardbuyfewsView:_onAnnuityExchangeRes()
	self:_updateData()
	self:_updateMark()
end

return YearcardbuyfewsView
