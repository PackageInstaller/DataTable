-- chunkname: @modules/logic/handbook/view/HandbookScene_Seven.lua

module("modules.logic.handbook.view.HandbookScene_Seven", package.seeall)

local HandbookScene_Seven = class("HandbookScene_Seven", HandbookScene_Base)
local cardCount = 5
local sevenCardDefaultPosMap = {
	0.1667,
	0.3333,
	0.5,
	0.6667,
	0.8333
}

local function getScreenOrderSkinIdx(scene)
	local sorted = {}

	for i = 1, cardCount do
		local progress = scene._tarotCardAniProgress[i]

		if progress ~= nil then
			sorted[#sorted + 1] = {
				progress = progress,
				skinIdx = scene._tarotCardIdx2SkinIdx[i]
			}
		end
	end

	table.sort(sorted, function(a, b)
		return a.progress < b.progress
	end)

	local skins = {}

	for _, item in ipairs(sorted) do
		skins[#skins + 1] = item.skinIdx
	end

	return table.concat(skins, ",")
end

function HandbookScene_Seven:getSkinCount()
	return HandbookEnum.SevenSkinCount
end

function HandbookScene_Seven:getCardCount()
	return HandbookEnum.SevenCardCount
end

function HandbookScene_Seven:getCardDefaultPosMap()
	return sevenCardDefaultPosMap
end

function HandbookScene_Seven:isMaxProgressAtScreenLeft()
	return false
end

function HandbookScene_Seven:getSkinCardDir()
	return HandbookEnum.SevenSkinCardDir
end

function HandbookScene_Seven:getSkinDefaultCardPath()
	return HandbookEnum.SevenSkinDefaultCardPath
end

function HandbookScene_Seven:getUnlockVxPath()
	return HandbookEnum.SkinUnlockVxPath.Seven
end

function HandbookScene_Seven:getUnlockVxGoName(cardIdx)
	return "sevenUnlockVx_" .. tostring(cardIdx)
end

function HandbookScene_Seven:getRedDotLocateWrapCount()
	return HandbookEnum.SevenSkinCount
end

function HandbookScene_Seven:isModeEntered()
	return self._scene._sevenMode
end

function HandbookScene_Seven:isModeEntering()
	return self._scene._enteringSevenMode
end

function HandbookScene_Seven:onDispatchEnterEvent()
	self._scene.viewContainer:dispatchEvent(HandbookEvent.OnClickSevenSkinSuit)
end

function HandbookScene_Seven:onDispatchExitEvent()
	self._scene.viewContainer:dispatchEvent(HandbookEvent.OnExitSevenSkinSuit)
end

function HandbookScene_Seven:onEnterSceneStart()
	self._scene._enteringSevenMode = true

	HandbookScene_Seven.super.onEnterSceneStart(self)
end

function HandbookScene_Seven:locateInitialCards()
	local scene = self._scene
	local actualSkinCount = #scene._skinIdList
	local visibleCount = math.min(actualSkinCount, cardCount)

	scene._curLeftIdx = 1 - math.floor((cardCount + 1 - visibleCount) / 2)
	scene._curRightIdx = scene._curLeftIdx + cardCount - 1

	local skinCount = self:getSkinCount()

	scene._curLeftIdx = (scene._curLeftIdx - 1) % skinCount + 1
	scene._curRightIdx = (scene._curRightIdx - 1) % skinCount + 1

	logNormal(string.format("[HandbookScene_Seven] enterScene 初始居中索引:%s (curLeftIdx:%s curRightIdx:%s)", self:getMiddleSkinIdx(), scene._curLeftIdx, scene._curRightIdx))
end

function HandbookScene_Seven:_hideRedDotAndMarkRead()
	HandbookScene_Seven.super._hideRedDotAndMarkRead(self)
	HandbookController.instance:statSkinSuitDetail(self._scene._suitId)
end

function HandbookScene_Seven:onEnterSceneEnd()
	local scene = self._scene

	logNormal(string.format("[HandbookScene_Seven] enterScene 最终居中索引:%s, cardIdx2SkinIdx:[%s], 屏幕顺序(左→右):[%s]", self:getMiddleSkinIdx(), table.concat(scene._tarotCardIdx2SkinIdx, ","), getScreenOrderSkinIdx(scene)))
	TaskDispatcher.runDelay(self.openSkinView, self, 2)
	TaskDispatcher.runDelay(self.onEnterAniDone, self, 2)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockHelper.instance:startBlock(UIBlockKey.WaitItemAnimeDone, 2)
	AudioMgr.instance:trigger(HandbookEnum.Audio.ui_tujianskin_qimeide_open)
end

function HandbookScene_Seven:openSkinView()
	local scene = self._scene

	UIBlockHelper.instance:endBlock(UIBlockKey.WaitItemAnimeDone)
	UIBlockMgrExtend.setNeedCircleMv(true)

	local viewName = HandbookSkinScene.SkinSuitId2SuitView[scene._suitId]

	if viewName then
		local viewParam = {
			skinThemeGroupId = scene._suitId
		}

		ViewMgr.instance:openView(viewName, viewParam)
	end

	AudioMgr.instance:trigger(AudioEnum.Handbook.play_ui_tujianskin_group_open)
	HandbookController.instance:statSkinSuitDetail(scene._suitId)
end

function HandbookScene_Seven:_markModeEntered()
	local scene = self._scene

	scene._enteringSevenMode = false
	scene._sevenMode = true
	self._enterAniDone = true
end

function HandbookScene_Seven:_markModeExited()
	local scene = self._scene

	scene._sevenMode = false
	scene._enteringSevenMode = false
	self._enterAniDone = false
end

function HandbookScene_Seven:_exitScene()
	local scene = self._scene

	if not scene._sevenMode then
		return
	end

	scene._sevenMode = false
	self._enterAniDone = false

	self:_doExitScene()
end

function HandbookScene_Seven:doCardPosToMiddle(skinIdx)
	local scene = self._scene

	logNormal(string.format("[HandbookScene_Seven] 点击卡牌居中前 居中索引:%s 目标索引:%s, cardIdx2SkinIdx:[%s], 屏幕顺序(左→右):[%s]", self:getMiddleSkinIdx(), skinIdx, table.concat(scene._tarotCardIdx2SkinIdx, ","), getScreenOrderSkinIdx(scene)))
	HandbookScene_Seven.super.doCardPosToMiddle(self, skinIdx)
end

function HandbookScene_Seven:cardPosToMiddleTweenEndCallback()
	HandbookScene_Seven.super.cardPosToMiddleTweenEndCallback(self)

	local scene = self._scene

	logNormal(string.format("[HandbookScene_Seven] 点击卡牌居中后 居中索引:%s, cardIdx2SkinIdx:[%s], 屏幕顺序(左→右):[%s]", self:getMiddleSkinIdx(), table.concat(scene._tarotCardIdx2SkinIdx, ","), getScreenOrderSkinIdx(scene)))
end

function HandbookScene_Seven:_doPlaySpCardCloseAni(cardAnimator, skinId)
	if skinId == 310003 then
		local spCardGo = cardAnimator.transform:Find("card/card_sp").gameObject
		local spCardAnimator = spCardGo:GetComponent(gohelper.Type_Animator)

		spCardAnimator:Play(UIAnimationName.Close)
	end
end

function HandbookScene_Seven:_doPlaySpCardOpenAni(cardAnimator, skinId)
	if skinId == 310003 then
		local spCardGo = cardAnimator.transform:Find("card/card_sp").gameObject
		local spCardAnimator = spCardGo:GetComponent(gohelper.Type_Animator)

		gohelper.setActive(spCardGo, true)
		spCardAnimator:Play(UIAnimationName.Open)
	end
end

function HandbookScene_Seven:_playUnlockUx(cardGoIdx, animator, skinId, showUnlockAnim)
	local scene = self._scene

	if showUnlockAnim then
		AudioMgr.instance:trigger(HandbookEnum.Audio.play_ui_activity_hero37_checkpoint_gather)
		HandbookController.instance:delaySendUnlockSkinRedDotInfo(skinId)

		local animEvent = scene._tarotCardUnlockAnimEvent[cardGoIdx]

		animEvent:AddEventListener("unlock", self.onUnlockAnimPlayFinish, {
			self,
			cardGoIdx
		})

		self._pendingOpenAnimCards = self._pendingOpenAnimCards or {}
		self._pendingOpenAnimCards[cardGoIdx] = true

		TaskDispatcher.runDelay(self._delayPlayOpenAnim, self, 0.1)
	else
		animator:Play(HandbookEnum.SkinUnlockAnimName.Idle, 0, 0)
	end
end

function HandbookScene_Seven:_delayPlayOpenAnim()
	local scene = self._scene

	if self._pendingOpenAnimCards then
		for cardGoIdx, _ in pairs(self._pendingOpenAnimCards) do
			local animator = scene._tarotCardUnlockAnimator[cardGoIdx]

			if animator then
				animator:Play(HandbookEnum.SkinUnlockAnimName.Open, 0, 0)
			end
		end

		self._pendingOpenAnimCards = nil
	end
end

function HandbookScene_Seven:onClose()
	HandbookScene_Seven.super.onClose(self)
	TaskDispatcher.cancelTask(self.openSkinView, self)
end

return HandbookScene_Seven
