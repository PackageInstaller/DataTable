-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattleshopView.lua

module("logic.extensions.glorybattle.view.GlorybattleshopView", package.seeall)

local GlorybattleshopView = class("GlorybattleshopView", ViewComponent)

function GlorybattleshopView:ctor()
	GlorybattleshopView.super.ctor(self)

	self._petEffects = {}
end

function GlorybattleshopView:unbindEvents()
	GlorybattleshopView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnMatch:RemoveClickListener()
	self._btnGiveUp:RemoveClickListener()
	self._btnTeam:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
	self._btnLvTips:RemoveClickListener()
	self._btnCutepetIcon:RemoveClickListener()
	self._btnTips:RemoveClickListener()
end

function GlorybattleshopView:bindEvents()
	GlorybattleshopView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnMatch:AddClickListener(self._onClickbtnMatch, self)
	self._btnGiveUp:AddClickListener(self._onClickbtnGiveUp, self)
	self._btnTeam:AddClickListener(self._onClickbtnTeam, self)
	self._btnRefresh:AddClickListener(self._onClickbtnRefresh, self)
	self._btnLvTips:AddClickListener(self._onClickbtnLvTips, self)
	self._btnCutepetIcon:AddClickListener(self._onClickcutepetIcon, self)
	self._btnTips:AddClickListener(self._onClickbtnTips, self)
end

function GlorybattleshopView:buildUI()
	GlorybattleshopView.super.buildUI(self)

	self._txtCoin = self:getTxt("txtCoin")
	self._txtExp = self:getTxt("txtExp")
	self._txtLv = self:getTxt("txtLv")
	self._btnClose = self:getBtn("btnClose")
	self._btnMatch = self:getBtn("bottomcon/btnMatch")
	self._btnGiveUp = self:getBtn("bottomcon/btnGiveUp")
	self._btnTeam = self:getBtn("bottomcon/btnTeam")
	self._btnRefresh = self:getBtn("btnRefresh")
	self._btnLvTips = self:getBtn("btnLvTips")
	self._goldbarconGo = self:getGo("goldbarcon")
	self._tableviewGoPet = self:getGo("bottomcon/tableview")
	self._tablecellGoPet = self:getGo("bottomcon/tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollerListPet = ScrollerList.create(self._tableviewGoPet, self._tablecellGoPet, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._tablecellhpGo = self:getGo("tablecellhp")
	self._tableviewwinGo = self:getGo("tableviewwin")
	self._tablecellwinGo = self:getGo("tablecellwin")
	self._tableviewhpGo = self:getGo("tableviewhp")
	self._scrollerListHp = ScrollerList.create(self._tableviewhpGo, self._tablecellhpGo, GameUtil.handler(self._updateHpCell, self), GameUtil.handler(self._clearHpCell, self))
	self._scrollerListWin = ScrollerList.create(self._tableviewwinGo, self._tablecellwinGo, GameUtil.handler(self._updateWinCell, self), GameUtil.handler(self._clearWinCell, self))
	self._lwIconGo = self:getGo("bottomcon/btnTeam/lw/icon")
	self._lwGo = self:getGo("bottomcon/btnTeam/lw")
	self._txtLwNum = self:getTxt("bottomcon/btnTeam/lw/txt")
	self._tablecellstarGo = self:getGo("tablecellstar")
	self._tableviewstarGo = self:getGo("tableviewstar")
	self._scrollerListStar = ScrollerList.create(self._tableviewstarGo, self._tablecellstarGo, GameUtil.handler(self._updateStarCell, self), GameUtil.handler(self._clearStarCell, self))
	self._expSlider = self:getSlider("slider")
	self._txtRefreshCost = self:getTxt("txtRefreshCost")
	self._cutepetIconGo = self:getGo("cutepetIcon")
	self._btnCutepetIcon = self:getBtn("cutepetIcon")
	self._btnTips = self:getBtn("btnTips")
	self._petViewportGo = self:getGo("bottomcon/tableview/effectcon")

	self._scrollerListPet:regReloadFinish(function()
		self:_onPetReloadFinish()
	end)

	self._clippRect = self:getGo("bottomcon/tableview/viewport"):GetComponent(goutil.Type_RectTransform)
end

function GlorybattleshopView:onExit()
	GlorybattleshopView.super.onExit(self)
	self._scrollerList:dispose()
	self._scrollerListPet:dispose()
	self._scrollerListHp:dispose()
	self._scrollerListWin:dispose()
	self._scrollerListStar:dispose()
	uGuiUtil.clearImage(self._cutepetIconGo)
	self:_stopEffectStar()

	if self._effectStarUp then
		UIEffectManager.instance:stopEffect(self._effectStarUp)

		self._effectStarUp = nil
	end

	if self._effectGainNewPet then
		UIEffectManager.instance:stopEffect(self._effectGainNewPet)

		self._effectGainNewPet = nil
	end

	for k, v in pairs(self._petEffects) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._petEffects = {}
end

function GlorybattleshopView:onEnter()
	GlorybattleshopView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.GloryBattleRefreshShopRes, self._updateShopItems, self)
	self.addGEvent(self, GlobalNotify.GloryBattleChangeLockStateRes, self._updateShopItems, self)
	self.addGEvent(self, GlobalNotify.GloryBattleGiveUpRes, self.close, self)
	self.addGEvent(self, GlobalNotify.GloryBattleBuyGoodsRes, self._onGloryBattleBuyGoodsRes, self)
	self.addGEvent(self, GlobalNotify.GloryBattleSalePetRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.GloryBattleOperateHolyStripeRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.GloryBattleInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.CutePetLevelUp, self._onCutePetLevelUp, self)
	self.addGEvent(self, GlobalNotify.GainNewPetCard, self._onGainNewPetCard, self)
	self.addGEvent(self, GlobalNotify.PetGainOrAwakenEffect, self._onPetGainOrAwakenEffect, self)

	self._activityId = self:getFirstParam()

	GloryBattleAgent.instance:sendPM_GloryBattleInfoReq(self._activityId)
	self:_updateUI()
end

function GlorybattleshopView:_onClickbtnClose()
	self:close()
end

function GlorybattleshopView:_onHandleRealMatch()
	local opponent = GlorybattleModel.instance:getOpponent(self._activityId)

	if not opponent or not opponent.headInfo then
		UIStateManager.instance:push(ViewName.GlorybattlematchView, self._activityId)
	else
		GlorybattleController.instance:enterMission(self._activityId)
	end
end

function GlorybattleshopView:_onClickbtnMatch()
	local bagNum = GlorybattleModel.instance:getPetNum(self._activityId)

	if bagNum < 1 then
		FloatWordMgr.instance:show("必须拥有一只以上常规精灵才可进入匹配")

		return
	end

	local num = GlorybattleConfig.instance:getCommonValue("FORMATION_LIMIT_NUM", true)
	local battleNum = GlorybattleModel.instance:getFightPetNum(self._activityId)

	if battleNum < num then
		TipsFacade.instance:openPopupWindow("提示", "当前不足上阵精灵数量是否继续", function()
			self:_onHandleRealMatch()
		end)
	else
		self:_onHandleRealMatch()
	end
end

function GlorybattleshopView:_onClickbtnGiveUp()
	local score = GlorybattleConfig.instance:getCommonValue("GIVE_UP_DEC_SCORE", true)
	local content = string.format("是否放弃本局，放弃后将直接结算扣除本次挑战次数")

	TipsFacade.instance:openPopupWindow("提示", content, function()
		GloryBattleAgent.instance:sendPM_GloryBattleGiveUpReq(self._activityId)
	end)
end

function GlorybattleshopView:_onClickbtnTeam()
	UIStateManager.instance:push(ViewName.GlorybattleteammgrView, self._activityId)
end

function GlorybattleshopView:_onClickbtnRefresh()
	local cost = GlorybattleConfig.instance:getCommonValue("REFRESH_SHOP_COST", true)

	if cost > self._info.challengeInfo.currency then
		FloatWordMgr.instance:show("消耗货币数量不足")

		return
	end

	if GlorybattleModel.instance:isAllShopItemLock(self._activityId) then
		FloatWordMgr.instance:show("您已锁定所有商品不可进行刷新")

		return
	end

	GloryBattleAgent.instance:sendPM_GloryBattleRefreshShopReq(self._activityId)
end

function GlorybattleshopView:_onClickbtnLvTips()
	local curRound = self._info.challengeInfo.curRound
	local genreId = self._info.challengeInfo.genreId
	local tips = GlorybattleController.instance:getShopLvTips(self._activityId, genreId, curRound)

	CommonTipsMgr.instance:showTextTips(tips, self._btnLvTips.gameObject)
end

function GlorybattleshopView:_updateUI()
	self:_getInfo()

	if not self._info or not self._info.challengeInfo or self._info.challengeInfo.genreId <= 0 then
		return
	end

	self._genreId = self._info.challengeInfo.genreId
	self._round = self._info.challengeInfo.curRound
	self._txtRefreshCost.text = GlorybattleConfig.instance:getCommonValue("REFRESH_SHOP_COST")

	self:_updateShopItems()
	self:_updatePets()
	self:_updateOther()
	self:_updateLeft()
end

function GlorybattleshopView:_getInfo()
	self._info = GlorybattleModel.instance:getInfo(self._activityId)
end

function GlorybattleshopView:_updateLeft()
	self._info = GlorybattleModel.instance:getInfo(self._activityId)

	local info = self._info

	if not info then
		return
	end

	local genreCfg = GlorybattleConfig.instance:getGenreCfg(self._activityId, info.challengeInfo.genreId)
	local cutePetLvCfgs = GlorybattleConfig.instance:getCutePetCfgs(genreCfg.cutePetId)
	local maxStar = #cutePetLvCfgs
	local totalRound = GlorybattleConfig.instance:getCommonValue("END_NEED_WIN_TIMES", true)
	local bloodNum = GlorybattleConfig.instance:getCommonValue("ORIGIN_BLOOD", true)
	local decBloodNum = info.challengeInfo.decBloodNum
	local winTime = info.challengeInfo.curRound - info.challengeInfo.decBloodNum
	local cutePetLv = info.challengeInfo.cutePetInfo.level
	local winList = {}
	local hpList = {}
	local starList = {}

	for i = 1, totalRound do
		table.insert(winList, {
			winIdx = i,
			isGray = winTime < i
		})
	end

	for i = 1, bloodNum do
		table.insert(hpList, {
			hpIdx = i,
			isGray = i > bloodNum - decBloodNum
		})
	end

	for i = 1, maxStar do
		table.insert(starList, {
			starIdx = i,
			isGray = cutePetLv < i
		})
	end

	self._scrollerListHp:reloadData(hpList)
	self._scrollerListWin:reloadData(winList)
	self._scrollerListStar:reloadData(starList)
	self:_setCutePetImg(info.challengeInfo.cutePetInfo.cutePetId)
	self:_updateNextStarExp()
end

function GlorybattleshopView:_setCutePetImg(cutePetId)
	local raceId = GlorybattleConfig.instance:getCutePetRaceId(cutePetId)
	local cfg = CutePetConfig.instance:getCutePetById(raceId)
	local url = GameUrl.getCutepetImgUrl(cfg.cardName)

	uGuiUtil.setSpriteToImage(self._cutepetIconGo, uGuiUtil.SpriteType.BigBg, url)
end

function GlorybattleshopView:_updateNextStarExp()
	local info = GlorybattleModel.instance:getInfo(self._activityId)
	local cutePetInfo = info.challengeInfo.cutePetInfo
	local cutePetId = cutePetInfo.cutePetId
	local experience = cutePetInfo.experience
	local level = cutePetInfo.level
	local value = GlorybattleController.instance:calCutePetNextLvExpSliderValue(cutePetId, level, experience)
	local lvCfg = GlorybattleConfig.instance:getCutePetCfg(cutePetId, level)
	local nextlvCfg = GlorybattleConfig.instance:getCutePetCfg(cutePetId, level + 1)
	local needExp = 0

	if lvCfg and nextlvCfg then
		needExp = lvCfg.upgradeNeedExperience
	else
		value = 1
	end

	self._expSlider:SetValue(value)

	self._txtExp.text = string.format("星级经验：%s/%s", experience, needExp)
end

function GlorybattleshopView:_updateOther()
	local shopLv = GlorybattleConfig.instance:getShopLv(self._activityId, self._genreId, self._round)

	self._txtLv.text = string.format("商店Lv.%s", shopLv)
end

function GlorybattleshopView:_updateShopItems()
	local blockInfo = self._info.challengeInfo.blockInfo
	local list = {}

	for i, v in ipairs(blockInfo) do
		if v.goodsId > 0 then
			table.insert(list, v)
		end
	end

	self._scrollerList:reloadData(list)
	self:_updateCurrency()
	self:_updateHasHolyStripeNum()
end

function GlorybattleshopView:_updateCurrency()
	self._txtCoin.text = self._info.challengeInfo.currency
end

function GlorybattleshopView:_updateHasHolyStripeNum()
	local num = 0

	for i, v in ipairs(self._info.challengeInfo.holyStripeInfos) do
		local bindNum = #v.bindCreepsId

		num = bindNum == 0 and num + v.num or num + v.num - bindNum
	end

	local has = num > 0

	goutil.setActive(self._lwGo, has)

	if has then
		self._txtLwNum.text = num
	end
end

function GlorybattleshopView:_updatePets()
	local finalList = {}

	table.insertto(finalList, self._info.challengeInfo.creepsInfos)

	for i, v in ipairs(self._info.challengeInfo.petCardInfos) do
		if v.num > 0 then
			for j = 1, v.num do
				local cardCfg = GlorybattleConfig.instance:getPetCardCfg(self._activityId, v.petCardId)
				local fakeCreepsInfo = {
					isPetCard = true,
					creepsId = cardCfg.creepsId,
					awakenLevel = cardCfg.awakenLevel,
					holyStripeId = cardCfg.holyStripeSuitId,
					petCardId = v.petCardId,
					gainIdx = j
				}

				table.insert(finalList, fakeCreepsInfo)
			end
		end
	end

	self:_sortPets(finalList)
	self._scrollerListPet:reloadData(finalList)
end

function GlorybattleshopView:_sortPets(finalList)
	local orderPets = GlorybattleModel.instance:getGetPetOrderDatas()
	local orderPetsMap = {}

	if orderPets then
		for i, v in ipairs(orderPets) do
			if v.creepsId then
				orderPetsMap[v.creepsId] = v.idx
			end
		end
	end

	table.sort(finalList, function(a, b)
		if a.isPetCard ~= b.isPetCard then
			return a.isPetCard
		end

		local aOrderIdx = orderPetsMap[a.creepsId]
		local bOrderIdx = orderPetsMap[b.creepsId]

		if aOrderIdx and bOrderIdx then
			return aOrderIdx < bOrderIdx
		elseif aOrderIdx then
			return true
		elseif bOrderIdx then
			return false
		end

		if a.awakenLevel ~= b.awakenLevel then
			return a.awakenLevel > b.awakenLevel
		end

		if a.holyStripeId ~= b.holyStripeId then
			return a.holyStripeId > b.holyStripeId
		end

		return a.creepsId < b.creepsId
	end)
end

function GlorybattleshopView:_updateCell(view, cell, data, tag)
	local btnBuy = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnBuy")
	local btnLock = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnLock")
	local goLock = goutil.findChild(cell.gameObject, "btnLock/lock")
	local goUnlock = goutil.findChild(cell.gameObject, "btnLock/unlock")
	local goIconLW = goutil.findChild(cell.gameObject, "lw/iconLW")
	local goLw = goutil.findChild(cell.gameObject, "lw")
	local txtPrice = goutil.findChildTextComponent(cell.gameObject, "btnBuy/price/txtPrice")
	local goPrice = goutil.findChild(cell.gameObject, "btnBuy/price")
	local goTxtSellout = goutil.findChild(cell.gameObject, "btnBuy/txtSellout")
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local goMask = goutil.findChild(cell.gameObject, "mask")
	local btnIcon = Framework.ButtonAdapter.GetFrom(cell.gameObject, "icon")
	local goodsCfg = GlorybattleConfig.instance:getBattleGoodsCfg(data.goodsId)
	local isLock = GlorybattleModel.instance:isShopItemLock(self._activityId, data.blockId)
	local isSellOut = GlorybattleModel.instance:isShopItemBuy(self._activityId, data.blockId)
	local iconUrl = GlorybattleController.instance:getShopItemIconUrl(self._activityId, goodsCfg, data)
	local isPetTryCard = goodsCfg.goodsType == GlorybattleController.GoodsType.PetTryCard

	uGuiUtil.setSpriteToImage(goIcon, uGuiUtil.SpriteType.BigBg, iconUrl)
	GameUtil.SetGray(btnBuy.gameObject, isSellOut)
	goutil.setActive(goLw, isPetTryCard)
	goutil.setActive(goLock, isLock)
	goutil.setActive(goUnlock, not isLock)
	goutil.setActive(goTxtSellout, isSellOut)
	goutil.setActive(goPrice, not isSellOut)
	goutil.setActive(goMask, isPetTryCard)

	txtPrice.text = goodsCfg.cost

	if isPetTryCard then
		local petCardCfg = GlorybattleConfig.instance:getPetCardCfg(self._activityId, goodsCfg.subKey)
		local suitCfg = GlorybattleConfig.instance:getHolyStripeSuitCfg(petCardCfg.holyStripeSuitId)
		local lwIconUrl = string.format("%s.png", suitCfg.iconUrl)

		uGuiUtil.setSpriteToImage(goIconLW, uGuiUtil.SpriteType.BigBg, lwIconUrl)
	end

	btnBuy:AddClickListener(function()
		if isSellOut then
			FloatWordMgr.instance:show("该商品已售罄")

			return
		end

		if goodsCfg.cost > self._info.challengeInfo.currency then
			FloatWordMgr.instance:show("消耗道具数量不足")

			return
		end

		if goodsCfg.goodsType == GlorybattleController.GoodsType.PetLvUpCard then
			if GlorybattleModel.instance:getPetNum(self._activityId) <= 0 then
				FloatWordMgr.instance:show("没有可觉醒的精灵")

				return
			end

			if GlorybattleModel.instance:isAllPetAwakeLevelMax(self._activityId) then
				FloatWordMgr.instance:show("没有可觉醒的精灵")

				return
			end
		end

		GlorybattleController.instance:sendPM_GloryBattleBuyGoodsReq(self._activityId, data.blockId)
	end)
	btnLock:AddClickListener(function()
		if isSellOut then
			FloatWordMgr.instance:show("该商品无需上锁")

			return
		end

		if isLock then
			if not GlorybattleController.LockType.UnLock then
				local changeType = GlorybattleController.LockType.Lock

				GloryBattleAgent.instance:sendPM_GloryBattleChangeLockStateReq(self._activityId, data.blockId, changeType)
			end
		end
	end)
	btnIcon:AddClickListener(function()
		if goodsCfg.clientItemId > 0 then
			CommonTipsMgr.instance:openMaterialTips(btnIcon.gameObject, MatType.Item_Fake, goodsCfg.clientItemId)

			return
		end

		if goodsCfg.goodsType == GlorybattleController.GoodsType.PetTryCard then
			local petMo = GlorybattleModel.instance:getPetCardPetMo(self._activityId, goodsCfg.subKey)

			CommonTipsMgr.instance:showPetTips(petMo)
		elseif goodsCfg.goodsType == GlorybattleController.GoodsType.HolyStripe then
			UIStateManager.instance:push(ViewName.GlorybattlelwtipsView, goodsCfg.subKey)
		elseif goodsCfg.goodsType == GlorybattleController.GoodsType.RandomGenrePet then
			local petMo = GlorybattleModel.instance:getPetMo(self._activityId, data.extParam)

			CommonTipsMgr.instance:showPetTips(petMo)
		end
	end)
end

function GlorybattleshopView:_clearCell(cell)
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local goIconLW = goutil.findChild(cell.gameObject, "lw/iconLW")

	uGuiUtil.clearImage(goIcon)
	uGuiUtil.clearImage(goIconLW)
end

function GlorybattleshopView:_updatePetCell(view, cell, creepsInfo, tag)
	local conGo = goutil.findChild(cell.gameObject, "con")
	local lwconGo = goutil.findChild(cell.gameObject, "lw")
	local lwIconGo = goutil.findChild(cell.gameObject, "lw/lwIcon")
	local limitGo = goutil.findChild(cell.gameObject, "limit")
	local btnLw = Framework.ButtonAdapter.Get(lwIconGo)
	local petMo = creepsInfo.isPetCard and GlorybattleModel.instance:getPetCardPetMo(self._activityId, creepsInfo.petCardId) or GlorybattleModel.instance:getPetMo(self._activityId, creepsInfo.creepsId)
	local holyStripeInfo = GlorybattleModel.instance:getHolyStripeInfo(self._activityId, creepsInfo.creepsId)

	goutil.setActive(lwconGo, holyStripeInfo or creepsInfo.isPetCard)
	goutil.setActive(limitGo, creepsInfo.isPetCard)

	if holyStripeInfo then
		local holyStripeCfg = GlorybattleConfig.instance:getHolyStripeSuitCfg(holyStripeInfo.holyStripeId)
		local url = string.format("%s.png", holyStripeCfg.iconUrl)

		uGuiUtil.setSpriteToImage(lwIconGo, uGuiUtil.SpriteType.BigBg, url)
	elseif creepsInfo.isPetCard then
		local petCardCfg = GlorybattleConfig.instance:getPetCardCfg(self._activityId, creepsInfo.petCardId)
		local holyStripeCfg = GlorybattleConfig.instance:getHolyStripeSuitCfg(petCardCfg.holyStripeSuitId)
		local url = string.format("%s.png", holyStripeCfg.iconUrl)

		uGuiUtil.setSpriteToImage(lwIconGo, uGuiUtil.SpriteType.BigBg, url)
	end

	local proxy = MaterialMgr.setCellByMo(petMo, conGo)

	proxy.binder:setLvl(0)
	proxy.binder:setClickCallBack(function()
		CommonTipsMgr.instance:showPetTips(petMo)
	end)
	proxy.binder:showStarByCustom(creepsInfo.awakenLevel)
	btnLw:AddClickListener(function()
		if holyStripeInfo then
			local holyStripeCfg = GlorybattleConfig.instance:getHolyStripeSuitCfg(holyStripeInfo.holyStripeId)

			UIStateManager.instance:push(ViewName.GlorybattlelwtipsView, holyStripeCfg.suitId)
		end
	end)
	self:_stopEffectPet(cell.gameObject)

	if not creepsInfo.isPetCard and self._petEffectDataMap and self._petEffectDataMap[creepsInfo.creepsId] then
		local ed = self._petEffectDataMap[creepsInfo.creepsId]

		if ed.isNewGain then
			local effName = "20251024/pvp/fx_ui_touxiang02_pvp.prefab"

			self:_playEffectPet(cell.gameObject, effName, 50, -48)
		elseif ed.isAwakenLevelUp then
			local effName = "20251024/pvp/fx_ui_shengji_pvp.prefab"

			self:_playEffectPet(cell.gameObject, effName, 51, -49)
		end

		self._petEffectDataMap[creepsInfo.creepsId] = nil
	end

	if creepsInfo.isPetCard and self._petCardEffectData and self._petCardEffectData.petCardId == creepsInfo.petCardId and self._petCardEffectData.gainIdx == creepsInfo.gainIdx then
		local effName = "20251024/pvp/fx_ui_touxiang02_pvp.prefab"

		self:_playEffectPet(cell.gameObject, effName, 50, -48)

		self._petCardEffectData = nil
	end
end

function GlorybattleshopView:_playEffectPet(go, effName, offsetX, offsetY)
	local eff

	eff = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false, nil, nil, function()
		eff:setClipping(self._clippRect)
	end)

	eff:setParent(go.transform)
	eff:setScale(1)
	eff:setLocalPos(offsetX, offsetY, 0)

	self._petEffects[go] = eff
end

function GlorybattleshopView:_stopEffectPet(go)
	local eff = self._petEffects[go]

	if eff then
		self._petEffects[go] = nil

		UIEffectManager.instance:stopEffect(eff)
	end
end

function GlorybattleshopView:_clearPetCell(cell)
	local conGo = goutil.findChild(cell.gameObject, "con")
	local lwIconGo = goutil.findChild(cell.gameObject, "lw/lwIcon")

	MaterialMgr.resetAll(conGo)
	uGuiUtil.clearImage(lwIconGo)
end

function GlorybattleshopView:_updateHpCell(view, cell, data, tag)
	GameUtil.SetGray(cell.gameObject, data.isGray)
end

function GlorybattleshopView:_clearHpCell(cell)
	return
end

function GlorybattleshopView:_updateWinCell(view, cell, data, tag)
	local goIcon = goutil.findChild(cell.gameObject, "icon")

	goutil.setActive(goIcon, not data.isGray)
end

function GlorybattleshopView:_clearWinCell(cell)
	return
end

function GlorybattleshopView:_onGloryBattleBuyGoodsRes()
	self:_getInfo()
	self:_updateShopItems()
	self:_updatePets()
	self:_updateLeft()

	local key = GlorybattleController.CurrencyKey .. self._activityId
	local forecastCurrency = checknumber(GameUtil.getUserData(key))
	local diffCurrency = self._info.challengeInfo.currency - forecastCurrency

	if forecastCurrency ~= 0 and diffCurrency > 0 then
		local shopCostMat = GlorybattleConfig.instance:getCommonValue("SHOP_COST_MAT")
		local list = {}
		local type, id, num = MaterialMgr.getMatParams(shopCostMat)

		if type == MatType.Item_Fake then
			local mo = MaterialModel.instance:UpdateMaterial(MatType.Item_Fake, id, diffCurrency)

			table.insert(list, mo)
		end

		local obj = {}

		obj.items = list
		obj.ci = 0

		MaterialController.instance:addInList(MaterialController.TYPE_ITEMSET, obj)
		MaterialController.instance:checkAndOpenDisplay()

		local tip = string.format("部分精灵已满觉，返还%d货币", diffCurrency)

		FloatWordMgr.instance:show(tip)
	end
end

function GlorybattleshopView:_updateStarCell(view, cell, data, tag)
	GameUtil.SetGray(cell.gameObject, data.isGray)

	if self._starEffectIdx == cell.data then
		self._starEffectIdx = nil

		self:_playEffectStar(cell.gameObject)
	end
end

function GlorybattleshopView:_playEffectStar(go)
	self:_stopEffectStar()

	local effName = "20251024/pvp/fx_ui_xingxing_pvp.prefab"

	self._effectHandlerStar = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false)

	self._effectHandlerStar:setParent(go.transform)
	self._effectHandlerStar:setScale(1)
	self._effectHandlerStar:setLocalPos(20, -17.2, 0)
end

function GlorybattleshopView:_stopEffectStar()
	if self._effectHandlerStar then
		UIEffectManager.instance:stopEffect(self._effectHandlerStar)

		self._effectHandlerStar = nil
	end
end

function GlorybattleshopView:_clearStarCell(cell)
	return
end

function GlorybattleshopView:_onClickcutepetIcon()
	local info = GlorybattleModel.instance:getInfo(self._activityId)
	local cutePetInfo = info.challengeInfo.cutePetInfo

	UIStateManager.instance:push(ViewName.GlorycutepetsimpletipView, cutePetInfo.cutePetId, cutePetInfo.level)
end

function GlorybattleshopView:_onClickbtnTips()
	local list = {}

	for i = 1, 3 do
		table.insert(list, {
			desc = "",
			url = GameUrl.getBigbgPngUrl("pvpwf/board_pvpwf_guize_0" .. i)
		})
	end

	UIStateManager.instance:push(ViewName.DivineMiYaClgImgRuleView, list, "规则说明")
end

function GlorybattleshopView:_onCutePetLevelUp()
	local info = GlorybattleModel.instance:getInfo(self._activityId)
	local cutePetInfo = info.challengeInfo.cutePetInfo

	self._starEffectIdx = cutePetInfo.level

	self._scrollerListStar:refresh()
	self:_playEffectStarUp()
end

function GlorybattleshopView:_playEffectStarUp()
	local effName = "20251024/pvp/fx_ui_shengji2_pvp.prefab"

	self._effectStarUp = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false)

	self._effectStarUp:setParent(self._cutepetIconGo.transform)
	self._effectStarUp:setScale(1)
	self._effectStarUp:setLocalPos(0, 0, 0)
end

function GlorybattleshopView:_playGainNewPetEffect()
	local effName = "20251024/pvp/fx_ui_touxiang01_pvp.prefab"

	self._effectGainNewPet = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, false)

	self._effectGainNewPet:setParent(self._petViewportGo.transform)
	self._effectGainNewPet:setScale(1)
	self._effectGainNewPet:setLocalPos(454, 176, 0)
end

function GlorybattleshopView:_onGainNewPetCard(petCardId, gainIdx)
	self._petCardEffectData = {
		petCardId = petCardId,
		gainIdx = gainIdx
	}
end

function GlorybattleshopView:_onPetGainOrAwakenEffect(effectDataMap)
	self._petEffectDataMap = effectDataMap

	local hasNew = false

	for i, v in pairs(effectDataMap) do
		if v.isNewGain then
			hasNew = true

			break
		end
	end

	if hasNew then
		self:_playGainNewPetEffect()
	end
end

function GlorybattleshopView:_onPetReloadFinish()
	self._petCardEffectData = nil
	self._petEffectDataMap = nil
end

return GlorybattleshopView
