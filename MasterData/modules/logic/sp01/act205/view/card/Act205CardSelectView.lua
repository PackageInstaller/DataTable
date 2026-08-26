-- chunkname: @modules/logic/sp01/act205/view/card/Act205CardSelectView.lua

module("modules.logic.sp01.act205.view.card.Act205CardSelectView", package.seeall)

local Act205CardSelectView = class("Act205CardSelectView", BaseView)
local ViewStage = {
	PlayerSelectCard = 2,
	ShowEnemyCard = 1
}
local AnimBlockKey = "Act205CardSelectViewConfirmSelect"

function Act205CardSelectView:onInitView()
	self._gomask = gohelper.findChild(self.viewGO, "BG/Mask")
	self._goenemyCards = gohelper.findChild(self.viewGO, "Enemy/#go_enemyCards")
	self._goplayer = gohelper.findChild(self.viewGO, "Self")
	self._goplayerCards = gohelper.findChild(self.viewGO, "Self/#go_playerCards")
	self._txtWeaponNum = gohelper.findChildText(self.viewGO, "Self/txt_Selected/#txt_WeaponNum")
	self._txtRoleNum = gohelper.findChildText(self.viewGO, "Self/txt_Selected/#txt_RoleNum")
	self._btnStart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Start")
	self._goNext = gohelper.findChild(self.viewGO, "#btn_Start/#go_Next")
	self._goStart = gohelper.findChild(self.viewGO, "#btn_Start/#go_Start")
	self._golight2 = gohelper.findChild(self.viewGO, "#btn_Start/stepIndexContent/#go_stepIndex2/go_light")
	self._godesc = gohelper.findChild(self.viewGO, "Info/image_DescrBG")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Info/image_DescrBG/#txt_InfoDescr")
	self._btnrule = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_rule")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act205CardSelectView:addEvents()
	self._btnStart:AddClickListener(self._btnStartOnClick, self)
	self._btnrule:AddClickListener(self._btnruleOnClick, self)
	self.addEventCb(self, Act205CardController.instance, Act205Event.PlayerSelectCard, self._onSelectedCard, self)
end

function Act205CardSelectView:removeEvents()
	self._btnStart:RemoveClickListener()
	self._btnrule:RemoveClickListener()
	self.removeEventCb(self, Act205CardController.instance, Act205Event.PlayerSelectCard, self._onSelectedCard, self)
end

function Act205CardSelectView:_btnStartOnClick()
	if self._viewStage == ViewStage.ShowEnemyCard then
		self:_enterNextStage()
	elseif self._viewStage == ViewStage.PlayerSelectCard then
		local result = Act205CardController.instance:checkPkPoint()

		if result then
			self.playAnim(self, "close", self._openCardShowAfterCloseAnim, self)
		end
	else
		self:setViewStage()
	end
end

function Act205CardSelectView:_openCardShowAfterCloseAnim()
	Act205CardController.instance:openCardShowView()
end

function Act205CardSelectView:_btnruleOnClick()
	Act205Controller.instance:openRuleTipsView()
end

function Act205CardSelectView:_onSelectedCard()
	self:refreshSelectedCard()
end

function Act205CardSelectView:_enterNextStage()
	self:setViewStage(ViewStage.PlayerSelectCard, true)
end

function Act205CardSelectView:_editableInitView()
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	local cardItemPath = self.viewContainer:getSetting().otherRes[1]

	self._goCardItem = self:getResInst(cardItemPath, self.viewGO, "cardItem")

	gohelper.setActive(self._goCardItem, false)
	self:setViewStage()
end

function Act205CardSelectView:setViewStage(stage, needPlay)
	self._viewStage = stage or ViewStage.ShowEnemyCard

	self:refreshViewStage(needPlay)
end

function Act205CardSelectView:onUpdateParam()
	return
end

function Act205CardSelectView:onOpen()
	local enemyCardList = Act205CardController.instance:getEnemyCardIdList()

	gohelper.CreateObjList(self, self._onEnemyCardItemCreated, enemyCardList, self._goenemyCards, self._goCardItem, Act205CardItem)

	local playerCardList = Act205CardController.instance:getPlayerCardIdList()

	gohelper.CreateObjList(self, self._onPlayerCardItemCreated, playerCardList, self._goplayerCards, self._goCardItem, Act205CardItem)
end

function Act205CardSelectView:_onEnemyCardItemCreated(obj, data, index)
	obj:setData(data)
end

function Act205CardSelectView:_onPlayerCardItemCreated(obj, data, index)
	obj:setData(data, true)
end

function Act205CardSelectView:refreshViewStage(needPlay)
	local isPlayerSelectedCard = self._viewStage == ViewStage.PlayerSelectCard

	gohelper.setActive(self._goNext, not isPlayerSelectedCard)
	gohelper.setActive(self._goStart, isPlayerSelectedCard)
	gohelper.setActive(self._golight2, isPlayerSelectedCard)

	if needPlay then
		local animName = isPlayerSelectedCard and "selfin" or "open"

		self:playAnim(animName)

		if isPlayerSelectedCard then
			AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_swich1)
		end
	end

	self:refreshSelectedCard()
end

function Act205CardSelectView:playAnim(animName, cb, cbObj)
	if string.nilorempty(animName) or not self._animatorPlayer then
		return
	end

	UIBlockMgr.instance:startBlock(AnimBlockKey)

	self._animCb = cb
	self._animCbObj = cbObj

	self._animatorPlayer:Play(animName, self._playAnimFinish, self)
end

function Act205CardSelectView:_playAnimFinish()
	if self._animCb then
		self._animCb(self._animCbObj)
	end

	self._animCb = nil
	self._animCbObj = nil

	UIBlockMgr.instance:endBlock(AnimBlockKey)
end

function Act205CardSelectView:refreshSelectedCard()
	local isPlayerSelectedCard = self._viewStage == ViewStage.PlayerSelectCard

	if not isPlayerSelectedCard then
		return
	end

	local isSelectedRoleCard = Act205CardModel.instance:isSelectedCardTypeCard(Act205Enum.CardType.Role)

	self._txtRoleNum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act205_card_selected"), isSelectedRoleCard and 1 or 0)

	UIColorHelper.set(self._txtRoleNum, isSelectedRoleCard and "#BA1515" or "#4B2A1E")

	local isSelectedWeaponCard = Act205CardModel.instance:isSelectedCardTypeCard(Act205Enum.CardType.Weapon)

	self._txtWeaponNum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act205_card_selected"), isSelectedWeaponCard and 1 or 0)

	UIColorHelper.set(self._txtWeaponNum, isSelectedWeaponCard and "#BA1515" or "#4B2A1E")

	local isCanPK = Act205CardModel.instance:getIsCanBeginPK()

	ZProj.UGUIHelper.SetGrayscale(self._goStart, not isCanPK)
end

function Act205CardSelectView:onClose()
	return
end

function Act205CardSelectView:onDestroyView()
	self._viewStage = nil

	UIBlockMgr.instance:endBlock(AnimBlockKey)
end

return Act205CardSelectView
