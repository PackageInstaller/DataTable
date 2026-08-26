-- chunkname: @modules/logic/versionactivity3_5/lamona/view/unit/LamonaGhostUnit.lua

module("modules.logic.versionactivity3_5.lamona.view.unit.LamonaGhostUnit", package.seeall)

local LamonaGhostUnit = class("LamonaGhostUnit", LamonaBaseUnit)

function LamonaGhostUnit:onInit()
	self._goCandleDown = gohelper.findChild(self.go, "Down/Candle")
	self._goCandleUp = gohelper.findChild(self.go, "Up/Candle")
	self._goCatchDown = gohelper.findChild(self.go, "Down/Catch")
	self._goCatchUp = gohelper.findChild(self.go, "Up/Catch")
	self._emojiItemDict = {}

	for _, emojiName in pairs(LamonaEnum.GhostEmoji) do
		local emojiItem = self:getUserDataTb_()
		local go = gohelper.findChild(self.go, string.format("emoji/%s", emojiName))

		if not gohelper.isNil(go) then
			emojiItem.go = go

			local animator = go:GetComponent(typeof(UnityEngine.Animator))

			if animator then
				emojiItem.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(go)
			end

			self._emojiItemDict[emojiName] = emojiItem
		end
	end

	self._animator = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.go)
end

function LamonaGhostUnit:onRefresh(isPlay)
	local mo = self:getMO()
	local isCaught = mo and mo:getIsCaught()

	gohelper.setActive(self._goCatchDown, isCaught)
	gohelper.setActive(self._goCatchUp, isCaught)

	local isTrap = false
	local hasFog = false
	local isMoving = false

	if mo and not isCaught then
		isTrap = mo:getHasTrap()
		hasFog = mo:getHasFog()
		isMoving = mo:getIsMoving()
	end

	gohelper.setActive(self._goCandleDown, isTrap)
	gohelper.setActive(self._goCandleUp, isTrap)
	self:setEmojiActive(LamonaEnum.GhostEmoji.Fog, hasFog, isPlay)
	self:setEmojiActive(LamonaEnum.GhostEmoji.Shocked, isMoving, isPlay)
	self:setEmojiActive(LamonaEnum.GhostEmoji.Sweat, isTrap or isCaught, isPlay)

	local cb, cbObj, cbParam
	local animName = LamonaEnum.GhostAnim.Idle
	local audioId

	if isCaught then
		cb = LamonaGameController.removeUnit
		cbObj = LamonaGameController.instance
		cbParam = mo:getUid()
		animName = LamonaEnum.GhostAnim.Catch
		audioId = AudioEnum3_5.Lamona.play_ui_lusongshi_lmn_shufu
	elseif isTrap then
		animName = LamonaEnum.GhostAnim.Trap
		audioId = AudioEnum3_5.Lamona.play_ui_lusongshi_lmn_clean
	end

	if isPlay then
		self:_playAnim(animName, audioId, cb, cbObj, cbParam)
	else
		self._animator.enabled = true

		self._animator:Play(animName, 0, 1)
	end
end

function LamonaGhostUnit:refreshPosition()
	local mo = self:getMO()

	if not mo then
		return
	end

	self:_killMoveTween()

	local gridX, gridY = mo:getGridXY()
	local pointX = 0
	local pointY = 0

	if not mo:getIsMoving() then
		local uid = mo:getUid()
		local standGhostUids = {}
		local allGhostUids = LamonaGameModel.instance:getUnitUidsInGrid(gridX, gridY, LamonaEnum.UnitType.Ghost)

		for _, ghostUid in ipairs(allGhostUids) do
			local ghostMO = LamonaGameModel.instance:getUnitByUid(ghostUid)

			if ghostMO and not ghostMO:getIsMoving() then
				standGhostUids[#standGhostUids + 1] = ghostUid
			end
		end

		local ghostCount = #standGhostUids
		local pointList = LamonaConfig.instance:getGridPointList(ghostCount)

		for i, ghostUid in ipairs(standGhostUids) do
			if ghostUid == uid then
				local point = pointList[i]

				pointX = point and point.x or 0
				pointY = point and point.y or 0

				gohelper.setSibling(self.go, i - 1)
			end
		end
	end

	local x, y = LamonaHelper.getGridPos(gridX, gridY)

	transformhelper.setLocalPos(self.trans, x + pointX, y + pointY, 0)
end

function LamonaGhostUnit:_playAnim(animName, audioId, cb, cbObj, cbParam)
	local mo = self:getMO()

	if not mo or string.nilorempty(animName) or self._playingAnimName == animName then
		return
	end

	local isCaught = mo:getIsCaught()

	if isCaught and animName ~= LamonaEnum.GhostAnim.Catch then
		return
	end

	self._playingAnimName = animName
	self._cb = cb
	self._cbObj = cbObj
	self._cbParam = cbParam

	self._animatorPlayer:Play(animName, self._playAnimFinished, self)

	if audioId then
		AudioMgr.instance:trigger(audioId)
	end
end

function LamonaGhostUnit:stopAllAnim()
	self._playingAnimName = nil

	if self._animatorPlayer then
		self._animatorPlayer:Stop()
	end

	if self._emojiItemDict then
		for _, emojiItem in pairs(self._emojiItemDict) do
			local animatorPlayer = emojiItem.animatorPlayer

			if animatorPlayer then
				animatorPlayer:Stop()
			end
		end
	end
end

function LamonaGhostUnit:_playAnimFinished()
	self._playingAnimName = nil

	local cb = self._cb
	local cbObj = self._cbObj
	local cbParam = self._cbParam

	self._cb = nil
	self._cbObj = nil
	self._cbParam = nil

	ArcadeGameHelper.callCallbackFunc(cb, cbObj, cbParam)
end

function LamonaGhostUnit:setEmojiActive(emojiName, isActive, isPlay)
	if self._emojiItemDict then
		local emojiItem = self._emojiItemDict[emojiName]
		local go = emojiItem and emojiItem.go

		isActive = not not isActive

		if gohelper.isNil(go) or go.activeSelf == isActive then
			return
		end

		local animTb = LamonaEnum.GhostEmojiAnim[emojiName]
		local animName = isActive and animTb and animTb.In or animTb and animTb.Out
		local animatorPlayer = emojiItem.animatorPlayer

		if isPlay and animatorPlayer and not string.nilorempty(animName) then
			if isActive then
				gohelper.setActive(go, true)
				animatorPlayer:Play(animName)
			else
				animatorPlayer:Play(animName, self._hideEmoji, {
					selfObj = self,
					emojiName = emojiName
				})
			end
		else
			gohelper.setActive(go, isActive)
		end
	end
end

function LamonaGhostUnit._hideEmoji(params)
	local selfObj = params and params.selfObj
	local emojiName = params and params.emojiName

	if selfObj then
		::label_8_0::

		local var_8_0 = selfObj._emojiItemDict

		if selfObj._emojiItemDict then
			local emojiItem = selfObj._emojiItemDict[emojiName]
			local go = emojiItem and emojiItem.go

			if gohelper.isNil(go) then
				return
			end

			gohelper.setActive(go, false)
		end
	end
end

return LamonaGhostUnit
