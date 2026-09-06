-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2026/main/Yearcardbuyfewsandfxs2026View.lua

module("logic.extensions.yearcard.view.yearcard2026.main.Yearcardbuyfewsandfxs2026View", package.seeall)

local Yearcardbuyfewsandfxs2026View = class("Yearcardbuyfewsandfxs2026View", ViewComponent)

function Yearcardbuyfewsandfxs2026View:ctor()
	Yearcardbuyfewsandfxs2026View.super.ctor(self)

	self._curActId = YearCardConfig.instance:getNextActId()
	self._skinId = 18001
	self._skinId1 = 18001
	self._skinId2 = 18021
	self._curShowIdx = 0
end

function Yearcardbuyfewsandfxs2026View:unbindEvents()
	Yearcardbuyfewsandfxs2026View.super.unbindEvents(self)
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnGoto:RemoveClickListener()
	self._btnPay1:RemoveClickListener()
	self._btnPay2:RemoveClickListener()
	self._btnPay3:RemoveClickListener()
	self._btnPay4:RemoveClickListener()
end

function Yearcardbuyfewsandfxs2026View:bindEvents()
	Yearcardbuyfewsandfxs2026View.super.bindEvents(self)
	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)
	self._btnInfo:AddClickListener(self._onClickbtnInfo, self)
	self._btnGoto:AddClickListener(self._onClickbtnGoto, self)
	self._btnPay1:AddClickListener(GameUtil.handler(self._onClickBuyGift, self, 1))
	self._btnPay2:AddClickListener(GameUtil.handler(self._onClickBuyGift, self, 2))
	self._btnPay3:AddClickListener(GameUtil.handler(self._onClickBuyGift, self, 3))
	self._btnPay4:AddClickListener(GameUtil.handler(self._onClickBuyGift, self, 4))
end

function Yearcardbuyfewsandfxs2026View:buildUI()
	Yearcardbuyfewsandfxs2026View.super.buildUI(self)

	self._btnPay1 = self:getBtn("annualfee/left/btnPayGift1")
	self._btnPay2 = self:getBtn("annualfee/left/btnPayGift2")
	self._btnPay3 = self:getBtn("annualfee/right/btnPayGift1")
	self._btnPay4 = self:getBtn("annualfee/right/btnPayGift2")
	self._txtbtnPay1 = self:getTxt("annualfee/left/btnPayGift1/txtCost")
	self._txtbtnPay2 = self:getTxt("annualfee/left/btnPayGift2/txtCost")
	self._txtbtnPay3 = self:getTxt("annualfee/right/btnPayGift1/txtCost")
	self._txtbtnPay4 = self:getTxt("annualfee/right/btnPayGift2/txtCost")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._txtDescName = self:getTxt("txtName")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnGoto = self:getBtn("btnGoto")
	self._itemGo = self:getGo("annualfee/item")
	self._rare = self:getGo("petInfo/rare")
	self._tableviewGo2 = self:getGo("annualfee/left/tableview")
	self._tableviewGo4 = self:getGo("annualfee/right/tableview")
	self._tablecellGo = self:getGo("annualfee/item")
	self._scrollerListReward2 = ScrollerList.create(self._tableviewGo2, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollerListReward4 = ScrollerList.create(self._tableviewGo4, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._itemcon1 = self:getGo("annualfee/left/itemcon")
	self._itemcon3 = self:getGo("annualfee/right/itemcon")
	self._roleImg2 = self:getGo("roleImg2"):GetComponent(ComponentType.RawImage)
	self._roleImg1 = self:getGo("roleImg1"):GetComponent(ComponentType.RawImage)

	goutil.setActive(self._roleImg1.gameObject, false)
	goutil.setActive(self._roleImg2.gameObject, false)

	self._bg2Go = self:getGo("petInfo/bg2")
	self._bg1Go = self:getGo("petInfo/bg1")

	goutil.setActive(self._bg2Go.gameObject, false)
	goutil.setActive(self._bg1Go.gameObject, false)
end

function Yearcardbuyfewsandfxs2026View:onExit()
	Yearcardbuyfewsandfxs2026View.super.onExit(self)
	MaterialMgr.resetAll(self._rare)
	MaterialMgr.resetAll(self._itemcon1)
	MaterialMgr.resetAll(self._itemcon3)
	self._scrollerListReward4:dispose()
	self._scrollerListReward2:dispose()
	removetimer(self._changeRoleShow, self)
	self:_stopEffect()
end

function Yearcardbuyfewsandfxs2026View:onEnter()
	Yearcardbuyfewsandfxs2026View.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.AnnuityExchangeRes, self._onAnnuityExchangeRes, self)
	self:_updateData()
	self:_updateUI()
	settimer(5, self._changeRoleShow, self, true)
	self:_changeRoleShow()
	self:_playEffect()
end

function Yearcardbuyfewsandfxs2026View:_updateData()
	self._exchangeList = YearCardModel.instance:getExchangeList(self._curActId) or {}
end

function Yearcardbuyfewsandfxs2026View:_onClickBuyGift(giftId)
	self:_buyGift(giftId)
end

function Yearcardbuyfewsandfxs2026View:_buyGift(giftId)
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

function Yearcardbuyfewsandfxs2026View:_onClickbtnSkill()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self._skinId)
	end
end

function Yearcardbuyfewsandfxs2026View:_onClickbtnInfo()
	PetbookController.instance:openPetinfoView(self._skinId)
end

function Yearcardbuyfewsandfxs2026View:_onClickbtnGoto()
	GotoMgr.gotoByString("func#545#1")
end

function Yearcardbuyfewsandfxs2026View:_updateUI()
	self:_updateRewards()
	self:_updateMark()
	self:_updateCost()
end

function Yearcardbuyfewsandfxs2026View:_getBuyTime(giftId)
	return (self._exchangeList[giftId] or nil) and (self._exchangeList[giftId].buyTimes or 0)
end

function Yearcardbuyfewsandfxs2026View:_updateMark()
	self:_checkAndMark(self._btnPay1.gameObject, 1)
	self:_checkAndMark(self._btnPay2.gameObject, 2)
	self:_checkAndMark(self._btnPay3.gameObject, 3)
	self:_checkAndMark(self._btnPay4.gameObject, 4)
end

function Yearcardbuyfewsandfxs2026View:_checkAndMark(btnGo, giftId)
	local cfg = YearCardConfig.instance:GetAnnuityExchangeCfg(self._curActId, giftId)
	local isActiveAnnuity = YearCardModel.instance:isActiveAnnuity(self._curActId)
	local buyTime = self:_getBuyTime(giftId)

	GameUtil.SetGray(btnGo, buyTime < cfg.timesLimit and cfg.needActiveAnnuity and not isActiveAnnuity or true)
end

function Yearcardbuyfewsandfxs2026View:_updateCost()
	self:_updateSingleCost(self._txtbtnPay1, 1)
	self:_updateSingleCost(self._txtbtnPay2, 2)
	self:_updateSingleCost(self._txtbtnPay3, 3)
	self:_updateSingleCost(self._txtbtnPay4, 4)
end

function Yearcardbuyfewsandfxs2026View:_updateSingleCost(txtComp, giftId)
	local cfg = YearCardConfig.instance:GetAnnuityExchangeCfg(self._curActId, giftId)
	local matType, matId, matNum = MaterialMgr.getMatParams(cfg.cost)
	local matName = MaterialMgr.getMaterialsName(matType, matId)

	txtComp.text = string.format("%s%s", matNum, matName)
end

function Yearcardbuyfewsandfxs2026View:_updatePet()
	MaterialMgr.setCell(MatType.Rare, self._skinId, self._rare)

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)

	self._txtPetName.text = skinCfg.name
end

function Yearcardbuyfewsandfxs2026View:_updateRewards()
	local cfg1 = YearCardConfig.instance:GetAnnuityExchangeCfg(self._curActId, 1)

	MaterialMgr.setCellByCfg(cfg1.prize, self._itemcon1)

	local cfg3 = YearCardConfig.instance:GetAnnuityExchangeCfg(self._curActId, 3)

	MaterialMgr.setCellByCfg(cfg3.prize, self._itemcon3)

	local cfg2 = YearCardConfig.instance:GetAnnuityExchangeCfg(self._curActId, 2)
	local rewards2 = {}

	for i, v in ipairs(string.split(cfg2.prize, "#")) do
		table.insert(rewards2, v)
	end

	self._scrollerListReward2:reloadData(rewards2)

	local cfg4 = YearCardConfig.instance:GetAnnuityExchangeCfg(self._curActId, 4)
	local rewards4 = {}

	for i, v in ipairs(string.split(cfg4.prize, "#")) do
		table.insert(rewards4, v)
	end

	self._scrollerListReward4:reloadData(rewards4)
end

function Yearcardbuyfewsandfxs2026View:_combineData(prizeStr, descs)
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

function Yearcardbuyfewsandfxs2026View:_updateItemCell(item, data)
	return
end

function Yearcardbuyfewsandfxs2026View:_onAnnuityExchangeRes()
	self:_updateData()
	self:_updateMark()
end

function Yearcardbuyfewsandfxs2026View:_updateCell(view, cell, prize, tag)
	local goItem = goutil.findChild(cell.gameObject, "con")

	MaterialMgr.resetAll(goItem)
	MaterialMgr.setCellByCfg(prize, goItem)
end

function Yearcardbuyfewsandfxs2026View:_clearCell(cell)
	local goItem = goutil.findChild(cell.gameObject, "con")

	MaterialMgr.resetAll(goItem)
end

function Yearcardbuyfewsandfxs2026View:_changeRoleShow()
	self._curShowIdx = self._curShowIdx + 1

	local idx = self._curShowIdx % 2

	goutil.setActive(self._roleImg1.gameObject, idx == 0)
	goutil.setActive(self._roleImg2.gameObject, idx == 1)

	if idx == 0 then
		self._skinId = self._skinId1 or self._skinId2
	end

	goutil.setActive(self._bg1Go, idx == 0)
	goutil.setActive(self._bg2Go, idx == 1)
	self:_updatePet()
end

function Yearcardbuyfewsandfxs2026View:_playEffect()
	local effName = "20251219/26nianfei/fx_ui_jiban_fw.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self.mainGO.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0, 0)
end

function Yearcardbuyfewsandfxs2026View:_stopEffect()
	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

return Yearcardbuyfewsandfxs2026View
