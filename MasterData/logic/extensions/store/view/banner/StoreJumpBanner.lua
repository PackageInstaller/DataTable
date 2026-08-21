-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/banner/StoreJumpBanner.lua

module("logic.extensions.store.view.banner.StoreJumpBanner", package.seeall)

local M = class("StoreJumpBanner")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
end

function M:Awake()
	return
end

function M:setUIRegistry(registry)
	self._btnClick = ButtonAdapter.Get(registry:findUIElement("store_super_value_panel_285261674"))

	self._btnClick:AddClickListener(self._clickSelf, self)

	local goBanner = registry:findUIElement("store_super_value_panel_285261674")

	self._imgBanner = UIComponentType.BigBGLocalizationLua(goBanner)
end

function M:_clickSelf()
	StoreAgent.instance:reqJumpTo(self._storeHotTabMo:getStoreId(), self._storeHotTabMo:getGoodsId())

	local goodsMo = StoreModel.instance:getGoodMoByGoodsId(self._storeHotTabMo:getGoodsId())

	if goodsMo then
		ViewMgr.instance:open(ViewName.StoreBuyConfirmView, goodsMo)
	end
end

function M:updateView(storeHotTabMo)
	self._storeHotTabMo = storeHotTabMo

	if self._icon ~= self._storeHotTabMo:getIcon() then
		self._icon = self._storeHotTabMo:getIcon()

		self._imgBanner:SetImage(GameUrl.getStoreDynamicIcon(string.format("store_banner1/%s", self._icon)), nil, self)
	end
end

function M:OnDestroy()
	self._imgBanner:ClearImage()
	self._btnClick:RemoveClickListener()

	self._icon = nil
end

return M
