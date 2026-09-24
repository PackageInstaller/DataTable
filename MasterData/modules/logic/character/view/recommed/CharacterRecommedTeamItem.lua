-- chunkname: @modules/logic/character/view/recommed/CharacterRecommedTeamItem.lua

module("modules.logic.character.view.recommed.CharacterRecommedTeamItem", package.seeall)

local CharacterRecommedTeamItem = class("CharacterRecommedTeamItem", LuaCompBase)

function CharacterRecommedTeamItem:init(go)
	self.go = go
end

function CharacterRecommedTeamItem:addEventListeners()
	return
end

function CharacterRecommedTeamItem:removeEventListeners()
	return
end

function CharacterRecommedTeamItem:onUpdateMO(teamInfo, viewContainer, hidePosIndex)
	self._goheroitem = self._goheroitem or viewContainer:getHeroIconRes()
	self._viewContainer = viewContainer
	self._hidePosIndex = hidePosIndex
	self._teamInfo = teamInfo
	self._heroList = self._teamInfo:getHeroList()
	self._teamIndex = self._teamInfo:getTeamIndex()
	self._showItem = false

	gohelper.CreateObjList(self, self._groupItemCB, self._heroList, self.go, self._goheroitem, CharacterRecommedReplaceHeroIcon)
	gohelper.setActive(self.go, self._showItem)
end

function CharacterRecommedTeamItem:_groupItemCB(obj, heroInfo, index)
	local _, posIndex = heroInfo:getCurPos()

	gohelper.setActive(obj.viewGO, self._hidePosIndex ~= posIndex)

	if self._hidePosIndex == posIndex then
		return
	end

	self._showItem = true

	local heroId = heroInfo:getHeroId()
	local destiny = heroInfo:getDestinyId()
	local mo = CharacterRecommedModel.instance:getHeroRecommendMo(heroId)

	obj:onUpdateMO(mo, destiny, self._teamInfo, posIndex)
	obj:setClickCallback(function()
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = mo.heroId,
			formView = self.viewName
		})
	end, self)

	local isOwnHero = mo:isOwnHero()

	obj:SetGrayscale(not isOwnHero)
end

function CharacterRecommedTeamItem:onDestroy()
	return
end

return CharacterRecommedTeamItem
