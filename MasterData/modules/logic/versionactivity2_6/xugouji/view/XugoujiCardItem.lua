-- chunkname: @modules/logic/versionactivity2_6/xugouji/view/XugoujiCardItem.lua

module("modules.logic.versionactivity2_6.xugouji.view.XugoujiCardItem", package.seeall)

local XugoujiCardItem = class("XugoujiCardItem", ListScrollCellExtend)
local actId = VersionActivity2_6Enum.ActivityId.Xugouji
local cardBackBgPlayer = "v2a6_xugouji_skillcard_selfback"

function XugoujiCardItem:onInitView()
	self._btn = gohelper.findChildButtonWithAudio(self.viewGO, "#image_RoleBG")
	self._goLock = gohelper.findChild(self.viewGO, "#go_Locked")
	self._goRoleBG = gohelper.findChild(self.viewGO, "#image_RoleBG")
	self._imageRoleBG = gohelper.findChildImage(self.viewGO, "#image_RoleBG")
	self._goCardIcon = gohelper.findChild(self.viewGO, "#simage_SkillIcon")
	self._imgCardIcon = gohelper.findChildImage(self.viewGO, "#simage_SkillIcon")
	self._goFlip = gohelper.findChild(self.viewGO, "#go_Flip")
	self._goSelected = gohelper.findChild(self.viewGO, "#go_RoleSelected")
	self._txtDebugLog = gohelper.findChildText(self.viewGO, "#txt_debuglog")
	self._animator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._goEnemyCardBackLogo = gohelper.findChild(self.viewGO, "#image_RoleBG/enemy_logo")
	self._enemyCardBackLogoAnimator = ZProj.ProjAnimatorPlayer.Get(self._goEnemyCardBackLogo)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function XugoujiCardItem:addEvents()
	self._btn:AddClickListener(self._clickCard, self)
end

function XugoujiCardItem:removeEvents()
	self._btn:RemoveClickListener()
end

function XugoujiCardItem:_clickCard()
	local operatable = Activity188Model.instance:getGameState()

	if operatable ~= XugoujiEnum.GameStatus.Operatable then
		return
	end

	local isBack = self._cardInfo.status == XugoujiEnum.CardStatus.Back

	if not isBack then
		return
	end

	XugoujiController.instance:selectCardItem(self._cardInfo.uid)
end

function XugoujiCardItem:_editableInitView()
	self._flipState = XugoujiEnum.CardStatus.Back
	self._perspective = false
	self._lockState = false
	self._active = false
end

function XugoujiCardItem:_editableAddEvents()
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.OperateCard, self._onOperatedCard, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.CardStatusUpdated, self._onCardStatusUpdate, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.CardPairStatusUpdated, self._onCardPairStatusUpdated, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.GotActiveCard, self._onGotCardPair, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.TurnChanged, self._onTurnChanged, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.CardEffectStatusUpdated, self._onCardEffectStatusUpdate, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.FilpBackUnActiveCard, self._onFilpBackUnActive, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.GotNewCardDisplay, self.onUpdateNewCard, self)
	self.addEventCb(self, XugoujiController.instance, XugoujiEvent.GameRestartCardDisplay, self.onGameRestart, self)
end

function XugoujiCardItem:_editableRemoveEvents()
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.OperateCard, self._onOperatedCard, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.CardStatusUpdated, self._onCardStatusUpdate, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.CardPairStatusUpdated, self._onCardPairStatusUpdated, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.GotActiveCard, self._onGotCardPair, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.TurnChanged, self._onTurnChanged, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.CardEffectStatusUpdated, self._onCardEffectStatusUpdate, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.FilpBackUnActiveCard, self._onFilpBackUnActive, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.GotNewCardDisplay, self.onUpdateNewCard, self)
	self.removeEventCb(self, XugoujiController.instance, XugoujiEvent.GameRestartCardDisplay, self.onGameRestart, self)
end

function XugoujiCardItem:_onOperatedCard(cardUid)
	if self._cardInfo.uid == cardUid then
		self._seleted = true

		gohelper.setActive(self._goSelected, self._seleted)
	end
end

function XugoujiCardItem:_onCardStatusUpdate(cardUid)
	if self._cardInfo.uid == cardUid then
		self:refreshUI()
	end
end

function XugoujiCardItem:_onGotCardPair(cardPair)
	if self._cardInfo.uid == cardPair[1] or self._cardInfo.uid == cardPair[2] then
		self:playCardGotPairAni()
	end
end

function XugoujiCardItem:_onCardPairStatusUpdated(cardUid)
	if self._cardInfo.uid == cardUid then
		self:playCardGotPairAni()
		self:hideCard()
	end
end

function XugoujiCardItem:_onTurnChanged()
	self._seleted = false

	gohelper.setActive(self._goSelected, false)
	gohelper.setActive(self._goEnemyCardBackLogo, true)

	local isMyTurn = Activity188Model.instance:isMyTurn()

	self._enemyCardBackLogoAnimator:Play((isMyTurn or nil) and (UIAnimationName.Out or UIAnimationName.In), nil, nil)

	local curStatue = self._cardInfo.status

	if not self._active and curStatue == XugoujiEnum.CardStatus.Disappear then
		self:playActiveAni()
	end

	if self._active or self._lockState then
		return
	end

	self:refreshUI()
end

function XugoujiCardItem:_onCardEffectStatusUpdate(cardUid)
	if self._cardInfo.uid == cardUid then
		self:refreshUI()
	end
end

function XugoujiCardItem:_onFilpBackUnActive()
	if self._flipState == XugoujiEnum.CardStatus.Back then
		return
	end

	local curStatue = self._cardInfo.status
	local cardStatue = self._flipState
	local isMyTurn = Activity188Model.instance:isMyTurn()

	gohelper.setActive(self._goEnemyCardBackLogo, isMyTurn)
	self._enemyCardBackLogoAnimator:Play((isMyTurn or nil) and (UIAnimationName.Idle or "idle1"), nil, nil)

	if curStatue == XugoujiEnum.CardStatus.Back and cardStatue ~= curStatue then
		self:refreshUI()
	end
end

function XugoujiCardItem:onUpdateNewCard()
	self._animator:Play(UIAnimationName.Close, nil, nil)

	local isMyTurn = Activity188Model.instance:isMyTurn()

	gohelper.setActive(self._goEnemyCardBackLogo, not isMyTurn)

	self._flipState = XugoujiEnum.CardStatus.Back

	Activity188Model.instance:setCardItemStatue(self._cardInfo.uid, self._flipState)
end

function XugoujiCardItem:onGameRestart()
	self._animator:Play(UIAnimationName.Close, nil, nil)
	gohelper.setActive(self._goEnemyCardBackLogo, false)

	self._flipState = XugoujiEnum.CardStatus.Back
end

function XugoujiCardItem:onUpdateData(cardInfo)
	self._cardInfo = cardInfo
	self._seleted = false
	self._hide = false
	self._lockState = false
	self._perspective = false
	self._active = false
	self._flipState = XugoujiEnum.CardStatus.Back

	Activity188Model.instance:setCardItemStatue(self._cardInfo.uid, self._flipState)
end

function XugoujiCardItem:refreshUI()
	if not self._cardInfo then
		return
	end

	if self._active then
		return
	end

	gohelper.setActive(self._goSelected, self._seleted)
	self:refreshCardAniShow(self._cardInfo)

	self._flipState = self._cardInfo.status

	Activity188Model.instance:setCardItemStatue(self._cardInfo.uid, self._flipState)

	local isFront = self._cardInfo.status == XugoujiEnum.CardStatus.Front
	local isBack = self._cardInfo.status == XugoujiEnum.CardStatus.Back
	local isDisappear = self._cardInfo.status == XugoujiEnum.CardStatus.Disappear

	if isBack and self._seleted then
		gohelper.setActive(self._goSelected, false)
	end

	local cardEffectStatus = Activity188Model.instance:getCardEffect(self._cardInfo.uid)

	gohelper.setActive(self._goCardIcon, isFront or isDisappear or cardEffectStatus and cardEffectStatus[XugoujiEnum.CardEffectStatus.Perspective])

	local isDebugMode = XugoujiController.instance:isDebugMode()

	gohelper.setActive(self._txtDebugLog.gameObject, XugoujiController.instance:isDebugMode())

	if isDebugMode then
		local debugStr = self._cardInfo.id
		local cardCfg = Activity188Config.instance:getCardCfg(actId, self._cardInfo.id)

		self._txtDebugLog.text = debugStr
	end
end

function XugoujiCardItem:hideCard()
	self._hide = true
	self._seleted = false
end

function XugoujiCardItem:refreshCardIcon()
	if not self._cardInfo then
		return
	end

	local cardCfg = Activity188Config.instance:getCardCfg(actId, self._cardInfo.id)
	local cardIconPath = cardCfg.resource

	if not cardIconPath or cardIconPath == "" then
		return
	end

	UISpriteSetMgr.instance:setXugoujiSprite(self._imgCardIcon, cardIconPath)
	UISpriteSetMgr.instance:setXugoujiSprite(self._imageRoleBG, cardBackBgPlayer)
end

function XugoujiCardItem:refreshCardAniShow(cardInfo)
	local curStatue = self._cardInfo.status

	if self._flipState == XugoujiEnum.CardStatus.Back and curStatue == XugoujiEnum.CardStatus.Front then
		self._perspective = false
		self._lockState = false

		self._animator:Play(UIAnimationName.Open, nil, nil)
		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardFilp)

		return
	elseif self._flipState == XugoujiEnum.CardStatus.Front and curStatue == XugoujiEnum.CardStatus.Back then
		self._animator:Play(UIAnimationName.Close, nil, nil)
		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardClose)

		return
	end

	local cardEffectStatus = Activity188Model.instance:getCardEffect(self._cardInfo.uid)

	if not self._perspective and cardEffectStatus and cardEffectStatus[XugoujiEnum.CardEffectStatus.Perspective] and not self._perspective then
		self._perspective = true

		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardPerspective)
		self._animator:Play("perspective_in", nil, nil)
	elseif self._perspective and cardEffectStatus and not cardEffectStatus[XugoujiEnum.CardEffectStatus.Perspective] then
		self._perspective = false

		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardPerspectiveEnd)
		self._animator:Play("perspective_out", nil, nil)
	elseif not self._lockState and cardEffectStatus and cardEffectStatus[XugoujiEnum.CardEffectStatus.Lock] then
		self._lockState = true

		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardLock)
		self._animator:Play("lock_in", nil, nil)
	elseif self._lockState and cardEffectStatus and not cardEffectStatus[XugoujiEnum.CardEffectStatus.Lock] then
		self._lockState = false

		self._animator:Play("lock_out", nil, nil)
	end
end

function XugoujiCardItem:playCardGotPairAni()
	self._animator:Play(UIAnimationName.Finish, nil, nil)
end

function XugoujiCardItem:playActiveAni()
	if self._active then
		return
	end

	self._active = true

	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardDisappear)
	self._animator:Play("active_in", nil, nil)
end

function XugoujiCardItem:clearCardEffect()
	if not self._cardInfo then
		return
	end

	local isFront = self._cardInfo.status == XugoujiEnum.CardStatus.Front
	local isDisappear = self._cardInfo.status == XugoujiEnum.CardStatus.Disappear

	gohelper.setActive(self._goCardIcon, isFront or isDisappear)
end

function XugoujiCardItem:onDestroyView()
	return
end

return XugoujiCardItem
