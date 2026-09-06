-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/PlotMapItem.lua

module("logic.extensions.plotcopy.view.PlotMapItem", package.seeall)

local PlotMapItem = class("PlotMapItem")

function PlotMapItem:ctor()
	return
end

function PlotMapItem:init(go, data, view)
	self._data = data
	self._view = view
	self._goRect = go:GetComponent(goutil.Type_RectTransform)
	self._activeRoot = goutil.findChild(go, "activeRoot")
	self._canvasGroup = self._activeRoot:GetComponent("CanvasGroup")
	self._btnClick = Framework.ButtonAdapter.GetFrom(go, "activeRoot/btnClick")
	self._spriteChange = goutil.findChild(go, "activeRoot/btnClick"):GetComponent("UIImageSpriteChange")
	self._txtName = goutil.findChild(go, "activeRoot/txtName"):GetComponent(goutil.Type_UIText)
	self._locked = goutil.findChild(go, "activeRoot/btnClick/imgLocked")
	self._txtCount = goutil.findChild(go, "activeRoot/txtCount"):GetComponent(goutil.Type_UIText)
	self._imgPassAll = goutil.findChild(go, "activeRoot/imgPassAll")
	self._imgRedPoint = goutil.findChild(go, "activeRoot/imgRedPoint")
	self._effectGo = goutil.findChild(go, "activeRoot/btnClick/effect")
	self._imgPerfect = goutil.findChild(go, "activeRoot/imgPerfect")

	self._btnClick:AddClickListener(self._onClick, self)
	self._activeRoot:SetActive(true)

	self._canvasGroup.alpha = 0
	self._curRootActive = false

	self._locked:SetActive(data.isLock)

	self._txtName.text = data.cfg.chapterName

	local isChapterPass = PlotCopyModel.instance:isChapterPassed(data.cfg.chapterId)

	if isChapterPass then
		self._spriteChange:ChangeStateNow(2)
		self._txtCount.gameObject:SetActive(false)
		self._imgPassAll:SetActive(true)
		self._effectGo:SetActive(false)
	else
		self._spriteChange:ChangeStateNow(0)
		self._txtCount.gameObject:SetActive(true)
		self._imgPassAll:SetActive(false)
		self._effectGo:SetActive(true)

		local curCount, totalCount = PlotCopyModel.instance:getStageFinishCountExceptPurePlot(data.cfg.chapterId)

		self._txtCount.text = curCount .. "/" .. totalCount
	end

	local isPerfectPass = PlotCopyModel.instance:isChapterPerfectPassed(data.cfg.chapterId)

	goutil.setActive(self._imgPerfect, isPerfectPass)

	local isShowRed = PlotCopyModel.instance:isChapterRewardCanGet(data.cfg.chapterId)

	self._imgRedPoint:SetActive(isShowRed)
end

function PlotMapItem:reset()
	self._data = nil
	self._view = nil
	self._go = nil

	self._btnClick:RemoveClickListener()
	self:_removeEffect()
end

function PlotMapItem:getIndex()
	return self._data.index
end

function PlotMapItem:setSelect(isSelect, isEmmediately)
	if self._curRootActive ~= isSelect then
		self._curRootActive = isSelect

		if isSelect then
			self._canvasGroup.alpha = 0

			self._canvasGroup:DOFade(1, 0.5)
			self:_loadEffect()
		else
			self._canvasGroup.alpha = 1

			self._canvasGroup:DOFade(0, 0.5)
			self:_removeEffect()
		end
	end
end

function PlotMapItem:hideItem()
	self._curRootActive = false

	self._canvasGroup:DOFade(0, 0.5)
end

function PlotMapItem:focusItem(bigMapRect, moveableMapRect, targetPointRect, isFirst, isSwitch, isSame)
	if isSame then
		self:_onClick()

		return
	end

	local targetPos = bigMapRect.transform:InverseTransformPoint(targetPointRect.transform.position)
	local startPos = bigMapRect.transform:InverseTransformPoint(self._goRect.transform.position)
	local moveX = targetPos.x - startPos.x
	local moveY = targetPos.y - startPos.y

	if moveableMapRect.anchoredPosition.x + moveX < bigMapRect.rect.width - moveableMapRect.rect.width then
		moveX = bigMapRect.rect.width - moveableMapRect.rect.width - moveableMapRect.anchoredPosition.x
	end

	if moveableMapRect.anchoredPosition.x + moveX > 0 then
		moveX = -1 * moveableMapRect.anchoredPosition.x
	end

	if moveableMapRect.anchoredPosition.y + moveY < bigMapRect.rect.height - moveableMapRect.rect.height then
		moveY = bigMapRect.rect.height - moveableMapRect.rect.height - moveableMapRect.anchoredPosition.y
	end

	if moveableMapRect.anchoredPosition.y + moveY > 0 then
		moveY = -moveableMapRect.anchoredPosition.y
	end

	local endPos = Vector2.New()

	endPos.x = moveableMapRect.anchoredPosition.x + moveX
	endPos.y = moveableMapRect.anchoredPosition.y + moveY

	local chapterId = self._data.cfg.chapterId
	local areaId = PlotCopyModel.instance:getAreaIdBy(chapterId)
	local isMark = PlotCopyModel.instance:getAreaUnlockState(areaId)

	if GuideController.instance:checkBranchIsGuiding(GuideConst.BRANCH_FIRST_OPEN_FB_36) or GuideController.instance:checkBranchIsGuiding(GuideConst.BRANCH_TASK_START_51) or isFirst then
		GameUtil.setAnchoredPos(moveableMapRect, endPos.x, endPos.y)

		if not isMark then
			self:_sendEvent(areaId)
		end
	else
		moveableMapRect:DOAnchorPos(endPos, 0.5):OnComplete(function()
			if not isSwitch then
				if isMark then
					self:_onClick()
					GlobalDispatcher:dispatch(GlobalNotify.CopyCloseMask)
				else
					self:_sendEvent(areaId)
				end
			end
		end)
	end
end

function PlotMapItem:_sendEvent(areaId)
	local effectTime = 2

	GlobalDispatcher:dispatch(GlobalNotify.PlayAreaUnlockEffect, areaId, effectTime)
	TweenUtil.DoDelay(effectTime, function()
		GlobalDispatcher:dispatch(GlobalNotify.CopyCloseMask)
	end)
end

function PlotMapItem:_onClick()
	if self._data.isLock then
		PlotCopyModel.instance:showLockTips(self._data.cfg)

		return
	else
		if not self._data.isSelect then
			return
		end

		PlotCopyModel.instance:setRecentOpenChapter(self._data.cfg.chapterType, self._data.index)
		PlotCopyController.instance:openChapterView(self._data.cfg.chapterId)
	end
end

function PlotMapItem:_loadEffect()
	if not self._effect then
		self._effect = UIEffectManager.instance:playEffect(self._view, "fx_ui_fuben/fx_ui_fuben_jiaozhan.prefab", self._effectGo.transform, 0, 0, true, false)

		self._effect:setParent(self._effectGo.transform)
		self._effect:setScale(1)
	end
end

function PlotMapItem:_removeEffect()
	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end
end

return PlotMapItem
