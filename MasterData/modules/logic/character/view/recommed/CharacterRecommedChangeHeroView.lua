-- chunkname: @modules/logic/character/view/recommed/CharacterRecommedChangeHeroView.lua

module("modules.logic.character.view.recommed.CharacterRecommedChangeHeroView", package.seeall)

local CharacterRecommedChangeHeroView = class("CharacterRecommedChangeHeroView", BaseView)

function CharacterRecommedChangeHeroView:onInitView()
	self._btnlv = gohelper.findChildButtonWithAudio(self.viewGO, "title/#btn_lv")
	self._golvSelect = gohelper.findChild(self.viewGO, "title/#btn_lv/btn2")
	self._golvSelect = gohelper.findChild(self.viewGO, "title/#btn_lv/btn2")
	self._golvSelectArrow = gohelper.findChild(self.viewGO, "title/#btn_lv/btn2/txt/arrow")
	self._golvUnSelect = gohelper.findChild(self.viewGO, "title/#btn_lv/btn1")
	self._btnrare = gohelper.findChildButtonWithAudio(self.viewGO, "title/#btn_rare")
	self._gorareSelect = gohelper.findChild(self.viewGO, "title/#btn_rare/btn2")
	self._gorareUnSelect = gohelper.findChild(self.viewGO, "title/#btn_rare/btn1")
	self._gorareSelectArrow = gohelper.findChild(self.viewGO, "title/#btn_rare/btn2/txt/arrow")
	self._scrollhero = gohelper.findChildScrollRect(self.viewGO, "#scroll_hero")
	self._goheroicon = gohelper.findChild(self.viewGO, "#go_heroicon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterRecommedChangeHeroView:addEvents()
	self._btnlv:AddClickListener(self._btnlvOnClick, self)
	self._btnrare:AddClickListener(self._btnrareOnClick, self)
	self.addEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnChangeHero, self._refreshHero, self)
end

function CharacterRecommedChangeHeroView:removeEvents()
	self._btnlv:RemoveClickListener()
	self._btnrare:RemoveClickListener()
	self.removeEventCb(self, CharacterRecommedController.instance, CharacterRecommedEvent.OnChangeHero, self._refreshHero, self)
end

function CharacterRecommedChangeHeroView:_btnlvOnClick()
	CharacterRecommedHeroListModel.instance:setSortLevel()
	self:_refreshSortBtn(true)
end

function CharacterRecommedChangeHeroView:_btnrareOnClick()
	CharacterRecommedHeroListModel.instance:setSortByRare()
	self:_refreshSortBtn(false)
end

function CharacterRecommedChangeHeroView:_editableInitView()
	gohelper.setActive(self._goheroicon, false)
end

function CharacterRecommedChangeHeroView:_refreshHero(heroId)
	CharacterRecommedHeroListModel.instance:selectById(heroId)
end

function CharacterRecommedChangeHeroView:onUpdateParam()
	return
end

function CharacterRecommedChangeHeroView:onOpen()
	self:_refreshHero(self.viewParam.heroId)
	self:_refreshSortBtn(true)
end

function CharacterRecommedChangeHeroView:_refreshSortBtn(isSortLevel)
	local levelAscend, rareAscend = CharacterRecommedHeroListModel.instance:getSortStatus()

	if isSortLevel then
		transformhelper.setLocalScale(self._golvSelectArrow.transform, 1, levelAscend and 1 or -1, 1)
	else
		transformhelper.setLocalScale(self._gorareSelectArrow.transform, 1, rareAscend and 1 or -1, 1)
	end

	gohelper.setActive(self._golvSelect, isSortLevel)
	gohelper.setActive(self._golvUnSelect, not isSortLevel)
	gohelper.setActive(self._gorareSelect, not isSortLevel)
	gohelper.setActive(self._gorareUnSelect, isSortLevel)
end

function CharacterRecommedChangeHeroView:onClose()
	return
end

function CharacterRecommedChangeHeroView:onDestroyView()
	return
end

return CharacterRecommedChangeHeroView
