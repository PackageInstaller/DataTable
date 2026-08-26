-- chunkname: @modules/logic/mainuiswitch/view/MainUISkinMaterialTipView.lua

module("modules.logic.mainuiswitch.view.MainUISkinMaterialTipView", package.seeall)

local MainUISkinMaterialTipView = class("MainUISkinMaterialTipView", MainSceneSkinMaterialTipView)

function MainUISkinMaterialTipView:onClickModalMask()
	self:closeThis()
end

return MainUISkinMaterialTipView
