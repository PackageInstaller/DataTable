-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/versiongift/VersionGiftGoodsItem.lua

module("logic.extensions.bonus.view.versiongift.VersionGiftGoodsItem", package.seeall)

local VersionGiftGoodsItem = class("VersionGiftGoodsItem", PayShopMibaoGoodsItem)

function VersionGiftGoodsItem:buildUI()
	VersionGiftGoodsItem.super.buildUI(self)
end

function VersionGiftGoodsItem:_checkGoodsSellOut(goodsCfg)
	if goodsCfg == nil then
		return true
	end

	if not PayShopModel.instance:getPayShopGoodsCanBuyById(goodsCfg.id) then
		return true
	end

	return PayShopModel.instance:chechShopGoodsSkillHave(goodsCfg)
end

return VersionGiftGoodsItem
