-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/cynthia/CynthiamainView.lua

module("logic.extensions.timelimitedchallenge.view.Cynthia.CynthiamainView", package.seeall)

local CynthiamainView = class("CynthiamainView", TimeLimitedMainView)

function CynthiamainView:unbindEvents()
	CynthiamainView.super.unbindEvents(self)
	self._btnStart:RemoveClickListener()
	self._btnGift:RemoveClickListener()
	self.btnSweep:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnShop)
end

function CynthiamainView:bindEvents()
	CynthiamainView.super.bindEvents(self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnGift:AddClickListener(self._onClickJump, self)
	self.btnSweep:AddClickListener(self._onClickSweep, self)
	GameUtil.addClickHandler(self.btnShop, self.onClickShop, self)
end

function CynthiamainView:onExit()
	CynthiamainView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	MaterialMgr.resetAll(self._itemGift)
	MaterialMgr.resetAll(self._pointRankItem)
	MaterialMgr.resetAll(self.item)
	GlobalDispatcher:removeListener(GlobalNotify.PM_CynthiaGetInfoRes, self.onRefreshUI, self)
	RedPointController.instance:unregRedPoint(self._redImgPoint)

	if self._playEff then
		UIEffectManager.instance:stopEffect(self._playEff)

		self._playEff = nil
	end

	MaterialMgr.clearIcon(self.head)
end

function CynthiamainView:buildUI()
	CynthiamainView.super.buildUI(self)

	self._challengeId = 17
	self._btnStart = self:getBtn("Button")
	self.btnSweep = self:getBtn("btnSweep")
	self._model = self:getGo("model")
	self._redImgPoint = self:getGo("Button/imgPoint")
	self._shopGo = self:getGo("shop")
	self._btnGift = self:getBtn("shop/btnShop")
	self._itemGift = self:getGo("shop/item")
	self.limited = self:getGo("limited")
	self.item = self:getGo("item")
	self.txtLimited = self:getTxt("limited/txtNum")
	self.btnShop = self:getGo("btnShop")
	self.head = self:getGo("btnShop/head")
end

function CynthiamainView:onEnter()
	CynthiamainView.super.onEnter(self)
	CynthiaChallengeAgent.instance:sendPM_CynthiaChallengeGetInfoReq(self._challengeId)
	self:onRefreshUI()
	GlobalDispatcher:addListener(GlobalNotify.PM_CynthiaGetInfoRes, self.onRefreshUI, self)
	GameUtil.doCallbackWhenFirst("CynthiamainView_20210902", function()
		self:_onClickRule()
	end)
	RedPointController.instance:regRedPoint(self._redImgPoint, RedPointModel.ID_CYNTHIABUFF)

	self.effResPath = "fx_ui_xinxiyatiaozhan/fx_ui_xinxiyatiaozhan.prefab"
	self._playEff = UIEffectManager.instance:playEffect(self, self.effResPath, nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self.mainGO.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)

	self:updateGoShop()
end

function CynthiamainView:updateGoShop()
	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	local raceId = self._challengeCfg.raceId

	MaterialMgr.setIcon(self.head, MatType.Pet, raceId)
end

function CynthiamainView:onClickShop()
	local goodsId = CynthiaConfig.instance:getCommonValue(self._challengeId, "jumpFuncId")

	PayShopController.instance:buyShopItemWithTips(goodsId)
end

function CynthiamainView:_onClickJump()
	local jumpShop = CynthiaConfig.instance:getCommonValue(self._challengeId, "jumpShop")

	GotoMgr.gotoByString(jumpShop)
end

function CynthiamainView:_onClickRank()
	UIStateManager.instance:push(ViewName.LightKingRankView, self._challengeId)
end

function CynthiamainView:_onClickStart()
	if not CynthiaModel.instance:getIsTimeAbleToChallenge(self._challengeId) then
		TipsFacade.instance:openCommonTips(lang("每天早上9点到次日5点开放挑战！"))

		return
	end

	UIStateManager.instance:push(ViewName.Cynthiachallengeview, self._challengeId)
end

function CynthiamainView:_onClickSweep()
	if not CynthiaModel.instance:getIsTimeAbleToChallenge(self._challengeId) then
		TipsFacade.instance:openCommonTips(lang("每天早上9点到次日5点开放挑战！"))

		return
	end

	if CynthiaModel.instance:getIsAbleToSweep(self._challengeId) then
		CynthiaChallengeAgent.instance:sendPM_CynthiaChallengeSweepReq(self._challengeId)
	else
		TipsFacade.instance:openCommonTips(lang("明日再来扫荡吧！"))
	end
end

function CynthiamainView:onRefreshUI()
	local mo = CynthiaModel.instance:getActMo(self._challengeId)
	local isAllPass = mo.isAllPass
	local isCanSweep = CynthiaModel.instance:getIsAbleToSweep(self._challengeId)

	GameUtil.SetActive(self._btnStart, not isAllPass)
	GameUtil.SetActive(self.btnSweep, isAllPass)

	local rankPrize = CynthiaConfig.instance:getCommonValue(self._challengeId, "rankPrize")
	local prizeCfg = CynthiaConfig.instance:getCommonValue(self._challengeId, "challengePrize")
	local petRankThreshold = checknumber(CynthiaConfig.instance:getCommonValue(self._challengeId, "rankSize"))

	self._tipRank.gameObject:SetActive(petRankThreshold > mo.rankSize)

	self._txtTipRank.text = string.format("前%s名\n可获得", petRankThreshold)

	MaterialMgr.setCellByCfg(rankPrize, self._pointRankItem)
	MaterialMgr.setCellByCfg(prizeCfg, self.item)

	local itemJump = CynthiaConfig.instance:getCommonValue(self._challengeId, "jumpItem")

	if not string.nilorempty(itemJump) then
		MaterialMgr.setCellByCfg(itemJump, self._itemGift)
	end
end

return CynthiamainView
