-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/relationship/heroinfo/HandbookHeroPassInfoFragmentView.lua

module("logic.extensions.playerinfo.view.handbook.relationship.heroinfo.HandbookHeroPassInfoFragmentView", package.seeall)

local M = class("HandbookHeroPassInfoFragmentView", CharacterPastInfoView)

function M:buildUI()
	local playableDirector = self._registry:findUIElement("role_file_tips_-1179355227", ComponentType.PlayableDirector)

	playableDirector.playOnAwake = true

	M.super.buildUI(self)
end

function M:bindEvents()
	M.super.bindEvents(self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
end

function M:onEnter()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local herodata = HeroDepotModel.instance:getHeroInfoByID(viewPageMo.hero:getId())

	self._ownHero = herodata ~= nil and herodata ~= false

	M.super.onEnter(self)
end

function M:onExit()
	M.super.onExit(self)
end

function M:getHeroLv()
	if self._ownHero then
		return M.super.getHeroLv(self)
	end

	return 0
end

function M:getHeroPowerLv()
	if self._ownHero then
		return M.super.getHeroPowerLv(self)
	end

	return 0
end

function M:getHeroTacit()
	if self._ownHero then
		return M.super.getHeroTacit(self)
	end

	return 0
end

return M
