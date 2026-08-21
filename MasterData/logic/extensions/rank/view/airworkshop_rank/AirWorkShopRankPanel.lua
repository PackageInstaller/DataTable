-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/airworkshop_rank/AirWorkShopRankPanel.lua

module("logic.extensions.rank.view.airworkshop_rank.AirWorkShopRankPanel", package.seeall)

local M = class("AirWorkShopRankPanel", RankPanelBase)

function M:buildUI()
	M.super.buildUI(self)

	local go_scrollView = self._registry:getGo("panel_kqgf_-1556895865")
	local go_itemMyBank = self._registry:getGo("panel_kqgf_1022934638")
	local lastRankToggle = self._registry:getUIComponent("panel_kqgf_964203761", UIComponentType.SpaceXToggle)
	local curRankToggle = self._registry:getUIComponent("panel_kqgf_991702732", UIComponentType.SpaceXToggle)

	self:registerScrollView(go_scrollView)
	self:registerMyRank(go_itemMyBank)
	self:registerRankToggle(lastRankToggle, curRankToggle)
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_AirWorkShop)
	M.super.onEnter(self)
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_AirWorkShop)
	M.super.onExit(self)
end

return M
