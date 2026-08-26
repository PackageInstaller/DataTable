-- chunkname: @modules/logic/summonuiswitch/view/SummonUISkinMaterialTipView.lua

module("modules.logic.summonuiswitch.view.SummonUISkinMaterialTipView", package.seeall)

local SummonUISkinMaterialTipView = class("SummonUISkinMaterialTipView", MainSceneSkinMaterialTipView)

function SummonUISkinMaterialTipView:onClickModalMask()
	self:closeThis()
end

return SummonUISkinMaterialTipView
