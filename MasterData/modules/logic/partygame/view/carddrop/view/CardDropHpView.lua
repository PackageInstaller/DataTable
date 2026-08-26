-- chunkname: @modules/logic/partygame/view/carddrop/view/CardDropHpView.lua

module("modules.logic.partygame.view.carddrop.view.CardDropHpView", package.seeall)

local CardDropHpView = class("CardDropHpView", BaseView)

function CardDropHpView:onInitView()
	local goEnemyHp = gohelper.findChild(self.viewGO, "top/bar/left")
	local goMyHp = gohelper.findChild(self.viewGO, "top/bar/right")

	self.goSettleItem = gohelper.findChild(self.viewGO, "top/settlementpoint/layout/#go_circleitem")

	gohelper.setActive(self.goSettleItem, false)

	self.settleItemList = {}
	self.enemyHpItem = self:createHpItem(goEnemyHp)
	self.myHpItem = self:createHpItem(goMyHp)
	self.interface = PartyGameCSDefine.CardDropInterfaceCs
	self.configInitHp = self.interface.GetConfigInitHp()
	self.multipleChar = luaLang("multiple")
end

CardDropHpView.TweenDuration = 0.5

function CardDropHpView:createHpItem(go)
	local hpItem = self:getUserDataTb_()

	hpItem.imageHp1 = gohelper.findChildImage(go, "#image_fg1")
	hpItem.imageHp2 = gohelper.findChildImage(go, "#image_fg2")
	hpItem.imageHp3 = gohelper.findChildImage(go, "#image_fg3")
	hpItem.txtHp = gohelper.findChildText(go, "#txt_num")
	hpItem.txtHpCount = gohelper.findChildText(go, "#txt_hpCount")
	hpItem.goHpCount = gohelper.findChild(go, "#txt_hpCount")
	hpItem.txtName = gohelper.findChildText(go, "namebg/#txt_name")
	hpItem.tweenHp = 0

	return hpItem
end

function CardDropHpView:addEvents()
	self.addEventCb(self, CardDropGameController.instance, CardDropGameEvent.OnLogicStateStart, self.onLogicStateStart, self)
	self.addEventCb(self, CardDropGameController.instance, CardDropGameEvent.OnFloatDamage, self.refreshUI, self)
end

function CardDropHpView:onOpen()
	self:initPlayerHp()
	self:initSettlePoint()
end

function CardDropHpView:initPlayerHp()
	self.enemyHpItem.uid = self.interface.GetEnemyPlayerUid()
	self.myHpItem.uid = self.interface.GetMyPlayerUid()

	local playerMo = PartyGameModel.instance:getPlayerMoByUid(self.enemyHpItem.uid)
	local curHp, maxHp = self:getPlayerHpAndMaxHp(self.enemyHpItem.uid)

	self.enemyHpItem.tweenHp = curHp
	self.enemyHpItem.maxHp = maxHp
	self.enemyHpItem.txtName.text = playerMo.name

	self:directSetHp(curHp, self.enemyHpItem)

	playerMo = PartyGameModel.instance:getPlayerMoByUid(self.myHpItem.uid)
	curHp, maxHp = self:getPlayerHpAndMaxHp(self.myHpItem.uid, nil)
	self.myHpItem.tweenHp = curHp
	self.myHpItem.maxHp = maxHp
	self.myHpItem.txtName.text = playerMo.name

	self:directSetHp(curHp, self.myHpItem)
end

function CardDropHpView:refreshSettle()
	local maxPointItem = CardDropGameController.instance.maxSelectedCount

	for i = 1, maxPointItem do
		local settleItem = self.settleItemList[i]

		if settleItem then
			local result = self.interface.GetBattleResult(i)

			self:refreshSettleItemState(settleItem, result)
		end
	end
end

function CardDropHpView:refreshAllPlayerHp()
	self:refreshPlayerHp(self.enemyHpItem)
	self:refreshPlayerHp(self.myHpItem)
end

function CardDropHpView:getPlayerHpAndMaxHp(uid)
	local curHp, maxHp = self.interface.GetPlayerHp(uid, nil)

	return curHp, maxHp
end

function CardDropHpView:refreshPlayerHp(hpItem)
	local uid = hpItem.uid
	local curHp = self:getPlayerHpAndMaxHp(uid)

	self:clearTween(hpItem)

	hpItem.tweenId = ZProj.TweenHelper.DOTweenFloat(hpItem.tweenHp, curHp, CardDropHpView.TweenDuration, self.frameCallback, self.onDoneCallback, self, hpItem)
end

function CardDropHpView:frameCallback(value, hpItem)
	self:directSetHp(value, hpItem)

	hpItem.tweenHp = value
end

function CardDropHpView:onDoneCallback(hpItem)
	hpItem.tweenId = nil
end

function CardDropHpView:directSetHp(hp, hpItem)
	local useHp = 0

	for i = 1, 3 do
		hpItem["imageHp" .. i].fillAmount = Mathf.Clamp01((hp - useHp) / self.configInitHp)
		useHp = useHp + self.configInitHp
	end

	hpItem.txtHp.text = string.format("%s/%s", math.floor(hp), hpItem.maxHp)

	local hpCount = math.ceil(hp / self.configInitHp)

	hpItem.txtHpCount.text = string.format("%s%s", self.multipleChar, hpCount)
end

function CardDropHpView:clearTween(hpItem)
	if hpItem.tweenId then
		ZProj.TweenHelper.KillById(hpItem.tweenId)

		hpItem.tweenId = nil
	end
end

function CardDropHpView:onLogicStateStart(curState)
	if curState == CardDropEnum.GameState.CardFly then
		self:refreshUI()
	end
end

function CardDropHpView:refreshUI()
	self:refreshAllPlayerHp()
	self:refreshSettle()
end

function CardDropHpView:initSettlePoint()
	local maxPointItem = CardDropGameController.instance.maxSelectedCount

	for i = 1, maxPointItem do
		local settleItem = self:getUserDataTb_()

		settleItem.go = gohelper.cloneInPlace(self.goSettleItem)

		gohelper.setActive(settleItem.go, true)

		settleItem.goNotStart = gohelper.findChild(settleItem.go, "#image_NotStarted")
		settleItem.goVictory = gohelper.findChild(settleItem.go, "#image_Victory")
		settleItem.goDefeat = gohelper.findChild(settleItem.go, "#image_Defeat")
		settleItem.goDraw = gohelper.findChild(settleItem.go, "#image_Draw")

		self:refreshSettleItemState(settleItem, CardDropEnum.SettleState.NotStart)
		table.insert(self.settleItemList, settleItem)
	end
end

function CardDropHpView:refreshSettleItemState(settleItem, state)
	gohelper.setActive(settleItem.goNotStart, state == CardDropEnum.SettleState.NotStart)
	gohelper.setActive(settleItem.goVictory, state == CardDropEnum.SettleState.Victory)
	gohelper.setActive(settleItem.goDefeat, state == CardDropEnum.SettleState.Defeat)
	gohelper.setActive(settleItem.goDraw, state == CardDropEnum.SettleState.Draw)
end

function CardDropHpView:onDestroyView()
	self:clearTween(self.enemyHpItem)
	self:clearTween(self.myHpItem)
end

return CardDropHpView
