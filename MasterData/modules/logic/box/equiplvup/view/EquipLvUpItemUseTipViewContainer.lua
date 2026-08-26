-- chunkname: @modules/logic/box/equiplvup/view/EquipLvUpItemUseTipViewContainer.lua

module("modules.logic.box.equiplvup.view.EquipLvUpItemUseTipViewContainer", package.seeall)

local EquipLvUpItemUseTipViewContainer = class("EquipLvUpItemUseTipViewContainer", BaseViewContainer)

function EquipLvUpItemUseTipViewContainer:buildViews()
	local views = {}

	table.insert(views, EquipLvUpItemUseTipView.New())
	table.insert(views, TabViewGroup.New(1, "#go_righttop"))

	return views
end

function EquipLvUpItemUseTipViewContainer:buildTabViews(tabContainerId)
	local currencyType = CurrencyEnum.CurrencyType
	local currencyParam = {
		currencyType.Diamond,
		currencyType.FreeDiamondCoupon
	}

	return {
		CurrencyView.New(currencyParam)
	}
end

return EquipLvUpItemUseTipViewContainer
