-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementsparkpetshopView.lua

module("logic.extensions.elementspark.view.ElementsparkpetshopView", package.seeall)

local ElementsparkpetshopView = class("ElementsparkpetshopView", ViewComponent)

function ElementsparkpetshopView:ctor()
	ElementsparkpetshopView.super.ctor(self)

	self._petMos = {}
end

function ElementsparkpetshopView:unbindEvents()
	ElementsparkpetshopView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function ElementsparkpetshopView:bindEvents()
	ElementsparkpetshopView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
end

function ElementsparkpetshopView:buildUI()
	ElementsparkpetshopView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._tablecellGo = self:getGo("tablecell")
	self._roleconGo = self:getGo("rolecon")
	self._txtBubbleDesc = self:getTxt("bubble/txtDesc")
	self._txtScore = self:getTxt("score/txt")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ElementsparkpetshopView:onExit()
	ElementsparkpetshopView.super.onExit(self)
	self._scrollerList:dispose()
	RoleObjectPool.instance:removeRole(self._loader)
end

function ElementsparkpetshopView:onEnter()
	ElementsparkpetshopView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ElementSparkBuyPetRes, self._onElementSparkBuyPetRes, self)

	self._activityId = ElementSparkController.instance:getActivityId()
	self._chunkId = self:getFirstParam() or ElementSparkModel.instance:getPetShopChunkId()

	local planId = ElementSparkController.instance:getMapPlanId()

	self._chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(planId, self._chunkId)

	local campId = self._chunkCfg.initCamp
	local campCfg = ElementSparkConfig.instance:getCampCfgById(self._activityId, campId)

	self._txtBubbleDesc.text = campCfg.desc

	local raceId = campCfg.shopRaceId
	local x, y, scale = 0, 0, 1

	self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, raceId, self._roleconGo, scale, nil, true, x, y)

	self:_updateUI()
end

function ElementsparkpetshopView:_onClickbtnClose()
	self:close()
end

function ElementsparkpetshopView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("ElementSparkPetShop_rule")
end

function ElementsparkpetshopView:_updateUI()
	local shopId = self._chunkCfg.petShopId
	local tempCfgs = ElementSparkConfig.instance:getPetShopCfgs(shopId)
	local shopCfgs = table.values(tempCfgs)

	self._buyItems = {}

	if self._chunkCfg.initCamp == ElementSparkModel.instance:getMyCampId() then
		local items = ElementSparkModel.instance:getPetShopItems()

		for i, v in ipairs(items) do
			self._buyItems[v] = true
		end
	end

	table.sort(shopCfgs, function(a, b)
		local selloutA = self._buyItems[a.shopItemId]
		local selloutB = self._buyItems[b.shopItemId]

		if selloutA ~= selloutB then
			return not selloutA
		end

		return a.shopItemId > b.shopItemId
	end)
	self._scrollerList:reloadData(shopCfgs)

	local petShopScore = ElementSparkModel.instance:getPetShopScore()

	self._txtScore.text = "酒馆积分：" .. petShopScore
end

function ElementsparkpetshopView:_updateCell(view, cell, cfg, tag)
	local pet = goutil.findChild(cell, "pet")
	local sellout = goutil.findChild(cell, "sellout")
	local petCon = goutil.findChild(cell, "pet/mask/con")
	local quality = goutil.findChild(cell, "pet/qualitybg"):GetComponent("UIImageSpriteChange")
	local attr = goutil.findChild(cell, "pet/attr"):GetComponent("UIImageSpriteChange")
	local job1 = goutil.findChild(cell, "pet/job1"):GetComponent("UIImageSpriteChange")
	local job2 = goutil.findChild(cell, "pet/job2"):GetComponent("UIImageSpriteChange")
	local tag = goutil.findChild(cell, "pet/tag")
	local txtLevel = goutil.findChildTextComponent(cell, "pet/txtLv")
	local txtCost = goutil.findChildTextComponent(cell, "cost/txtCost")
	local btnSelect = goutil.findChildButtonComponent(cell, "btnSelect")
	local btnBuy = goutil.findChildButtonComponent(cell, "cost/btnBuy")
	local petCfg = ElementSparkConfig.instance:getSupportPetCfg(cfg.supportPetId)
	local raceId = petCfg.raceId
	local rare = CharacterConfig.instance:getRareByAwakenLv(petCfg.awakeLevel, raceId)

	quality:SetState(rare)

	local petCo = CharacterConfig.instance:getPetCo(raceId)

	if petCo then
		local race = PetSkinConfig.instance:getFisrtEleAttrIdx(raceId)

		attr:SetState(race - 1)
	end

	local modelCfg = CharacterConfig.instance:getModelCo(raceId)

	if modelCfg then
		uGuiUtil.setSpriteToImage(petCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCfg.cardName))
	end

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(raceId)

	GameUtil.setUIImageSpriteIdx(job1, firstJobIdx - 1)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(raceId)
	local isNeedJob1 = secondJobIdx > 20

	GameUtil.SetActive(job2, isNeedJob1)

	if isNeedJob1 then
		GameUtil.setUIImageSpriteIdx(job1, secondJobIdx - 1 - 20)
	end

	txtLevel.text = petCfg.lv
	txtCost.text = "酒馆积分x" .. cfg.price

	GameUtil.SetActive(sellout, self._buyItems[cfg.shopItemId])
	GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickSelectCell, self, cfg.supportPetId))
	GameUtil.addClickHandler(btnBuy, GameUtil.handler(self._onClickBuyCell, self, cfg.shopItemId, cfg.supportPetId, cfg.price))
end

function ElementsparkpetshopView:_clearCell(cell)
	local petCon = goutil.findChild(cell, "pet/mask/con")

	uGuiUtil.clearImage(petCon)
end

function ElementsparkpetshopView:_onClickSelectCell(supportPetId)
	local petMo = self._petMos[supportPetId]

	if not petMo then
		local petCfg = ElementSparkConfig.instance:getSupportPetCfg(supportPetId)
		local mo = FightingPowerPetMo.New()

		mo:fromChallengeCreepCo(petCfg)

		petMo = mo:toBaseBagPetMo()
		self._petMos[supportPetId] = petMo
	end

	CommonTipsMgr.instance:showPetTips(petMo)
end

function ElementsparkpetshopView:_onClickBuyCell(shopItemId, supportPetId, price)
	if self._buyItems[shopItemId] then
		FloatWordMgr.instance:show("已售罄~")

		return
	end

	local canBuy = true

	if self._chunkCfg.occupyRequiredGuards then
		for i, chunkId in ipairs(self._chunkCfg.occupyRequiredGuards) do
			local isMe = ElementSparkModel.instance:getChunlBelongMe(chunkId)

			if not isMe then
				canBuy = false

				break
			end
		end
	end

	if not canBuy then
		FloatWordMgr.instance:show("未占领酒馆，暂时无法购买")

		return
	end

	if self._chunkCfg.initCamp ~= ElementSparkModel.instance:getMyCampId() then
		FloatWordMgr.instance:show("不属于你方阵营的酒馆，暂时无法购买")

		return
	end

	local petShopScore = ElementSparkModel.instance:getPetShopScore()

	if checknumber(petShopScore) < checknumber(price) then
		FloatWordMgr.instance:show("积分不足，无法购买")

		return
	end

	UIStateManager.instance:push(ViewName.ElementsparkbuypetView, self._chunkCfg.petShopId, shopItemId)
end

function ElementsparkpetshopView:_onElementSparkBuyPetRes()
	self:_updateUI()
end

return ElementsparkpetshopView
