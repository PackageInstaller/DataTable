-- chunkname: @modules/logic/character/view/recommed/CharacterDevelopGoalsView.lua

module("modules.logic.character.view.recommed.CharacterDevelopGoalsView", package.seeall)

local CharacterDevelopGoalsView = class("CharacterDevelopGoalsView", BaseView)

function CharacterDevelopGoalsView:onInitView()
	self._scrollgroup = gohelper.findChildScrollRect(self.viewGO, "#scroll_group")
	self._gomax = gohelper.findChild(self.viewGO, "#go_max")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDevelopGoalsView:addEvents()
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnCutHeroAnimCB, self._refreshHero, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshItems, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshItems, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._refreshItems, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._refreshItems, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._refreshItems, self)
end

function CharacterDevelopGoalsView:removeEvents()
	self.removeEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnCutHeroAnimCB, self._refreshHero, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshItems, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshItems, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroRankUp, self._refreshItems, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroLevelUp, self._refreshItems, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._refreshItems, self)
end

function CharacterDevelopGoalsView:_editableInitView()
	return
end

function CharacterDevelopGoalsView:onUpdateParam()
	return
end

function CharacterDevelopGoalsView:onOpen()
	self._heroId = nil

	self:_refreshHero(self.viewParam.heroId)
	self:playViewAnim(CharacterRecommedEnum.AnimName.Open, 0, 0)
end

function CharacterDevelopGoalsView:_refreshHero(heroId)
	if self._heroId == heroId then
		return
	end

	self._heroId = heroId
	self._heroRecommendMO = CharacterRecommedModel.instance:getHeroRecommendMo(heroId)

	self:_refreshItems()
end

function CharacterDevelopGoalsView:_refreshItems()
	local moList = self._heroRecommendMO:getNextDevelopMaterial()

	self._goGoalsItem = self._goGoalsItem or self.viewContainer:getGoalsItemRes()

	local _moList = {}

	for _, mo in pairs(moList) do
		local items = mo:getItemList()

		if items and #items > 0 then
			table.insert(_moList, mo)
		end
	end

	table.sort(_moList, function(a, b)
		return a:getDevelopGoalsType() < b:getDevelopGoalsType()
	end)
	gohelper.CreateObjList(self, self._goalsItemCB, _moList, self._scrollgroup.content.gameObject, self._goGoalsItem, CharacterDevelopGoalsItem)
	gohelper.setActive(self._gomax.gameObject, #_moList == 0)
	gohelper.setActive(self._scrollgroup.gameObject, #_moList > 0)
end

function CharacterDevelopGoalsView:_goalsItemCB(obj, data, index)
	obj:onUpdateMO(data)
end

function CharacterDevelopGoalsView:playViewAnim(animName, layer, normalizedTime)
	self._viewAnim = self._viewAnim or self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._viewAnim then
		self._viewAnim:Play(animName, layer, normalizedTime)
	end
end

function CharacterDevelopGoalsView:onClose()
	return
end

function CharacterDevelopGoalsView:onDestroyView()
	return
end

return CharacterDevelopGoalsView
