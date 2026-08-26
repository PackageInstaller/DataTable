-- chunkname: @modules/logic/versionactivity3_6/yami/view/handbook/V3a6YaMiHeroHandbookDetailView.lua

module("modules.logic.versionactivity3_6.yami.view.handbook.V3a6YaMiHeroHandbookDetailView", package.seeall)

local V3a6YaMiHeroHandbookDetailView = class("V3a6YaMiHeroHandbookDetailView", V3a6YaMiHeroDetailView)

function V3a6YaMiHeroHandbookDetailView:addEvents()
	V3a6YaMiHeroHandbookDetailView.super.addEvents(self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onSelectHandbookHero, self._onSelectHandbookHero, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onSelectHeroHandbook, self._onSelectHandbookHero, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onSelectSkillHero, self._onSelectHandbookHero, self)
end

function V3a6YaMiHeroHandbookDetailView:removeEvents()
	V3a6YaMiHeroHandbookDetailView.super.removeEvents(self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onSelectHandbookHero, self._onSelectHandbookHero, self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onSelectHeroHandbook, self._onSelectHandbookHero, self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onSelectSkillHero, self._onSelectHandbookHero, self)
end

function V3a6YaMiHeroHandbookDetailView:_editableInitView()
	V3a6YaMiHeroHandbookDetailView.super._editableInitView(self)

	self._listModel = self.viewContainer.getListModel and self.viewContainer:getListModel() or V3a6YaMiHeroHandbookListModel.instance
end

function V3a6YaMiHeroHandbookDetailView:onOpen()
	V3a6YaMiHeroHandbookDetailView.super.onOpen(self)

	local heroMo = self._listModel:getSelectMo()

	self:refreshDetail(heroMo)
end

function V3a6YaMiHeroHandbookDetailView:_onSelectHandbookHero()
	local heroMo = self._listModel:getSelectMo()

	self:refreshDetail(heroMo)
end

function V3a6YaMiHeroHandbookDetailView:_onUnlockHero(heroId)
	self:_refreshLock()

	if heroId then
		self.viewContainer:onEquipHero(heroId, false)
		V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onSelectHeroHandbook, heroId)
	end
end

return V3a6YaMiHeroHandbookDetailView
