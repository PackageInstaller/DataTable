-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroGameView.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroGameView", package.seeall)

local DiceHeroGameView = class("DiceHeroGameView", BaseView)

function DiceHeroGameView:onInitView()
	self._anim = gohelper.findChildAnim(self.viewGO, "")
	self._godice = gohelper.findChild(self.viewGO, "#go_dice")
	self._maskAnim = gohelper.findChildAnim(self.viewGO, "#simage_mask")
	self._gocard = gohelper.findChild(self.viewGO, "#go_card/item")
	self._goenemy = gohelper.findChild(self.viewGO, "#go_enemy/#go_item")
	self._gohero = gohelper.findChild(self.viewGO, "#go_hero")
	self._curRound = gohelper.findChildTextMesh(self.viewGO, "#go_target/roundbg/anim/curround/#txt_curround")
	self._txttarget = gohelper.findChildTextMesh(self.viewGO, "#go_target/#go_tasklist/#go_taskitem/txt_desc")
	self._damageEffectHero = gohelper.findChild(self.viewGO, "#screeneff_attack/hero")
	self._damageEffectEnemy = gohelper.findChild(self.viewGO, "#screeneff_attack/enemy")

	local textureRef = gohelper.findChild(self.viewGO, "#go_texture_ref")

	if textureRef then
		local trans = textureRef.transform

		for i = 0, trans.childCount - 1 do
			local child = trans:GetChild(i)
			local image = child.gameObject:GetComponent(gohelper.Type_RawImage)

			if image then
				DiceHeroHelper.instance:setDiceTexture(child.name, image.texture)
			end
		end
	end
end

function DiceHeroGameView:addEvents()
	DiceHeroController.instance:registerCallback(DiceHeroEvent.RoundEnd, self.beginRound, self)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.ConfirmDice, self.confirmDice, self)
	DiceHeroController.instance:registerCallback(DiceHeroEvent.OnDamage, self.onDamageEffect, self)
end

function DiceHeroGameView:removeEvents()
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.RoundEnd, self.beginRound, self)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.ConfirmDice, self.confirmDice, self)
	DiceHeroController.instance:unregisterCallback(DiceHeroEvent.OnDamage, self.onDamageEffect, self)
end

function DiceHeroGameView:onOpen()
	gohelper.setActive(self._maskAnim, true)

	local heroitempath = self.viewContainer._viewSetting.otherRes.roleinfoitem
	local effectpath = self.viewContainer._viewSetting.otherRes.effect
	local effectItem = self:getResInst(effectpath, self.viewGO)

	gohelper.setActive(effectItem, false)
	DiceHeroHelper.instance:setEffectItem(effectItem)

	self._diceBox = MonoHelper.addNoUpdateLuaComOnceToGo(self._godice, DiceHeroDiceBoxItem, self)

	local heroInstGo = self:getResInst(heroitempath, self._gohero)

	self._hero = MonoHelper.addNoUpdateLuaComOnceToGo(heroInstGo, DiceHeroHeroItem)
	self._txttarget.text = luaLang("dicehero_target")

	self:refreshCards()
	self:refreshEnemys()
	self:beginRound()
end

function DiceHeroGameView:onUpdateParam()
	if not self._diceBox then
		return
	end

	self._anim:Play("open", 0, 0)
	self._diceBox:onStepEnd(true)
	self._hero:refreshAll()
	self:refreshCards()
	self:refreshEnemys()
	self:beginRound()
end

function DiceHeroGameView:beginRound()
	self._maskAnim:Play("out", 0, 1)

	local gameInfo = DiceHeroFightModel.instance:getGameData()

	self._curRound.text = gameInfo.round
	self._roundFlow = FlowSequence.New()

	self._roundFlow:addWork(FunctionWork.New(self._hideDiceAndShowEnemyBehavior, self))
	self._roundFlow:addWork(DelayDoFuncWork.New(self._showMask, self, 1))
	self._roundFlow:addWork(DelayDoFuncWork.New(self._showDiceAndHideEnemyBehavior, self, 0.1))
	self._roundFlow:registerDoneListener(self.flowDone, self)
	self._roundFlow:start()
end

function DiceHeroGameView:_hideDiceAndShowEnemyBehavior()
	UIBlockHelper.instance:startBlock("DiceHeroGameView_RoundStart", 1)
	gohelper.setActive(self._godice, false)

	for _, enemyItem in pairs(self._enemys) do
		enemyItem:refreshAll()
		enemyItem:showBehavior()
	end

	self._hero:refreshAll()
end

function DiceHeroGameView:_showMask()
	self._anim:Play("camerain", 0, 0)
	self._maskAnim:Play("in", 0, 0)
end

function DiceHeroGameView:onDamageEffect(isFromHero)
	gohelper.setActive(self._damageEffectHero, isFromHero)
	gohelper.setActive(self._damageEffectEnemy, not isFromHero)

	local gameData = DiceHeroFightModel.instance:getGameData()

	if gameData.confirmed then
		self._anim:Play("damage", 0, 0)
	else
		self._anim:Play("damage1", 0, 0)
	end
end

function DiceHeroGameView:_showDiceAndHideEnemyBehavior()
	gohelper.setActive(self._godice, true)
	self._diceBox:startRoll()

	for _, enemyItem in pairs(self._enemys) do
		enemyItem:hideBehavior()
	end
end

function DiceHeroGameView:flowDone()
	local gameInfo = DiceHeroFightModel.instance:getGameData()

	DiceHeroController.instance:dispatchEvent(DiceHeroEvent.DiceHeroGuideRoundInfo, string.format("%s_%s", DiceHeroModel.instance.lastEnterLevelId, gameInfo.round))

	self._roundFlow = nil

	if DiceHeroHelper.instance.afterFlow then
		local flow = DiceHeroHelper.instance.afterFlow

		DiceHeroHelper.instance.afterFlow = nil

		DiceHeroHelper.instance:startFlow(flow)
	end
end

function DiceHeroGameView:confirmDice()
	self._anim:Play("cameraout", 0, 0)
	self._maskAnim:Play("out", 0, 0)
end

function DiceHeroGameView:refreshCards()
	local skillCards = DiceHeroFightModel.instance:getGameData().skillCards

	self._cards = self._cards or {}

	gohelper.CreateObjList(self, self._createCard, skillCards, nil, self._gocard, DiceHeroCardItem)
end

function DiceHeroGameView:_createCard(obj, data, index)
	obj:initData(data)

	self._cards[data.skillId] = obj
end

function DiceHeroGameView:refreshEnemys()
	local enemyHeros = DiceHeroFightModel.instance:getGameData().enemyHeros

	self._enemys = self._enemys or {}

	gohelper.CreateObjList(self, self._createEnemy, enemyHeros, nil, self._goenemy, DiceHeroEnemyItem, nil, nil, 1)
end

function DiceHeroGameView:_createEnemy(obj, data, index)
	obj:initData(data)

	self._enemys[data.uid] = obj
end

function DiceHeroGameView:onDestroyView()
	if self._roundFlow then
		self._roundFlow:onDestroyInternal()

		self._roundFlow = nil
	end

	DiceHeroHelper.instance:clear()
end

return DiceHeroGameView
