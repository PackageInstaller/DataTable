-- chunkname: @modules/logic/survival/view/tippopview/SurvivalRoleLevelTipPopView.lua

module("modules.logic.survival.view.tippopview.SurvivalRoleLevelTipPopView", package.seeall)

local SurvivalRoleLevelTipPopView = class("SurvivalRoleLevelTipPopView", TipPopViewBase)

function SurvivalRoleLevelTipPopView:onInitView()
	SurvivalRoleLevelTipPopView.super.onInitView(self)

	self.survivalroleleveltipcomp = gohelper.findChild(self.container, "survivalroleleveltipcomp")
	self.survivalRoleLevelTipComp = GameFacade.createLuaCompByGo(self.survivalroleleveltipcomp, SurvivalRoleLevelTipComp)
end

return SurvivalRoleLevelTipPopView
