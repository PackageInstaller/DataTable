-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryView.lua

module("logic.extensions.lottery.view.LotteryView", package.seeall)

local LotteryView = class("LotteryView", TableViewComponent)

LotteryView.DivineBountyData = {
	petBg = "bg_shenyaotedian.png",
	tabName = "神曜特典",
	viewName = ViewName.DivineBountyView
}
LotteryView.DivineBountyIndex = 1

function LotteryView:ctor()
	LotteryView.super.ctor(self)

	self.choIndex = 1
	self.clickTimer = 0
	self.oneFreeEff = nil
	self.tenFreeEff = nil
	self.shopGiftCfg = nil
	self.expandGiftCfg = nil
end

function LotteryView:onExit()
	self.clickTimer = 0

	if ViewMgr.instance:isOpen(ViewName.LotteryMaterial) then
		ViewMgr.instance:close(ViewName.LotteryMaterial)
	end

	removetimer(self.CalculationSurplusTime, self)

	if self.viewBgEff then
		UIEffectManager.instance:stopEffect(self.viewBgEff)

		self.viewBgEff = nil
	end

	if self.longyanEff then
		UIEffectManager.instance:stopEffect(self.longyanEff)

		self.longyanEff = nil
	end

	if self.oneFreeEff then
		UIEffectManager.instance:stopEffect(self.oneFreeEff)

		self.oneFreeEff = nil
	end

	if self.tenFreeEff then
		UIEffectManager.instance:stopEffect(self.tenFreeEff)

		self.tenFreeEff = nil
	end

	ViewBlockMgr.instance:blockClick(false, self)

	self.choIndex = 1

	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self.OnCurrencyCountChange, self)
	GlobalDispatcher:removeListener(LotteryModel.UpdataZhaohuanTimes, self.UpdataCountAndOpenView, self)
	GlobalDispatcher:removeListener("UpdataChoiseGroupPoolId", self.SetCurrentChoiseIndex, self)
	GlobalDispatcher:removeListener(PayShopController.NotifyPayShopItemBuySucRes, self._onShopItemBuySucRes, self)
end

function LotteryView:destroyUI()
	self.petTrainList = nil

	local bgBig = self.viewBgImaGo:GetComponent("ImageBigBG")

	if bgBig then
		bgBig:ClearImage()
	end

	local shopBg = self.shopIconIma.gameObject:GetComponent("ImageBigBG")

	if shopBg then
		shopBg:ClearImage()
	end

	local scoreBg = self.scoreImaGo:GetComponent("ImageBigBG")

	if scoreBg then
		scoreBg:ClearImage()
	end

	local scoreBg2 = self.scoreIconIma.gameObject:GetComponent("ImageBigBG")

	if scoreBg2 then
		scoreBg2:ClearImage()
	end

	local wishBg = self.wishImaGo:GetComponent("ImageBigBG")

	if wishBg then
		wishBg:ClearImage()
	end

	local opBg = self.opeIconGo:GetComponent("ImageBigBG")

	if opBg then
		opBg:ClearImage()
	end

	self.shopGiftCfg = nil
	self.expandGiftCfg = nil
end

function LotteryView:bindEvents()
	LotteryView.super.bindEvents(self)
	self.viewCloseBtn:AddClickListener(self._onClickBtnClose, self)
	self.scoreItemBtn:AddClickListener(self._onClickScoreItem, self)
	self.scoreAddBtn:AddClickListener(self._onClickScoreAdd, self)
	GameUtil.asBtn(self.daibiAddBtnGo):AddClickListener(self._onClickDaibiAdd, self)
	GameUtil.asBtn(self.diamondAddBtnGo):AddClickListener(self._onClickDiamondAdd, self)
	GameUtil.asBtn(self.oneClickBtnGo):AddClickListener(function()
		self:OnClickCallSpriteBtn(true)
	end, self)
	GameUtil.asBtn(self.tenClickBtnGo):AddClickListener(function()
		self:OnClickCallSpriteBtn(false)
	end, self)
	GameUtil.asBtn(self.JackpotClickBtnGo):AddClickListener(self._onClickJackpot, self)
	GameUtil.addClickHandler(self.shopBtn, self._onClickShop, self)
	GameUtil.addClickHandler(self.expandShopBtn, self._onClickExpandShop, self)
	GameUtil.addClickHandler(self.scoreBtn, function()
		local poolCfg = self._curViewDatas[self.choIndex].tabData.poolCfg

		if poolCfg == nil or checknumber(poolCfg.poolId) < 1 then
			return
		end

		LotteryModel.instance.openTabIndex = self.choIndex

		UIStateManager.instance:push(ViewName.LotteryScore, poolCfg.poolId)
	end, self)
	GameUtil.addClickHandler(self.wishBtn, function()
		local poolCfg = self._curViewDatas[self.choIndex].tabData.poolCfg

		if poolCfg == nil or checknumber(poolCfg.poolId) < 1 then
			return
		end

		local stage, need, have = LotteryModel.instance:GetWishPoolStage(poolCfg.poolId)

		if stage < 0 then
			return
		end

		if stage > 0 and checknumber(need) > checknumber(have) then
			FloatWordMgr.instance:show(langPara("text_lottery_desc_1", checknumber(need) - checknumber(have)))

			return
		end

		LotteryModel.instance.openTabIndex = self.choIndex

		UIStateManager.instance:push(ViewName.LotteryWish, poolCfg.poolId)
	end, self)
	self.zhaohuanBtn:AddClickListener(self.OpenLotteryCountView, self)
	self.spriteSkillBtn:AddClickListener(function()
		self:OnClickSkillExplainBtn(true)
	end, self)
	self.spriteTestBtn:AddClickListener(self.OnClickSpriteTestBtn, self)
	self.spriteExplainBtn:AddClickListener(self.OnClickSkillExplainBtn, self)
	self.groupClickBtn:AddClickListener(function()
		local data = self._curViewDatas[self.choIndex].tabData

		if data == nil or data.groupCfg == nil or data.poolCfg == nil then
			return
		end

		UIStateManager.instance:push(ViewName.LotteryGroup, {
			groupId = data.groupCfg.groupId,
			poolId = data.poolCfg.poolId,
			idList = data.groupCfg.poolIds
		})
	end, self)
	self.tipsBtn:AddClickListener(function()
		TipsFacade.instance:openTipWindow("优化说明", lang("text_lottery_desc_33"), nil, lang("tip_know"))
	end, self)
	self.operateBtn:AddClickListener(function()
		if self._operateCfg == nil then
			FloatWordMgr.instance:show("当前特惠活动已结束！")

			return
		end

		UIStateManager.instance:push(ViewName.LotteryOperate, self._operateCfg)
	end, self)
	GameUtil.addClickHandler(self.btn_2, self.clickJumpFunc, self)
	self._btnSkip:AddClickListener(self._onClickbtnSkip, self)
end

function LotteryView:unbindEvents()
	LotteryView.super.unbindEvents(self)
	self.viewCloseBtn:RemoveClickListener()
	self.scoreItemBtn:RemoveClickListener()
	self.scoreAddBtn:RemoveClickListener()
	GameUtil.asBtn(self.daibiAddBtnGo):RemoveClickListener()
	GameUtil.asBtn(self.diamondAddBtnGo):RemoveClickListener()
	GameUtil.asBtn(self.oneClickBtnGo):RemoveClickListener()
	GameUtil.asBtn(self.tenClickBtnGo):RemoveClickListener()
	GameUtil.asBtn(self.JackpotClickBtnGo):RemoveClickListener()
	self.spriteSkillBtn:RemoveClickListener()
	self.spriteTestBtn:RemoveClickListener()
	self.spriteExplainBtn:RemoveClickListener()
	self.groupClickBtn:RemoveClickListener()
	self.tipsBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self.shopBtn)
	GameUtil.rmClickHandler(self.expandShopBtn)
	GameUtil.rmClickHandler(self.scoreBtn)
	GameUtil.rmClickHandler(self.wishBtn)
	self.zhaohuanBtn:RemoveClickListener()
	self.operateBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self.btn_2)
	self._btnSkip:RemoveClickListener()
end

function LotteryView:buildUI()
	LotteryView.super.buildUI(self)

	self.viewBgImaGo = self:getGo("viewBgIma")
	self.viewCloseBtn = self:getBtn("upShowTran/viewCloseBtn")
	self._upItems = self:getGo("upShowTran/items")

	local scoreItem = self:getGo("upShowTran/items/scoreItem")

	self.scoreItemBtn = self:getBtn("upShowTran/items/scoreItem")
	self.scoreAddBtn = self:getBtn("upShowTran/items/scoreItem/scoreAddBtn")
	self.scoreIconIma = goutil.findChild(scoreItem, "scoreIconIma"):GetComponent("Image")
	self.scoreCountTxt = goutil.findChild(scoreItem, "scoreCountTxt"):GetComponent("Text")

	local daibiItem = self:getGo("upShowTran/items/daibiItem")

	self.daibiIconIma = goutil.findChild(daibiItem, "daibiIconIma"):GetComponent("Image")
	self.daibiCountTxt = goutil.findChild(daibiItem, "daibiCountTxt"):GetComponent("Text")
	self.daibiAddBtnGo = goutil.findChild(daibiItem, "daibiAddBtn")

	local diamondItem = self:getGo("upShowTran/items/diamondItem")

	self.diamondCountTxt = goutil.findChild(diamondItem, "diamondCountTxt"):GetComponent("Text")
	self.diamondAddBtnGo = goutil.findChild(diamondItem, "diamondAddBtn")
	self.spriteSkillBtn = self:getBtn("spriteSkillBtn")
	self.spriteTestBtn = self:getBtn("spriteTestBtn")
	self.testRedGo = self:getGo("spriteTestBtn/testRedGo")
	self.spriteExplainBtn = self:getBtn("spriteExplainBtn")

	self.testRedGo:SetActive(false)
	self.spriteTestBtn.gameObject:SetActive(false)

	local viewDownGo = self:getGo("viewDownTran")

	self._viewDownGo = viewDownGo
	self.cycleDesIma = goutil.findChild(viewDownGo, "cycleDesIma"):GetComponent("UIImageSpriteChange")
	self.cycleNum_1 = goutil.findChild(viewDownGo, "cycleCountGo/cycleNum_1"):GetComponent("UIImageSpriteChange")
	self.cycleNum_2 = goutil.findChild(viewDownGo, "cycleCountGo/cycleNum_2"):GetComponent("UIImageSpriteChange")
	self.oneClickBtnGo = goutil.findChild(viewDownGo, "oneClickBtn")
	self.oneFreeGo = goutil.findChild(self.oneClickBtnGo, "oneFreeGo")
	self.oneFreeTxt = goutil.findChildTextComponent(self.oneFreeGo, "oneFreeTxt")
	self.oneNeedGo = goutil.findChild(viewDownGo, "oneNeedGo")
	self.oneNeedIma = goutil.findChild(self.oneNeedGo, "oneNeedIma"):GetComponent("Image")
	self.oneNeedTxt = goutil.findChild(self.oneNeedGo, "oneNeedTxt"):GetComponent("Text")
	self.tenClickBtnGo = goutil.findChild(viewDownGo, "tenClickBtn")
	self.tenRedGo = goutil.findChild(self.tenClickBtnGo, "tenRedGo")
	self.tenFreeGo = goutil.findChild(self.tenClickBtnGo, "tenFreeGo")
	self.tenFreeTxt = goutil.findChildTextComponent(self.tenFreeGo, "tenFreeTxt")
	self.tenNeedGo = goutil.findChild(viewDownGo, "tenNeedGo")
	self.tenNeedIma = goutil.findChild(self.tenNeedGo, "tenNeedIma"):GetComponent("Image")
	self.tenNeedTxt = goutil.findChild(self.tenNeedGo, "tenNeedTxt"):GetComponent("Text")
	self.JackpotClickBtnGo = goutil.findChild(viewDownGo, "JackpotClickBtn")
	self.shopBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "shopBtn")
	self.shopIconIma = goutil.findChild(viewDownGo, "shopBtn/shopIconIma"):GetComponent("Image")
	self.shopZheTxt = goutil.findChild(viewDownGo, "shopBtn/shopZheTxt"):GetComponent("Text")
	self.shopNameTxt = goutil.findChild(viewDownGo, "shopBtn/shopNameTxt"):GetComponent("Text")
	self.scoreBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "scoreBtn")
	self.scoreImaGo = goutil.findChild(viewDownGo, "scoreBtn/scoreIma")
	self.scoreTxt = goutil.findChild(viewDownGo, "scoreBtn/scoreTxt"):GetComponent("Text")
	self.scoreRed = goutil.findChild(viewDownGo, "scoreBtn/scoreRed")
	self.wishBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "wishBtn")
	self.wishImaGo = goutil.findChild(viewDownGo, "wishBtn/wishIma")
	self.unLockGo = goutil.findChild(viewDownGo, "wishBtn/unLockGo")
	self.wishRed = goutil.findChild(viewDownGo, "wishBtn/wishRed")
	self.groupClickBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "groupClickBtn")
	self.groupIma = goutil.findChild(viewDownGo, "groupClickBtn/groupIma"):GetComponent("UIImageSpriteChange")
	self.tipsBtn = self:getBtn("tipsBtn")
	self.operateBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "operateBtn")
	self.opeIconGo = goutil.findChild(viewDownGo, "operateBtn/operateIconIma")
	self.operateTagGo = goutil.findChild(viewDownGo, "operateBtn/operateTagGo")
	self.operateZheTxt = goutil.findChildTextComponent(self.operateTagGo, "operateZheTxt")
	self.operateNameTxt = goutil.findChildTextComponent(viewDownGo, "operateBtn/operateNameTxt")
	self.goGDC = self:getGo("goldenDiamondCard")
	self.itemGDC = goutil.findChild(self.goGDC, "item")
	self.showTip = goutil.findChildTextComponent(self.goGDC, "showTip")
	self.colorChange = goutil.findChildComponent(self.goGDC, "showTip", "UITextColorChange")

	self.oneFreeGo:SetActive(false)
	self.tenRedGo:SetActive(false)
	self.tenFreeGo:SetActive(false)

	self.shopZheTxt.text = ""
	self.shopNameTxt.text = ""

	GameUtil.SetActive(self.shopBtn, false)

	self.scoreTxt.text = ""

	self.scoreRed:SetActive(false)
	GameUtil.SetActive(self.wishRed, false)
	GameUtil.SetActive(self.unLockGo, false)
	GameUtil.SetActive(self.wishBtn, false)
	GameUtil.SetActive(self.groupClickBtn, false)
	GameUtil.SetActive(self.tipsBtn, false)

	self.operateZheTxt.text = ""
	self.operateNameTxt.text = ""

	GameUtil.SetActive(self.operateTagGo, false)
	GameUtil.SetActive(self.operateBtn, false)

	self.longyanGo = self:getGo("longyanGo")
	self.proogSlid = goutil.findChild(self.longyanGo, "proogSlid"):GetComponent("Slider")
	self.proogTxt = goutil.findChild(self.longyanGo, "proogTxt"):GetComponent("Text")
	self.startTxt = goutil.findChild(self.longyanGo, "startTxt"):GetComponent("Text")
	self.endTxt = goutil.findChild(self.longyanGo, "endTxt"):GetComponent("Text")
	self.showTimeTxt = goutil.findChild(self.longyanGo, "showTimeTxt"):GetComponent("Text")
	self.zhaohuanBtn = Framework.ButtonAdapter.GetFrom(self.longyanGo, "zhaohuanBtn")
	self.showTimeTxt.text = ""

	self.longyanGo:SetActive(false)

	self.expandShopBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "expandShopBtn")
	self.expandIconIma = goutil.findChild(viewDownGo, "expandShopBtn/expandIconIma"):GetComponent("Image")
	self.expandNameTxt = goutil.findChild(viewDownGo, "expandShopBtn/expandNameTxt"):GetComponent("Text")
	self.expandRedGo = goutil.findChild(viewDownGo, "expandShopBtn/expandRedGo")
	self.expandNameTxt.text = ""

	GameUtil.SetActive(self.expandRedGo, false)
	GameUtil.SetActive(self.expandShopBtn, false)

	self.btn_1 = self:getGo("btn_1")
	self.btn_2 = self:getGo("btn_2")
	self._subParentGo = self:getGo("subParentGo")

	self:setSelectBtn(self.btn_1, true)
	self:setSelectBtn(self.btn_2, false)

	self._viewDownTranBgGo = self:getGo("viewDownTranBg")
	self._skipGo = self:getGo("skip")
	self._btnSkip = self:getBtn("skip/btnSkip")
	self._skipGouGo = self:getGo("skip/skipGou")
end

function LotteryView:setSelectBtn(btn, boo)
	local unselect = goutil.findChild(btn, "unselect")
	local selected = goutil.findChild(btn, "selected")

	GameUtil.SetActive(selected, boo)
	GameUtil.SetActive(unselect, not boo)
end

function LotteryView:clickJumpFunc()
	local funcId = 323

	if FuncOpenModel.instance:getFuncIsOpen(funcId) then
		FuncOpenController.instance:openFunc(funcId)
		self:close()
	end
end

function LotteryView:onEnter()
	LotteryView.super.onEnter(self)

	LotteryModel.instance.isFirstLogin = false

	UIStateManager.instance:updateParms(self._viewPresentor.viewName, nil)

	self.petTrainList = LotteryConfig.instance:GetPetTrainParams()

	GameUtil.SetActive(self.groupClickBtn, false)
	GameUtil.SetActive(self.tipsBtn, false)

	self.choIndex = LotteryModel.instance.openTabIndex

	self:SetCurrentChoiseIndex(self:getFirstParam())
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self.OnCurrencyCountChange, self)
	GlobalDispatcher:addListener(LotteryModel.UpdataZhaohuanTimes, self.UpdataCountAndOpenView, self)
	GlobalDispatcher:addListener("UpdataChoiseGroupPoolId", self.SetCurrentChoiseIndex, self)
	self.addGEvent(self, LotteryAgent.LotteryDrawRes, self._onLotteryDrawRes, self)
	LotteryController.instance:CSRequestLotteryInfo()
end

function LotteryView:SetCurrentChoiseIndex(poolId)
	self._hasDivineBounty = FuncOpenModel.instance:getFuncIsOpen(1119)

	local curChoIndex = self.choIndex

	if self._hasDivineBounty then
		curChoIndex = curChoIndex - 1
	end

	local tempChoIndex, lotterTabDatas = LotteryModel.instance:getOpenPoolIndex(curChoIndex, poolId)

	if self._hasDivineBounty and (self.choIndex ~= LotteryView.DivineBountyIndex or checknumber(poolId) > 0) then
		self.choIndex = tempChoIndex + 1
	end

	self._curViewDatas = {}

	if self._hasDivineBounty then
		table.insert(self._curViewDatas, LotteryView.DivineBountyData)
	end

	for i, v in ipairs(lotterTabDatas) do
		if BootstrapPjaqGameConfigMgr.isReview and checkbool(v.poolCfg.hideWithReview) then
			-- block empty
		else
			table.insert(self._curViewDatas, {
				tabData = v,
				tabName = v.poolCfg.name
			})
		end
	end

	self._tableview:ReloadData()
	self:UpdataZhaohuanView()
end

function LotteryView:UpdataCountAndOpenView(index)
	index = index or self.choIndex

	self:UpdataZhaohuanView(index)

	if index == LotteryView.DivineBountyIndex or BootstrapPjaqGameConfigMgr.isReview then
		return
	end

	local value = GameUtil.getUserDayData("OpenLotteryCountView" .. index)
	local isOpen = false

	if checknumber(value) ~= 1 and self._curViewDatas then
		GameUtil.saveUserDayData("OpenLotteryCountView" .. index, 1)

		local tabStructData = self._curViewDatas[index]
		local tabData = tabStructData.tabData

		if tabData and string.nilorempty(tabData.poolCfg.jumpTo) then
			local prizeData = LotteryModel.instance:GetLotteryProgressCfg(tabData.poolCfg.poolId)

			if prizeData == nil or not prizeData.isFull then
				isOpen = self:OpenLotteryCountView()
			end
		end
	end

	local tabStructData = self._curViewDatas[index]
	local tabData = tabStructData.tabData

	if tabStructData and tabData and tabData.poolCfg then
		LotteryController.instance:checkMustPickPet(tabData.poolCfg.poolId, (tabData.groupCfg or nil) and tabData.groupCfg.groupId)
	end

	if not isOpen and tabData.poolCfg.poolInGroup then
		local va = GameUtil.getUserDayData("OpenLotteryView_Group")

		if checknumber(va) ~= 1 then
			GameUtil.saveUserDayData("OpenLotteryView_Group", 1)
			TipsFacade.instance:openTipWindow("优化说明", lang("text_lottery_desc_33"), nil, lang("tip_know"))
		end
	end
end

function LotteryView:UpdataZhaohuanView(index)
	self.choIndex = index or self.choIndex

	self:_updateViewObjActiveByIndex(self.choIndex)
	self:showTabAt(self._subParentGo)
	self._tableview:ReloadData()
	self:_updateSkipAnimState()

	local tabStructData = self._curViewDatas[self.choIndex]

	if not string.nilorempty(tabStructData.viewName) then
		local path = "ui/bigbg/zhaohuan/" .. tabStructData.petBg

		uGuiUtil.setSpriteToImage(self.viewBgImaGo, uGuiUtil.SpriteType.BigBg, path)
		self:showTabAt(self._subParentGo, tabStructData.viewName)

		return
	end

	local tabData = self._curViewDatas[self.choIndex].tabData
	local poolCfg = tabData.poolCfg

	if poolCfg == nil or checknumber(poolCfg.petId) < 1 then
		return
	end

	local path = "ui/bigbg/zhaohuan/" .. poolCfg.petBg

	uGuiUtil.setSpriteToImage(self.viewBgImaGo, uGuiUtil.SpriteType.BigBg, path)

	local isScore = LotteryModel.instance:IsShowScoreBtn(poolCfg.poolId)

	GameUtil.SetActive(self.scoreBtn, isScore)

	if poolCfg.poolId == 6 then
		if self.viewBgEff then
			UIEffectManager.instance:stopEffect(self.viewBgEff)

			self.viewBgEff = nil
		end

		if self.longyanEff == nil then
			local path = "fx_ui_zhaohuanmianban/fx_ui_zhaohuan_fenwei.prefab"

			self.longyanEff = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
				Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
			end)

			self.longyanEff:setParent(self.viewBgImaGo.transform)
			self.longyanEff:setScale(1)
		end
	else
		if self.longyanEff then
			UIEffectManager.instance:stopEffect(self.longyanEff)

			self.longyanEff = nil
		end

		if self.viewBgEff == nil then
			local path = "fx_ui_zhaohuanmianban/fx_ui_zhaohuanmianban_bg.prefab"

			self.viewBgEff = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
				Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
			end)

			self.viewBgEff:setParent(self.viewBgImaGo.transform)
			self.viewBgEff:setScale(1)
		end
	end

	if poolCfg.poolId == 63 then
		local value = GameUtil.getUserData("OpenMultipleGift")

		if checknumber(value) ~= 1 then
			GameUtil.saveUserData("OpenMultipleGift", 1)
			UIStateManager.instance:push(ViewName.MultiplegiftpacksView)
		end
	end

	local groupCfg = tabData.groupCfg

	if groupCfg then
		GameUtil.SetActive(self.groupClickBtn, true)
		GameUtil.SetActive(self.tipsBtn, true)

		local index = 1

		for i = 1, #groupCfg.poolIds do
			if groupCfg.poolIds[i] == poolCfg.poolId then
				index = i

				break
			end
		end

		self.groupIma:SetState(index - 1)
	else
		GameUtil.SetActive(self.groupClickBtn, false)
		GameUtil.SetActive(self.tipsBtn, false)
	end

	local stage, need, have = LotteryModel.instance:GetWishPoolStage(poolCfg.poolId)

	if stage < 0 then
		GameUtil.SetActive(self.wishRed, false)
		GameUtil.SetActive(self.unLockGo, false)
		GameUtil.SetActive(self.wishBtn, false)
	else
		local wishPetId = LotteryModel.instance:GetWishPoolPetId(poolCfg.poolId)

		if checknumber(wishPetId) > 0 then
			MaterialMgr.setIcon(self.wishImaGo, MatType.Pet, wishPetId)
		else
			uGuiUtil.setSpriteToImage(self.wishImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl("icon_10300_mininuo"))
		end

		GameUtil.SetActive(self.unLockGo, checknumber(need) > checknumber(have))
		GameUtil.SetActive(self.wishBtn, true)
		GameUtil.SetActive(self.wishRed, LotteryModel.instance:GetWishPoolRedPoint(poolCfg.poolId))
	end

	if self.petTrainList == nil or self.petTrainList[poolCfg.petId] == nil then
		self.testRedGo:SetActive(false)
		self.spriteTestBtn.gameObject:SetActive(false)
		self.spriteSkillBtn.gameObject:SetActive(true)
	else
		self.spriteSkillBtn.gameObject:SetActive(false)
		self.spriteTestBtn.gameObject:SetActive(true)

		local isSkillRed = PetCollegeModel.instance:canBattleByRaceId(poolCfg.petId)

		self.testRedGo:SetActive(isSkillRed)
	end

	local index = 2

	if checknumber(poolCfg.imageIndex) > 0 then
		GameUtil.SetActive(self.cycleDesIma, true)
		self.cycleDesIma:SetState(poolCfg.imageIndex - 1)

		index = poolCfg.imageIndex
	else
		GameUtil.SetActive(self.cycleDesIma, false)
	end

	GameUtil.SetActive(self.cycleNum_1, false)
	GameUtil.SetActive(self.cycleNum_2, false)

	if checknumber(poolCfg.cycleCount) > 0 then
		local supCount = LotteryModel.instance:GetLotteryExplicitCfg(poolCfg.poolId)

		if supCount <= 0 then
			supCount = 40
		end

		if supCount > 99 then
			supCount = 99
		end

		GameUtil.SetActive(self.cycleNum_1, true)

		if supCount > 9 then
			local shi = math.floor(supCount / 10)
			local ge = supCount - shi * 10

			self.cycleNum_1:SetState((index - 2) * 10 + shi)
			GameUtil.SetActive(self.cycleNum_2, true)
			self.cycleNum_2:SetState((index - 2) * 10 + ge)
		else
			self.cycleNum_1:SetState((index - 2) * 10 + supCount)
		end
	end

	self:SetLongyanXinshou()

	if not string.nilorempty(poolCfg.pointPrize) then
		local prizeList = string.split(poolCfg.pointPrize, ":")

		if prizeList and checknumber(prizeList[2]) == 19 then
			self.scoreTxt.text = lang("text_lottery_shenhuan")

			uGuiUtil.setSpriteToImage(self.scoreImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl("icon_shenhuanjifn"))
		else
			self.scoreTxt.text = lang("text_lottery_zhaohuan")

			uGuiUtil.setSpriteToImage(self.scoreImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl("icon_zhaohuanjifn"))
		end
	else
		self.scoreTxt.text = ""
	end

	self:UpdataLuckDraw()

	self._operateCfg = nil

	local indexId, isOpen = LotteryModel.instance:getLotteryOperateInfo(poolCfg.consume)

	if checknumber(indexId) <= 0 then
		self.operateZheTxt.text = ""
		self.operateNameTxt.text = ""

		GameUtil.SetActive(self.operateTagGo, false)
		GameUtil.SetActive(self.operateBtn, false)

		return
	end

	local operateCfg = LotteryConfig.instance:getOperateCfgs(indexId)

	if operateCfg == nil or operateCfg.itemIds == nil then
		self.operateZheTxt.text = ""
		self.operateNameTxt.text = ""

		GameUtil.SetActive(self.operateTagGo, false)
		GameUtil.SetActive(self.operateBtn, false)

		return
	end

	self._operateCfg = operateCfg

	GameUtil.SetActive(self.operateBtn, true)

	self.operateNameTxt.text = operateCfg.name

	uGuiUtil.setSpriteToImage(self.opeIconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(operateCfg.icon))

	if string.nilorempty(operateCfg.name) then
		self.operateZheTxt.text = ""

		GameUtil.SetActive(self.operateTagGo, false)
	else
		GameUtil.SetActive(self.operateTagGo, true)

		self.operateZheTxt.text = operateCfg.tag
	end
end

function LotteryView:UpdataLuckDraw()
	self:OnCurrencyCountChange()

	local poolCfg = self._curViewDatas[self.choIndex].tabData.poolCfg

	if poolCfg == nil or string.nilorempty(poolCfg.consume) then
		return
	end

	local countList, isComm, isGold = LotteryModel.instance:GetHaveFreeCount(poolCfg.poolId)
	local matType, matId, matNum = self:_getLotteryShowConsume(poolCfg)

	if countList[1] <= 0 then
		self.oneFreeGo:SetActive(false)
		self.oneNeedGo:SetActive(true)
		MaterialMgr.setIcon(self.oneNeedIma, matType, matId)

		self.oneNeedTxt.text = langPara("text_lottery_xiaohao", matNum)

		if self.oneFreeEff then
			UIEffectManager.instance:stopEffect(self.oneFreeEff)
		end

		self.oneFreeEff = nil
	else
		self.oneNeedGo:SetActive(false)
		self.oneFreeGo:SetActive(true)

		self.oneFreeTxt.text = "本次免费"

		local path = "fx_ui_zhaohuanmianban/fx_ui_bcmf_zhaohuan.prefab"

		self.oneFreeEff = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 3, 0)
		end)

		self.oneFreeEff:setParent(self.oneFreeGo.transform)
		self.oneFreeEff:setScale(1)
	end

	if countList[10] <= 0 then
		self.tenRedGo:SetActive(false)
		self.tenFreeGo:SetActive(false)
		self.tenNeedGo:SetActive(true)
		MaterialMgr.setIcon(self.tenNeedIma, matType, matId)

		self.tenNeedTxt.text = langPara("text_lottery_xiaohao", matNum * 10)

		if self.tenFreeEff then
			UIEffectManager.instance:stopEffect(self.tenFreeEff)
		end

		self.tenFreeEff = nil
	else
		self.tenNeedGo:SetActive(false)
		self.tenRedGo:SetActive(true)
		self.tenFreeGo:SetActive(true)

		self.tenFreeTxt.text = "本次免费"

		local path = "fx_ui_zhaohuanmianban/fx_ui_bcmf_zhaohuan.prefab"

		self.tenFreeEff = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 3, 0)
		end)

		self.tenFreeEff:setParent(self.tenFreeGo.transform)
		self.tenFreeEff:setScale(1)
	end

	local zkStr = LotteryModel.instance:getPoolConsumePlan(poolCfg)

	if not string.nilorempty(zkStr) then
		self.oneFreeGo:SetActive(true)
		self.tenFreeGo:SetActive(true)

		self.oneFreeTxt.text = zkStr
		self.tenFreeTxt.text = zkStr
	end

	if isComm then
		self.goGDC:SetActive(false)

		return
	end

	self.goGDC:SetActive(true)

	local isOpenGDC = GoldenDiamondCardModel.instance.isUser

	uGuiUtil.setRawImageGrayState(self.itemGDC, not isOpenGDC)
	self.colorChange:SetState(isOpenGDC and 0 or 1)

	local leftTime, totalTime = GoldenDiamondCardModel.instance:getLeftTimeOfPrivilege(GoldenDiamondCardModel.PrivilegeType.FreeSummon)

	self.showTip.text = isOpenGDC and langPara("text_lottery_desc_2", leftTime, totalTime) or langPara("text_lottery_desc_3", totalTime)
end

function LotteryView:_getLotteryShowConsume(cfg)
	local infos = string.split(cfg.consume, ":")
	local matType = checknumber(infos[1])
	local matId = checknumber(infos[2])
	local needNum = checknumber(infos[3])
	local zkStr, zk = LotteryModel.instance:getPoolConsumePlan(cfg)

	if not string.nilorempty(zkStr) then
		needNum = checknumber(zk)
	end

	if string.nilorempty(cfg.consumeSubstitute) or checknumber(MaterialModel.instance:getMaterialsNumber(matType, matId)) > 0 then
		return matType, matId, needNum
	end

	infos = string.split(cfg.consumeSubstitute, ":")
	matType = checknumber(infos[1])
	matId = checknumber(infos[2])
	needNum = checknumber(infos[3])

	return matType, matId, needNum
end

function LotteryView:OnCurrencyCountChange()
	if self._hasDivineBounty and self.choIndex == LotteryView.DivineBountyIndex then
		return
	end

	self.shopGiftCfg = nil
	self.expandGiftCfg = nil

	if self.diamondCountTxt then
		local num = RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()

		self.diamondCountTxt.text = tostring(num)
	end

	local poolCfg = self._curViewDatas[self.choIndex].tabData.poolCfg
	local matType, matId = MaterialMgr.getMatParams(poolCfg.consume)

	if self.daibiCountTxt then
		local count = MaterialModel.instance:getMaterialsNumber(matType, matId)

		self.daibiCountTxt.text = tostring(count)

		MaterialMgr.setIcon(self.daibiIconIma, matType, matId)
	end

	local have = 0

	if poolCfg then
		if string.nilorempty(poolCfg.consumeSubstitute) then
			if not poolCfg.pointPrize then
				do
					local temp = poolCfg.consumeSubstitute

					matType, matId = MaterialMgr.getMatParams(temp)
					have = MaterialModel.instance:getMaterialsNumber(matType, matId)

					MaterialMgr.setIcon(self.scoreIconIma, matType, matId)
				end

				if self.scoreCountTxt then
					self.scoreCountTxt.text = tostring(have)
				end

				local function func()
					self.shopGiftCfg = LotteryModel.instance:GetShoppingGiftInfo(poolCfg.giftBagKey)

					if self.shopGiftCfg then
						GameUtil.SetActive(self.shopBtn, true)

						if self.shopGiftCfg.btnType == 1 and self.shopGiftCfg.itemType == 1 then
							MaterialMgr.updateItemByStr(self.shopIconIma, self.shopGiftCfg.icon)
						else
							uGuiUtil.setSpriteToImage(self.shopIconIma.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(self.shopGiftCfg.icon))
						end

						self.shopNameTxt.text = self.shopGiftCfg.itemName
						self.shopZheTxt.text = self.shopGiftCfg.zheStr
					else
						GameUtil.SetActive(self.shopBtn, false)
					end

					self.expandGiftCfg = LotteryModel.instance:GetShoppingGiftInfo(poolCfg.expandGiftKey)

					if self.expandGiftCfg then
						local isRed = LotteryModel.instance:getExpandShopRedponit(poolCfg.expandGiftKey)

						GameUtil.SetActive(self.expandShopBtn, true)
						GameUtil.SetActive(self.expandRedGo, isRed)

						local IconPath = string.format("ui/icon/%s.png", self.expandGiftCfg.icon)

						if self.expandGiftCfg.btnType == 1 and self.expandGiftCfg.itemType == 1 then
							MaterialMgr.updateItemByStr(self.expandIconIma, self.expandGiftCfg.icon)
						else
							uGuiUtil.setSpriteToImage(self.expandIconIma.gameObject, uGuiUtil.SpriteType.BigBg, IconPath)
						end

						self.expandNameTxt.text = self.expandGiftCfg.itemName
					else
						GameUtil.SetActive(self.expandShopBtn, false)
					end
				end

				if ShopModel.instance.isCountInited then
					func()
				else
					ShopController.instance:getGoodLeftCount(func)
				end
			end
		end
	end
end

function LotteryView:SetLongyanXinshou()
	removetimer(self.CalculationSurplusTime, self)
	MaterialMgr.resetAll(self.longyanGo)
	self.longyanGo:SetActive(false)

	local tabData = self._curViewDatas[self.choIndex].tabData
	local poolCfg = tabData.poolCfg

	if poolCfg == nil or checknumber(poolCfg.petId) < 1 then
		return
	end

	if not string.nilorempty(poolCfg.firstPlay) then
		local strList = string.split(poolCfg.firstPlay, "#")
		local str = string.format("lotteryfirstplaydraw_%s_%s", LoginModel.instance.userId, poolCfg.poolId)
		local firstPlay = UnityEngine.PlayerPrefs.GetInt(str)

		if strList and not string.nilorempty(strList[1]) and checknumber(firstPlay) ~= 1 then
			ViewBlockMgr.instance:blockClick(true, self)
			AnimationPlayer.play(strList[1], function()
				ViewBlockMgr.instance:blockClick(false, self)
			end, nil, self)
			UnityEngine.PlayerPrefs.SetInt(str, 1)

			if checknumber(strList[2]) > 0 then
				AudioPlayerEx.instance:playVoice(checknumber(strList[2]))
			end
		end
	end

	if LotteryConfig.instance:getPoolSelectPrizeCfgs(poolCfg.poolId) then
		self:showTabAt(self._subParentGo, ViewName.LotteryMaterial, poolCfg.poolId)

		return
	end

	if LotteryConfig.instance:GetSelfSelectPetGroupCfg(poolCfg.poolId) then
		self:showTabAt(self._subParentGo, ViewName.LotteryselfselectView, poolCfg.poolId, (tabData.groupCfg or nil) and tabData.groupCfg.groupId)

		return
	end

	local prizeData = LotteryModel.instance:GetLotteryProgressCfg(poolCfg.poolId)

	if prizeData == nil then
		return
	end

	self.longyanGo:SetActive(true)

	if poolCfg.countdown then
		local isOpen, isPre, endTime = LotteryModel.instance:getPoolIsOpenParams(poolCfg)

		if not isOpen or endTime <= ServerTime.nowServerLook() then
			self.showTimeTxt.text = lang("text_lottery_desc_6")
		else
			self:CalculationSurplusTime()
		end
	else
		self.showTimeTxt.text = ""
	end

	local path = "ui/bigbg/zhaohuan/" .. poolCfg.bonusBg .. ".png"

	uGuiUtil.setSpriteToImage(self.longyanGo, uGuiUtil.SpriteType.BigBg, path)

	if prizeData.isFull then
		GameUtil.SetActive(self.proogSlid, false)

		self.proogTxt.text = lang("text_lottery_desc_4")
		self.startTxt.text = ""
		self.endTxt.text = ""

		Framework.TransformUtil.SetLocalPos(self.proogTxt.gameObject.transform, 20, -50, 0)

		return
	end

	GameUtil.SetActive(self.proogSlid, true)

	self.proogSlid.value = (prizeData.useCount - prizeData.startCount) / (prizeData.endCount - prizeData.startCount)
	self.proogTxt.text = langPara("text_lottery_desc_5", prizeData.endCount - prizeData.useCount)
	self.startTxt.text = "0"

	Framework.TransformUtil.SetLocalPos(self.proogTxt.gameObject.transform, -22.5, -15, 0)

	self.endTxt.text = tostring(prizeData.endCount - prizeData.startCount)

	if prizeData.goodsInfo and #prizeData.goodsInfo > 2 then
		local itemType = checknumber(prizeData.goodsInfo[1])
		local itemId = checknumber(prizeData.goodsInfo[2])
		local itemCount = checknumber(prizeData.goodsInfo[3])
		local proxy = MaterialMgr.setCell(itemType, itemId, self.longyanGo)

		GameUtil.setLocalScale(proxy.view, 0.5, 0.5, 0.5)
		Framework.TransformUtil.SetLocalPos(proxy.view.transform, 93, -16, 0)
		proxy.binder:setNum(itemCount)

		if itemType == MatType.Pet then
			local lv = prizeData.goodsInfo[4] and checknumber(prizeData.goodsInfo[4]) or 1

			proxy.binder:setLvl(lv)
		end
	end
end

function LotteryView:CalculationSurplusTime()
	local poolCfg = self._curViewDatas[self.choIndex].tabData.poolCfg
	local isOpen, isPre, endTime = LotteryModel.instance:getPoolIsOpenParams(poolCfg)
	local supTime = isOpen and endTime - ServerTime.nowServerLook() or 0

	if supTime > 0 then
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

		self.showTimeTxt.text = day > 0 and langPara("text_suo_timer_1", day, hour, min) or langPara("text_suo_timer_2", hour, min, sec)
	else
		self.showTimeTxt.text = lang("text_lottery_desc_6")

		if supTime < 0 then
			removetimer(self.CalculationSurplusTime, self)
			self:SetCurrentChoiseIndex()
		end
	end
end

function LotteryView:OnClickSkillExplainBtn(isSkill)
	if not self:PreventTooFastClick(true) then
		return
	end

	LotteryModel.instance.openTabIndex = self.choIndex

	local poolCfg = self._curViewDatas[self.choIndex].tabData.poolCfg

	UIJumper.instance:pushOneStack(self._viewPresentor.viewName, true)

	if isSkill then
		PetbookController.instance:previewBattle(poolCfg.petId)
	else
		PetbookController.instance:openPetinfoView(poolCfg.petId)
	end
end

function LotteryView:OnClickSpriteTestBtn()
	if not self:PreventTooFastClick(true) then
		return
	end

	LotteryModel.instance.openTabIndex = self.choIndex

	local poolCfg = self._curViewDatas[self.choIndex].tabData.poolCfg

	UIJumper.instance:pushOneStack(self._viewPresentor.viewName, true)

	if self.petTrainList == nil or self.petTrainList[poolCfg.petId] == nil then
		PetbookController.instance:previewBattle(poolCfg.petId)

		return
	end

	local jumpTo = "func#149#" .. poolCfg.petId

	GotoMgr.gotoByString(jumpTo)
end

function LotteryView:OpenLotteryCountView()
	local poolCfg = self._curViewDatas[self.choIndex].tabData.poolCfg

	if poolCfg == nil then
		return false
	end

	if not string.nilorempty(poolCfg.jumpTo) then
		GotoMgr.gotoByString(poolCfg.jumpTo)

		return true
	end

	if checknumber(poolCfg.poolId) < 1 then
		return false
	end

	local list = LotteryConfig.instance:GetProgPrizeCfgs(poolCfg.poolId)

	if list == nil or #list == 0 then
		return false
	end

	UIStateManager.instance:push(ViewName.LotteryCount, poolCfg.poolId)

	return true
end

function LotteryView:OnClickCallSpriteBtn(isOnce)
	if not self:PreventTooFastClick() then
		return
	end

	local groupId = -1
	local tabData = self._curViewDatas[self.choIndex].tabData

	if tabData.groupCfg then
		groupId = tabData.groupCfg.groupId
	end

	local poolCfg = tabData.poolCfg

	if LotteryConfig.instance:getPoolSelectPrizeCfgs(poolCfg.poolId) and not LotteryModel.instance:isSetAllBigPrizeGain(poolCfg.poolId) then
		FloatWordMgr.instance:show(lang("text_lottery_desc_34"))

		return
	end

	if LotteryConfig.instance:GetSelfSelectPetGroupCfg(poolCfg.poolId) then
		if not LotteryController.instance:checkHasSelectPet(poolCfg.poolId) then
			FloatWordMgr.instance:show(lang("text_lottery_desc_34"))

			return
		end

		if LotteryController.instance:checkMustPickPet(poolCfg.poolId, groupId) then
			return
		end
	end

	LotteryModel.instance.openTabIndex = self.choIndex

	local strs = LotteryConfig.instance:GetChouJiangTypeData()
	local lotteryNum = isOnce and tonumber(strs[1]) or tonumber(strs[2])
	local countInfo = LotteryModel.instance:GetUseZhaohuanCount(poolCfg.poolId)
	local supCount = poolCfg.dailyLimit - countInfo.todayCount

	if supCount < lotteryNum then
		FloatWordMgr.instance:show(lang("text_lottery_desc_7"))

		return
	end

	local countList = LotteryModel.instance:GetHaveFreeCount(poolCfg.poolId)

	if lotteryNum == 1 then
		if countList and countList[1] > 0 then
			LotteryController.instance:SetRecordNeedCount(1)
			LotteryController.instance:CSRequestLuckDraw(1, poolCfg.poolId, groupId)

			return
		end
	elseif countList and countList[10] > 0 then
		LotteryController.instance:SetRecordNeedCount(10)
		LotteryController.instance:CSRequestLuckDraw(10, poolCfg.poolId, groupId)

		return
	end

	local isEnough, matType, matId, matNum, needNum, sttt = LotteryController.instance:getLotteryNeedConsume(lotteryNum, poolCfg)

	if not isEnough then
		self._buyCallData = {
			lotteryNum = lotteryNum,
			poolId = poolCfg.poolId,
			groupId = groupId
		}

		GlobalDispatcher:addListener(PayShopController.NotifyPayShopItemBuySucRes, self._onShopItemBuySucRes, self)

		if matId == 31 and needNum > 0 then
			ShopController.instance:buyGoodByCfgId(2102, needNum)
		elseif matId == 36 and needNum > 0 then
			ShopController.instance:buyGoodByCfgId(2101, needNum)
		else
			FloatWordMgr.instance:show(langPara("text_lottery_desc_8", MaterialMgr.getMaterialsName(matType, matId)))
		end

		return
	end

	if poolCfg.poolId == 13 then
		LotteryController.instance:setLotteryBgEffectType(GameEnum.LotteryBgEffectType.MengZhiDui)
	elseif poolCfg.poolId == 17 then
		LotteryController.instance:setLotteryBgEffectType(GameEnum.LotteryBgEffectType.YiRenZhiXia)
	end

	local function localFunc()
		LotteryController.instance:SetRecordNeedCount(lotteryNum)

		local zkStr, zk, zkCfg = LotteryModel.instance:getPoolConsumePlan(poolCfg)

		LotteryController.instance:CSRequestLuckDraw(lotteryNum, poolCfg.poolId, groupId, sttt, (not string.nilorempty(zkStr) and zkCfg and zkCfg.subId or nil) and zkCfg.subId)
	end

	local value = matNum * (lotteryNum - sttt)

	if matType == MatType.GodGem and value > 0 then
		local list = string.split(poolCfg.prize, ":")
		local coinCount = checknumber(list[#list]) * (lotteryNum - sttt)
		local str = string.format("确定花费<color=#d44c28>%s神钻</color>购买%s金币，进行%s次召唤吗？\n每次召唤赠送10点神唤积分", matNum * (lotteryNum - sttt), coinCount, lotteryNum - sttt)

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum * (lotteryNum - sttt), str, localFunc, nil, nil, UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	localFunc()
end

function LotteryView:PreventTooFastClick(isTips)
	if self.clickTimer == 0 then
		self.clickTimer = ServerTime.now()
	else
		local now = ServerTime.now()

		if now - self.clickTimer < 2 then
			return
		end

		self.clickTimer = now
	end

	return true
end

function LotteryView:_getPath()
	return {
		cellPath = "itemGo",
		viewPath = "itemListSR"
	}
end

function LotteryView:_cellSize()
	return 210, 90
end

function LotteryView:_clearTableview(cell)
	local redpointGo = goutil.findChild(cell, "redpointGo")

	RedPointController.instance:unregRedPoint(redpointGo)
end

function LotteryView:_updateCell(view, cell, data)
	local index = cell.data
	local choiseGo = goutil.findChild(cell, "choiseGo")
	local redpointGo = goutil.findChild(cell, "redpointGo")
	local tagImaGo = goutil.findChild(cell, "tagImaGo")
	local tagTxt = goutil.findChildTextComponent(tagImaGo, "tagTxt")
	local lockGo = goutil.findChild(cell, "lockGo")
	local lockTxt = goutil.findChildTextComponent(lockGo, "lockTxt")
	local itemTxt = goutil.findChildTextComponent(cell, "itemTxt")
	local tabData = data.tabData
	local tipStr = ""
	local redPointActive = false
	local tagImaActive = false

	itemTxt.text = data.tabName
	tagTxt.text = ""

	RedPointController.instance:unregRedPoint(redpointGo)

	if tabData and tabData.isPre and tabData.poolCfg.openType ~= LotteryController.OpenPoolType.BackDay then
		lockGo:SetActive(true)

		if tabData.poolCfg.openType <= LotteryController.OpenPoolType.OpenTime then
			local timestr = GameUtil.formatTimeString("%Y-%m-%d %H:%M", tabData.poolCfg.openDateTime)

			tipStr = langPara("text_lottery_desc_31", timestr)
		else
			tipStr = langPara("text_lottery_desc_32", tabData.poolCfg.startDay)
		end

		lockTxt.text = tipStr
		redPointActive = false

		choiseGo:SetActive(false)
	else
		lockTxt.text = ""

		lockGo:SetActive(false)
		choiseGo:SetActive(index == self.choIndex)

		if tabData and tabData.poolCfg then
			redPointActive = LotteryModel.instance:GetSubRedpointByCfg(tabData.poolCfg)

			if not string.nilorempty(tabData.poolCfg.btnTag) then
				tagImaActive = true
				tagTxt.text = tabData.poolCfg.btnTag
			end
		end
	end

	if data.viewName == ViewName.DivineBountyView then
		RedPointController.instance:regRedPoint(redpointGo, 603)
		goutil.setActive(tagImaGo, true)

		tagTxt.text = "推荐"
	else
		goutil.setActive(redpointGo, redPointActive)
		goutil.setActive(tagImaGo, tagImaActive)
	end

	GameUtil.asBtn(cell):AddClickListener(function()
		if not string.nilorempty(tipStr) then
			FloatWordMgr.instance:show(tipStr)

			return
		end

		if self.choIndex == index then
			return
		end

		self:_onClickTab(index)
	end, self)
end

function LotteryView:_onShopItemBuySucRes(msg)
	for i, v in ipairs(msg.buyTimes) do
		if v.id == 2101 or v.id == 2102 then
			GlobalDispatcher:removeListener(PayShopController.NotifyPayShopItemBuySucRes, self._onShopItemBuySucRes, self)

			if self._buyCallData then
				local changeSetId = msg.changeSetId

				MaterialFacade:getItemsByChangeSetId(changeSetId)
				LotteryController.instance:SetRecordNeedCount(self._buyCallData.lotteryNum)
				LotteryController.instance:CSRequestLuckDraw(self._buyCallData.lotteryNum, self._buyCallData.poolId, self._buyCallData.groupId)

				self._buyCallData = nil
			end
		end
	end
end

function LotteryView:_onClickTab(index)
	self:UpdataCountAndOpenView(index)
end

function LotteryView:_onClickScoreItem()
	local poolCfg = self._curViewDatas[self.choIndex].tabData.poolCfg

	if poolCfg == nil then
		return
	end

	if string.nilorempty(poolCfg.consumeSubstitute) then
		if not poolCfg.pointPrize then
			local temp = poolCfg.consumeSubstitute

			CommonTipsMgr.instance:openTipsByConfStr(self.scoreItemBtn.gameObject, temp)
		end
	end
end

function LotteryView:_onClickScoreAdd()
	local poolCfg = self._curViewDatas[self.choIndex].tabData.poolCfg

	if poolCfg == nil then
		return
	end

	if string.nilorempty(poolCfg.consumeSubstitute) then
		if not poolCfg.pointPrize then
			local temp = poolCfg.consumeSubstitute

			LotteryModel.instance.openTabIndex = self.choIndex

			MaterialMgr.openGetSourceByStr(temp)
		end
	end
end

function LotteryView:_onClickBtnClose()
	LotteryModel.instance.openTabIndex = 1

	self:close()
end

function LotteryView:_onClickDaibiAdd()
	local poolCfg = self._curViewDatas[self.choIndex].tabData.poolCfg

	LotteryModel.instance.openTabIndex = self.choIndex

	if poolCfg and not string.nilorempty(poolCfg.consume) then
		MaterialMgr.openGetSourceByStr(poolCfg.consume)
	end
end

function LotteryView:_onClickDiamondAdd()
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(28)

	if not FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
		FloatWordMgr.instance:show(cfg.lockedTips)

		return
	end

	LotteryModel.instance.openTabIndex = self.choIndex

	PayShopController.instance:openView(GameEnum.PayShopEasyJump.Recharge)
end

function LotteryView:_onClickJackpot()
	local poolCfg = self._curViewDatas[self.choIndex].tabData.poolCfg

	if poolCfg == nil or checknumber(poolCfg.poolId) < 1 then
		return
	end

	ViewMgr.instance:open(ViewName.CallExplain, poolCfg.poolId)
end

function LotteryView:_onClickShop()
	function func()
		if self.shopGiftCfg then
			LotteryModel.instance.openTabIndex = self.choIndex

			if self.shopGiftCfg.btnType == 1 then
				local cfg = PayShopConfig.instance:getPayShopGoodsCfgById(self.shopGiftCfg.itemId)

				if PayShopModel.instance:getPayShopGoodsCanBuyById(self.shopGiftCfg.itemId) then
					if self.shopGiftCfg.payType == GameEnum.PayShopPayType.RMB then
						local data = {
							id = self.shopGiftCfg.itemId,
							times = PayShopModel.instance:getMibaoBuyTimesById(self.shopGiftCfg.itemId)
						}

						UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data)
					else
						ShopController.instance:buyGoodByCfgId(self.shopGiftCfg.itemId, 1)
					end
				elseif self.shopGiftCfg.itemType == 1 then
					PayShopController.instance:openView(GameEnum.PayShopEasyJump.DiscountGift)
				else
					PayShopController.instance:openView(GameEnum.PayShopEasyJump.TehuiGift)
				end
			elseif self.shopGiftCfg.btnType == 2 then
				GotoMgr.gotoByString(self.shopGiftCfg.jumpTo)
			end
		end
	end

	if ShopModel.instance.isCountInited then
		func()
	else
		ShopController.instance:getGoodLeftCount(func)
	end
end

function LotteryView:_onClickExpandShop()
	function func()
		if self.expandGiftCfg then
			LotteryModel.instance.openTabIndex = self.choIndex

			if self.expandGiftCfg.btnType == 1 then
				local cfg = PayShopConfig.instance:getPayShopGoodsCfgById(self.expandGiftCfg.itemId)

				if PayShopModel.instance:getPayShopGoodsCanBuyById(self.expandGiftCfg.itemId) then
					if self.expandGiftCfg.payType == GameEnum.PayShopPayType.RMB then
						local data = {
							id = self.expandGiftCfg.itemId,
							times = PayShopModel.instance:getMibaoBuyTimesById(self.expandGiftCfg.itemId)
						}

						UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data)
					else
						ShopController.instance:buyGoodByCfgId(self.expandGiftCfg.itemId, 1)
					end
				elseif self.expandGiftCfg.itemType == 1 then
					PayShopController.instance:openView(GameEnum.PayShopEasyJump.DiscountGift)
				else
					PayShopController.instance:openView(GameEnum.PayShopEasyJump.TehuiGift)
				end
			elseif self.expandGiftCfg.btnType == 2 then
				GotoMgr.gotoByString(self.expandGiftCfg.jumpTo)
			end
		end
	end

	if ShopModel.instance.isCountInited then
		func()
	else
		ShopController.instance:getGoodLeftCount(func)
	end
end

function LotteryView:_updateViewObjActiveByIndex(index)
	if self._hasDivineBounty then
		local isDivineBounty = index == LotteryView.DivineBountyIndex

		goutil.setActive(self._viewDownGo, not isDivineBounty)
		goutil.setActive(self._viewDownTranBgGo, not isDivineBounty)
		goutil.setActive(self.goGDC, not isDivineBounty)
		goutil.setActive(self._upItems, not isDivineBounty)
		goutil.setActive(self.longyanGo, not isDivineBounty)
		goutil.setActive(self.spriteExplainBtn.gameObject, not isDivineBounty)
		goutil.setActive(self.spriteSkillBtn.gameObject, not isDivineBounty)
	end
end

function LotteryView:_onClickbtnSkip()
	local poolCfg = self._curViewDatas[self.choIndex].tabData.poolCfg

	LotteryModel.instance:changePoolSkipAnim(poolCfg.poolId)
	self:_updateSkipAnimState()
end

function LotteryView:_updateSkipAnimState()
	local viewData = self._curViewDatas[self.choIndex]

	if not viewData or not viewData.tabData or not viewData.tabData.poolCfg then
		goutil.setActive(self._skipGo, false)

		return
	end

	local poolCfg = viewData.tabData.poolCfg

	goutil.setActive(self._skipGo, poolCfg.skipAnim)
	goutil.setActive(self._skipGouGo, LotteryModel.instance:getPoolSkipAnim(poolCfg.poolId))
end

function LotteryView:_onLotteryDrawRes(status)
	if status == 0 and self.choIndex and self._curViewDatas[self.choIndex] and self._curViewDatas[self.choIndex].tabData then
		local poolCfg = self._curViewDatas[self.choIndex].tabData.poolCfg

		if poolCfg.skipAnim and LotteryModel.instance:getPoolSkipAnim(poolCfg.poolId) then
			LotteryController.instance:CSRequestLotteryInfo()
		end
	end
end

return LotteryView
