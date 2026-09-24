-- chunkname: @modules/logic/character/view/recommed/CharacterRecommedReplaceHeroIcon.lua

module("modules.logic.character.view.recommed.CharacterRecommedReplaceHeroIcon", package.seeall)

local CharacterRecommedReplaceHeroIcon = class("CharacterRecommedReplaceHeroIcon", CharacterRecommedHeroIcon)

CharacterRecommedReplaceHeroIcon.anchorMin = Vector2(0, 0.5)
CharacterRecommedReplaceHeroIcon.anchorMax = Vector2(0, 0.5)

function CharacterRecommedReplaceHeroIcon:onInitView()
	CharacterRecommedReplaceHeroIcon.super.onInitView(self)

	self._btnreplace = gohelper.findChildButtonWithAudio(self.viewGO, "#go_replace/#btn_replace")
	self.transform.anchorMin = CharacterRecommedReplaceHeroIcon.anchorMin
	self.transform.anchorMax = CharacterRecommedReplaceHeroIcon.anchorMax
	self._longclickItem = SLFramework.UGUI.UILongPressListener.Get(self._btnclick.gameObject)

	self._longclickItem:SetLongPressTime({
		0.5,
		99999
	})

	self._dragListener = SLFramework.UGUI.UIDragListener.Get(self._btnclick.gameObject)
	self._imagedestinybg = gohelper.findChildImage(self.viewGO, "#go_destiny/bg")
	self._isNotDrag = true
	self._isScroll = false

	self:initScrollInfo()
end

function CharacterRecommedReplaceHeroIcon:addEventListeners()
	CharacterRecommedReplaceHeroIcon.super.addEventListeners(self)
	self._btnreplace:AddClickListener(self._btnreplaceOnClick, self)
	self._longclickItem:AddLongPressListener(self._onLongClickItem, self)
	self._dragListener:AddDragBeginListener(self._onDragBegin, self)
	self._dragListener:AddDragListener(self._onDrag, self)
	self._dragListener:AddDragEndListener(self._onDragEnd, self)
	CharacterRecommedController.instance:dispatchEvent(CharacterRecommedEvent.RegisterHeroIcon, self)
end

function CharacterRecommedReplaceHeroIcon:removeEventListeners()
	CharacterRecommedReplaceHeroIcon.super.removeEventListeners(self)
	self._btnreplace:RemoveClickListener()
	self._longclickItem:RemoveLongPressListener()
	self._dragListener:RemoveDragBeginListener()
	self._dragListener:RemoveDragListener()
	self._dragListener:RemoveDragEndListener()
end

function CharacterRecommedReplaceHeroIcon:_btnclickOnClick()
	if self._scrollDragComp and self._scrollDragComp:isDragging() then
		return
	end

	CharacterRecommedReplaceHeroIcon.super._btnclickOnClick(self)
end

function CharacterRecommedReplaceHeroIcon:_btnreplaceOnClick()
	CharacterRecommedModel.instance:swapTeamHero(self._teamId, self._teamIndex, 1, self._posIndex)
end

function CharacterRecommedReplaceHeroIcon:_btndestinyOnClick()
	if self._heroMo then
		CharacterDestinyController.instance:openCharacterDestinySlotView(self._heroMo)

		return
	end

	if self._clickCB and self._clickCBobj then
		self._clickCB(self._clickCBobj)
	end
end

function CharacterRecommedReplaceHeroIcon:initScrollInfo()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.CharacterRecommedView)
	local groupView = viewContainer and viewContainer:getGroupView()

	if not groupView then
		return
	end

	self._goScrollList = groupView:getScrollList()
	self._scrollDragComp = groupView:getScrollDragComp()
end

function CharacterRecommedReplaceHeroIcon:onUpdateMO(mo, destinyId, teamInfo, posIndex)
	CharacterRecommedReplaceHeroIcon.super.onUpdateMO(self, mo)

	self._destinyId = destinyId
	self._teamInfo = teamInfo
	self._teamId = teamInfo:getTeamId()
	self._teamIndex = teamInfo:getTeamIndex()
	self._posIndex = posIndex
	self._heroMo = self._mo:getHeroMo()
	self._destinyStoneMo = self._heroMo and self._heroMo.destinyStoneMo
	self._isUnlockSlot = self._destinyStoneMo and self._destinyStoneMo:isUnlockSlot()

	gohelper.setActive(self._goreplace, mo ~= nil and self._teamIndex > 1)
	self:setVisible(true)
	self:refreshDestiny()
	self:updatePosition()
end

function CharacterRecommedReplaceHeroIcon:refreshDestiny()
	local consumeCo = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(self._destinyId)

	gohelper.setActive(self._godestiny, consumeCo ~= nil)

	if consumeCo ~= nil then
		self._simagedestiny:LoadImage(ResUrl.getDestinyIcon(consumeCo.icon))
		ZProj.UGUIHelper.SetGrayscale(self._imagedestinybg.gameObject, not self._isUnlockSlot)
		ZProj.UGUIHelper.SetGrayscale(self._simagedestiny.gameObject, not self._isUnlockSlot)
	end
end

function CharacterRecommedReplaceHeroIcon:updatePosition()
	local posX = (self._posIndex - 1) * CharacterRecommedEnum.HeroIconSpace + CharacterRecommedEnum.HeroIconStart

	recthelper.setAnchorX(self.transform, posX, 0)
end

function CharacterRecommedReplaceHeroIcon:getData()
	return self._teamId, self._teamIndex, self._posIndex, self._mo
end

function CharacterRecommedReplaceHeroIcon:_onLongClickItem()
	if self._isScroll then
		return
	end

	self._isNotDrag = false
end

function CharacterRecommedReplaceHeroIcon:_onDragBegin(param, pointerEventData)
	if self._isNotDrag then
		ZProj.UGUIHelper.PassEvent(self._goScrollList, pointerEventData, 4)

		return
	end

	CharacterRecommedController.instance:dispatchEvent(CharacterRecommedEvent.OnBeginDragHeroIcon, self)
end

function CharacterRecommedReplaceHeroIcon:_onDrag(param, pointerEventData)
	if self._isNotDrag then
		self._isScroll = true

		ZProj.UGUIHelper.PassEvent(self._goScrollList, pointerEventData, 5)

		return
	end

	CharacterRecommedController.instance:dispatchEvent(CharacterRecommedEvent.OnDragHeroIcon, self)
end

function CharacterRecommedReplaceHeroIcon:_onDragEnd(param, pointerEventData)
	if self._isNotDrag then
		self._isScroll = false

		ZProj.UGUIHelper.PassEvent(self._goScrollList, pointerEventData, 6)

		return
	end

	self._isNotDrag = true

	CharacterRecommedController.instance:dispatchEvent(CharacterRecommedEvent.OnEndDragHeroIcon, self)
end

function CharacterRecommedReplaceHeroIcon:setVisible(isVisible)
	gohelper.setActive(self.viewGO, isVisible)
end

return CharacterRecommedReplaceHeroIcon
