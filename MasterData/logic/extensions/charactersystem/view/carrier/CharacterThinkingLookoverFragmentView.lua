-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/CharacterThinkingLookoverFragmentView.lua

module("logic.extensions.charactersystem.view.carrier.CharacterThinkingLookoverFragmentView", package.seeall)

local M = class("CharacterThinkingLookoverFragmentView", CharacterThinkingPanelFragmentView)

function M:buildUI()
	M.super.buildUI(self)
	self:hideBtn(true)
end

function M:bindEvents()
	for index = 1, #self._thinkingItemViews do
		local view = self._thinkingItemViews[index]

		view:setClickCallback(function(thinkingMo)
			self:_onSelectThinking(thinkingMo)
		end)
	end
end

function M:unbindEvents()
	for index = 1, #self._thinkingItemViews do
		local view = self._thinkingItemViews[index]

		view:setClickCallback(nil)
	end
end

function M:onEnter()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false
	local thinkingItemData = heroData:getThinkingItemData()
	local recommendThinking = heroData:getRecommendThinking()
	local heroThinkingMo = thinkingItemData:getThinkingMo()

	for index = 1, #self._thinkingItemViews do
		local view = self._thinkingItemViews[index]
		local mo = thinkingItemData:getMoByIndex(index)

		if mo then
			view:setVisible(true)
			view:setMo(mo)
			view:setLockVisible(not thinkingItemData:isThinkingUnlocked(mo:getId()))
			view:setIsRecommend(table.indexof(recommendThinking, mo:getId()) and true or false)

			local isUsing = heroThinkingMo and heroThinkingMo:getId() == mo:getId() or false

			view:setIsUsing(isUsing)
			view:move(isUsing)
		else
			view:setVisible(false)
		end
	end

	self._detailView:setMo(heroThinkingMo)
end

return M
