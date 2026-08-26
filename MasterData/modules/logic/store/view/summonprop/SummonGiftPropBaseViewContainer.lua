-- chunkname: @modules/logic/store/view/summonprop/SummonGiftPropBaseViewContainer.lua

module("modules.logic.store.view.summonprop.SummonGiftPropBaseViewContainer", package.seeall)

local SummonGiftPropBaseViewContainer = class("SummonGiftPropBaseViewContainer", BaseViewContainer)

function SummonGiftPropBaseViewContainer:buildViews()
	local views = {}

	table.insert(views, SummonGiftPropBaseView.New())

	return views
end

function SummonGiftPropBaseViewContainer:getGoodsItem(parentGo)
	local path = self._viewSetting.otherRes[1]
	local itemGo = self:getResInst(path, parentGo)

	return (MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, PackageStoreGoodsItem))
end

return SummonGiftPropBaseViewContainer
