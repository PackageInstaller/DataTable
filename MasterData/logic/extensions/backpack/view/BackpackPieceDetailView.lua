-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackPieceDetailView.lua

module("logic.extensions.backpack.view.BackpackPieceDetailView", package.seeall)

local M = class("BackpackPieceDetailView", BackpackItemDetailView)

function M:_bindEvents()
	M.super._bindEvents(self)
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self.refreshView, self)
end

function M:_unbindEvents()
	M.super._unbindEvents(self)
	GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self.refreshView, self)
end

function M:refreshView()
	M.super.refreshView(self)

	local itemData = self._itemData
	local _, subType = ItemUtil.getItemTypeByItemId(itemData:getItemId())

	goutil.setActive(self._btnUse.gameObject, subType == CommEnum.HeroItemSubType.HeroHeartAnchor)
end

function M:_onClickComplexBtn()
	GlobalDispatcher:dispatchEvent(EventType.CONTRACT_ITEM, {
		uuid = self._itemData:getUuid(),
		type = self._itemData:getType(),
		subType = self._itemData:getSubType(),
		itemId = self._itemData:getItemId(),
		count = self._itemData:getCount()
	})
end

function M:_onClickUseBtn()
	local heroId = self._itemData:getItemInfo().heroId
	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if not heroData then
		FloatWordMgr.instance:show(lang("tip_role_not_get"))

		return
	end

	HeroDepotModel.instance:setViewPageMo({
		index = 1,
		hero = heroData,
		list = {
			heroData
		}
	})
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_gongming, nil, nil, nil)
	ViewMgr.instance:open(ViewName.CharacterHeartAnchorBreakView)
end

return M
