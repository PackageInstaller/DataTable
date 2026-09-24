-- chunkname: @modules/logic/matchgame/outside/herogroup/MatchGameHeroCardItem.lua

module("modules.logic.matchgame.outside.herogroup.MatchGameHeroCardItem", package.seeall)

local MatchGameHeroCardItem = class("MatchGameHeroCardItem", LuaCompBase)
local CardState = {
	Occupied = 2,
	Lock = 0,
	Empty = 1
}
local DRAG_SWAP_THRESHOLD = 30
local DragBlockKey = "MatchGameHeroCardItem_Drag"

function MatchGameHeroCardItem:init(go)
	self.viewGO = go
	self.transform = self.viewGO.transform
	self._goContainer = gohelper.findChild(self.viewGO, "container")
	self._goIcon = gohelper.findChild(self.viewGO, "container/go_Icon")
	self._cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goIcon, MatchGameHeroCardBaseItem)

	self._cardItem:setClickCallback(self._onClickCallback, self)

	self._defaultPos = self.transform.position
	self._defaultLocalX, self._defaultLocalY = recthelper.getAnchor(self.transform)
	self._goPos = self.transform.parent.gameObject
	self._animator = gohelper.onceAddComponent(self._goContainer, gohelper.Type_Animator)
	self._isFirstEnter = true
	self._isNeedPlaySwitch = false
end

function MatchGameHeroCardItem:addEventListeners()
	local clickArea = gohelper.findChild(self._goIcon, "clickarea")

	self._drag = UIDragListenerHelper.New()

	self._drag:create(clickArea)
	self._drag:registerCallback(self._drag.EventBegin, self._onDragBegin, self)
	self._drag:registerCallback(self._drag.EventDragging, self._onDragging, self)
	self._drag:registerCallback(self._drag.EventEnd, self._onDragEnd, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function MatchGameHeroCardItem:removeEventListeners()
	self._drag:release()
end

function MatchGameHeroCardItem:setPosIndex(posIndex)
	self._posIndex = posIndex

	self._cardItem:setPosIndex(posIndex)
end

function MatchGameHeroCardItem:getPosIndex()
	return self._posIndex
end

function MatchGameHeroCardItem:onUpdateMO(singleMo)
	self:updateData(singleMo)
	self:refreshUI()
end

function MatchGameHeroCardItem:updateData(singleMo)
	local preSingleId = self._singleId

	self:updateState(singleMo)

	self._singleMo = singleMo
	self._singleId = self._singleMo and self._singleMo.id

	if self._isFirstEnter then
		self._preSingleId = self._singleId or preSingleId
	end

	self._isNeedPlaySwitch = self._singleId ~= self._preSingleId
	self._isFirstEnter = false

	if self._singleMo then
		local heroMo = self._singleMo.heroMo

		self._heroMo = not self._isLock and heroMo
	end
end

function MatchGameHeroCardItem:updateState(singleMo)
	local curEpisodeId = MatchGameLevelModel.instance:getCurEpisodeId()
	local maxRoleNum = MatchGameConfig.instance:getEpisodeRoleNum(curEpisodeId)

	self._isLock = maxRoleNum and maxRoleNum < self._posIndex

	if self._isLock then
		self._state = CardState.Lock or CardState.Empty
	end

	if self._state == CardState.Empty and singleMo and singleMo.id ~= 0 then
		self._state = CardState.Occupied
	end
end

function MatchGameHeroCardItem:refreshUI()
	self._cardItem:onUpdateMO(self._heroMo)
	self._cardItem:setLockIconVisible(self._isLock)
	self._cardItem:setAddIconVisible(not self._isLock)
	self:resetPosition()
end

function MatchGameHeroCardItem:getSingleMo()
	return self._singleMo
end

function MatchGameHeroCardItem:setAnimatorEnabled(enabled)
	self._animator.enabled = enabled

	self._cardItem:setAnimatorEnabled(enabled)
end

function MatchGameHeroCardItem:setInteractionCallback(callback, callbackObj)
	self._interactionCallback = callback
	self._interactionCallbackObj = callbackObj
end

function MatchGameHeroCardItem:_fireInteraction(action, ...)
	if self._interactionCallback and self._interactionCallbackObj then
		self._interactionCallback(self._interactionCallbackObj, action, self._posIndex, ...)
	end
end

function MatchGameHeroCardItem:_onDragBegin()
	self._isDragging = false

	GameUtil.setActiveUIBlock(DragBlockKey, true, false)
end

function MatchGameHeroCardItem:_onDragging()
	local dragInfo = self._drag:dragInfo()

	if not dragInfo or not dragInfo.screenPos or self._state == CardState.Empty then
		return
	end

	if self._state == CardState.Lock then
		GameFacade.showToast(ToastEnum.IsRoleNumLock)

		return
	end

	if self._singleMo and self._singleMo:isTrial() then
		GameFacade.showToast(ToastEnum.TrialCantChangePos)

		return
	end

	if not self._isDragging then
		if dragInfo.screenPos_st then
			local dx = dragInfo.screenPos.x - (dragInfo.screenPos_st.x or 0)

			if dragInfo.screenPos_st then
				local dy = dragInfo.screenPos.y - (dragInfo.screenPos_st.y or 0)

				if math.sqrt(dx * dx + dy * dy) < DRAG_SWAP_THRESHOLD then
					return
				end

				self._isDragging = true

				gohelper.setAsLastSibling(self._goPos)
				self._fireInteraction(self, "drag", self, true)
			end
		end
	end

	self._fireInteraction(self, "drag", self, false)
end

function MatchGameHeroCardItem:_onDragEnd()
	GameUtil.setActiveUIBlock(DragBlockKey, false, true)

	if not self._isDragging then
		self._isDragging = false

		return
	end

	self._isDragging = false

	if self._drag then
		local dragInfo = self._drag:dragInfo()
		local screenPos = dragInfo and dragInfo.screenPos

		self:_fireInteraction("swap", screenPos)
	end
end

function MatchGameHeroCardItem:_onClickCallback()
	if self._state == CardState.Lock then
		GameFacade.showToast(ToastEnum.MatchGameHeroGroupPosLock)

		return
	end

	MatchGameHeroGroupController.instance:openEditView(self._posIndex)
end

function MatchGameHeroCardItem:_onCloseView(viewName)
	if viewName == ViewName.MatchGameHeroGroupView then
		self._animator:Play("close", 0, 0)
	elseif viewName == ViewName.MatchGameHeroGroupEditView and self._isNeedPlaySwitch then
		self._animator:Play("swicth", 0, 0)

		self._isNeedPlaySwitch = false
	end
end

function MatchGameHeroCardItem:resetPosition()
	recthelper.setAnchor(self.transform, self._defaultLocalX, self._defaultLocalY)
end

function MatchGameHeroCardItem:getDefaultCardPos()
	return self._defaultPos
end

function MatchGameHeroCardItem:onDestroy()
	GameUtil.setActiveUIBlock(DragBlockKey, false, true)
end

return MatchGameHeroCardItem
