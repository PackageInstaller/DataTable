-- chunkname: @modules/common/others/LuaListScrollViewWithAnimator.lua

module("modules.common.others.LuaListScrollViewWithAnimator", package.seeall)

local LuaListScrollViewWithAnimator = class("LuaListScrollViewWithAnimator", LuaListScrollView)

function LuaListScrollViewWithAnimator:ctor(scrollModel, listScrollParam, animationDelayTimes)
	LuaListScrollViewWithAnimator.super.ctor(self, scrollModel, listScrollParam)

	self._animationStartTime = nil
	self._animationDelayTimes = animationDelayTimes
	self._firstUpdate = true
	self.dontPlayCloseAnimation = false
	self.indexOffset = 0
end

function LuaListScrollViewWithAnimator:ResetFirstUpdate()
	self._firstUpdate = true
end

function LuaListScrollViewWithAnimator:_getAnimationTime(index)
	if not self._animationStartTime then
		return nil
	end

	index = index - self.indexOffset

	if index < 1 then
		return nil
	end

	if not self._animationDelayTimes or not self._animationDelayTimes[index] then
		return nil
	end

	return self._animationStartTime + self._animationDelayTimes[index]
end

function LuaListScrollViewWithAnimator:playOpenAnimation()
	self._animationStartTime = Time.time

	self:onModelUpdate()
end

function LuaListScrollViewWithAnimator:changeDelayTime(changeTime)
	if changeTime and self._animationDelayTimes then
		for i, delayTime in ipairs(self._animationDelayTimes) do
			self._animationDelayTimes[i] = delayTime + changeTime
		end
	end
end

function LuaListScrollViewWithAnimator:onOpen()
	LuaListScrollViewWithAnimator.super.onOpen(self)

	if self.viewContainer.notPlayAnimation or self._param and self._param.notPlayAnimation then
		return
	end

	self:playOpenAnimation()
end

function LuaListScrollViewWithAnimator:onClose()
	LuaListScrollViewWithAnimator.super.onClose(self)

	if self._moveTweenId then
		ZProj.TweenHelper.KillById(self._moveTweenId)

		self._moveTweenId = nil
	end

	if self.dontPlayCloseAnimation then
		return
	end

	for cellComp, _ in pairs(self._cellCompDict) do
		LuaListScrollViewWithAnimator._playCloseAnimation(cellComp)
	end
end

function LuaListScrollViewWithAnimator:_onUpdateCell(cellGO, index)
	if self._firstUpdate then
		self._firstUpdate = false
		self._animationStartTime = Time.time
	end

	LuaListScrollViewWithAnimator.super._onUpdateCell(self, cellGO, index)

	local prefabInstGO = gohelper.findChild(cellGO, LuaListScrollView.PrefabInstName)

	if not prefabInstGO then
		return
	end

	local cellComp = MonoHelper.getLuaComFromGo(prefabInstGO, self._param.cellClass)

	LuaListScrollViewWithAnimator._refreshOpenAnimation(cellComp)
end

local idleHash = UnityEngine.Animator.StringToHash(UIAnimationName.Idle)

function LuaListScrollViewWithAnimator._refreshOpenAnimation(cellComp)
	if not cellComp then
		return
	end

	if not cellComp.getAnimator then
		return
	end

	local animator = cellComp:getAnimator()

	if not animator or not animator.gameObject.activeInHierarchy then
		return
	end

	local openAnimTime = cellComp._view:_getAnimationTime(cellComp._index)

	if not openAnimTime then
		animator.speed = 0

		animator:Play(UIAnimationName.Open, 0, 1)
		animator:Update(0)
	else
		local openAnimLen = LuaListScrollViewWithAnimator._getOpenAnimLen(cellComp)

		if not openAnimLen or openAnimLen >= Time.time - openAnimTime or not LuaListScrollViewWithAnimator._haveIdleAnim(cellComp) then
			animator.speed = 0

			animator:Play(UIAnimationName.Open, 0, 0)
			animator:Update(0)
		else
			animator:Play(idleHash, 0, 0)
		end

		LuaListScrollViewWithAnimator._delayPlayOpenAnimation(cellComp)
	end
end

function LuaListScrollViewWithAnimator._getOpenAnimLen(cellComp)
	if not cellComp then
		return false
	end

	if cellComp.__openAnimLen ~= nil then
		return cellComp.__openAnimLen
	end

	if not cellComp.getAnimator then
		return false
	end

	local animator = cellComp:getAnimator()
	local clips = animator.runtimeAnimatorController.animationClips

	for i = 0, clips.Length - 1 do
		local clip = clips[i]

		if clip.name:find(UIAnimationName.Open) then
			cellComp.__openAnimLen = math.abs(clip.length)

			break
		end
	end

	cellComp.__openAnimLen = cellComp.__openAnimLen or false

	return cellComp.__openAnimLen
end

function LuaListScrollViewWithAnimator._haveIdleAnim(cellComp)
	if not cellComp then
		return false
	end

	if not cellComp.getAnimator then
		return false
	end

	local animator = cellComp:getAnimator()

	return animator:HasState(0, idleHash)
end

function LuaListScrollViewWithAnimator._delayPlayOpenAnimation(cellComp)
	if not cellComp then
		return
	end

	if not cellComp.getAnimator then
		return
	end

	local animator = cellComp:getAnimator()

	if not animator or not animator.gameObject.activeInHierarchy then
		return
	end

	if not cellComp._view:_getAnimationTime(cellComp._index) then
		return
	end

	animator.speed = 1

	local openAnimTime = cellComp._view:_getAnimationTime(cellComp._index)
	local openAnimLen = LuaListScrollViewWithAnimator._getOpenAnimLen(cellComp)

	if openAnimLen and openAnimLen < Time.time - openAnimTime and LuaListScrollViewWithAnimator._haveIdleAnim(cellComp) then
		animator:Play(UIAnimationName.Idle, 0, 0)

		return
	end

	animator:Play(UIAnimationName.Open, 0, 0)
	animator:Update(0)

	local currentAnimatorStateInfo = animator:GetCurrentAnimatorStateInfo(0)
	local length = currentAnimatorStateInfo.length

	if length <= 0 then
		length = 1
	end

	animator:Play(UIAnimationName.Open, 0, (Time.time - openAnimTime) / length)
	animator:Update(0)
end

function LuaListScrollViewWithAnimator._playCloseAnimation(cellComp)
	if not cellComp then
		return
	end

	if not cellComp.getAnimator then
		return
	end

	local animator = cellComp:getAnimator()

	if animator and animator.gameObject.activeInHierarchy then
		animator.speed = 1

		animator:Play(UIAnimationName.Close, 0, 0)
	end
end

function LuaListScrollViewWithAnimator:moveToByCheckFunc(func, time, callback, callbackObj)
	if not func then
		return
	end

	local list = self._model:getList()

	if not list then
		return
	end

	local moveIndex

	for i, v in ipairs(list) do
		if func(v) then
			moveIndex = i

			break
		end
	end

	if not moveIndex then
		return
	end

	self:moveToByIndex(moveIndex, time, callback, callbackObj)
end

function LuaListScrollViewWithAnimator:moveToByIndex(moveIndex, time, callback, callbackObj)
	local scrollRect = self._csListScroll.gameObject:GetComponent(gohelper.Type_ScrollRect)
	local content = scrollRect.content
	local index = math.ceil(moveIndex / self._param.lineCount)
	local isV = self._param.scrollDir == ScrollEnum.ScrollDirV
	local startSpace = self._param.startSpace

	if isV then
		if not self._param.cellSpaceV then
			local space = self._param.cellSpaceH

			if isV then
				if not self._param.cellHeight then
					local width = self._param.cellWidth
					local pos = startSpace + (index - 1) * (space + width)
					local moveLimt = 0

					if isV then
						local contentHeight = recthelper.getHeight(content)
						local scrollHeight = recthelper.getHeight(scrollRect.transform)
						local heightOffset = contentHeight - scrollHeight

						moveLimt = math.max(0, heightOffset)
						pos = math.min(moveLimt, pos)
					else
						local contentWidth = recthelper.getWidth(content)
						local scrollWidth = recthelper.getWidth(scrollRect.transform)
						local widthOffset = contentWidth - scrollWidth

						moveLimt = math.max(0, widthOffset)
						pos = math.min(moveLimt, pos)
						pos = -pos
					end

					if self._moveTweenId then
						ZProj.TweenHelper.KillById(self._moveTweenId)

						self._moveTweenId = nil
					end

					if time and time > 0 then
						self._moveTweenId = isV and ZProj.TweenHelper.DOAnchorPosY(content, pos, time, callback, callbackObj) or ZProj.TweenHelper.DOAnchorPosX(content, pos, time, callback, callbackObj)
					else
						if isV then
							recthelper.setAnchorY(content, pos)
						else
							recthelper.setAnchorX(content, pos)
						end

						if callback then
							callback(callbackObj)
						end
					end
				end
			end
		end
	end
end

return LuaListScrollViewWithAnimator
