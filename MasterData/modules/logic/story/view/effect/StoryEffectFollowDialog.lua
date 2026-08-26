-- chunkname: @modules/logic/story/view/effect/StoryEffectFollowDialog.lua

module("modules.logic.story.view.effect.StoryEffectFollowDialog", package.seeall)

local StoryEffectFollowDialog = class("StoryEffectFollowDialog")

function StoryEffectFollowDialog:ctor(owner)
	self._owner = owner
	self._curLineNumber = nil
	self._tweenId = nil
end

function StoryEffectFollowDialog:start()
	self._owner:setEffectVisible(false)
	self._owner:_addLateUpdateHandle(self._onLateUpdate, self)
end

function StoryEffectFollowDialog:stop()
	self._owner:_removeLateUpdateHandle(self._onLateUpdate, self)
end

function StoryEffectFollowDialog:_onLateUpdate(deltaTime)
	self:_tick(deltaTime)
end

function StoryEffectFollowDialog:_tick(deltaTime)
	local stepId = StoryModel.instance:getCurStepId()
	local stepCo = StoryStepModel.instance:getStepListById(stepId)

	if stepCo.conversation.type ~= StoryEnum.ConversationType.ScreenDialog then
		return
	end

	local txt = StoryViewMgr.instance:getStoryScreenTxtComp()

	if not txt then
		return
	end

	local tmpTxt = txt.gameObject:GetComponent(gohelper.Type_TextMesh)

	if gohelper.isNil(tmpTxt) then
		return
	end

	if not txt.maxVisibleCharacters then
		local maxVis = 0

		if maxVis <= 0 then
			return
		end

		txt:ForceMeshUpdate()

		local info = txt.textInfo

		if not info or info.characterCount <= 0 then
			return
		end

		local ci, idx = StoryTool.findPrevVisibleChar(info, maxVis - 1)

		if not ci then
			return
		end

		if self._curLineNumber == ci.lineNumber then
			if not self._tweenId then
				local ciPos = txt.transform:TransformPoint(Vector3(ci.bottomRight.x, ci.baseLine, 0))
				local x, y = recthelper.rectToRelativeAnchorPos2(ciPos, self._owner.viewGO.transform)

				recthelper.setAnchor(self._owner._uieffectTransform, x, y)
			end

			return
		end

		self._curLineNumber = ci.lineNumber

		local li = info.lineInfo[ci.lineNumber]

		if not li then
			return
		end

		local firstIdx = li.firstVisibleCharacterIndex
		local lastIdx = li.lastVisibleCharacterIndex
		local firstCi = info.characterInfo[firstIdx]
		local lastCi = info.characterInfo[lastIdx]

		if not firstCi or not lastCi then
			return
		end

		self._owner:setEffectVisible(true, true)

		local worldStart = txt.transform:TransformPoint(Vector3(firstCi.bottomLeft.x, firstCi.baseLine, 0))
		local worldEnd = txt.transform:TransformPoint(Vector3(lastCi.bottomRight.x, lastCi.baseLine, 0))
		local sx, sy = recthelper.rectToRelativeAnchorPos2(worldStart, self._owner.viewGO.transform)
		local ex, ey = recthelper.rectToRelativeAnchorPos2(worldEnd, self._owner.viewGO.transform)
		local totalTime = stepCo.conversation.showTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
		local totalChars = info.characterCount
		local lineChars = lastIdx - firstIdx + 1
		local duration = totalTime * lineChars / math.max(totalChars, 1)

		recthelper.setAnchor(self._owner._uieffectTransform, sx, sy)
		self:killTween()

		self._tweenId = ZProj.TweenHelper.DOAnchorPos(self._owner._uieffectTransform, ex, ey, duration, self._onTweenFinished, self, nil, EaseType.Linear)
	end
end

function StoryEffectFollowDialog:killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function StoryEffectFollowDialog:_onTweenFinished()
	self:killTween()
	self._owner:setEffectVisible(false, true)
end

function StoryEffectFollowDialog:destroy()
	self:stop()
	self:killTween()

	self._owner = nil
end

return StoryEffectFollowDialog
