-- chunkname: @modules/logic/character/view/CharacterBackpackCardListItem.lua

module("modules.logic.character.view.CharacterBackpackCardListItem", package.seeall)

local CharacterBackpackCardListItem = class("CharacterBackpackCardListItem", ListScrollCell)

CharacterBackpackCardListItem.PressColor = GameUtil.parseColor("#C8C8C8")

function CharacterBackpackCardListItem:init(go)
	self._heroGO = go
	self._heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._heroGO, CommonHeroItem)

	self._heroItem:addClickListener(self._onItemClick, self)
	self._heroItem:addClickDownListener(self._onItemClickDown, self)
	self._heroItem:addClickUpListener(self._onItemClickUp, self)
	self:_initObj()
end

function CharacterBackpackCardListItem:_initObj()
	self._animator = self._heroGO:GetComponent(typeof(UnityEngine.Animator))
end

function CharacterBackpackCardListItem:addEventListeners()
	RedDotController.instance:registerCallback(RedDotEvent.RefreshClientCharacterDot, self._refreshRedDot, self)
	PlayerController.instance:registerCallback(PlayerEvent.UpdateSimpleProperty, self._refreshRedDot, self)
end

function CharacterBackpackCardListItem:removeEventListeners()
	RedDotController.instance:unregisterCallback(RedDotEvent.RefreshClientCharacterDot, self._refreshRedDot, self)
	PlayerController.instance:unregisterCallback(PlayerEvent.UpdateSimpleProperty, self._refreshRedDot, self)
end

function CharacterBackpackCardListItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)
	self._heroItem:setStyle_CharacterBackpack()
	self:_refreshRedDot()

	if self._heroItemContainer then
		self._heroItemContainer.spines = nil
	end
end

function CharacterBackpackCardListItem:_refreshRedDot()
	local reddotShow = CharacterModel.instance:isHeroCouldExskillUp(self._mo.heroId) or CharacterModel.instance:hasCultureRewardGet(self._mo.heroId) or CharacterModel.instance:hasItemRewardGet(self._mo.heroId) or self:_isShowDestinyReddot() or self._mo.extraMo:showReddot() or self:_isShowNuodikaReddot()

	if reddotShow then
		self._heroItem:setRedDotShow(true)
	else
		self._heroItem:setRedDotShow(false)
	end
end

function CharacterBackpackCardListItem:_onrefreshItem()
	return
end

function CharacterBackpackCardListItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	CharacterController.instance:openCharacterView(self._mo)

	if self:_isShowDestinyReddot() then
		HeroRpc.instance:setHeroRedDotReadRequest(self._mo.heroId, 1)
	end
end

function CharacterBackpackCardListItem:_onItemClickDown()
	self:_setHeroItemPressState(true)
end

function CharacterBackpackCardListItem:_onItemClickUp()
	self:_setHeroItemPressState(false)
end

function CharacterBackpackCardListItem:_setHeroItemPressState(press)
	if not self._heroItemContainer then
		self._heroItemContainer = self:getUserDataTb_()

		local images = self._heroGO:GetComponentsInChildren(gohelper.Type_Image, true)

		self._heroItemContainer.images = images

		local tmps = self._heroGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		self._heroItemContainer.tmps = tmps
		self._heroItemContainer.compColor = {}

		local iter = images:GetEnumerator()

		while iter:MoveNext() do
			self._heroItemContainer.compColor[iter.Current] = iter.Current.color
		end

		iter = tmps:GetEnumerator()

		while iter:MoveNext() do
			self._heroItemContainer.compColor[iter.Current] = iter.Current.color
		end
	end

	if not self._heroItemContainer.spines then
		local spines = self._heroGO:GetComponentsInChildren(GuiSpine.TypeSkeletonGraphic, true)

		self._heroItemContainer.spines = spines

		local iter = spines:GetEnumerator()

		while iter:MoveNext() do
			self._heroItemContainer.compColor[iter.Current] = iter.Current.color
		end
	end

	if self._heroItemContainer then
		self:_setUIPressState(self._heroItemContainer.images, press, self._heroItemContainer.compColor)
		self:_setUIPressState(self._heroItemContainer.tmps, press, self._heroItemContainer.compColor)
		self:_setUIPressState(self._heroItemContainer.spines, press, self._heroItemContainer.compColor)
	end
end

function CharacterBackpackCardListItem:_setUIPressState(graphicCompArray, isPress, oriColorMap)
	if not graphicCompArray then
		return
	end

	local iter = graphicCompArray:GetEnumerator()

	while iter:MoveNext() do
		local color

		if isPress then
			color = oriColorMap and oriColorMap[iter.Current] * 0.7 or CharacterBackpackCardListItem.PressColor
			color.a = iter.Current.color.a
		else
			color = oriColorMap and oriColorMap[iter.Current] or Color.white
		end

		iter.Current.color = color
	end
end

function CharacterBackpackCardListItem:onDestroy()
	if self._heroItem then
		self._heroItem:onDestroy()

		self._heroItem = nil
	end
end

function CharacterBackpackCardListItem:getAnimator()
	return self._animator
end

function CharacterBackpackCardListItem:_isShowDestinyReddot()
	if self._mo and self._mo.destinyStoneMo then
		local isOpenDestiny = self._mo:isCanOpenDestinySystem()

		return isOpenDestiny and self._mo.destinyStoneMo:getRedDot() < 1
	end
end

function CharacterBackpackCardListItem:_isShowNuodikaReddot()
	local isOverRank, isCanShow = CharacterModel.instance:isNeedShowNewSkillReddot(self._mo)

	return isOverRank and isCanShow
end

return CharacterBackpackCardListItem
