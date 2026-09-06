-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/FeinChallengeMainView.lua

module("logic.extensions.moonking.view.FeinChallengeMainView", package.seeall)

local FeinChallengeMainView = class("FeinChallengeMainView", ViewComponent)

function FeinChallengeMainView:ctor()
	FeinChallengeMainView.super.ctor(self)
end

function FeinChallengeMainView:bindEvents()
	FeinChallengeMainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "feiyinchallenge_rule")
	end, self)
	self._gotoBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.FeinChallengeBattleView, self._challCfg.challengeId)
	end, self)
	self._rankBtn:AddClickListener(function()
		if self._challCfg == nil or string.nilorempty(self._challCfg.jumpTo2) then
			return
		end

		GotoMgr.gotoByString(self._challCfg.jumpTo2)
	end, self)
	self._shopBtn:AddClickListener(function()
		if self._challCfg == nil or string.nilorempty(self._challCfg.jumpTo1) then
			return
		end

		GotoMgr.gotoByString(self._challCfg.jumpTo1)
	end, self)
	GameUtil.addClickHandler(self._btnPush, function()
		if self._challCfg == nil or string.nilorempty(self._challCfg.jumpTo3) then
			return
		end

		GotoMgr.gotoByString(self._challCfg.jumpTo3)
	end, self)
	self._skillBtn:AddClickListener(function()
		PetbookController.instance:previewBattle(self._challCfg.skinId)
	end, self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(self._challCfg.skinId)
	end, self)
end

function FeinChallengeMainView:unbindEvents()
	FeinChallengeMainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._gotoBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._shopBtn:RemoveClickListener()
	self._skillBtn:RemoveClickListener()
	self._introduceBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnPush)
end

function FeinChallengeMainView:onExit()
	FeinChallengeMainView.super.onExit(self)
	removetimer(self._calculationSurplusTime, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil
	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)

	MaterialMgr.resetAll(self._sprintRareGo)
	MaterialMgr.resetAll(self._tryGoods)
	MaterialMgr.resetAll(self._shopGoods)
	uGuiUtil.clearImage(self._shopGoods)
end

function FeinChallengeMainView:destroyUI()
	FeinChallengeMainView.super.destroyUI(self)
end

function FeinChallengeMainView:buildUI()
	FeinChallengeMainView.super.buildUI(self)

	self._sprintGo = self:getGo("sprintGo")

	local sprintInfoGo = self:getGo("sprintInfoGo")

	self._sprintRareGo = goutil.findChild(sprintInfoGo, "rareGo")
	self._skillBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "skillBtn")
	self._introduceBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "introduceBtn")

	local shopItemGo = self:getGo("shopItemGo")

	self._shopGoods = goutil.findChild(shopItemGo, "shopGoods")
	self._shopBtn = Framework.ButtonAdapter.GetFrom(shopItemGo, "shopBtn")
	self._contractBtn = Framework.ButtonAdapter.GetFrom(shopItemGo, "contractBtn")
	self._tryBtn = self:getBtn("tryBtn")
	self._rankBtn = self:getBtn("rankBtn")
	self._gotoBtn = self:getBtn("gotoBtn")
	self._gotoRedGo = self:getGo("gotoBtn/gotoRedGo")
	self._gotoEffGo = self:getGo("gotoBtn/gotoEffGo")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._closeBtn = self:getBtn("closeBtn")
	self._timerTxt = self:getTxt("time/txtTime")

	self._gotoRedGo:SetActive(false)

	self._timerTxt.text = ""
	self._btnPush = self:getBtn("pushBtn")
	self._timeGo = self:getGo("time")
end

function FeinChallengeMainView:onEnter()
	FeinChallengeMainView.super.onEnter(self)

	self._challCfg = MoonKingConfig.instance:getBattleBaseCfg(MoonKingModel.instance.feinChallengeId)

	self:_showActivityTimer()
	self:_showSpriteRawInfo()
	self:_showPetTryGoodsInfo()

	local effPath = "fx_ui_tongtiaozhan/fx_ui_mianban_tongtiaozhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function FeinChallengeMainView:_showActivityTimer()
	self._timerTxt.text = TimeGateController.instance:getActTimeShowByChallengeId(MoonKingModel.instance.feinChallengeId)
end

function FeinChallengeMainView:_calculationSurplusTime()
	local supTime = self._endTime - ServerTime.now()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timerTxt.text = lang("text_tong_desc_12")
		self._isActivityEnd = true

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._timerTxt.text = day > 0 and langPara("text_suo_timer_1", day, hour, min) or langPara("text_suo_timer_2", hour, min, sec)
end

function FeinChallengeMainView:_showSpriteRawInfo()
	MaterialMgr.setCell(MatType.Rare, self._challCfg.skinId, self._sprintRareGo)

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, self._challCfg.skinId, self._sprintGo, self._challCfg.modelScale, nil, true, 0, 0)
end

function FeinChallengeMainView:_showPetTryGoodsInfo()
	local isShow = MoonKingModel.instance:getFeinRedpoint(true)

	self._gotoRedGo:SetActive(isShow)

	if checknumber(self._challCfg.GOODS_ID) > 0 then
		local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._challCfg.GOODS_ID)
		local arr = string.split(goodsCfg.content, "#")

		MaterialMgr.setCellByCfg(arr[1], self._shopGoods)
	elseif not string.nilorempty(self._challCfg.showPrize) then
		uGuiUtil.setSpriteToImage(self._shopGoods, nil, GameUrl.getCharacterIconUrl(self._challCfg.showPrize))
	end
end

return FeinChallengeMainView
