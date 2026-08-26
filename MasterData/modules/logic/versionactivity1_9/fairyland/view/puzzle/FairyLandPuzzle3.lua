-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/puzzle/FairyLandPuzzle3.lua

module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzle3", package.seeall)

local FairyLandPuzzle3 = class("FairyLandPuzzle3", FairyLandPuzzleBase)

function FairyLandPuzzle3:onInitView()
	self._shapeGO = gohelper.findChild(self.viewGO, "main/#go_Shape/3")

	local arrow = gohelper.findChild(self._shapeGO, "image_shape/#go_Arrow")

	self.tipAnim = SLFramework.AnimatorPlayer.Get(arrow)
	self._shapeTrs = self._shapeGO.transform
	self._goImageShape = gohelper.findChild(self._shapeGO, "image_shape")

	self:addDrag(self._goImageShape)
	gohelper.setActive(self._shapeGO, true)

	self._dragTrs = self._goImageShape.transform

	local x, y = recthelper.getAnchor(self._dragTrs)

	self.initPos = {
		x = x,
		y = y
	}
	self.minVolume = 0
	self.maxVolume = 100
	self._canUseSDK = BootNativeUtil.isMobilePlayer() and BootNativeUtil.getPackageName() ~= "com.shenlan.m.reverse1999.nearme.gamecenter"
	self._isUnsupportChangeVolume = nil

	if not self:canUseSdk() then
		self.initBGMVolume = SettingsModel.instance:getMusicValue()
	end

	self.initVolume = self:getVolume()

	TaskDispatcher.runDelay(self.delaySetFlag, self, 0.1)
end

function FairyLandPuzzle3:isUnsupportChangeVolume()
	return self._isUnsupportChangeVolume == nil or self._isUnsupportChangeVolume
end

function FairyLandPuzzle3:delaySetFlag()
	if self:canUseSdk() then
		self._isUnsupportChangeVolume = SDKMgr.instance:isUnsupportChangeVolume()
	end
end

function FairyLandPuzzle3:onStart()
	local isPass = FairyLandModel.instance:isPassPuzzle(self.config.id)

	self._canDrag = not isPass

	gohelper.setActive(self._puzzleGO, not isPass)
	gohelper.setActive(self._shapeGO, not isPass)

	if not isPass then
		self:playAudio()
		self:startCheckTips()

		local characterElement = FairyLandModel.instance:getDialogElement(0)
		local npcElement = FairyLandModel.instance:getDialogElement(6)

		self.minPosX = -720
		self.maxPosX = self:getElementAnchorX(npcElement)

		TaskDispatcher.runDelay(self.delayRunTick, self, 0.1)
	end
end

function FairyLandPuzzle3:delayRunTick()
	TaskDispatcher.runRepeat(self._tick, self, 0)
end

function FairyLandPuzzle3:getElementAnchorX(element)
	if not element then
		return 0
	end

	local anchor = recthelper.rectToRelativeAnchorPos(element.goChess.transform.position, self._shapeTrs)

	return anchor.x
end

function FairyLandPuzzle3:addDrag(go)
	if self._drag then
		return
	end

	self._drag = SLFramework.UGUI.UIDragListener.Get(go)

	self._drag:AddDragBeginListener(self._onBeginDrag, self, go.transform)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onEndDrag, self, go.transform)
end

function FairyLandPuzzle3:_tick()
	if not self._canDrag then
		return
	end

	if self.inDrag then
		self:updateVolume()
	else
		self:updatePos()
	end

	self:checkFinish()
end

function FairyLandPuzzle3:updatePos()
	local volume = self:getVolume()

	if volume == self.volume then
		return
	end

	self.volume = volume

	local maxPosX = self.initPos.x
	local minPosX = self.minPosX
	local maxVolume = self.initVolume
	local minVolume = 0

	if volume > self.initVolume then
		maxPosX = self.maxPosX
		minPosX = self.initPos.x
		maxVolume = self.maxVolume
		minVolume = self.initVolume
	end

	local percent = (volume - minVolume) / (maxVolume - minVolume)
	local pos = percent * (maxPosX - minPosX) + minPosX

	self:_tweenToPosX(self._dragTrs, pos)
end

function FairyLandPuzzle3:checkFinish()
	local isFirstCheck = not self.notIsFirstCheck

	self.notIsFirstCheck = true

	local posX = recthelper.getAnchorX(self._dragTrs)
	local distance = math.abs(posX - self.minPosX)

	if distance < 1 and not self.inDrag then
		self:finished(isFirstCheck)

		return
	end

	local volume = self:getVolume()

	if volume == 0 and not self.inDrag then
		self:finished(isFirstCheck)
	end
end

function FairyLandPuzzle3:getVolume()
	if self:canUseSdk() then
		if self:isUnsupportChangeVolume() then
			return 0
		end

		return SDKMgr.instance:getSystemMediaVolume()
	else
		return SettingsModel.instance:getEffectValue()
	end
end

function FairyLandPuzzle3:setVolume(volume, force)
	if self.volume == volume and not force then
		return
	end

	if self:canUseSdk() then
		if not self:isUnsupportChangeVolume() then
			SDKMgr.instance:setSystemMediaVolume(volume)
		end
	else
		SettingsModel.instance:setEffectValue(volume)
	end

	self.volume = self:getVolume()
end

function FairyLandPuzzle3:resetVolume()
	if self:canUseSdk() then
		if not self:isUnsupportChangeVolume() then
			SDKMgr.instance:setSystemMediaVolume(self.initVolume)
		end
	else
		SettingsModel.instance:setEffectValue(self.initVolume)
		SettingsModel.instance:setMusicValue(self.initBGMVolume)
	end
end

function FairyLandPuzzle3:canUseSdk()
	if self._canUseSDK then
		return true
	end

	return false
end

function FairyLandPuzzle3:finished(isFirstCheck)
	self:stopCheckTips()

	self._canDrag = false

	gohelper.setActive(self._puzzleGO, false)
	gohelper.setActive(self._shapeGO, false)
	self:stopTask()
	self:killTweenId()
	self:stopAudio()

	if isFirstCheck then
		self:playSpecialTalk()
	else
		self:playSuccessTalk()
	end
end

function FairyLandPuzzle3:playSpecialTalk()
	TaskDispatcher.cancelTask(self.playTipsTalk, self)

	if not FairyLandModel.instance:isPassPuzzle(self.config.id) then
		FairyLandRpc.instance:sendResolvePuzzleRequest(self.config.id, self.config.answer)
	end

	self.playTalk(self, 22, self.openCompleteView, self)
end

function FairyLandPuzzle3:openCompleteView()
	self:resetVolume()
	FairyLandPuzzle3.super.openCompleteView(self)
end

function FairyLandPuzzle3:updateVolume()
	local posX = recthelper.getAnchorX(self._dragTrs)
	local maxPosX = self.initPos.x
	local minPosX = self.minPosX
	local maxVolume = self.initVolume
	local minVolume = 0

	if posX > self.initPos.x then
		maxPosX = self.maxPosX
		minPosX = self.initPos.x
		maxVolume = self.maxVolume
		minVolume = self.initVolume
	end

	local percent = (posX - minPosX) / (maxPosX - minPosX)
	local volume = math.floor(percent * (maxVolume - minVolume) + minVolume)

	self:setVolume(volume)

	if not self:canUseSdk() then
		maxVolume = self.initBGMVolume
		minVolume = 0

		if posX > self.initPos.x then
			maxVolume = self.maxVolume
			minVolume = self.initBGMVolume
		end

		volume = math.floor(percent * (maxVolume - minVolume) + minVolume)

		if volume ~= self.musicValue then
			self.musicValue = volume

			SettingsModel.instance:setMusicValue(self.musicValue)
		end
	end
end

function FairyLandPuzzle3:canDrag()
	return self._canDrag
end

function FairyLandPuzzle3:getDragPos(position)
	return (recthelper.screenPosToAnchorPos(position, self._shapeTrs))
end

function FairyLandPuzzle3:_onBeginDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	self:killTweenId()

	self.inDrag = true
end

function FairyLandPuzzle3:_onDrag(dragTransform, pointerEventData)
	if not self:canDrag() then
		self.inDrag = false

		return
	end

	local anchorPos = self:getDragPos(pointerEventData.position)

	self:_tweenToPosX(self._dragTrs, anchorPos.x)

	self.inDrag = true
end

function FairyLandPuzzle3:_onEndDrag(dragTransform, pointerEventData)
	self:startCheckTips()

	self.inDrag = false

	if not self:canDrag() then
		return
	end

	self:killTweenId()
end

function FairyLandPuzzle3:_onDragTweenEnd()
	return
end

function FairyLandPuzzle3:_tweenToPosX(transform, anchorPosX)
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end

	local movePosX = self:clampPosX(anchorPosX)
	local curAnchorX = recthelper.getAnchorX(transform)

	if math.abs(curAnchorX - movePosX) > 10 then
		self.tweenId = ZProj.TweenHelper.DOAnchorPosX(transform, movePosX, 0.1, nil, nil, nil, EaseType.Linear)
	else
		recthelper.setAnchorX(transform, movePosX)
	end
end

function FairyLandPuzzle3:clampPosX(anchorPosX)
	return Mathf.Clamp(anchorPosX, self.minPosX, self.maxPosX)
end

function FairyLandPuzzle3:killTweenId()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function FairyLandPuzzle3:playTipsAnim()
	gohelper.setActive(self.tipAnim, true)
	self.tipAnim:Stop()

	if not self.tipAnim.isActiveAndEnabled then
		return
	end

	self.tipAnim:Play("open", self.startCheckAnim, self)
end

function FairyLandPuzzle3:playAudio()
	if self.playingId then
		return
	end

	self.playingId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_soundwave_loop)
end

function FairyLandPuzzle3:stopAudio()
	if self.playingId then
		AudioMgr.instance:stopPlayingID(self.playingId)

		self.playingId = nil
	end
end

function FairyLandPuzzle3:stopTask()
	TaskDispatcher.cancelTask(self.delaySetFlag, self)
	TaskDispatcher.cancelTask(self.delayRunTick, self)
	TaskDispatcher.cancelTask(self._tick, self)
end

function FairyLandPuzzle3:onDestroyView()
	self:stopAudio()

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	self:resetVolume()
	self:stopTask()
	self:killTweenId()
	gohelper.setActive(self._shapeGO, false)
end

return FairyLandPuzzle3
