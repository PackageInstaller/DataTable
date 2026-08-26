-- chunkname: @modules/logic/character/view/CharacterLevelItem.lua

module("modules.logic.character.view.CharacterLevelItem", package.seeall)

local CharacterLevelItem = class("CharacterLevelItem", ListScrollCellExtend)
local MAX_SCALE = 1
local MIN_SCALE = 0.75
local MAX_ALPHA = 1
local MIN_ALPHA = 0.5

function CharacterLevelItem:onInitView()
	self._click = gohelper.getClickWithDefaultAudio(self.viewGO)
	self._gocurlv = gohelper.findChild(self.viewGO, "#go_curLv")
	self._transcurlv = self._gocurlv.transform
	self._txtcurlv = gohelper.findChildText(self.viewGO, "#go_curLv/#txt_curLvNum")
	self._txtlvnum = gohelper.findChildText(self.viewGO, "#txt_LvNum")
	self._translvnum = self._txtlvnum.transform
	self._txtefflvnum = gohelper.findChildText(self.viewGO, "#txt_LvNum/#txt_leveleffect")
	self._goline = gohelper.findChild(self.viewGO, "#go_line")
	self._gomax = gohelper.findChild(self.viewGO, "#go_Max")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterLevelItem:addEvents()
	self._click:AddClickListener(self.onClick, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onItemChanged, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.characterLevelItemPlayEff, self._onPlayLevelUpEff, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.levelUpChangePreviewLevel, self._onChangePreviewLevel, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.levelScrollChange, self._onLevelScrollChange, self)
end

function CharacterLevelItem:removeEvents()
	self._click:RemoveClickListener()
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onItemChanged, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.characterLevelItemPlayEff, self._onPlayLevelUpEff, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.levelUpChangePreviewLevel, self._onChangePreviewLevel, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.levelScrollChange, self._onLevelScrollChange, self)
end

function CharacterLevelItem:onClick()
	if not self._mo then
		return
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.levelUpClickLevel, self._mo.level)
end

function CharacterLevelItem:_onItemChanged()
	if not self._view then
		return
	end

	local container = self._view.viewContainer
	local waitHeroLevelUpRefresh = container and container:getWaitHeroLevelUpRefresh()

	if waitHeroLevelUpRefresh then
		return
	end

	self:refresh()
end

function CharacterLevelItem:_onPlayLevelUpEff(level)
	if self._mo then
		local heroId = self._mo.heroId

		if heroId then
			::label_6_0::

			local heroMO = HeroModel.instance:getByHeroId(heroId)

			if not heroMO then
				return
			end

			if self._mo.level == level then
				self._animator:Play("click", 0, 0)
			end
		end
	end
end

function CharacterLevelItem:_onChangePreviewLevel(previewLevel)
	if not self._view then
		return
	end

	local container = self._view.viewContainer
	local waitHeroLevelUpRefresh = container and container:getWaitHeroLevelUpRefresh()

	if waitHeroLevelUpRefresh then
		return
	end

	self:refreshCurLevelMark()
end

function CharacterLevelItem:_onLevelScrollChange(contentOffset)
	contentOffset = contentOffset and math.abs(contentOffset) or 0

	if contentOffset > self._itemOffset then
		self:refreshScale(-contentOffset, -self._rightBoundary, -self._itemOffset)
	else
		self:refreshScale(contentOffset, self._leftBoundary, self._itemOffset)
	end
end

function CharacterLevelItem:_editableInitView()
	return
end

function CharacterLevelItem:onUpdateMO(mo)
	self._mo = mo

	local container = self._view.viewContainer
	local itemWidth = container:getLevelItemWidth()
	local halfWidth = itemWidth / 2

	self._itemOffset = (self._index - 1) * itemWidth
	self._rightBoundary = self._itemOffset + halfWidth
	self._leftBoundary = self._itemOffset - halfWidth

	self:refresh()

	local contentOffset = self._view.viewContainer.characterLevelUpView:getContentOffset()

	self:_onLevelScrollChange(contentOffset)
	self._animator:Play("idle", 0, 0)
end

function CharacterLevelItem:refresh()
	local txtLv = self._mo and HeroConfig.instance:getShowLevel(self._mo.level) or ""

	self._txtcurlv.text = txtLv
	self._txtlvnum.text = txtLv
	self._txtefflvnum.text = txtLv

	if self._mo then
		local heroId = self._mo.heroId

		if heroId then
			::label_11_0::

			local heroMO = HeroModel.instance:getByHeroId(heroId)

			if not heroMO then
				return
			end

			local hasEnough = true
			local curLevel = heroMO.level
			local itemLv = self._mo.level
			local costItemList = HeroConfig.instance:getLevelUpItems(heroId, curLevel, itemLv)

			for _, costItem in ipairs(costItemList) do
				local type = tonumber(costItem.type)
				local id = tonumber(costItem.id)
				local costQuantity = tonumber(costItem.quantity)
				local hasQuantity = ItemModel.instance:getItemQuantity(type, id)

				if hasQuantity < costQuantity then
					hasEnough = false

					break
				end
			end

			if not hasEnough then
				self._txtlvnum.text = string.format("<color=#793426>%s</color>", txtLv)
			end

			local curRankMaxLv = CharacterModel.instance:getrankEffects(heroId, heroMO.rank)[1]

			gohelper.setActive(self._gomax, itemLv == curRankMaxLv)
			self:refreshCurLevelMark()
		end
	end
end

function CharacterLevelItem:refreshCurLevelMark()
	local isMarkCurLevel = false

	if self._mo then
		local heroId = self._mo.heroId

		if heroId then
			::label_12_0::

			local heroMO = HeroModel.instance:getByHeroId(heroId)

			if heroMO then
				local itemLv = self._mo.level
				local container = self._view.viewContainer
				local localUpLevel = container:getLocalUpLevel()
				local curLevel = localUpLevel or heroMO.level
				local isCurLevelItem = itemLv == curLevel

				if isCurLevelItem then
					local previewLevel = container.characterLevelUpView.previewLevel

					isMarkCurLevel = previewLevel ~= itemLv
				end
			end

			gohelper.setActive(self._gocurlv, isMarkCurLevel)
			gohelper.setActive(self._goline, not isMarkCurLevel)
			gohelper.setActive(self._txtlvnum.gameObject, not isMarkCurLevel)
		end
	end
end

function CharacterLevelItem:refreshScale(factor, minFactor, maxFactor)
	if not factor or not minFactor or not maxFactor then
		return
	end

	local scale = GameUtil.remap(factor, minFactor, maxFactor, MIN_SCALE, MAX_SCALE)

	transformhelper.setLocalScale(self._translvnum, scale, scale, scale)

	local color = self._txtlvnum.color

	color.a = GameUtil.remap(factor, minFactor, maxFactor, MIN_ALPHA, MAX_ALPHA)
	self._txtlvnum.color = color
end

return CharacterLevelItem
