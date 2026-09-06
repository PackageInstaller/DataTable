-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/view/UniqueWorldShopView.lua

module("logic.extensions.uniqueworld.view.UniqueWorldShopView", package.seeall)

local UniqueWorldShopView = class("UniqueWorldShopView", ViewComponent)

function UniqueWorldShopView:ctor()
	UniqueWorldShopView.super.ctor(self)
end

function UniqueWorldShopView:unbindEvents()
	UniqueWorldShopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function UniqueWorldShopView:bindEvents()
	UniqueWorldShopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function UniqueWorldShopView:buildUI()
	UniqueWorldShopView.super.buildUI(self)

	self._tip = self:getGo("tip")
	self._tipRect = self:getGo("tip"):GetComponent(goutil.Type_RectTransform)
	self._btnClose = self:getGo("btnClose")
	self._txtNum = self:getTxt("goldBarCon/txtNum")
	self._icon = self:getGo("goldBarCon/icon")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:regValueChanged(GameUtil.handler(self._onValueChanged, self))
end

function UniqueWorldShopView:onExit()
	UniqueWorldShopView.super.onExit(self)
	self._scrollList:dispose()
	MaterialMgr.clearIcon(self._icon)
	self._moveSequence:Kill(true)

	self._moveSequence = nil
end

function UniqueWorldShopView:onEnter()
	UniqueWorldShopView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_UniqueWorldDoEventRes, self._onMapChangeRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 584001
	end

	self._gridId = checknumber(params[2])
	self._eventId = checknumber(params[3])
	self._actCfg = UniqueWorldConfig.instance:getActCfg(self._activityId)
	self._coinMatStr = self._actCfg.coinMatStr
	self._coinMatName = MaterialMgr.getMaterialsNameByCfg(self._coinMatStr)

	self:_updateData()

	self._curSelectNeedCoin = 0

	self:_onSetUI()
end

function UniqueWorldShopView:_onSetUI()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._coinMatStr)
	local sortShopCfg = UniqueWorldController.instance:getSortShopCfg(self._activityId, self._eventId)

	MaterialMgr.setIcon(self._icon, matType, matId, nil, nil)

	self._txtNum.text = self._curCoin

	if sortShopCfg then
		self._scrollList:reloadData(sortShopCfg)
	end

	self._startY = -213
	self._moveY = 5
	self._animInterval = 1
	self._animTime = 0.3
	self._moveSequence = nil
	self._moveSequence = DG.Tweening.DOTween.Sequence()

	self:_setTipAnim()
end

function UniqueWorldShopView:_setTipAnim()
	for i = 1, 2 do
		local moveUpTween = self._tipRect:DOAnchorPosY(self._startY + self._moveY, self._animTime):SetEase(DG.Tweening.Ease.Linear)
		local moveDownTween = self._tipRect:DOAnchorPosY(self._startY - self._moveY, self._animTime):SetEase(DG.Tweening.Ease.Linear)

		self._moveSequence:Append(moveUpTween)
		self._moveSequence:Append(moveDownTween)
	end

	local moveBackTween = self._tipRect:DOAnchorPosY(self._startY, self._animTime):SetEase(DG.Tweening.Ease.Linear)

	self._moveSequence:Append(moveBackTween)
	self._moveSequence:AppendInterval(self._animInterval)
	self._moveSequence:SetLoops(-1)
end

function UniqueWorldShopView:_updateData()
	local info = UniqueWorldModel.instance:getInfo(self._activityId)
	local mapInfo = info and info.mapInfo
	local gameInfo = mapInfo and mapInfo.gameInfo

	if gameInfo then
		self._curCoin = gameInfo.leftCoin or 0
	end

	self._shopList = UniqueWorldModel.instance:getShopList(self._activityId)
	self._petHpMap = UniqueWorldModel.instance:getPetHpMap(self._activityId)
end

function UniqueWorldShopView:_onUpdate()
	self:_updateData()

	self._txtNum.text = self._curCoin

	local sortShopCfg = UniqueWorldController.instance:getSortShopCfg(self._activityId, self._eventId)

	if sortShopCfg then
		self._scrollList:reloadData(sortShopCfg)
	end
end

function UniqueWorldShopView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local btnBuy = goutil.findChild(cell, "btnBuy")
	local buyGo = goutil.findChild(cell, "btnBuy/buy")
	local imgBuy = goutil.findChild(cell, "btnBuy/buy/imgBuy")
	local soldOutGo = goutil.findChild(cell, "btnBuy/txtSoldOut")
	local txtBuy = goutil.findChildTextComponent(cell, "btnBuy/buy/txtBuy")
	local effects = data.effects
	local effectList = UniqueWorldController.instance:getEffectList(effects)
	local effectTb

	if #effectList > 0 then
		effectTb = effectList[1]
	end

	local isPet = false
	local isItem = false
	local id = 0
	local num = 0

	if effectTb then
		if effectTb.effect == UniqueWorldEnum.EffectType.AddPet then
			isPet = true
			id = effectTb.num
		elseif effectTb.effect == UniqueWorldEnum.EffectType.AddItem then
			isItem = true
			id = effectTb.id
			num = effectTb.num
		end
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(self._coinMatStr)
	local hasBuy = table.indexof(self._shopList, data.shopItemId)
	local canBuy = self._curCoin >= data.costCoin
	local hasThisPet = self._petHpMap[id] ~= nil

	txtBuy.text = data.costCoin

	if isPet then
		local petCfg = UniqueWorldConfig.instance:getSystemPetCfg(id)

		if petCfg then
			local raceId = petCfg.raceId

			MaterialMgr.setCell(MatType.Pet, raceId, item)
		end
	elseif isItem then
		local itemCfg = UniqueWorldConfig.instance:getItemCfg(id)

		if itemCfg then
			local matStr = itemCfg.matStr
			local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
			local str = string.format("%s:%s:%s", matType, matId, num)

			MaterialMgr.setCellByCfg(str, item)
		end
	end

	MaterialMgr.setIcon(imgBuy, matType, matId, nil, nil)
	GameUtil.SetActive(imgBuy, not hasBuy and not hasThisPet)
	GameUtil.SetActive(txtBuy.gameObject, not hasBuy and not hasThisPet)
	GameUtil.SetActive(soldOutGo, hasBuy or hasThisPet)
	GameUtil.SetGray(btnBuy, hasBuy or not canBuy or hasThisPet)
	GameUtil.addClickHandler(btnBuy, function()
		if not canBuy then
			FloatWordMgr.instance:show(string.format("%s不足", self._coinMatName))

			return
		end

		if hasBuy then
			FloatWordMgr.instance:show("已购买过该商品，无法重复购买")

			return
		end

		if hasThisPet then
			FloatWordMgr.instance:show("已拥有过该精灵，无法重复购买")

			return
		end

		self._selectBuyShopId = data.shopItemId

		UniqueWorldController.instance:sendPM_UniqueWorldDoEventReq(self._activityId, self._gridId, data.shopItemId .. "")
	end, self)
end

function UniqueWorldShopView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local btnBuy = goutil.findChild(cell, "btnBuy")
	local imgBuy = goutil.findChild(cell, "btnBuy/buy/imgBuy")

	MaterialMgr.resetAll(item)
	MaterialMgr.clearIcon(imgBuy)
	GameUtil.rmClickHandler(btnBuy)
end

function UniqueWorldShopView:_onMapChangeRes()
	local shopItemCfg = UniqueWorldConfig.instance:getShopCfgById(self._eventId, self._selectBuyShopId)

	if shopItemCfg then
		local itemEffect = shopItemCfg.effects
		local effectList = UniqueWorldController.instance:getEffectList(itemEffect)

		for _, effectTb in ipairs(effectList) do
			local effect = effectTb.effect

			if effect == UniqueWorldEnum.EffectType.AddPet then
				local creepsId = effectTb.num
				local petCfg = UniqueWorldConfig.instance:getSystemPetCfg(creepsId)

				if petCfg then
					local name = petCfg.creepsName

					FloatWordMgr.instance:show(string.format("购买【%s】成功！", name))
				end
			elseif effect == UniqueWorldEnum.EffectType.AddItem then
				local num = effectTb.num
				local id = effectTb.id
				local itemCfg = UniqueWorldConfig.instance:getItemCfg(id)

				if itemCfg then
					local name = itemCfg.name

					FloatWordMgr.instance:show(string.format("购买【%sx%d】成功！", name, num))
				end
			end
		end
	end

	self:_onUpdate()
end

function UniqueWorldShopView:_onValueChanged()
	GameUtil.SetActive(self._tip, not self._scrollList:isShowFinishCell())
end

return UniqueWorldShopView
