-- chunkname: @modules/logic/handbook/view/HandbookScene_Tarot.lua

module("modules.logic.handbook.view.HandbookScene_Tarot", package.seeall)

local HandbookScene_Tarot = class("HandbookScene_Tarot", HandbookScene_Base)

function HandbookScene_Tarot:getSkinCount()
	return HandbookEnum.TarotSkinCount
end

function HandbookScene_Tarot:getCardCount()
	return HandbookEnum.TarotCardCount
end

function HandbookScene_Tarot:getSkinCardDir()
	return HandbookEnum.TarotSkinCardDir
end

function HandbookScene_Tarot:getSkinDefaultCardPath()
	return HandbookEnum.TarotSkinDefaultCardPath
end

function HandbookScene_Tarot:getUnlockVxPath()
	return HandbookEnum.SkinUnlockVxPath.Tarot
end

function HandbookScene_Tarot:getUnlockVxGoName(cardIdx)
	return "tarotUnlockVx_" .. tostring(cardIdx)
end

function HandbookScene_Tarot:getRedDotLocateWrapCount()
	return HandbookEnum.TarotSkinCount
end

function HandbookScene_Tarot:isModeEntered()
	return self._scene._tarotMode
end

function HandbookScene_Tarot:isModeEntering()
	return self._scene._enteringTarotMode
end

function HandbookScene_Tarot:onDispatchEnterEvent()
	self._scene.viewContainer:dispatchEvent(HandbookEvent.OnClickTarotSkinSuit)
end

function HandbookScene_Tarot:onDispatchExitEvent()
	self._scene.viewContainer:dispatchEvent(HandbookEvent.OnExitTarotSkinSuit)
end

function HandbookScene_Tarot:locateInitialCards()
	local scene = self._scene

	scene._curLeftIdx = 1
	scene._curRightIdx = 5
end

function HandbookScene_Tarot:_onParseCardData(cardIdx, skinId)
	if HandbookEnum.SkinSpAnimEnum[skinId] or HandbookEnum.SkinSp2AnimEnum[skinId] then
		local scene = self._scene

		scene._tarotCardDatas[cardIdx].extraCardIcon1 = string.format("%s/%s_l.png", HandbookEnum.TarotSkinCardDir, scene._skinCardNameList[cardIdx])
		scene._tarotCardDatas[cardIdx].extraCardIcon2 = string.format("%s/%s_r.png", HandbookEnum.TarotSkinCardDir, scene._skinCardNameList[cardIdx])
	end
end

function HandbookScene_Tarot:_initSubSceneCardTables()
	local scene = self._scene

	scene._tarotCardBackSpriteRender = scene:getUserDataTb_()
	scene._tarotCardLeftSpriteRenders = scene:getUserDataTb_()
	scene._tarotCardRightSpriteRenders = scene:getUserDataTb_()
end

function HandbookScene_Tarot:_setupCardExtraRenderers(cardRootGo, cardIdx, skinId)
	local scene = self._scene
	local goSpriteCardBack = gohelper.findChild(cardRootGo, "card/back")

	scene._tarotCardBackSpriteRender[cardIdx] = goSpriteCardBack:GetComponent(typeof(UnityEngine.SpriteRenderer))

	local isSpCard = HandbookEnum.SkinSpAnimEnum[skinId]
	local leftPath = isSpCard and "card/card_sp/card_left/sprite" or "card/card_sp2/card_left/sprite"
	local rightPath = isSpCard and "card/card_sp/card_right/sprite" or "card/card_sp2/card_right/sprite"
	local goSpriteLeft = gohelper.findChild(cardRootGo, leftPath)

	scene._tarotCardLeftSpriteRenders[cardIdx] = goSpriteLeft and goSpriteLeft:GetComponent(typeof(UnityEngine.SpriteRenderer))

	local goSpriteRight = gohelper.findChild(cardRootGo, rightPath)

	scene._tarotCardRightSpriteRenders[cardIdx] = goSpriteRight and goSpriteRight:GetComponent(typeof(UnityEngine.SpriteRenderer))
end

function HandbookScene_Tarot:onEnterSceneEnd()
	local scene = self._scene

	self:_setCardBackSprite()

	scene._enteringTarotMode = true

	AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_special)
	TaskDispatcher.runDelay(self.onEnterAniDone, self, 2)
end

function HandbookScene_Tarot:_setCardBackSprite()
	local scene = self._scene
	local spritePath = HandbookEnum.TarotSkinDefaultCardPath

	if not string.nilorempty(spritePath) then
		if scene._cardbackLoader then
			scene._cardbackLoader:dispose()
		end

		local loader = MultiAbLoader.New()

		scene._cardbackLoader = loader

		loader:addPath(spritePath)
		loader:startLoad(self._onCardBackLoadDone, self)
	end
end

function HandbookScene_Tarot:_onCardBackLoadDone(loader)
	local scene = self._scene
	local spritePath = HandbookEnum.TarotSkinDefaultCardPath
	local assetItem = loader:getAssetItem(spritePath)
	local texture = assetItem:GetResource(spritePath)
	local sprite = UnityEngine.Sprite.Create(texture, UnityEngine.Rect.New(0, 0, texture.width, texture.height), Vector2.New(0.5, 0.5), 100, 0)

	for _, cardBackSpriteRender in ipairs(scene._tarotCardBackSpriteRender) do
		cardBackSpriteRender.sprite = sprite
	end
end

function HandbookScene_Tarot:_markModeEntered()
	local scene = self._scene

	scene._enteringTarotMode = false
	scene._tarotMode = true
	scene._tarotEnterAniDone = true
end

function HandbookScene_Tarot:_onCardEnterAniDone(cardIdx)
	self:playSpCardOpenAni(cardIdx)
	HandbookScene_Tarot.super._onCardEnterAniDone(self, cardIdx)
end

function HandbookScene_Tarot:exitScene()
	local scene = self._scene

	if not scene._tarotMode then
		return
	end

	scene._tarotMode = false
	scene._tarotEnterAniDone = false

	self:_doExitScene()
end

function HandbookScene_Tarot:_doPlaySpCardCloseAni(cardAnimator, skinId)
	if HandbookEnum.SkinSpAnimEnum[skinId] then
		local spCardGo = cardAnimator.transform:Find("card/card_sp").gameObject
		local spCardAnimator = spCardGo:GetComponent(gohelper.Type_Animator)

		spCardAnimator.enabled = true

		spCardAnimator:Play(UIAnimationName.Close)
	elseif HandbookEnum.SkinSp2AnimEnum[skinId] then
		local spCardGo = cardAnimator.transform:Find("card/card_sp2").gameObject
		local spCardAnimator = spCardGo:GetComponent(gohelper.Type_Animator)

		spCardAnimator.enabled = true

		spCardAnimator:Play(UIAnimationName.Close)
	end
end

function HandbookScene_Tarot:_doPlaySpCardOpenAni(cardAnimator, skinId)
	if HandbookEnum.SkinSpAnimEnum[skinId] then
		local spCardGo = cardAnimator.transform:Find("card/card_sp").gameObject
		local spCardAnimator = spCardGo:GetComponent(gohelper.Type_Animator)

		gohelper.setActive(spCardGo, true)

		spCardAnimator.enabled = true

		spCardAnimator:Play(UIAnimationName.Open)
	elseif HandbookEnum.SkinSp2AnimEnum[skinId] then
		local spCardGo = cardAnimator.transform:Find("card/card_sp2").gameObject
		local spCardAnimator = spCardGo:GetComponent(gohelper.Type_Animator)

		gohelper.setActive(spCardGo, true)

		spCardAnimator.enabled = true

		spCardAnimator:Play(UIAnimationName.Open)
	end
end

function HandbookScene_Tarot:_playUnlockUx(cardGoIdx, animator, skinId, showUnlockAnim)
	local scene = self._scene
	local animName = showUnlockAnim and "open" or "idle"

	animator:Play(animName, 0, 0)

	if scene.isUniqueSkin then
		if not HandbookEnum.Audio.play_ui_tujianskin_special_unlock then
			local audioId = HandbookEnum.Audio.play_ui_activity_hero37_checkpoint_gather

			AudioMgr.instance:trigger(audioId)
			HandbookController.instance:delaySendUnlockSkinRedDotInfo(skinId)
		end
	end
end

return HandbookScene_Tarot
